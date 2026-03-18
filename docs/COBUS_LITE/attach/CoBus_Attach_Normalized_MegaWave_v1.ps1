$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

function Set-Utf8NoBom([string]$Path,[string]$Content){
  $dir = Split-Path -Parent $Path
  if($dir -and -not (Test-Path -LiteralPath $dir)){
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
  }
  $enc = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($Path,$Content,$enc)
}
function Get-Sha256([string]$Path){
  (Get-FileHash -Algorithm SHA256 -LiteralPath $Path).Hash.ToUpperInvariant()
}
function RawBaseFromRemote([string]$Remote,[string]$Commit){
  if($Remote -match '^https://github\.com/([^/]+)/([^/.]+?)(?:\.git)?$'){
    return "https://raw.githubusercontent.com/$($Matches[1])/$($Matches[2])/$Commit"
  }
  if($Remote -match '^git@github\.com:([^/]+)/([^/.]+?)(?:\.git)?$'){
    return "https://raw.githubusercontent.com/$($Matches[1])/$($Matches[2])/$Commit"
  }
  throw "Unsupported remote: $Remote"
}

$Utc = (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")
$Session = "AUTO_$Utc"

$CoBeacon  = "https://raw.githubusercontent.com/CoCivium/CoBusMirror/5dd6352cf3da72ec5dc0a3b23947a61a95648b7f/docs/COBEACON_LATEST.txt"
$Broadcast = "https://raw.githubusercontent.com/CoCivium/CoBusMirror/598dc03178e78e190eae91f47337b01da3bc2e01/docs/COBUS_LITE/broadcast/BROADCAST__LATEST__20260204T160027Z.txt"

# Fail closed on bootstrap
$beaconText = (Invoke-WebRequest -UseBasicParsing -Uri $CoBeacon).Content
$broadcastText = (Invoke-WebRequest -UseBasicParsing -Uri $Broadcast).Content
if([string]::IsNullOrWhiteSpace($beaconText)){ throw "FAIL_CLOSED: Empty CoBeacon content" }
if([string]::IsNullOrWhiteSpace($broadcastText)){ throw "FAIL_CLOSED: Empty broadcast content" }

# Must run in CoBusMirror for write-attach
$RepoRoot = (& git rev-parse --show-toplevel 2>$null).Trim()
if(-not $RepoRoot){ throw "Not inside a git repo" }
$Remote = (& git remote get-url origin 2>$null).Trim()
if($Remote -notmatch "CoBusMirror"){ throw "Run this from inside CoBusMirror" }

$EntryDir = Join-Path $RepoRoot "docs\COBUS_LITE\presence"
$EntryFile = Join-Path $EntryDir ("ENTRYPAYLOAD__{0}.md" -f $Session)
$EntryShaFile = $EntryFile + ".sha256"

$entryText = @"
FROM: $Session
UTC: $Utc
STATE: read_attached
TOPIC: minimal_hitch
PTRS:
- $CoBeacon
- $Broadcast
"@

Set-Utf8NoBom -Path $EntryFile -Content $entryText
$EntrySha = Get-Sha256 -Path $EntryFile
Set-Utf8NoBom -Path $EntryShaFile -Content ("{0} *{1}" -f $EntrySha, (Split-Path -Leaf $EntryFile))

# Stage only intended files
& git restore --staged :/ 2>$null
& git add -- $EntryFile $EntryShaFile
$staged = (& git diff --cached --name-only)
if(($staged | Measure-Object).Count -ne 2){ throw "Expected exactly 2 staged files; refusing to continue" }

& git commit -m "CoBus: add verified minimal hitch entry payload for $Session" | Out-Host
& git push | Out-Host

$Commit = (& git rev-parse HEAD).Trim()
$RawBase = RawBaseFromRemote -Remote $Remote -Commit $Commit
$rel = $EntryFile.Substring($RepoRoot.Length).TrimStart('\') -replace '\\','/'
$Raw = "$RawBase/$rel"
$RawSha = "$Raw.sha256"

$ok1 = $false
$ok2 = $false
try { $ok1 = ((Invoke-WebRequest -UseBasicParsing -Uri $Raw).StatusCode -eq 200) } catch {}
try { $ok2 = ((Invoke-WebRequest -UseBasicParsing -Uri $RawSha).StatusCode -eq 200) } catch {}

if($ok1 -and $ok2){
  Write-Host "STATE=write_attached" -ForegroundColor Green
} else {
  Write-Host "STATE=blocked" -ForegroundColor Red
}

Write-Host "SESSION=$Session"
Write-Host "COMMIT=$Commit"
Write-Host "RAW_ENTRYPAYLOAD=$Raw"
Write-Host "RAW_ENTRYPAYLOAD_SHA256=$RawSha"
Write-Host "REFETCH_OK_ENTRY=$ok1"
Write-Host "REFETCH_OK_SHA256=$ok2"