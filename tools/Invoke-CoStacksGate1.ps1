#requires -Version 7.0
<#
Invoke-CoStacksGate1.ps1

FAIL-CLOSED EXECUTION RULE:
  Must be run as a file:
    pwsh -NoProfile -ExecutionPolicy Bypass -File .\Invoke-CoStacksGate1.ps1 -CoBeaconRaw "<FULL_URL>"
  If pasted into the console, it fails immediately.

Goal:
  - Pull CoBeacon FULL-URL pointers only
  - Resolve required artifacts via FULL URLs (no guessing)
  - Download
  - Verify sha256 receipts (strict/fail-closed)
  - Emit deterministic zip pack + sha256
  - Print ready-to-paste CoBusLite EntryPayload (does NOT auto-write)

Policy (fail-closed):
  - Each non-.sha256 artifact must be verifiable via:
      (a) explicit companion URL ending ".sha256" present in CoBeacon pointers, OR
      (b) a referenced RECEIPT.sha256 that lists it by basename
  - Mutable "/main/" URLs rejected unless -AllowMutableMain
    (CoBeacon itself may be /main/; allowed but flagged.)
#>

[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)]
  [string]$CoBeaconRaw,

  [Parameter(Mandatory=$false)]
  [string]$OutDir = (Join-Path $PWD "out\CoStacksGate1"),

  [Parameter(Mandatory=$false)]
  [string]$PackName = "",

  [Parameter(Mandatory=$false)]
  [switch]$AllowMutableMain,

  [Parameter(Mandatory=$false)]
  [switch]$PrintGitPRHints
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$ProgressPreference    = 'SilentlyContinue'
$env:GIT_TERMINAL_PROMPT='0'
$env:GIT_PAGER='cat'

function Fail([string]$m){ throw "FAIL-CLOSED: $m" }
function UTS { (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ') }

# Guard: refuse interactive paste / partial execution
if([string]::IsNullOrWhiteSpace($PSCommandPath)){
  Fail "Run as a file, not pasted. Example:`n  pwsh -NoProfile -ExecutionPolicy Bypass -File .\Invoke-CoStacksGate1.ps1 -CoBeaconRaw `"$CoBeaconRaw`" -AllowMutableMain"
}
if(-not (Test-Path -LiteralPath $PSCommandPath)){
  Fail "PSCommandPath set but file not found: $PSCommandPath"
}

function Ensure-FullUrl([string]$u){
  if($u -notmatch '^https://'){ Fail "Non-https or non-URL pointer rejected: $u" }
  $u
}

function Is-MutableMainUrl([string]$u){
  return ($u -match '^https://raw\.githubusercontent\.com/[^/]+/[^/]+/main/')
}

function Get-Sha256Hex([string]$Path){
  if(!(Test-Path -LiteralPath $Path)){ Fail "Missing file for hash: $Path" }
  (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}

function Download-File([string]$Url,[string]$DestPath){
  Ensure-FullUrl $Url | Out-Null
  $parent = Split-Path -Parent $DestPath
  if(!(Test-Path -LiteralPath $parent)){ New-Item -ItemType Directory -Path $parent -Force | Out-Null }
  try { Invoke-WebRequest -Uri $Url -OutFile $DestPath | Out-Null }
  catch { Fail "Download failed: $Url :: $($_.Exception.Message)" }
  if(!(Test-Path -LiteralPath $DestPath)){ Fail "Download missing after fetch: $Url => $DestPath" }
}

function Parse-CoBeaconUrls([string]$Text){
  $m = [regex]::Matches($Text, 'https://[^\s]+')
  $urls = foreach($x in $m){ $x.Value.Trim() }
  ($urls | Sort-Object -Unique)
}

function Parse-Sha256FileLine([string]$line){
  $t = $line.Trim()
  if($t -eq '' -or $t.StartsWith('#')){ return $null }
  $m = [regex]::Match($t, '^(?<h>[A-Fa-f0-9]{64})\s+\*?(?<f>.+)$')
  if(!$m.Success){ return $null }
  [pscustomobject]@{ Hash=$m.Groups['h'].Value.ToLowerInvariant(); File=$m.Groups['f'].Value.Trim() }
}

function Read-Receipt([string]$ReceiptPath){
  $items = @()
  foreach($line in (Get-Content -LiteralPath $ReceiptPath -ErrorAction Stop)){
    $p = Parse-Sha256FileLine $line
    if($null -ne $p){ $items += $p }
  }
  if($items.Count -eq 0){ Fail "Receipt had no parseable hash lines: $ReceiptPath" }
  $items
}

function New-DeterministicZip([string]$SourceDir,[string]$ZipPath){
  Add-Type -AssemblyName System.IO.Compression
  Add-Type -AssemblyName System.IO.Compression.FileSystem
  if(Test-Path -LiteralPath $ZipPath){ Remove-Item -LiteralPath $ZipPath -Force }
  $files = Get-ChildItem -LiteralPath $SourceDir -File -Recurse | Sort-Object FullName
  $zipFs = [System.IO.File]::Open($ZipPath, [System.IO.FileMode]::CreateNew)
  try {
    $zip = New-Object System.IO.Compression.ZipArchive($zipFs, [System.IO.Compression.ZipArchiveMode]::Create, $true)
    try {
      foreach($f in $files){
        $rel = [System.IO.Path]::GetRelativePath($SourceDir, $f.FullName).Replace('\','/')
        $entry = $zip.CreateEntry($rel, [System.IO.Compression.CompressionLevel]::Optimal)
        $entry.LastWriteTime = [datetimeoffset]::new([datetime]::SpecifyKind([datetime]'1980-01-01T00:00:00', 'Utc'))
        $inStream  = [System.IO.File]::OpenRead($f.FullName)
        try {
          $outStream = $entry.Open()
          try { $inStream.CopyTo($outStream) } finally { $outStream.Dispose() }
        } finally { $inStream.Dispose() }
      }
    } finally { $zip.Dispose() }
  } finally { $zipFs.Dispose() }
}

# MAIN
$CoBeaconRaw = Ensure-FullUrl $CoBeaconRaw
$runUtc = UTS
$workRoot = Join-Path $OutDir ("run_" + $runUtc)
$dlDir    = Join-Path $workRoot "download"
$packDir  = Join-Path $workRoot "pack"
New-Item -ItemType Directory -Path $dlDir,$packDir -Force | Out-Null

$coBeaconIsMutable = (Is-MutableMainUrl $CoBeaconRaw)
$coBeaconPath = Join-Path $dlDir "COBEACON_LATEST.txt"
Download-File -Url $CoBeaconRaw -DestPath $coBeaconPath
$coBeaconText = Get-Content -LiteralPath $coBeaconPath -Raw -ErrorAction Stop

$urls = Parse-CoBeaconUrls $coBeaconText
if($urls.Count -eq 0){ Fail "No URLs found in CoBeacon." }

$mutable = @($urls | Where-Object { Is-MutableMainUrl $_ })
if($mutable.Count -gt 0 -and (-not $AllowMutableMain)){
  $sample = ($mutable | Select-Object -First 8) -join "`n  "
  Fail "Mutable /main/ URLs present (rejected). Re-run with -AllowMutableMain if you accept mutable pointers.`n  $sample"
}

$downloadIndex = @{}
for($i=0; $i -lt $urls.Count; $i++){
  $u  = $urls[$i]
  $bn = [System.IO.Path]::GetFileName(([uri]$u).AbsolutePath)
  if([string]::IsNullOrWhiteSpace($bn)){ Fail "URL has no basename: $u" }
  $name = ('{0:d4}__{1}' -f $i, $bn)
  $dest = Join-Path $dlDir $name
  Download-File -Url $u -DestPath $dest
  $downloadIndex[$u] = $dest
}

$shaByTargetUrl = @{}
foreach($u in $urls){
  if($u -match '\.sha256$'){
    $target = $u.Substring(0, $u.Length - 7)
    if($urls -contains $target){ $shaByTargetUrl[$target] = $u }
  }
}

$receiptUrls = @($urls | Where-Object { $_ -match 'RECEIPT\.sha256$' } | Sort-Object -Unique)
$receiptMap = @{}
foreach($ru in $receiptUrls){
  $rp = $downloadIndex[$ru]
  $items = Read-Receipt $rp
  foreach($it in $items){
    $base = [System.IO.Path]::GetFileName($it.File)
    if([string]::IsNullOrWhiteSpace($base)){ continue }
    $receiptMap[$base] = $it.Hash
  }
}

foreach($u in $urls){
  if($u -match '\.sha256$'){ continue }
  $p = $downloadIndex[$u]
  $actual = Get-Sha256Hex $p

  $expected = $null
  if($shaByTargetUrl.ContainsKey($u)){
    $shaUrl  = $shaByTargetUrl[$u]
    $shaPath = $downloadIndex[$shaUrl]
    $lines = Get-Content -LiteralPath $shaPath -ErrorAction Stop
    $found = $null
    foreach($line in $lines){
      $parsed = Parse-Sha256FileLine $line
      if($null -ne $parsed){ $found = $parsed.Hash; break }
    }
    if([string]::IsNullOrWhiteSpace($found)){ Fail "Companion sha256 had no parseable hash: $shaUrl" }
    $expected = $found
  } else {
    $base = [System.IO.Path]::GetFileName(([uri]$u).AbsolutePath)
    if($receiptMap.ContainsKey($base)){ $expected = $receiptMap[$base] }
  }

  if([string]::IsNullOrWhiteSpace($expected)){ Fail "Unverified artifact: $u" }
  if($actual -ne $expected){ Fail "SHA256 mismatch: $u`n  expected=$expected`n  actual  =$actual" }
}

foreach($u in $urls){ Copy-Item -LiteralPath $downloadIndex[$u] -Destination $packDir -Force }

if([string]::IsNullOrWhiteSpace($PackName)){ $PackName = "PACK__CoStacksGate1__v0__${runUtc}.zip" }
$zipPath = Join-Path $workRoot $PackName
New-DeterministicZip -SourceDir $packDir -ZipPath $zipPath
$zipHash = Get-Sha256Hex $zipPath
$zipShaPath = $zipPath + ".sha256"
"{0}  {1}" -f $zipHash, ([System.IO.Path]::GetFileName($zipPath)) | Set-Content -LiteralPath $zipShaPath -Encoding ascii -NoNewline

$mutableNote  = if($mutable.Count -gt 0){"MUTABLE_MAIN_URLS=YES"}else{"MUTABLE_MAIN_URLS=NO"}
$beaconNote   = if($coBeaconIsMutable){"COBEACON_MUTABLE=YES"}else{"COBEACON_MUTABLE=NO"}
$urlsCompact  = ($urls -join ' ; ')

$entry = @"
EntryPayload:
STATE=hold
UTC=$runUtc
KIND=CoStacksGate1
INTENT=Gate1: downloaded FULL-URL pointers from CoBeacon; verified sha256 fail-closed; produced deterministic zip+sha; did NOT auto-write entry.
COBEACON_RAW=$CoBeaconRaw
$beaconNote ; $mutableNote
PACK_ZIP_PATH=$zipPath
PACK_ZIP_SHA256=$zipHash
PACK_ZIP_SHA256_FILE=$zipShaPath
SOURCE_URLS=$urlsCompact
VERIFIED=YES
NOTE=Paste EntryPayload into ONE CoBusLite entry; commit+push; replace PACK_ZIP_PATH with published pickup RAW URL(s).
"@

Write-Host ""
Write-Host "=== OUTPUT FILES ==="
Write-Host $zipPath
Write-Host $zipShaPath
Write-Host ""
Write-Host "=== CoBusLite EntryPayload (COPY/PASTE) ==="
Write-Host $entry

if($PrintGitPRHints){
  if(!(Test-Path -LiteralPath (Join-Path $PWD ".git"))){
    Write-Host "PR hints skipped: not in git repo."
  } else {
    Write-Host "git checkout -b tool/CoStacksGate1"
    Write-Host "git add tools/Invoke-CoStacksGate1.ps1"
    Write-Host "git commit -m `"Add Invoke-CoStacksGate1 Gate1 downloader+verifier+deterministic pack emitter`""
    Write-Host "git push -u origin tool/CoStacksGate1"
  }
}