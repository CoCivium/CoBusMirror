<# CoRepoPreflight_Rail (PUBLIC, LATEST)
   FAIL-CLOSED. Sets: $env:CO_REPOROOT
   Invocation: & .\CoRepoPreflight_Rail.ps1 -OrgRepo "CoCivium/CoSteward" -Leaf "CoSteward"
#>
param(
  [Parameter(Mandatory=$true)][string]$OrgRepo,
  [Parameter(Mandatory=$true)][string]$Leaf,
  [string]$GitHubRoot,
  [switch]$NoFetch
)

Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
if (Get-Variable -Name PSNativeCommandUseErrorActionPreference -Scope Global -ErrorAction SilentlyContinue) { $global:PSNativeCommandUseErrorActionPreference = $false }

function Fail([string]$m){ throw "FAIL-CLOSED: $m" }

function Find-GitHubRoot {
  $c=@(
    (Join-Path $HOME 'Documents\GitHub'),
    (Join-Path $HOME 'GitHub'),
    (Join-Path $HOME 'source\repos')
  ) | Where-Object { $_ -and (Test-Path $_) }
  if(@($c).Count -eq 0){ Fail "No GitHub root found under HOME. Create $HOME\Documents\GitHub." }
  return $c[0]
}

function Ensure-Repo([string]$orgRepo,[string]$localPath){
  if(Test-Path $localPath){
    if(-not (Test-Path (Join-Path $localPath '.git'))){ Fail "Path exists but is not a git repo: $localPath" }
    return
  }
  New-Item -ItemType Directory -Force -Path (Split-Path $localPath -Parent) | Out-Null
  & gh repo clone $orgRepo $localPath | Out-Null
  if($LASTEXITCODE -ne 0){ Fail "gh clone failed: $orgRepo -> $localPath" }
  if(-not (Test-Path (Join-Path $localPath '.git'))){ Fail "Clone claimed success but .git missing: $localPath" }
}

function Assert-RepoRoot([string]$repoPath,[string]$expectedLeaf){
  if(-not (Test-Path (Join-Path $repoPath '.git'))){ Fail "No .git at repoPath: $repoPath" }
  $root = (& git -C $repoPath rev-parse --show-toplevel 2>$null).Trim()
  if(-not $root){ Fail "git rev-parse failed at: $repoPath" }
  $leaf = Split-Path $root -Leaf
  if($leaf -ne $expectedLeaf){ Fail "Safety stop: repo leaf '$leaf' != expected '$expectedLeaf' (root=$root)" }
  return $root
}

if(-not $GitHubRoot){ $GitHubRoot = Find-GitHubRoot }
$local = Join-Path $GitHubRoot $Leaf
Ensure-Repo $OrgRepo $local
$root = Assert-RepoRoot $local $Leaf

if(-not $NoFetch){
  & git -C $root fetch origin --prune | Out-Null
  if($LASTEXITCODE -ne 0){ Fail "git fetch failed for: $root" }
}

$env:CO_REPOROOT = $root
Write-Output $root