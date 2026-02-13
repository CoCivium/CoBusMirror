# COPYPONG | SHELL=pwsh | COPY_SAFE=TRUE | NAME=MegaWave.CoBlock.MegaZipFetchRunClean.TEMPLATE | NOTE=Paste ONE block that contains the MegaZip URL + expected SHA256. It downloads to Downloads, verifies hash, expands to stage, runs MegaWaveRunner, cleans stage+logs (keeps zip).
& {
  Set-StrictMode -Version Latest
  $ErrorActionPreference='Stop'
  $ProgressPreference='SilentlyContinue'

  function Fail([string]$m){ throw "FAIL-CLOSED: $m" }
  function UTS { (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ') }
  function EnsureDir([string]$p){ New-Item -ItemType Directory -Force -Path $p | Out-Null }
  function SHA256([string]$p){ (Get-FileHash -Algorithm SHA256 -LiteralPath $p).Hash.ToLowerInvariant() }
  function OneLine([string]$s){ ($s -replace "(\r?\n)+"," " -replace "\s{2,}"," ").Trim() }

  $utc = UTS

  # REQUIRED (paste the link+sha in THIS SAME BLOCK every wave)
  $MegaZipUrl      = "PASTE_MEGAZIP_URL_HERE"
  $MegaZipSha256   = "PASTE_EXPECTED_SHA256_HERE".ToLowerInvariant()

  # OPTIONAL knobs
  $SessionLabel    = "MegaWave|Wave|$utc"   # can include pipes
  $KeepZip         = $true                 # default keep the downloaded zip
  $KeepLogs        = $false                # logs are outside git; default delete after run
  $Downloads       = Join-Path $HOME "Downloads"
  $RunnerRel       = "docs\COBUS_LITE\canon\MegaWave\MegaWaveRunner__LATEST.ps1"

  if([string]::IsNullOrWhiteSpace($MegaZipUrl) -or $MegaZipUrl -like "PASTE_*"){ Fail "MegaZipUrl not set in this block." }
  if([string]::IsNullOrWhiteSpace($MegaZipSha256) -or $MegaZipSha256 -like "paste_*"){ Fail "MegaZipSha256 not set in this block." }

  # repo root
  $repo = (& git rev-parse --show-toplevel 2>$null)
  if(-not $repo){ Fail "Not in a git repo." }

  $runner = Join-Path $repo $RunnerRel
  if(-not (Test-Path -LiteralPath $runner)){ Fail "Runner missing: $runner" }

  # download zip
  EnsureDir $Downloads
  $zipPath = Join-Path $Downloads ("MEGAZIP__dl__{0}.zip" -f $utc)

  try {
    Invoke-WebRequest -Uri $MegaZipUrl -OutFile $zipPath -ErrorAction Stop | Out-Null
  } catch {
    Fail ("Download failed: " + $_.Exception.Message)
  }

  # verify hash
  $got = (SHA256 $zipPath)
  if($got -ne $MegaZipSha256){
    Fail ("SHA256 mismatch. got={0} expected={1} file={2}" -f $got,$MegaZipSha256,$zipPath)
  }

  # stage extract
  $stage = Join-Path $Downloads ("_MegaWaveStage\{0}" -f $utc)
  EnsureDir $stage
  Expand-Archive -LiteralPath $zipPath -DestinationPath $stage -Force

  # run (runner handles its own commit-safe outputs)
  & pwsh -NoProfile -File $runner -MegaZipPath $zipPath -SessionLabel $SessionLabel | Out-Host

  # cleanup stage
  try { Remove-Item -LiteralPath $stage -Recurse -Force -ErrorAction SilentlyContinue } catch {}

  # cleanup logs (runner default logs root; best-effort)
  if(-not $KeepLogs){
    $logsRoot = Join-Path $Downloads "_MegaWaveLogs"
    if(Test-Path -LiteralPath $logsRoot){
      try { Remove-Item -LiteralPath $logsRoot -Recurse -Force -ErrorAction SilentlyContinue } catch {}
    }
  }

  if(-not $KeepZip){
    try { Remove-Item -LiteralPath $zipPath -Force -ErrorAction SilentlyContinue } catch {}
  }

  Write-Host (OneLine "RECEIPT|UTC=$utc|STATE=PASS|COBLOCK=MegaZipFetchRunClean|ZIP=$zipPath|ZIP_SHA256=$got|SESSION_LABEL=$SessionLabel|NOTES=Downloaded+verified megazip, executed runner, cleaned stage (kept zip by default).")
  "# COPY_SAFE:TRUE | END_OF_BLOCK"
}
