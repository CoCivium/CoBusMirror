param(
    [Parameter(Mandatory=$false)][string]$TranscriptPath = "C:\CoGuardian\session.log",
    [Parameter(Mandatory=$false)][string]$RepoRoot = "C:\Users\rball\Documents\GitHub\CoBusMirror"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$watcher = Join-Path $RepoRoot "tools\coguardian\CoGuardian_Watcher.ps1"
if (-not (Test-Path $watcher)) { throw "Watcher missing: $watcher" }

New-Item -ItemType Directory -Path (Split-Path -Parent $TranscriptPath) -Force | Out-Null
if (-not (Test-Path $TranscriptPath)) {
    "" | Out-File -FilePath $TranscriptPath -Encoding utf8
}

Write-Host ("STARTING WATCHER :: " + $watcher)
Write-Host ("TRANSCRIPT :: " + $TranscriptPath)
& powershell -ExecutionPolicy Bypass -File $watcher -TranscriptPath $TranscriptPath -RepoRoot $RepoRoot
