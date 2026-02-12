# MegaWaveRunner__LATEST.ps1
# Zero-ask: derive repo + defaults; only required input is -MegaZipPath (or -MegaZipRawUrl)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'

function UTS { (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ') }
function Fail([string]$m){ throw "FAIL-CLOSED: $m" }
function OneLine([string]$s){ ($s -replace "(\r?\n)+"," " -replace "\s{2,}"," ").Trim() }
function San([string]$s){ ($s -replace '[^\w\.\-]+','_').Trim('_') } # windows-safe
function EnsureDir([string]$p){ New-Item -ItemType Directory -Force -Path $p | Out-Null }

param(
  [string]$MegaZipPath,
  [string]$MegaZipRawUrl,
  [string]$SessionLabel = "SESSION",
  [string]$CanonOutRel  = "docs/COBUS_LITE/canon/MegaRuns"
)

$utc = UTS

# Repo root auto
$repo = (& git rev-parse --show-toplevel 2>$null)
if(-not $repo){ Fail "Not in a git repo." }

# Require exactly one input
if(([string]::IsNullOrWhiteSpace($MegaZipPath)) -and ([string]::IsNullOrWhiteSpace($MegaZipRawUrl))){
  Fail "Provide -MegaZipPath OR -MegaZipRawUrl"
}
if((-not [string]::IsNullOrWhiteSpace($MegaZipPath)) -and (-not [string]::IsNullOrWhiteSpace($MegaZipRawUrl))){
  Fail "Provide only one of -MegaZipPath or -MegaZipRawUrl"
}

# Fetch if URL
if(-not [string]::IsNullOrWhiteSpace($MegaZipRawUrl)){
  $dl = Join-Path $env:TEMP ("MEGAZIP__dl__{0}.zip" -f $utc)
  try {
    Invoke-WebRequest -Uri $MegaZipRawUrl -OutFile $dl -UseBasicParsing -ErrorAction Stop | Out-Null
  } catch {
    Fail ("Fetch failed: " + $MegaZipRawUrl + " :: " + $_.Exception.Message)
  }
  $MegaZipPath = $dl
}

if(-not (Test-Path -LiteralPath $MegaZipPath)){ Fail "MegaZip missing: $MegaZipPath" }

# Stage (windows-safe)
$stage = Join-Path $HOME ("Downloads\_SessionLocalStage\{0}\_megawave_{1}" -f (San $SessionLabel), $utc)
EnsureDir $stage

Expand-Archive -LiteralPath $MegaZipPath -DestinationPath $stage -Force

$manifestPath = Join-Path $stage 'manifest\MANIFEST.json'
if(-not (Test-Path -LiteralPath $manifestPath)){
  Fail "NOT_A_MEGAZIP: MANIFEST.json missing at manifest\MANIFEST.json"
}
$manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
if(-not $manifest.megazip_id){ Fail "MANIFEST invalid: missing megazip_id" }
if(-not $manifest.plan){ Fail "MANIFEST invalid: missing plan[]" }

# Outputs
$outRoot = Join-Path $stage 'out'
EnsureDir $outRoot

$results = New-Object System.Collections.Generic.List[object]

function RunStep($step){
  $sid = [string]$step.id
  if([string]::IsNullOrWhiteSpace($sid)){ Fail "Step missing id" }

  $stepOut = Join-Path $outRoot (San $sid)
  EnsureDir $stepOut

  $log = Join-Path $stepOut ("LOG__{0}__{1}.txt" -f (San $sid), $utc)
  $rcp = Join-Path $stepOut ("RECEIPT__{0}__{1}.txt" -f (San $sid), $utc)

  $scriptPath = Join-Path $stage $step.script
  if(-not (Test-Path -LiteralPath $scriptPath)){ Fail "Step script missing: $($step.script)" }

  Write-Progress -Activity "MegaWave" -Status "Running $sid" -PercentComplete 0

  $state='PASS'; $notes='ok'
  try {
    & $scriptPath *>&1 | Tee-Object -FilePath $log | Out-Null
  } catch {
    $state='FAIL'; $notes=$_.Exception.Message
    if($step.on_fail -eq 'fallback' -and $step.fallback_script){
      $fb = Join-Path $stage $step.fallback_script
      if(Test-Path -LiteralPath $fb){
        try {
          Add-Content -LiteralPath $log -Value ("FALLBACK_START " + $step.fallback_script)
          & $fb *>&1 | Tee-Object -FilePath $log -Append | Out-Null
          $state='WARN'; $notes='fallback applied'
        } catch {
          $state='FAIL'; $notes='fallback failed'
        }
      }
    }
    if($step.on_fail -eq 'stop'){ }
  }

  $line = OneLine ("RECEIPT|UTC={0}|MEGAZIP={1}|STEP={2}|STATE={3}|COMMIT_SHA=NA|RAW_PTR=NA|NOTES={4}" -f $utc,$manifest.megazip_id,$sid,$state,$notes)
  Set-Content -LiteralPath $rcp -Value $line -Encoding UTF8

  $results.Add([pscustomobject]@{ step=$sid; state=$state; receipt=$rcp; log=$log })
  Write-Progress -Activity "MegaWave" -Status "Done $sid ($state)" -PercentComplete 100

  if($state -eq 'FAIL' -and $step.on_fail -eq 'stop'){ Fail "Step failed and stop policy set: $sid" }
}

foreach($s in $manifest.plan){ RunStep $s }

# Promote run folder into repo canon
$canonAbs = Join-Path $repo $CanonOutRel
EnsureDir $canonAbs

$runFolderName = "MEGARUN__{0}__{1}__{2}" -f (San $manifest.megazip_id), (San $SessionLabel), $utc
$runFolder = Join-Path $canonAbs $runFolderName
EnsureDir $runFolder

Copy-Item -LiteralPath $outRoot -Destination (Join-Path $runFolder 'out') -Recurse -Force

$triage = Join-Path $runFolder ("TRIAGE__{0}.txt" -f $utc)
$tri = @()
$tri += "TRIAGE|UTC=$utc|MEGAZIP=$($manifest.megazip_id)|SESSION=$SessionLabel"
foreach($r in $results){ $tri += ("STEP={0}|STATE={1}|RECEIPT={2}" -f $r.step,$r.state,(Split-Path -Leaf $r.receipt)) }
Set-Content -LiteralPath $triage -Value ($tri -join "`r`n") -Encoding UTF8

& git add $runFolder | Out-Null
& git commit -m ("MegaRun: {0} {1} {2}" -f $manifest.megazip_id,$SessionLabel,$utc) | Out-Null
$sha = (& git rev-parse HEAD).Trim()

Write-Host ("MEGARUN_COMMIT_SHA: " + $sha)
Write-Host ("MEGARUN_RAW_TRIAGE: https://raw.githubusercontent.com/CoCivium/CoBusMirror/{0}/{1}" -f $sha, (($triage.Substring($repo.Length)).TrimStart('\') -replace '\\','/'))
