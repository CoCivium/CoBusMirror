param(
  [Parameter(Mandatory=$true)][string]$Repo,     # Org/Repo
  [string]$RepoDir = ''                          # optional, default = current repo root
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
function Fail([string]$m){ throw "FAIL-CLOSED: $m" }

if([string]::IsNullOrWhiteSpace($Repo) -or $Repo -notmatch '^[^/]+/[^/]+$'){ Fail "Repo must be Org/Repo" }

$here = if($RepoDir){ $RepoDir } else { (git rev-parse --show-toplevel 2>$null).Trim() }
if(-not $here){ Fail "Not in a git repo (no toplevel)" }

$leaf = Split-Path $here -Leaf
if($leaf -ne ($Repo.Split('/')[1])){ Fail "RepoDir leaf mismatch (dir=$leaf expected=$(($Repo.Split('/')[1])))" }

$origin = (git -C $here remote get-url origin 2>$null).Trim()
if(-not $origin){ Fail "Missing origin remote" }
if($origin -notmatch [regex]::Escape($Repo)){ Fail "origin mismatch: $origin (expected contains $Repo)" }

if(Get-Command gh -ErrorAction SilentlyContinue){
  $seen = (gh repo view $Repo --json nameWithOwner --jq .nameWithOwner 2>$null).Trim()
  if(-not $seen){ Fail "gh cannot view $Repo (auth/typo?)" }
  if($seen -ne $Repo){ Fail "gh repo mismatch: $seen != $Repo" }
}

"OK: RepoIdentityGuard PASS Repo=$Repo Dir=$here"