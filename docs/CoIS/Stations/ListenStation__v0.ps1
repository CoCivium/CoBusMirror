param(
    [Parameter(Mandatory)][string]$InputType,
    [Parameter(Mandatory)][string]$InputPath,
    [Parameter(Mandatory)][string]$ConfigPath,
    [Parameter(Mandatory)][string]$LogRoot,
    [Parameter(Mandatory)][string]$EntropyRoot
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

function Get-EntropyScore([string]$text) {
    if ([string]::IsNullOrWhiteSpace($text)) { return 0.0 }
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
    $freq = @{}
    foreach ($b in $bytes) { if ($freq.ContainsKey($b)) { $freq[$b]++ } else { $freq[$b] = 1 } }
    $entropy = 0.0
    foreach ($count in $freq.Values) {
        $p = $count / $bytes.Length
        $entropy -= $p * [Math]::Log($p, 2)
    }
    [Math]::Round($entropy, 3)
}

function Get-Compressibility([string]$text) {
    if ([string]::IsNullOrEmpty($text) -or $text.Length -lt 32) { return 0.0 }
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
    $ms = New-Object System.IO.MemoryStream
    $ds = New-Object System.IO.Compression.DeflateStream($ms, [IO.Compression.CompressionMode]::Compress)
    $ds.Write($bytes, 0, $bytes.Length)
    $ds.Close()
    $ratio = 1 - ($ms.Length / [double]$bytes.Length)
    [Math]::Round([Math]::Max(0.0, $ratio), 3)
}

if (-not (Test-Path $InputPath)) { throw "INPUT_NOT_FOUND: $InputPath" }
if (-not (Test-Path $ConfigPath)) { throw "CONFIG_NOT_FOUND: $ConfigPath" }

$config = Get-Content -LiteralPath $ConfigPath -Raw | ConvertFrom-Json
$content = Get-Content -LiteralPath $InputPath -Raw

$entropy  = Get-EntropyScore $content
$compress = Get-Compressibility $content
$length   = $content.Length

$class = "noise"
$confidence = 0.2

if ($length -ge $config.min_length -and $compress -ge $config.thresholds.candidate_signal.compressibility -and $entropy -ge $config.thresholds.candidate_signal.entropy) {
    $class = "candidate_signal"
    $confidence = 0.7
}
elseif ($length -ge $config.min_length -and $compress -ge $config.thresholds.structured_anomaly.compressibility -and $entropy -ge $config.thresholds.structured_anomaly.entropy) {
    $class = "structured_anomaly"
    $confidence = 0.5
}

$stamp = (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")
$base  = "{0}__{1}" -f $InputType, $stamp

$record = [ordered]@{
    utc           = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    input_type    = $InputType
    input_path    = $InputPath
    config_path   = $ConfigPath
    class         = $class
    entropy       = $entropy
    compress      = $compress
    length        = $length
    confidence    = $confidence
    action        = if ($class -eq "candidate_signal") { "store_and_flag" } elseif ($class -eq "structured_anomaly") { "store_only" } else { "discard_or_archive" }
}

$logPath = Join-Path $LogRoot ("log__" + $base + ".json")
$record | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $logPath -Encoding UTF8

if ($class -ne "noise") {
    $entropyPath = Join-Path $EntropyRoot ("entropy__" + $base + ".txt")
    $content | Set-Content -LiteralPath $entropyPath -Encoding UTF8
}

Write-Host "STATE=observation"
Write-Host "INPUT_TYPE=$InputType"
Write-Host "CLASS=$class"
Write-Host "ENTROPY=$entropy"
Write-Host "COMPRESS=$compress"
Write-Host "CONFIDENCE=$confidence"
Write-Host "LOG=$logPath"
