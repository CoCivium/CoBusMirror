param([string]$Root = (git rev-parse --show-toplevel))
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'

$pat = 'raw\.githubusercontent\.com/.+/main/'
$targets = @(
  Join-Path $Root 'docs/COBUS_LITE/canon',
  Join-Path $Root 'docs/COBUS_LITE/index',
  Join-Path $Root 'docs/COBUS_LITE/registry'
) | Where-Object { Test-Path -LiteralPath $_ }

$hits = @()
foreach($t in $targets){
  $_hits = Select-String -Path (Join-Path $t '*') -Pattern $pat -AllMatches -ErrorAction SilentlyContinue
  if($_hits){ $hits += $_hits }
}

if($hits.Count -gt 0){
  Write-Host "`nFAIL: /main RAW leakage detected:`n"
  foreach($h in $hits){
    Write-Host ("{0}:{1}: {2}" -f $h.Path, $h.LineNumber, $h.Line)
  }
  exit 2
}
