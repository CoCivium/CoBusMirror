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

function Parse-EntryFile {
    param([string]$Path)
    $lines = Get-Content -LiteralPath $Path -Encoding utf8
    $map = [ordered]@{}
    foreach ($line in $lines) {
        if ($line -match "^\s*([A-Z_]+):\s*(.*)$") {
            $map[$matches[1].Trim()] = $matches[2]
        }
        elseif ($line -match "^\s*-\s*([A-Z_]+)=(.*)$") {
            $map[$matches[1].Trim()] = $matches[2]
        }
    }
    return [pscustomobject]$map
}

if (-not (Test-Path $RepoRoot)) { throw "RepoRoot not found: $RepoRoot" }

$entryRoot = Join-Path $RepoRoot "docs\COBUS_LITE\entries"
$targetRoot = Join-Path $RepoRoot "docs\COBUS_LITE\target_queue"
if (-not (Test-Path $entryRoot)) { throw "Entry root not found: $entryRoot" }
New-Item -ItemType Directory -Path $targetRoot -Force | Out-Null

$files = Get-ChildItem -Path $entryRoot -Recurse -File -Filter "*WatcherEvent*.md" -ErrorAction SilentlyContinue |
    Where-Object { -not (Test-Path ($_.FullName + ".targeted")) } |
    Sort-Object LastWriteTimeUtc

foreach ($f in $files) {
    $m = Parse-EntryFile -Path $f.FullName

    $from = Get-MapValue -Map $m -Key "FROM" -Default "unknown"
    $utcv = Get-MapValue -Map $m -Key "UTC" -Default ((Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ"))
    $state = Get-MapValue -Map $m -Key "STATE" -Default "doing"
    $ptr = Get-MapValue -Map $m -Key "PTR" -Default $f.FullName
    $sha = Get-MapValue -Map $m -Key "SHA" -Default ""
    $to  = Get-MapValue -Map $m -Key "TO" -Default "UNROUTED"
    $kind = Get-MapValue -Map $m -Key "KIND" -Default "UNKNOWN"

    $safeTo = ($to -replace "[^A-Za-z0-9\._-]","_")
    $safeFrom = ($from -replace "[^A-Za-z0-9\._-]","_")

    $y = $utcv.Substring(0,4)
    $mo = $utcv.Substring(4,2)
    $d = $utcv.Substring(6,2)
    $outDir = Join-Path $targetRoot "$safeTo\$y\$mo\$d"
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null

    $outPath = Join-Path $outDir ($utcv + "__" + $safeFrom + "__" + $kind + ".txt")
    $n = 1
    while (Test-Path $outPath) {
        $outPath = Join-Path $outDir ($utcv + "__" + $safeFrom + "__" + $kind + "__" + $n + ".txt")
        $n++
    }

    @(
        "UTC_ROUTED: $((Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ"))",
        "FROM: $from",
        "TO: $to",
        "UTC: $utcv",
        "STATE: $state",
        "KIND: $kind",
        "PTR: $ptr",
        "SHA: $sha",
        "SOURCE_COBUS_ENTRY: $($f.FullName)"
    ) | Out-File -FilePath $outPath -Encoding utf8

    @(
        "UTC_TARGETED=" + ((Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")),
        "TARGET_QUEUE_FILE=" + $outPath
    ) | Out-File -FilePath ($f.FullName + ".targeted") -Encoding utf8

    Write-CoSignal ("ROUTED: " + $outPath)
}

