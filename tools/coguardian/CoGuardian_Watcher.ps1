function Write-CoSignal {
    param([string]$Text)
    Write-Host $Text -ForegroundColor Magenta
}
param(
    [Parameter(Mandatory=$true)][string]$TranscriptPath,
    [Parameter(Mandatory=$false)][string]$RepoRoot = "C:\Users\rball\Documents\GitHub\CoBusMirror"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function New-StableHash {
    param([string]$Text)
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try {
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($Text)
        $hash = $sha.ComputeHash($bytes)
        return ([System.BitConverter]::ToString($hash)).Replace("-","").ToLowerInvariant()
    }
    finally {
        $sha.Dispose()
    }
}

function Parse-VioletEvent {
    param([string]$Line)
    $parts = $Line -split "\s+\|\s+"
    if ($parts.Count -lt 2) { return $null }
    if ($parts[0].Trim() -ne "VIOLET_EVENT") { return $null }
    $map = [ordered]@{}
    $map["PREFIX"] = "VIOLET_EVENT"
    foreach ($p in $parts[1..($parts.Count-1)]) {
        if ($p -match "^\s*([A-Z_]+)=(.*)$") {
            $k = $matches[1].Trim()
            $v = $matches[2].Trim()
            $map[$k] = $v
        }
    }
    return [pscustomobject]$map
}

if (-not (Test-Path $TranscriptPath)) { throw "Transcript not found: $TranscriptPath" }
if (-not (Test-Path $RepoRoot)) { throw "RepoRoot not found: $RepoRoot" }

$processed = New-Object "System.Collections.Generic.HashSet[string]"
$queueRoot = Join-Path $RepoRoot "docs\COBUS_LITE\watcher_queue"
New-Item -ItemType Directory -Path $queueRoot -Force | Out-Null

Write-Host ("CoGuardian watcher started :: Transcript=" + $TranscriptPath)
Write-Host ("QueueRoot=" + $queueRoot)

Get-Content -LiteralPath $TranscriptPath -Wait | ForEach-Object {
    $line = $_
    if ($null -eq $line) { return }
    if ($line -notmatch "^VIOLET_EVENT\s+\|") { return }

    $eventHash = New-StableHash -Text $line
    if ($processed.Contains($eventHash)) { return }
    [void]$processed.Add($eventHash)

    $evt = Parse-VioletEvent -Line $line
    if ($null -eq $evt) { return }

    $now = (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")
    $y = $now.Substring(0,4)
    $m = $now.Substring(4,2)
    $d = $now.Substring(6,2)
    $outDir = Join-Path $queueRoot "$y\$m\$d"
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null

    $safeFrom = "unknown"
    if ($evt.PSObject.Properties.Name -contains "FROM" -and -not [string]::IsNullOrWhiteSpace($evt.FROM)) {
        $safeFrom = ($evt.FROM -replace "[^A-Za-z0-9\._-]","_")
    }

    $outPath = Join-Path $outDir ($now + "__" + $safeFrom + "__" + $eventHash + ".txt")

    $payload = @()
    $payload += "UTC_CAPTURED: $now"
    $payload += "EVENT_HASH: $eventHash"
    $payload += "RAW_LINE: $line"
    $payload += ""
    foreach ($prop in $evt.PSObject.Properties) {
        $payload += ($prop.Name + ": " + [string]$prop.Value)
    }

    $payload | Out-File -FilePath $outPath -Encoding utf8
    Write-CoSignal ("WATCHER_CAPTURED: " + $outPath)
}


