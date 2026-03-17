param(
    [Parameter(Mandatory=$false)][string]$RepoRoot = "C:\Users\rball\Documents\GitHub\CoBusMirror"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$super = Join-Path $RepoRoot "tools\coguardian\CoGuardian_TraySupervisor.ps1"
if (-not (Test-Path $super)) { throw "Supervisor missing: $super" }

# stop older supervisor copies
Get-CimInstance Win32_Process |
    Where-Object { $_.CommandLine -like "*CoGuardian_TraySupervisor.ps1*" } |
    ForEach-Object {
        try { Stop-Process -Id $_.ProcessId -Force -ErrorAction Stop } catch {}
    }

Start-Sleep -Seconds 1

$p = Start-Process -FilePath "powershell.exe" -ArgumentList @(
    "-ExecutionPolicy","Bypass",
    "-File",$super,
    "-RepoRoot",$RepoRoot
) -WindowStyle Minimized -PassThru

Write-Host ("SUPERVISOR_PID: " + $p.Id)
