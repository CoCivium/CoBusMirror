Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$repo = "C:\Users\rball\Documents\GitHub\CoBusMirror"
$cgRoot = "C:\CoGuardian"
$transcript = Join-Path $cgRoot "session.log"
$heartbeat = Join-Path $cgRoot "tray_supervisor.heartbeat.txt"
$watcherLauncher = Join-Path $repo "tools\coguardian\Start-CoGuardianWatcher.ps1"
$bridgeLauncher  = Join-Path $repo "tools\coguardian\Start-CoGuardianQueueToCoBus.ps1"
$queueRoot = Join-Path $repo "docs\COBUS_LITE\watcher_queue"
$entryRoot = Join-Path $repo "docs\COBUS_LITE\entries"
$intentPath = Join-Path $repo "research\coprime_takeover\4.0_PRIME_260307\SESSION_INTENT_CAPTURE__4.0_PRIME_260307__LATEST.md"
$domainIndexPath = Join-Path $repo "docs\infrastructure\domain_registry\COCIVIUM_DOMAIN_INDEX__v0.1.md"
$metaSchemaPath = Join-Path $repo "research\coprime_takeover\4.0_PRIME_260307\COMETATRAIN_HEADER_SCHEMA__v0.1.md"
$protectionsPath = Join-Path $repo "docs\infrastructure\guardian\RECENT_PROTECTIONS__LATEST.md"
$coBeaconRaw = "https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBEACON_LATEST.txt"
$bossboardRaw = "https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBUS_LITE/BOSSBOARD.md"
$cohubPlaceholder = "https://github.com/CoCivium"
New-Item -ItemType Directory -Path $cgRoot -Force | Out-Null
if (-not (Test-Path $transcript)) { "" | Out-File -FilePath $transcript -Encoding utf8 }

function Start-Watcher {
    if (-not (Test-Path $watcherLauncher)) { [System.Windows.Forms.MessageBox]::Show("Missing launcher: $watcherLauncher") | Out-Null; return }
    Start-Process -FilePath "powershell.exe" -ArgumentList @("-ExecutionPolicy","Bypass","-File",$watcherLauncher,"-TranscriptPath",$transcript,"-RepoRoot",$repo) -WindowStyle Minimized | Out-Null
}

function Run-Bridge {
    if (-not (Test-Path $bridgeLauncher)) { [System.Windows.Forms.MessageBox]::Show("Missing bridge launcher: $bridgeLauncher") | Out-Null; return }
    Start-Process -FilePath "powershell.exe" -ArgumentList @("-ExecutionPolicy","Bypass","-File",$bridgeLauncher,"-RepoRoot",$repo) -WindowStyle Minimized | Out-Null
}

function Emit-TestEvent {
    $u = (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")
    $ptr = $metaSchemaPath
    $sha = "missing"
    if (Test-Path $ptr) { $sha = (Get-FileHash -Algorithm SHA256 -Path $ptr).Hash.ToLowerInvariant() }
    $line = "VIOLET_EVENT | KIND=DONE | FROM=4.0|PRIME|260307 | TO=Workflows | UTC=$u | STATE=doing | TOPIC=TrayHelpModelTest | PTR=$ptr | SHA=$sha ⊂ CoEvo advancing"
    Add-Content -Path $transcript -Value $line -Encoding utf8
    [System.Windows.Forms.MessageBox]::Show("Test event emitted.") | Out-Null
}

function Open-IfExists([string]$path) { if (Test-Path $path) { Start-Process explorer.exe $path | Out-Null } }
function Open-TextIfExists([string]$path) { if (Test-Path $path) { Start-Process notepad.exe $path | Out-Null } }
function Open-Url([string]$url) { Start-Process $url | Out-Null }

function Show-Status {
    $parts = @()
    $parts += "CoGuardian status"
    $parts += ""
    if (Test-Path $heartbeat) { $parts += "Supervisor heartbeat:"; $parts += (Get-Content $heartbeat -Raw -Encoding utf8).Trim(); $parts += "" }
    $parts += "Signal: CoEvo advancing"
    [System.Windows.Forms.MessageBox]::Show(($parts -join [Environment]::NewLine), "CoGuardian Status") | Out-Null
}

function Show-Troubleshooting {
    $msg = @(
        "Troubleshooting"
        ""
        "- If tray disappears, supervisor should restart it."
        "- If events are not flowing, inspect transcript, watcher queue, and CoBus entries."
        "- If queue grows but entries do not, run Queue-to-CoBus Bridge."
        "- If claims cannot be substantiated, treat them as noncanonical or recreatable."
        ""
        "Advanced contains operator controls."
    ) -join [Environment]::NewLine
    [System.Windows.Forms.MessageBox]::Show($msg, "Troubleshooting") | Out-Null
}

function Show-WhyThisMatters {
    $msg = @(
        "Why This Matters"
        ""
        "- CoGuardian is an AI hitch, not a fully standalone app."
        "- Chat memory is fragile; repo truth is recoverable."
        "- Receipts, pointers, and canon-aware artifacts reduce drift."
        "- CoGuardian helps make backend protection work visible."
        ""
        "CoEvo Together - divided we decay"
    ) -join [Environment]::NewLine
    [System.Windows.Forms.MessageBox]::Show($msg, "Why This Matters") | Out-Null
}

function Show-LearnAlign {
    $msg = @(
        "Learn / Align"
        ""
        "Assume first-time user by default."
        "CoGuardian exists to help you understand, trust, and use the session-linked system."
        "It is most useful when a recognized session context exists."
        ""
        "Open Recent Protections, the intent packet, or the CoMetaTrain schema for deeper context."
    ) -join [Environment]::NewLine
    [System.Windows.Forms.MessageBox]::Show($msg, "Learn / Align") | Out-Null
}

function Show-About {
    $msg = @(
        "About CoGuardian"
        ""
        "Signal: CoEvo advancing"
        "Motto: CoEvo Together - divided we decay"
        ""
        "Current role:"
        "- local trust shell"
        "- watcher launcher"
        "- queue bridge launcher"
        "- troubleshooting and orientation surface"
    ) -join [Environment]::NewLine
    [System.Windows.Forms.MessageBox]::Show($msg, "About CoGuardian") | Out-Null
}

$notify = New-Object System.Windows.Forms.NotifyIcon
$notify.Icon = [System.Drawing.SystemIcons]::Information
$notify.Visible = $true
$notify.Text = "CoGuardian v0.1"

$menu = New-Object System.Windows.Forms.ContextMenuStrip
$statusMenu = $menu.Items.Add("Status")
$troubleMenu = $menu.Items.Add("Troubleshooting")
$whyMenu = $menu.Items.Add("Why This Matters")
$learnMenu = $menu.Items.Add("Learn / Align")
$protectionsMenu = $menu.Items.Add("Recent Protections")
$advancedMenu = New-Object System.Windows.Forms.ToolStripMenuItem("Advanced")
$helpMenu = New-Object System.Windows.Forms.ToolStripMenuItem("Help")

$statusMenu.add_Click({ Show-Status })
$troubleMenu.add_Click({ Show-Troubleshooting })
$whyMenu.add_Click({ Show-WhyThisMatters })
$learnMenu.add_Click({ Show-LearnAlign })
$protectionsMenu.add_Click({ Open-TextIfExists $protectionsPath })

[void]$advancedMenu.DropDownItems.Add("Start Watcher").add_Click({ Start-Watcher })
[void]$advancedMenu.DropDownItems.Add("Run Queue-to-CoBus Bridge").add_Click({ Run-Bridge })
[void]$advancedMenu.DropDownItems.Add("Emit Test Event").add_Click({ Emit-TestEvent })
[void]$advancedMenu.DropDownItems.Add("Open Transcript").add_Click({ Open-TextIfExists $transcript })
[void]$advancedMenu.DropDownItems.Add("Open Watcher Queue").add_Click({ Open-IfExists $queueRoot })
[void]$advancedMenu.DropDownItems.Add("Open CoBus Entries").add_Click({ Open-IfExists $entryRoot })
[void]$advancedMenu.DropDownItems.Add("Open Repo Root").add_Click({ Open-IfExists $repo })

[void]$helpMenu.DropDownItems.Add("Open CoHub Placeholder").add_Click({ Open-Url $cohubPlaceholder })
[void]$helpMenu.DropDownItems.Add("Open CoBeacon RAW").add_Click({ Open-Url $coBeaconRaw })
[void]$helpMenu.DropDownItems.Add("Open BOSSBOARD RAW").add_Click({ Open-Url $bossboardRaw })
[void]$helpMenu.DropDownItems.Add("Open Domain Registry").add_Click({ Open-TextIfExists $domainIndexPath })
[void]$helpMenu.DropDownItems.Add("Open Latest Intent Packet").add_Click({ Open-TextIfExists $intentPath })
[void]$helpMenu.DropDownItems.Add("Open CoMetaTrain Header Schema").add_Click({ Open-TextIfExists $metaSchemaPath })
[void]$helpMenu.DropDownItems.Add("About CoGuardian").add_Click({ Show-About })

[void]$menu.Items.Add($advancedMenu)
[void]$menu.Items.Add($helpMenu)
[void]$menu.Items.Add("-")
$exitItem = $menu.Items.Add("Exit CoGuardian")
$exitItem.add_Click({
    $notify.Visible = $false
    $notify.Dispose()
    [System.Windows.Forms.Application]::Exit()
})

$notify.ContextMenuStrip = $menu
$notify.BalloonTipTitle = "CoGuardian"
$notify.BalloonTipText = "Trust shell loaded: first-time user framing, recent protections, and advanced controls available."
$notify.ShowBalloonTip(3000)

[System.Windows.Forms.Application]::Run()
