param(
    [string]$InputType = "model",   # model | dataset | log
    [string]$InputPath = ""
)

function Get-EntropyScore($text) {
    if ([string]::IsNullOrWhiteSpace($text)) { return 0 }
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
    $freq = @{}
    foreach ($b in $bytes) { $freq[$b] = ($freq[$b] + 1) }
    $entropy = 0.0
    foreach ($count in $freq.Values) {
        $p = $count / $bytes.Length
        $entropy -= $p * [Math]::Log($p,2)
    }
    return [Math]::Round($entropy,3)
}

function Get-Compressibility($text) {
    if ($text.Length -eq 0) { return 0 }
    $compressed = [System.IO.Compression.DeflateStream]::new(
        [System.IO.MemoryStream]::new(),
        [System.IO.Compression.CompressionMode]::Compress
    )
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
    $ms = New-Object System.IO.MemoryStream
    $ds = New-Object System.IO.Compression.DeflateStream($ms, [IO.Compression.CompressionMode]::Compress)
    $ds.Write($bytes,0,$bytes.Length)
    $ds.Close()
    return 1 - ($ms.Length / $bytes.Length)
}

function Classify($entropy,$compress) {
    if ($compress -gt 0.6 -and $entropy -gt 3) { return "candidate_signal" }
    if ($compress -gt 0.4) { return "structured_anomaly" }
    return "noise"
}

# -----------------------------
# INGEST
# -----------------------------
if (-not (Test-Path $InputPath)) {
    Write-Host "STATE=blocked INPUT_NOT_FOUND"
    exit 1
}

$content = Get-Content $InputPath -Raw

# -----------------------------
# ANALYZE
# -----------------------------
$entropy  = Get-EntropyScore $content
$compress = Get-Compressibility $content
$class    = Classify $entropy $compress

# -----------------------------
# OUTPUT RECORD
# -----------------------------
$record = @{
    UTC        = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    CLASS      = $class
    ENTROPY    = $entropy
    COMPRESS   = [Math]::Round($compress,3)
    LENGTH     = $content.Length
    CONFIDENCE = if ($class -eq "candidate_signal") { 0.7 } elseif ($class -eq "structured_anomaly") { 0.5 } else { 0.2 }
}

$logPath = Join-Path "'"$LogDir"'" ("log__" + (Get-Date -Format "yyyyMMddTHHmmssZ") + ".json")
$record | ConvertTo-Json -Depth 3 | Set-Content $logPath

# -----------------------------
# ENTROPY HARVEST
# -----------------------------
if ($class -ne "noise") {
    $entropyPath = Join-Path "'"$EntropyDir"'" ("entropy__" + (Get-Date -Format "yyyyMMddTHHmmssZ") + ".txt")
    $content | Set-Content $entropyPath
}

# -----------------------------
# EMIT (bounded)
# -----------------------------
Write-Host "STATE=observation"
Write-Host "CLASS=$class"
Write-Host "ENTROPY=$entropy"
Write-Host "COMPRESS=$compress"
Write-Host "CONFIDENCE=$($record.CONFIDENCE)"
Write-Host "ACTION=$(if ($class -eq 'candidate_signal') {'store_and_flag'} else {'store_only'})"
