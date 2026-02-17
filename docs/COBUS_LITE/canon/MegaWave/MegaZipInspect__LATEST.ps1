param([Parameter(Mandatory=$true)][string]$MegaZipPath)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'
function Fail([string]$m){ throw "FAIL-CLOSED: $m" }
function UTS { (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ') }
function SHA256([string]$p){ (Get-FileHash -Algorithm SHA256 -LiteralPath $p).Hash.ToLowerInvariant() }

$utc = UTS
if(-not (Test-Path -LiteralPath $MegaZipPath)){ Fail "MegaZip missing: $MegaZipPath" }

$sha = SHA256 $MegaZipPath
$stage = Join-Path $env:TEMP ("MegaZipInspect__{0}" -f $utc)
New-Item -ItemType Directory -Force -Path $stage | Out-Null
try {
  Expand-Archive -LiteralPath $MegaZipPath -DestinationPath $stage -Force
  $manifestPath = Join-Path $stage 'manifest\MANIFEST.json'
  if(-not (Test-Path -LiteralPath $manifestPath)){ Fail "NOT_A_MEGAZIP: manifest\MANIFEST.json missing" }
  $manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
  $planCount = @($manifest.plan).Count
  $lastId = if($planCount -gt 0){ $manifest.plan[$planCount-1].id } else { "" }
  $scriptCount = (Get-ChildItem -LiteralPath (Join-Path $stage 'scripts') -Filter '*.ps1' -File -ErrorAction SilentlyContinue | Measure-Object).Count
  Write-Host ("MEGAZIP_INSPECT|UTC={0}|PATH={1}|SHA256={2}|MEGAZIP_ID={3}|PLAN_COUNT={4}|SCRIPTS_COUNT={5}|LAST_STEP_ID={6}" -f $utc,$MegaZipPath,$sha,$manifest.megazip_id,$planCount,$scriptCount,$lastId)
} finally {
  try { Remove-Item -LiteralPath $stage -Recurse -Force -ErrorAction SilentlyContinue } catch {}
}
