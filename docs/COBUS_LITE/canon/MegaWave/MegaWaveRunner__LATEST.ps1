# MegaWaveRunner__LATEST.ps1
# Zero-ask runner. param() MUST be first non-comment statement.
param(
  [string]$MegaZipPath,
  [string]$MegaZipRawUrl,
  [string]$SessionLabel = "SESSION",
  [string]$CanonOutRel  = "docs/COBUS_LITE/canon/MegaRuns",
  [string]$LogsRoot     = ""   # if empty -> defaults to $HOME\Downloads\_MegaWaveLogs
)

Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'

function UTS { (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ') }
function Fail([string]$m){ throw "FAIL-CLOSED: $m" }
function EnsureDir([string]$p){ New-Item -ItemType Directory -Force -Path $p | Out-Null }
function OneLine([string]$s){ ($s -replace "(\r?\n)+"," " -replace "\s{2,}"," ").Trim() }
function SHA256([string]$p){ (Get-FileHash -Algorithm SHA256 -LiteralPath $p).Hash.ToLowerInvariant() }
function SanPath([string]$s){ ($s -replace '[^\w\.\-]+','_').Trim('_') }
function TrimLen([string]$s,[int]$n){ if($s.Length -le $n){$s}else{$s.Substring(0,$n)} }

$utc = UTS
$PathLabel = SanPath $SessionLabel  # pipes OK in label; sanitized only for filesystem paths

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

# Logs root (outside repo by default)
if([string]::IsNullOrWhiteSpace($LogsRoot)){
  $LogsRoot = Join-Path $HOME "Downloads\_MegaWaveLogs"
}
EnsureDir $LogsRoot

# Fetch if URL
if(-not [string]::IsNullOrWhiteSpace($MegaZipRawUrl)){
  $dl = Join-Path $env:TEMP ("MEGAZIP__dl__{0}.zip" -f $utc)
  try { Invoke-WebRequest -Uri $MegaZipRawUrl -OutFile $dl -ErrorAction Stop | Out-Null }
  catch { Fail ("Fetch failed: " + $MegaZipRawUrl + " :: " + $_.Exception.Message) }
  $MegaZipPath = $dl
}
if(-not (Test-Path -LiteralPath $MegaZipPath)){ Fail "MegaZip missing: $MegaZipPath" }

# Stage (local)
$stage = Join-Path $HOME ("Downloads\_SessionLocalStage\{0}\_megawave_{1}" -f $PathLabel, $utc)
EnsureDir $stage
Expand-Archive -LiteralPath $MegaZipPath -DestinationPath $stage -Force

$manifestPath = Join-Path $stage 'manifest\MANIFEST.json'
if(-not (Test-Path -LiteralPath $manifestPath)){
  Fail "NOT_A_MEGAZIP: MANIFEST.json missing at manifest\MANIFEST.json"
}
$manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
if(-not $manifest.megazip_id){ Fail "MANIFEST invalid: missing megazip_id" }
if(-not $manifest.plan){ Fail "MANIFEST invalid: missing plan[]" }

# Short run id to avoid long paths
$zipIdSafe = SanPath $manifest.megazip_id
$zipIdShort = TrimLen $zipIdSafe 42
$labShort   = TrimLen $PathLabel  48
$runId      = "MR__{0}__{1}__{2}" -f $zipIdShort, $labShort, $utc

# Repo-run folder (commit-safe, shallow)
$canonAbs = Join-Path $repo $CanonOutRel
EnsureDir $canonAbs
$runFolder = Join-Path $canonAbs $runId
EnsureDir $runFolder

# Commit-safe artifacts
$receiptsDir = Join-Path $runFolder "receipts"
EnsureDir $receiptsDir
$triage = Join-Path $runFolder ("TRIAGE__{0}.txt" -f $utc)
$meta   = Join-Path $runFolder ("METADATA__{0}.txt" -f $utc)

# Logs folder (NOT committed)
$logRun = Join-Path $LogsRoot $runId
EnsureDir $logRun

$results = New-Object System.Collections.Generic.List[object]

function RunStep($step){
  $sid = [string]$step.id
  if([string]::IsNullOrWhiteSpace($sid)){ Fail "Step missing id" }
  $sidSafe = SanPath $sid

  $log = Join-Path $logRun ("LOG__{0}__{1}.txt" -f $sidSafe, $utc)
  $rcp = Join-Path $receiptsDir ("RECEIPT__{0}__{1}.txt" -f $sidSafe, $utc)

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
  }

  $logSha = $null
  if(Test-Path -LiteralPath $log){ $logSha = SHA256 $log } else { $logSha = "na" }

  $line = OneLine ("RECEIPT|UTC={0}|MEGAZIP={1}|STEP={2}|STATE={3}|LOG_SHA256={4}|LOG_PATH={5}|NOTES={6}" -f $utc,$manifest.megazip_id,$sid,$state,$logSha,$log,$notes)
  Set-Content -LiteralPath $rcp -Value $line -Encoding UTF8

  $results.Add([pscustomobject]@{ step=$sid; state=$state; receipt=(Split-Path -Leaf $rcp); log=$log; log_sha=$logSha })
  Write-Progress -Activity "MegaWave" -Status "Done $sid ($state)" -PercentComplete 100

  if($state -eq 'FAIL' -and $step.on_fail -eq 'stop'){ Fail "Step failed and stop policy set: $sid" }
}

foreach($s in $manifest.plan){ RunStep $s }

# TRIAGE + METADATA (commit-safe)
$tri = New-Object System.Collections.Generic.List[string]
$tri.Add(("TRIAGE|UTC={0}|MEGAZIP={1}|SESSION={2}|RUNID={3}|LOGS_ROOT={4}" -f $utc,$manifest.megazip_id,$SessionLabel,$runId,$logRun)) | Out-Null
foreach($r in $results){
  $tri.Add(("STEP={0}|STATE={1}|RECEIPT={2}|LOG_SHA256={3}" -f $r.step,$r.state,$r.receipt,$r.log_sha)) | Out-Null
}
$tri | Set-Content -LiteralPath $triage -Encoding UTF8

$m = @()
$m += "UTC=$utc"
$m += "SESSION_LABEL=$SessionLabel"
$m += "PATH_LABEL=$PathLabel"
$m += "RUNID=$runId"
$m += "MEGAZIP_ID=$($manifest.megazip_id)"
$m += "MEGAZIP_PATH=$MegaZipPath"
$m += "LOGS_ROOT=$logRun"
Set-Content -LiteralPath $meta -Value ($m -join "`r`n") -Encoding UTF8

# Commit ONLY triage/meta/receipts (NOT logs)
& git add $runFolder | Out-Null
& git commit -m ("MegaRun: {0} {1} {2}" -f $manifest.megazip_id,$SessionLabel,$utc) | Out-Null
$sha = (& git rev-parse HEAD).Trim()

Write-Host ("MEGARUN_COMMIT_SHA: " + $sha)
Write-Host ("MEGARUN_RAW_TRIAGE: https://raw.githubusercontent.com/CoCivium/CoBusMirror/{0}/{1}" -f $sha, (($triage.Substring($repo.Length)).TrimStart('\') -replace '\\','/'))
Write-Host ("MEGARUN_RAW_META:   https://raw.githubusercontent.com/CoCivium/CoBusMirror/{0}/{1}" -f $sha, (($meta.Substring($repo.Length)).TrimStart('\') -replace '\\','/'))
