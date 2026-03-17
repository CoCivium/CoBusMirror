function Write-CoSignal {
    param([string]$Text)
    Write-Host $Text -ForegroundColor Magenta
}
param(
    [Parameter(Mandatory=$false)][string]$RepoRoot = "C:\Users\rball\Documents\GitHub\CoBusMirror"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Get-MapValue {
    param($Map,[string]$Key,[string]$Default="")
    if ($null -eq $Map) { return $Default }
    if ($Map.PSObject.Properties.Name -contains $Key) {
        $v = [string]$Map.$Key
        if (-not [string]::IsNullOrWhiteSpace($v)) { return $v }
    }
    return $Default
}

function Parse-QueueFile {
    param([string]$Path)
    $lines = Get-Content -LiteralPath $Path -Encoding utf8
    $map = [ordered]@{}
    foreach ($line in $lines) {
        if ($line -match "^\s*([A-Z_]+):\s*(.*)$") {
            $map[$matches[1].Trim()] = $matches[2]
        }
    }
    return [pscustomobject]$map
}

if (-not (Test-Path $RepoRoot)) { throw "RepoRoot not found: $RepoRoot" }

$queueRoot = Join-Path $RepoRoot "docs\COBUS_LITE\watcher_queue"
$entryRoot = Join-Path $RepoRoot "docs\COBUS_LITE\entries"
if (-not (Test-Path $queueRoot)) { throw "Queue root not found: $queueRoot" }
New-Item -ItemType Directory -Path $entryRoot -Force | Out-Null

$files = Get-ChildItem -Path $queueRoot -Recurse -File -Filter "*.txt" -ErrorAction SilentlyContinue |
    Where-Object { -not (Test-Path ($_.FullName + ".processed")) } |
    Sort-Object LastWriteTimeUtc

foreach ($f in $files) {
    $m = Parse-QueueFile -Path $f.FullName

    $from = Get-MapValue -Map $m -Key "FROM" -Default "unknown"
    $utc  = Get-MapValue -Map $m -Key "UTC" -Default ((Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ"))
    $state = Get-MapValue -Map $m -Key "STATE" -Default "doing"
    $topic = Get-MapValue -Map $m -Key "TOPIC" -Default ("watcher event " + (Get-MapValue -Map $m -Key "KIND" -Default "UNKNOWN"))
    $ptr = Get-MapValue -Map $m -Key "PTR" -Default $f.FullName
    $sha = Get-MapValue -Map $m -Key "SHA" -Default ""
    $kind = Get-MapValue -Map $m -Key "KIND" -Default "UNKNOWN"
    $to = Get-MapValue -Map $m -Key "TO" -Default ""
    $eventHash = Get-MapValue -Map $m -Key "EVENT_HASH" -Default ([IO.Path]::GetFileNameWithoutExtension($f.Name))

    $y = $utc.Substring(0,4)
    $mo = $utc.Substring(4,2)
    $d = $utc.Substring(6,2)
    $entryDir = Join-Path $entryRoot "$y\$mo\$d"
    New-Item -ItemType Directory -Path $entryDir -Force | Out-Null

    $safeFrom = ($from -replace "[^A-Za-z0-9\._-]","_")
    $entryPath = Join-Path $entryDir ($utc + "__" + $safeFrom + "__WatcherEvent.md")
    $n = 1
    while (Test-Path $entryPath) {
        $entryPath = Join-Path $entryDir ($utc + "__" + $safeFrom + "__WatcherEvent__" + $n + ".md")
        $n++
    }

    @(
        "FROM: $from",
        "UTC: $utc",
        "STATE: $state",
        "TOPIC: watcher bridge event $kind",
        "",
        "SHIPPED:",
        "- SOURCE_QUEUE_FILE=$($f.FullName)",
        "- EVENT_HASH=$eventHash",
        "",
        "BLOCKED:",
        "- none",
        "",
        "NEXT:",
        "- target=$to",
        "",
        "PTRS:",
        "- PTR=$ptr",
        "- SHA=$sha",
        "- TO=$to",
        "- KIND=$kind",
        ""
    ) | Out-File -FilePath $entryPath -Encoding utf8

    @(
        "UTC_PROCESSED=" + ((Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")),
        "SOURCE_QUEUE_FILE=" + $f.FullName,
        "COBUS_ENTRY=" + $entryPath
    ) | Out-File -FilePath ($f.FullName + ".processed") -Encoding utf8

    Write-CoSignal ("BRIDGED: " + $entryPath)
}

