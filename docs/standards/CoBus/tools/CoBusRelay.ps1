param(
  [Parameter(Mandatory=$true)][string]$From,
  [Parameter(Mandatory=$true)][string]$To,
  [Parameter(Mandatory=$true)][string]$State,
  [Parameter(Mandatory=$true)][string]$Intent,
  [string]$Label = 'SIDENOTE',
  [string]$Utc,
  [string]$RepoPath,
  [string]$RemoteName,
  [switch]$NoPush
)

Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'

function Fail([string]$m){ throw "FAIL-CLOSED: $m" }
function UTS { (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ') }

function Pick-Remote([string]$RepoPath){
  $cands = @(git -C $RepoPath remote 2>$null)
  foreach($r in $cands){
    $u = (git -C $RepoPath remote get-url $r 2>$null)
    if($u -match 'github\.com[:/]+CoCivium/CoBusMirror(\.git)?$'){ return $r }
  }
  if($cands -contains 'cocivium'){ return 'cocivium' }
  if($cands -contains 'origin'){ return 'origin' }
  Fail ("No suitable git remote found. remotes=" + ($cands -join ','))
}

function RunGit([string]$RepoPath, [string[]]$GitArgs, [int[]]$OkCodes=@(0)){
  if(-not $GitArgs -or $GitArgs.Count -lt 1){ Fail "RunGit called with empty GitArgs" }
  & git -C $RepoPath @GitArgs | Out-Null
  $c = $LASTEXITCODE
  if($OkCodes -notcontains $c){ Fail ("git " + ($GitArgs -join ' ') + " exit=$c") }
  return $c
}

if(-not $Utc){ $Utc = UTS }

if(-not $RepoPath){
  $RepoPath = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path
}
if(!(Test-Path (Join-Path $RepoPath '.git'))){ Fail "Not a git repo: $RepoPath" }

if(-not $RemoteName){ $RemoteName = Pick-Remote $RepoPath }

# Keep local in sync before we mutate logs (fail-closed on divergence)
if(-not $NoPush){
  RunGit $RepoPath @('fetch','--all','--prune')
  RunGit $RepoPath @('pull','--ff-only',$RemoteName,'main')
}

$SideNoteTool = Join-Path $RepoPath 'docs/standards/CoStatus/tools/CoSideNote.ps1'
if(!(Test-Path $SideNoteTool)){ Fail "Missing CoSideNote tool: $SideNoteTool" }
. $SideNoteTool

$LogRel   = 'docs/CoBus/SideNotes'
$LogDir   = Join-Path $RepoPath $LogRel
$LogMd    = Join-Path $LogDir 'SideNotes__LATEST.md'
$LogJsonl = Join-Path $LogDir 'SideNotes.machine.jsonl'
$LogRcp   = Join-Path $LogDir 'RECEIPT.sha256'

New-Item -ItemType Directory -Force -Path $LogDir | Out-Null
if(!(Test-Path $LogMd)){ @("# SideNotes Log — LATEST","","# COPY_SAFE:TRUE | END_OF_BLOCK") | Set-Content -Encoding UTF8 $LogMd }
if(!(Test-Path $LogJsonl)){ New-Item -ItemType File -Force -Path $LogJsonl | Out-Null }

$sn = New-CoSideNoteLine -From $From -To $To -Utc $Utc -State $State -Intent $Intent
Out-CoSideNote $sn $Label
try { Set-Clipboard -Value $sn } catch {}

Add-Content -Encoding UTF8 $LogMd -Value $sn
$rec = @{ utc=$Utc; from=$From; to=$To; state=$State; intent=$Intent; line=$sn } | ConvertTo-Json -Compress
Add-Content -Encoding UTF8 $LogJsonl -Value $rec

$h1 = (Get-FileHash -Algorithm SHA256 $LogMd).Hash.ToLower()
$h2 = (Get-FileHash -Algorithm SHA256 $LogJsonl).Hash.ToLower()
("{0}  {1}`n{2}  {3}`n" -f $h1,(Split-Path $LogMd -Leaf),$h2,(Split-Path $LogJsonl -Leaf)) | Set-Content -Encoding ASCII $LogRcp

if(-not $NoPush){
  RunGit $RepoPath @('add', $LogRel)
  RunGit $RepoPath @('commit','-m',("CoBusRelay: append SideNote " + $Utc))
  RunGit $RepoPath @('push',$RemoteName,'main')

  $oid = (& git -C $RepoPath rev-parse HEAD).Trim()
  Write-Host "# REMOTE_USED=$RemoteName"
  Write-Host "# PUSHED_COMMIT_OID=$oid"
  Write-Host ("# RAW_LOG_MD=https://raw.githubusercontent.com/CoCivium/CoBusMirror/{0}/{1}/SideNotes__LATEST.md" -f $oid,$LogRel)
  Write-Host ("# RAW_LOG_JSONL=https://raw.githubusercontent.com/CoCivium/CoBusMirror/{0}/{1}/SideNotes.machine.jsonl" -f $oid,$LogRel)
  Write-Host ("# RAW_RECEIPT=https://raw.githubusercontent.com/CoCivium/CoBusMirror/{0}/{1}/RECEIPT.sha256" -f $oid,$LogRel)
}
