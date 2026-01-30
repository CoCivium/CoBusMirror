Set-StrictMode -Version Latest
param(
  [Parameter(Mandatory=$true)][string]$From,
  [Parameter(Mandatory=$true)][string]$To,
  [Parameter(Mandatory=$true)][string]$State,
  [Parameter(Mandatory=$true)][string]$Intent,
  [string]$Label = 'SIDENOTE',
  [string]$Utc,
  [string]$RepoPath,
  [switch]$NoPush
)

function Fail([string]$m){ throw "FAIL-CLOSED: $m" }
function UTS { (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ') }
if(-not $Utc){ $Utc = UTS }
if(-not $RepoPath){
  # infer repo root from script location: docs/standards/CoBus/tools
  $RepoPath = Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..') | Select-Object -ExpandProperty Path
}

$SideNoteTool = Join-Path $RepoPath 'docs/standards/CoStatus/tools/CoSideNote.ps1'
if(!(Test-Path $SideNoteTool)){ Fail "Missing CoSideNote tool: $SideNoteTool" }
. $SideNoteTool

$LogDir   = Join-Path $RepoPath 'docs/CoBus/SideNotes'
$LogMd    = Join-Path $LogDir 'SideNotes__LATEST.md'
$LogJsonl = Join-Path $LogDir 'SideNotes.machine.jsonl'
$LogRcp   = Join-Path $LogDir 'RECEIPT.sha256'
New-Item -ItemType Directory -Force -Path $LogDir | Out-Null
if(!(Test-Path $LogMd)){
  @("# SideNotes Log — LATEST","","# COPY_SAFE:TRUE | END_OF_BLOCK") | Set-Content -Encoding UTF8 $LogMd
}
if(!(Test-Path $LogJsonl)){ New-Item -ItemType File -Force -Path $LogJsonl | Out-Null }

$sn = New-CoSideNoteLine -From $From -To $To -Utc $Utc -State $State -Intent $Intent

# UX: reverse-video banner + green one-liner
Out-CoSideNote $sn $Label

# Convenience: clipboard (still one-line)
try { Set-Clipboard -Value $sn } catch {}

# Append to logs (md + jsonl)
Add-Content -Encoding UTF8 $LogMd -Value $sn
$rec = @{ utc=$Utc; from=$From; to=$To; state=$State; intent=$Intent; line=$sn } | ConvertTo-Json -Compress
Add-Content -Encoding UTF8 $LogJsonl -Value $rec

# Receipt (hashes change per append; still useful for integrity-at-rest)
$h1 = (Get-FileHash -Algorithm SHA256 $LogMd).Hash.ToLower()
$h2 = (Get-FileHash -Algorithm SHA256 $LogJsonl).Hash.ToLower()
("{0}  {1}`n{2}  {3}`n" -f $h1,(Split-Path $LogMd -Leaf),$h2,(Split-Path $LogJsonl -Leaf)) | Set-Content -Encoding ASCII $LogRcp

if(-not $NoPush){
  & git -C $RepoPath add $LogDir | Out-Null
  & git -C $RepoPath commit -m ("CoBusRelay: append SideNote " + $Utc) | Out-Null
  & git -C $RepoPath push origin main | Out-Null
  $oid = (& git -C $RepoPath rev-parse HEAD).Trim()
  Write-Host "# PUSHED_COMMIT_OID=$oid"
  Write-Host ("# RAW_LOG_MD=https://raw.githubusercontent.com/CoCivium/CoBusMirror/{0}/docs/CoBus/SideNotes/SideNotes__LATEST.md" -f $oid)
  Write-Host ("# RAW_LOG_JSONL=https://raw.githubusercontent.com/CoCivium/CoBusMirror/{0}/docs/CoBus/SideNotes/SideNotes.machine.jsonl" -f $oid)
  Write-Host ("# RAW_RECEIPT=https://raw.githubusercontent.com/CoCivium/CoBusMirror/{0}/docs/CoBus/SideNotes/RECEIPT.sha256" -f $oid)
}
