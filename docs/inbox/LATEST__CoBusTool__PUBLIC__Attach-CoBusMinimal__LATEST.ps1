<# Attach-CoBusMinimal (PUBLIC, LATEST) FAIL-CLOSED.
   PURPOSE:
   - Read CoBeacon + CoBus Index + CoPong Spec
   - Write a minimal public CoPulse note to CoBusMirror/main
   - Verify the pushed raw URL
   - Return conservative attachment state
#>
param(
  [Parameter(Mandatory=$true)][string]$SessionLabel,
  [string]$PrimeTo = '4.0|PRIME|260125',
  [string]$BeaconUrl = 'https://raw.githubusercontent.com/CoCivium/CoBusMirror/5dd6352cf3da72ec5dc0a3b23947a61a95648b7f/docs/COBEACON_LATEST.txt',
  [string]$RepoRoot = ''
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

function Fail([string]$Message) { throw $Message }
function Get-Text([string]$Url) { (Invoke-WebRequest -UseBasicParsing -Uri $Url).Content }
function Parse-BeaconUrl([string]$BeaconText, [string]$LabelPattern) {
  $m = [regex]::Match($BeaconText, "$LabelPattern:\s*(https://raw\.githubusercontent\.com/\S+)")
  if ($m.Success) { return $m.Groups[1].Value }
  return $null
}
function Resolve-CoBusMirrorRepo {
  if ($RepoRoot -and (Test-Path (Join-Path $RepoRoot '.git'))) { return $RepoRoot }
  $candidates = @(
    'C:\Users\rball\Documents\GitHub\CoBusMirror',
    'C:\Users\rball\Documents\GitHub\CoCivium\CoBusMirror'
  )
  foreach ($c in $candidates) {
    if (Test-Path (Join-Path $c '.git')) { return $c }
  }
  Fail 'CoBusMirror repo not found. Provide -RepoRoot or clone repo first.'
}
function Get-RemoteMeta([string]$RepoRoot) {
  $remote = (git -C $RepoRoot remote get-url origin).Trim()
  if ($remote -match '^https://github\.com/([^/]+)/([^/.]+?)(\.git)?$') {
    return @{ Owner = $Matches[1]; Repo = $Matches[2] }
  }
  elseif ($remote -match '^git@github\.com:([^/]+)/([^/.]+?)(\.git)?$') {
    return @{ Owner = $Matches[1]; Repo = $Matches[2] }
  }
  Fail "Unsupported remote: $remote"
}

$Utc = (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ')
$CoBusSpecUrl  = 'https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/inbox/LATEST__CoBusNote__PUBLIC__CoBus_Spec__LATEST.txt'
$CoBusIndexUrl = 'https://raw.githubusercontent.com/CoCivium/CoBusMirror/587aa38629482d283b223e5a9cdb152136507106/docs/inbox/LATEST__CoBusNote__PUBLIC__CoBus_Index__LATEST.json'
$CoPongSpecUrl = 'https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/inbox/LATEST__CoBusNote__PUBLIC__CoPong_Spec__LATEST.txt'

$Beacon = Get-Text $BeaconUrl
if (-not $Beacon) { Fail "Cannot read CoBeacon: $BeaconUrl" }

$ParsedCoBusSpecUrl  = Parse-BeaconUrl $Beacon 'CoBus Spec'
$ParsedCoBusIndexUrl = Parse-BeaconUrl $Beacon 'CoBus Index'
$ParsedCoPongSpecUrl = Parse-BeaconUrl $Beacon 'CoPong Spec'

if ($ParsedCoBusSpecUrl)  { $CoBusSpecUrl  = $ParsedCoBusSpecUrl }
if ($ParsedCoBusIndexUrl) { $CoBusIndexUrl = $ParsedCoBusIndexUrl }
if ($ParsedCoPongSpecUrl) { $CoPongSpecUrl = $ParsedCoPongSpecUrl }

$Spec  = Get-Text $CoBusSpecUrl
$Index = Get-Text $CoBusIndexUrl
$Pong  = Get-Text $CoPongSpecUrl

if ($Spec -notmatch [regex]::Escape('Every wave MUST emit at least a minimal CoPulse/CoSync')) {
  Fail 'Public CoBus Spec missing required heartbeat rule.'
}
if ($Pong -notmatch [regex]::Escape("TO=$PrimeTo")) {
  Fail "Public CoPong Spec missing expected runtime PRIME receiver: $PrimeTo"
}

$ResolvedRepo = Resolve-CoBusMirrorRepo
$InboxDir = Join-Path $ResolvedRepo 'docs\inbox'
if (!(Test-Path $InboxDir)) { Fail "Inbox dir missing: $InboxDir" }

Push-Location $ResolvedRepo
try {
  git fetch origin --prune
  git checkout main | Out-Host
  git pull --ff-only origin main | Out-Host

  $NoteName = "NOTE__PUBLIC__COPULSE__${SessionLabel}__${Utc}.md"
  $NotePath = Join-Path $InboxDir $NoteName
  @(
    'PUBLIC_NOTE'
    "UTC=$Utc"
    "SESSION_LABEL=$SessionLabel"
    "PRIME_ID=$PrimeTo"
    'STATUS=doing'
    'STATE=write_attached'
    'INTENT=Minimal reusable CoBus attach wave.'
    'CHANGES='
    '- READ CoBeacon'
    '- READ CoBus Index'
    '- WROTE this minimal CoPulse'
    'POINTERS='
    "- URL_RAW_BEACON=$BeaconUrl"
    "- URL_RAW_SPEC=$CoBusSpecUrl"
    "- URL_RAW_INDEX=$CoBusIndexUrl"
    "- URL_RAW_COPONG=$CoPongSpecUrl"
    'END'
  ) | Set-Content -LiteralPath $NotePath -Encoding UTF8

  git add -- $NotePath
  if (-not (git status --short)) { Fail 'No staged changes detected.' }

  git commit -m "CoBus: add minimal CoPulse for $SessionLabel at $Utc" | Out-Host
  git push origin main | Out-Host

  $meta = Get-RemoteMeta $ResolvedRepo
  $commit = (git rev-parse HEAD).Trim()
  $rel = $NotePath.Replace($ResolvedRepo, '').TrimStart('\').Replace('\','/')
  $raw = "https://raw.githubusercontent.com/$($meta.Owner)/$($meta.Repo)/$commit/$rel"
  $body = Get-Text $raw
  if ($body -notmatch [regex]::Escape("SESSION_LABEL=$SessionLabel")) {
    Fail 'Remote verification failed.'
  }

  Write-Host "VERIFY_STATUS=VERIFIED_LANDED_PUBLIC"
  Write-Host "ATTACHMENT_STATE=write_attached"
  Write-Host "COMMIT=$commit"
  Write-Host "RAW_NOTE=$raw"
  Write-Host "COPONG=# CoPong | FROM=$SessionLabel -> TO=$PrimeTo | UTC=$Utc | STATE=write_attached_verified_public_copulse | ACTIONNOW=observe_raw_note_and_continue_independent_coordination | PASS=commit:$commit | POINTERS=URL_RAW=$raw VISIBILITY=public"
}
finally {
  Pop-Location
}
