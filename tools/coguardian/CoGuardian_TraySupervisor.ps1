param(
    [Parameter(Mandatory=$false)][string]$RepoRoot = "C:\Users\rball\Documents\GitHub\CoBusMirror",
    [Parameter(Mandatory=$false)][int]$PollSeconds = 8
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$cgRoot = "C:\CoGuardian"
$trayHost = Join-Path $RepoRoot "tools\coguardian\CoGuardian_TrayHost.ps1"
$logPath = Join-Path $cgRoot "tray_supervisor.log"
$heartbeatPath = Join-Path $cgRoot "tray_supervisor.heartbeat.txt"
New-Item -ItemType Directory -Path $cgRoot -Force | Out-Null

$script:RestartTimes = New-Object System.Collections.Generic.List[datetime]

function LogLine {
    param([string]$Text)
    $u = (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")
    Add-Content -Path $logPath -Value ($u + " " + $Text) -Encoding utf8
    Set-Content -Path $heartbeatPath -Value ($u + " " + $Text) -Encoding utf8
}

function Get-TrayProc {
    Get-CimInstance Win32_Process |
        Where-Object { $_.CommandLine -like "*CoGuardian_TrayHost.ps1*" } |
        Select-Object -First 1
}

function Allow-Restart {
    $now = [datetime]::UtcNow
    $cut = $now.AddMinutes(-2)
    $keep = New-Object System.Collections.Generic.List[datetime]
    foreach ($t in $script:RestartTimes) { if ($t -ge $cut) { [void]$keep.Add($t) } }
    $script:RestartTimes = $keep
    if ($script:RestartTimes.Count -ge 5) { return $false }
    [void]$script:RestartTimes.Add($now)
    return $true
}

if (-not (Test-Path $trayHost)) { throw "Tray host missing: $trayHost" }
LogLine "SUPERVISOR_START trayHost=$trayHost"

while ($true) {
    try {
        $p = Get-TrayProc
        if ($null -eq $p) {
            if (Allow-Restart) {
                $proc = Start-Process -FilePath "powershell.exe" -ArgumentList @(
                    "-ExecutionPolicy","Bypass",
                    "-File",$trayHost
                ) -WindowStyle Minimized -PassThru
                LogLine ("TRAY_RESTART pid=" + $proc.Id)
                Start-Sleep -Seconds 3
            }
            else {
                LogLine "TRAY_BACKOFF too_many_restarts_in_2min"
                Start-Sleep -Seconds 30
            }
        }
        else {
            LogLine ("TRAY_OK pid=" + $p.ProcessId)
        }
    }
    catch {
        LogLine ("SUPERVISOR_ERROR " + $_.Exception.Message)
    }
    Start-Sleep -Seconds $PollSeconds
}
