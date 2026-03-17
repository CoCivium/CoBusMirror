param(
    [Parameter(Mandatory=$false)][string]$RepoRoot = "C:\Users\rball\Documents\GitHub\CoBusMirror"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$bridge = Join-Path $RepoRoot "tools\coguardian\CoGuardian_QueueToCoBus.ps1"
if (-not (Test-Path $bridge)) { throw "Bridge missing: $bridge" }

Write-Host ("RUNNING BRIDGE :: " + $bridge)
& powershell -ExecutionPolicy Bypass -File $bridge -RepoRoot $RepoRoot
