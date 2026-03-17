param(
    [Parameter(Mandatory=$false)][string]$RepoRoot = "C:\Users\rball\Documents\GitHub\CoBusMirror"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$router = Join-Path $RepoRoot "tools\coguardian\CoGuardian_CoBusToTargetQueue.ps1"
if (-not (Test-Path $router)) { throw "Router missing: $router" }
Write-Host ("RUNNING ROUTER :: " + $router)
& powershell -ExecutionPolicy Bypass -File $router -RepoRoot $RepoRoot
