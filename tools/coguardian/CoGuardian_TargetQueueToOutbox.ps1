param(
    [Parameter(Mandatory=$false)][string]$RepoRoot = "C:\Users\rball\Documents\GitHub\CoBusMirror"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (-not (Test-Path $RepoRoot)) { throw "RepoRoot not found: $RepoRoot" }

$targetRoot = Join-Path $RepoRoot "docs\COBUS_LITE\target_queue"
$outboxRoot = Join-Path $RepoRoot "docs\COBUS_LITE\outbox"
New-Item -ItemType Directory -Path $outboxRoot -Force | Out-Null
if (-not (Test-Path $targetRoot)) { throw "Target root not found: $targetRoot" }

$files = Get-ChildItem -Path $targetRoot -Recurse -File -Filter "*.txt" -ErrorAction SilentlyContinue |
    Where-Object { -not (Test-Path ($_.FullName + ".outboxed")) } |
    Sort-Object LastWriteTimeUtc

foreach ($f in $files) {
    $lines = Get-Content -LiteralPath $f.FullName -Encoding utf8
    $map = [ordered]@{}
    foreach ($line in $lines) {
        if ($line -match "^\s*([A-Z_]+):\s*(.*)$") { $map[$matches[1].Trim()] = $matches[2] }
    }

    $to = if ($map.Contains("TO")) { [string]$map["TO"] } else { "UNROUTED" }
    $from = if ($map.Contains("FROM")) { [string]$map["FROM"] } else { "unknown" }
    $utc = if ($map.Contains("UTC")) { [string]$map["UTC"] } else { (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ") }
    $state = if ($map.Contains("STATE")) { [string]$map["STATE"] } else { "doing" }
    $kind = if ($map.Contains("KIND")) { [string]$map["KIND"] } else { "UNKNOWN" }
    $ptr = if ($map.Contains("PTR")) { [string]$map["PTR"] } else { $f.FullName }
    $sha = if ($map.Contains("SHA")) { [string]$map["SHA"] } else { "" }

    $safeTo = ($to -replace "[^A-Za-z0-9\._-]","_")
    $safeFrom = ($from -replace "[^A-Za-z0-9\._-]","_")
    $y = $utc.Substring(0,4)
    $m = $utc.Substring(4,2)
    $d = $utc.Substring(6,2)

    $outDir = Join-Path $outboxRoot "$safeTo\$y\$m\$d"
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null

    $outPath = Join-Path $outDir ($utc + "__" + $safeFrom + "__" + $kind + ".txt")
    $n = 1
    while (Test-Path $outPath) {
        $outPath = Join-Path $outDir ($utc + "__" + $safeFrom + "__" + $kind + "__" + $n + ".txt")
        $n++
    }

    @(
        "UTC_OUTBOXED: $((Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ"))",
        "FROM: $from",
        "TO: $to",
        "UTC: $utc",
        "STATE: $state",
        "KIND: $kind",
        "PTR: $ptr",
        "SHA: $sha",
        "SOURCE_TARGET_QUEUE: $($f.FullName)",
        "MODE: post_stub_only"
    ) | Out-File -FilePath $outPath -Encoding utf8

    @(
        "UTC_OUTBOXED=" + ((Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")),
        "OUTBOX_FILE=" + $outPath
    ) | Out-File -FilePath ($f.FullName + ".outboxed") -Encoding utf8

    Write-Host ("OUTBOXED: " + $outPath) -ForegroundColor Cyan
}
