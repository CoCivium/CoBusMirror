$ErrorActionPreference="Stop"; Set-StrictMode -Version Latest
if (Get-Variable -Name PSNativeCommandUseErrorActionPreference -Scope Global -ErrorAction SilentlyContinue) { $global:PSNativeCommandUseErrorActionPreference = $false }

function Find-GitHubRoot {
  $candidates = @((Join-Path $HOME "Documents\GitHub"),(Join-Path $HOME "GitHub"),(Join-Path $HOME "source\repos")) | Where-Object { $_ -and (Test-Path $_) }
  if($candidates.Count -eq 0){ throw "No GitHub root folder found under HOME. Create `$HOME\Documents\GitHub." }
  return $candidates[0]
}
function Ensure-Repo([string]$orgRepo,[string]$localPath){
  if(Test-Path $localPath){ if(-not (Test-Path (Join-Path $localPath ".git"))){ throw "Path exists but is not a git repo: $localPath" }; return }
  New-Item -ItemType Directory -Force -Path (Split-Path $localPath -Parent) | Out-Null
  if(Get-Command gh -ErrorAction SilentlyContinue){ & gh repo clone $orgRepo $localPath; if($LASTEXITCODE -ne 0){ throw "gh clone failed: $orgRepo -> $localPath" } }
  elseif(Get-Command git -ErrorAction SilentlyContinue){ & git clone ("https://github.com/$orgRepo.git") $localPath; if($LASTEXITCODE -ne 0){ throw "git clone failed: $orgRepo -> $localPath" } }
  else { throw "Neither gh nor git is available in PATH." }
  if(-not (Test-Path (Join-Path $localPath ".git"))){ throw "Clone claimed success but .git missing: $localPath" }
}
function Assert-RepoRoot([string]$repoPath,[string]$expectedLeaf){
  if(-not (Test-Path (Join-Path $repoPath ".git"))){ throw "No .git at repoPath: $repoPath" }
  $root = (& git -C $repoPath rev-parse --show-toplevel 2>$null).Trim()
  if(-not $root){ throw "git rev-parse failed at: $repoPath" }
  $leaf = Split-Path $root -Leaf
  if($leaf -ne $expectedLeaf){ throw "Safety stop: repo leaf '$leaf' != expected '$expectedLeaf' (root=$root)" }
  return $root
}

param(
  [Parameter(Mandatory=$true)][string]$OrgRepo,
  [Parameter(Mandatory=$true)][string]$Leaf
)

$ghRoot = Find-GitHubRoot
$local  = Join-Path $ghRoot $Leaf
Ensure-Repo $OrgRepo $local
$repoRoot = Assert-RepoRoot $local $Leaf
Set-Location $repoRoot
$env:CO_REPOROOT = $repoRoot
"OK: CO_REPOROOT=$repoRoot (cwd set). All subsequent writes MUST be under this repoRoot."