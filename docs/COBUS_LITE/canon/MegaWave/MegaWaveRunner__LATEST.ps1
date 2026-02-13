# MegaWaveRunner__LATEST.ps1
param(
  [string]$MegaZipPath,
  [string]$MegaZipRawUrl,
  [string]$SessionLabel = "SESSION",
  [string]$CanonOutRel  = "docs/COBUS_LITE/canon/MegaRuns",
  [string]$LogsRoot     = ""   # default: $HOME\Downloads\_MegaWaveLogs
)

Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'

function UTS { (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ') }
function Fail([string]$m){ throw "FAIL-CLOSED: $m" }
function EnsureDir([string]$p){ New-Item -ItemType Directory -Force -Path $p | Out-Null }
function OneLine([string]$s){ ($s -replace "(\r?\n)+"," " -replace "\s{2,}"," ").Trim() }
function SHA256([string]$p){ (Get-FileHash -Algorithm SHA256 -LiteralPath $p).Hash.ToLowerInvariant() }
function H8([string]$s){
  $bytes = [Text.Encoding]::UTF8.GetBytes($s)
  $sha = [Security.Cryptography.SHA256]::Create().ComputeHash($bytes)
  -join ($sha[0..3] | ForEach-Object { $_.ToString("x2") })
}

$utc = UTS

# Repo root auto
$repo = (& git rev-parse --show-toplevel 2>$null)
if(-not $repo){ Fail "Not in a git repo." }

# Require exactly one input
if(([string]::IsNullOrWhiteSpace($MegaZipPath)) -and ([string]::IsNullOrWhiteSpace($MegaZipRawUrl))){ Fail "Provide -MegaZipPath OR -MegaZipRawUrl" }
if((-not [string]::IsNullOrWhiteSpace($MegaZipPath)) -and (-not [string]::IsNullOrWhiteSpace($MegaZipRawUrl))){ Fail "Provide only one of -MegaZipPath or -MegaZipRawUrl" }

# Logs root (outside repo by default)
if([string]::IsNullOrWhiteSpace($LogsRoot)){ $LogsRoot = Join-Path $HOME "Downloads\_MegaWaveLogs" }
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
$stage = Join-Path $HOME ("Downloads\_SessionLocalStage\mw_{0}" -f $utc)
EnsureDir $stage
Expand-Archive -LiteralPath $MegaZipPath -DestinationPath $stage -Force

$manifestPath = Join-Path $stage 'manifest\MANIFEST.json'
if(-not (Test-Path -LiteralPath $manifestPath)){ Fail "NOT_A_MEGAZIP: MANIFEST.json missing at manifest\MANIFEST.json" }
$manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
if(-not $manifest.megazip_id){ Fail "MANIFEST invalid: missing megazip_id" }
if(-not $manifest.plan){ Fail "MANIFEST invalid: missing plan[]" }

# Ultra-short run id: MR__{UTC}__{hash8}
$runId = "MR__{0}__{1}" -f $utc, (H8 ($manifest.megazip_id + "|" + $SessionLabel))

# Repo-run folder (commit-safe, shallow)
$canonAbs = Join-Path $repo $CanonOutRel
EnsureDir $canonAbs
$runFolder = Join-Path $canonAbs $runId
EnsureDir $runFolder

# Commit-safe artifacts (short names)
$rdir  = Join-Path $runFolder "r"
EnsureDir $rdir
$triage = Join-Path $runFolder "T.txt"
$meta   = Join-Path $runFolder "M.txt"

# Logs folder (NOT committed)
$logRun = Join-Path $LogsRoot $runId
EnsureDir $logRun

$results = New-Object System.Collections.Generic.List[object]

# Run steps (receipt name: r_0001.txt ...)
$idx = 0
foreach($step in $manifest.plan){
  $idx++
  $sid = [string]$step.id
  if([string]::IsNullOrWhiteSpace($sid)){ Fail "Step missing id" }

  $log = Join-Path $logRun ("L_{0:0000}.txt" -f $idx)
  $rcp = Join-Path $rdir   ("r_{0:0000}.txt" -f $idx)

  $scriptPath = Join-Path $stage $step.script
  if(-not (Test-Path -LiteralPath $scriptPath)){ Fail "Step script missing: $($step.script)" }

  $state='PASS'; $notes='ok'
  try { & $scriptPath *>&1 | Tee-Object -FilePath $log | Out-Null }
  catch {
    $state='FAIL'; $notes=$_.Exception.Message
    if($step.on_fail -eq 'fallback' -and $step.fallback_script){
      $fb = Join-Path $stage $step.fallback_script
      if(Test-Path -LiteralPath $fb){
        try {
          Add-Content -LiteralPath $log -Value ("FALLBACK_START " + $step.fallback_script)
          & $fb *>&1 | Tee-Object -FilePath $log -Append | Out-Null
          $state='WARN'; $notes='fallback applied'
        } catch { $state='FAIL'; $notes='fallback failed' }
      }
    }
  }

  $logSha = (Test-Path -LiteralPath $log) ? (SHA256 $log) : "na"
  $line = OneLine ("RECEIPT|UTC={0}|MEGAZIP={1}|STEP={2}|IDX={3}|STATE={4}|LOG_SHA256={5}|LOG_PATH={6}|NOTES={7}" -f $utc,$manifest.megazip_id,$sid,$idx,$state,$logSha,$log,$notes)
  Set-Content -LiteralPath $rcp -Value $line -Encoding UTF8

  $results.Add([pscustomobject]@{ idx=$idx; step=$sid; state=$state; log_sha=$logSha }) | Out-Null
  if($state -eq 'FAIL' -and $step.on_fail -eq 'stop'){ Fail "Step failed and stop policy set: $sid" }
}

# TRIAGE + META (short)
$tri = New-Object System.Collections.Generic.List[string]
$tri.Add(("UTC={0}" -f $utc)) | Out-Null
$tri.Add(("MEGAZIP={0}" -f $manifest.megazip_id)) | Out-Null
$tri.Add(("SESSION={0}" -f $SessionLabel)) | Out-Null
$tri.Add(("RUNID={0}" -f $runId)) | Out-Null
$tri.Add(("LOGS_ROOT={0}" -f $logRun)) | Out-Null
foreach($r in $results){ $tri.Add(("S{0:0000}|STATE={1}|LOG_SHA256={2}|STEP={3}" -f $r.idx,$r.state,$r.log_sha,$r.step)) | Out-Null }
$tri | Set-Content -LiteralPath $triage -Encoding UTF8

@(
  "UTC=$utc"
  "SESSION_LABEL=$SessionLabel"
  "RUNID=$runId"
  "MEGAZIP_ID=$($manifest.megazip_id)"
  "MEGAZIP_PATH=$MegaZipPath"
  "LOGS_ROOT=$logRun"
) | Set-Content -LiteralPath $meta -Encoding UTF8

# Commit ONLY triage/meta/receipts dir (NOT logs)
try {
  & git add $runFolder | Out-Null
} catch {
  Fail ("git add failed (path/permission). runFolder=" + $runFolder + " :: " + $_.Exception.Message)
}
try {
  & git commit -m ("MegaRun: {0} {1} {2}" -f $manifest.megazip_id,$SessionLabel,$utc) | Out-Null
} catch {
  Fail ("git commit failed. runFolder=" + $runFolder + " :: " + $_.Exception.Message)
}
$sha = (& git rev-parse HEAD).Trim()

Write-Host ("MEGARUN_COMMIT_SHA: " + $sha)
Write-Host ("MEGARUN_RAW_TRIAGE: https://raw.githubusercontent.com/CoCivium/CoBusMirror/{0}/{1}" -f $sha, (($triage.Substring($repo.Length)).TrimStart('\') -replace '\\','/'))
Write-Host ("MEGARUN_RAW_META:   https://raw.githubusercontent.com/CoCivium/CoBusMirror/{0}/{1}" -f $sha, (($meta.Substring($repo.Length)).TrimStart('\') -replace '\\','/'))
