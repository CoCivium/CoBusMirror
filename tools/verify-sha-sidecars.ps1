Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
function Fail([string]$m){ throw "FAIL-CLOSED: $m" }

$root = (git rev-parse --show-toplevel 2>$null).Trim()
if(-not $root){ Fail "Not in a git repo" }

$scanRoots = @(
  (Join-Path $root 'docs\inbox'),
  (Join-Path $root 'tools'),
  (Join-Path $root '.github\workflows')
) | Where-Object { Test-Path $_ }

if(-not $scanRoots -or $scanRoots.Count -eq 0){
  Fail "No scanRoots found; refusing to enforce empty scope."
}

$shaFiles = foreach($sr in $scanRoots){
  Get-ChildItem -LiteralPath $sr -Recurse -File -Filter '*.sha256'
}

foreach($sf in $shaFiles){
  $t = Get-Content -LiteralPath $sf.FullName -Raw
  $parts = ($t -split '\s+')
  if($parts.Count -lt 2){ Fail "Bad sha file format: $($sf.FullName)" }
  $exp = $parts[0].Trim().ToLower()
  $leaf = $parts[1].Trim()
  if($exp -notmatch '^[0-9a-f]{64}$'){ Fail "Bad sha hash: $($sf.FullName)" }

  $target = Join-Path $sf.DirectoryName $leaf
  if(-not (Test-Path $target)){ Fail "Missing target for sha sidecar: $($sf.FullName) -> $leaf" }

  $act = (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash.ToLower()
  if($act -ne $exp){ Fail "SHA mismatch: $($sf.FullName) target=$leaf" }
}

"PASS: verify-sha-sidecars (scoped)"