param(
    [Parameter(Mandatory)][string]$ConfigPath,
    [Parameter(Mandatory)][string]$LogRoot,
    [Parameter(Mandatory)][string]$PlaneRoot
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$config = Get-Content -LiteralPath $ConfigPath -Raw | ConvertFrom-Json
$window = [int]$config.correlation_window_minutes
$maxScan = [int]$config.max_files_scan

$logs = Get-ChildItem -LiteralPath $LogRoot -Filter "log__*.json" -File -ErrorAction SilentlyContinue |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First $maxScan

$records = @()
foreach ($f in $logs) {
    try {
        $j = Get-Content -LiteralPath $f.FullName -Raw | ConvertFrom-Json
        $utc = [datetime]::Parse($j.utc).ToUniversalTime()
        $records += [pscustomobject]@{
            file       = $f.FullName
            utc        = $utc
            input_type = [string]$j.input_type
            class      = [string]$j.class
            confidence = [double]$j.confidence
            entropy    = [double]$j.entropy
            compress   = [double]$j.compress
            length     = [int]$j.length
        }
    } catch {}
}

if (-not $records) {
    Write-Host "STATE=idle NO_RECORDS"
    exit 0
}

$now = (Get-Date).ToUniversalTime()
$recent = $records | Where-Object { $_.utc -ge $now.AddMinutes(-$window) }

# Cross-surface hint: same class on >=2 input types in window
$classGroups = $recent | Group-Object class
$crossSurfaceClasses = @{}
foreach ($g in $classGroups) {
    $types = $g.Group.input_type | Select-Object -Unique
    if (($types | Measure-Object).Count -ge 2) {
        $crossSurfaceClasses[$g.Name] = $true
    }
}

$stamp = $now.ToString("yyyyMMddTHHmmssZ")
$summary = [System.Collections.Generic.List[string]]::new()
$summary.Add("# CoIS Notification Routing Run")
$summary.Add("UTC: $stamp")
$summary.Add("")

foreach ($planeName in @("shadow","advisory","escalation","hold")) {
    $plane = $config.planes.$planeName
    $outDir = Join-Path $PlaneRoot $plane.output_subdir
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null

    $matches = $recent | Where-Object {
        ($plane.classes -contains $_.class) -and
        ($_.confidence -ge [double]$plane.min_confidence) -and
        (
            (-not [bool]$plane.require_cross_surface) -or
            ($crossSurfaceClasses.ContainsKey($_.class))
        )
    }

    $summary.Add("## $planeName")
    $summary.Add("count=$($matches.Count)")

    if ($matches.Count -gt 0) {
        $path = Join-Path $outDir ("alert__{0}__{1}.md" -f $planeName, $stamp)
        $lines = [System.Collections.Generic.List[string]]::new()
        $lines.Add("# CoIS Alert")
        $lines.Add("UTC: $stamp")
        $lines.Add("PLANE: $planeName")
        $lines.Add("")

        foreach ($m in $matches | Select-Object -First 20) {
            $lines.Add("- input_type=$($m.input_type) class=$($m.class) confidence=$($m.confidence) entropy=$($m.entropy) compress=$($m.compress)")
        }

        $lines | Set-Content -LiteralPath $path -Encoding UTF8
        $summary.Add("alert_file=$path")
    }

    $summary.Add("")
}

$runPath = Join-Path $PlaneRoot ("routing_run__" + $stamp + ".md")
$summary | Set-Content -LiteralPath $runPath -Encoding UTF8

Write-Host "STATE=ok"
Write-Host "RUN=$runPath"
