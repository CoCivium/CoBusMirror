param(
  [int]$HistoryN = 5,
  [string]$ClassesPath = (Join-Path (git rev-parse --show-toplevel) 'docs/COBUS_LITE/canon/ASSET_CLASSES__LATEST.yml')
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
if(-not (Test-Path -LiteralPath $ClassesPath)){ throw "Missing: $ClassesPath" }

# Minimal YAML parse by regex (good enough for this simple file; replace with real parser later if desired)
$txt = Get-Content -LiteralPath $ClassesPath -Raw
$blocks = ($txt -split "`n  - class_id:" | Select-Object -Skip 1) | ForEach-Object { "class_id:" + $_ }

$rows = foreach($b in $blocks){
  $_id  = ([regex]::Match($b,'class_id:\s*([A-Z0-9_]+)')).Groups[1].Value
  $_req = ([regex]::Match($b,'required:\s*(true|false)')).Groups[1].Value
  $_st  = ([regex]::Match($b,'status:\s*([A-Z_]+)')).Groups[1].Value
  $_pin = ([regex]::Match($b,'latest_pin:\s*""?([^"\r\n]*)')).Groups[1].Value.Trim()
  [pscustomobject]@{ class_id=$_id; required=$_req; status=$_st; latest_pin=$_pin }
}
$rows | Sort-Object class_id | Format-Table -AutoSize
