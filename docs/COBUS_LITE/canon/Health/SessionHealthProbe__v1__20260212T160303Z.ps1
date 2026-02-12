Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'

function UTS { (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ') }
function OneLine([string]$s){ ($s -replace "(\r?\n)+"," " -replace "\s{2,}"," ").Trim() }

$utc = UTS
$session = '4.0|PRIME|260211'  # EDIT IF RUNNING IN OTHER SESSION

# Simple machine snapshot (best-effort)
$cpu = (Get-CimInstance Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average
$os  = Get-CimInstance Win32_OperatingSystem
$freeGB = [math]::Round(($os.FreePhysicalMemory/1MB),2)
$totalGB = [math]::Round(($os.TotalVisibleMemorySize/1MB),2)

# CoBus artifact count proxy
$drop = '\\Server\homes\RB\CoBux\INBOX'
$count = (Get-ChildItem -LiteralPath $drop -File -ErrorAction SilentlyContinue | Measure-Object).Count

# Operator fills these four explicitly (do NOT auto-guess)
$CU='OK'; $PU='OK'; $HU='OK'; $WT='OK'
$trigger='none'
$notes = "cpu_pct=$cpu mem_free_gb=$freeGB/$totalGB cobus_files=$count"

if((@($CU,$PU,$HU,$WT) -contains 'HARD') -or (@($CU,$PU,$HU,$WT) -contains 'FATAL')){ $trigger='cycle_now' }

$line = OneLine "CoHealth|UTC=$utc|SESSION=$session|CU=$CU|PU=$PU|HU=$HU|WT=$WT|TRIGGER=$trigger|NOTES=$notes"
$out = Join-Path $drop ("SessionHealth__{0}__{1}.txt" -f ($session -replace '[^\w\.\-\|]','_'), $utc)
Set-Content -LiteralPath $out -Value $line -Encoding UTF8
Write-Host "WROTE_COHEALTH: $out"
Write-Host $line
