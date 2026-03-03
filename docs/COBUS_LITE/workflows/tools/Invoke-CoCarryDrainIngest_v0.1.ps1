param(
  [ValidateSet('Clipboard','Folder')]
  [string]$Mode = 'Clipboard',

  # Only used in Folder mode
  [string]$PendingDirRel = 'docs/inbox/workflows/pending',

  # Repo root auto-detected from this script's location if not provided
  [string]$RepoRoot = ''
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

function Fail([string]$m){ throw "FAIL-CLOSED: $m" }
function UTS { (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ') }
function EnsureDir([string]$p){ if(-not (Test-Path -LiteralPath $p)){ New-Item -ItemType Directory -Path $p -Force | Out-Null } }
function SHA256([string]$p){ (Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash.ToLowerInvariant() }
function OneLine([string]$s){ ($s -replace "(\r?\n)+"," " -replace "\s{2,}"," ").Trim() }

$utc = UTS

if([string]::IsNullOrWhiteSpace($RepoRoot)){
  # RepoRoot = two levels up from .../docs/COBUS_LITE/workflows/tools
  $here = Split-Path -Parent $PSCommandPath
  $RepoRoot = (Resolve-Path (Join-Path $here '..\..\..\..')).Path
}

if(-not (Test-Path -LiteralPath (Join-Path $RepoRoot '.git'))){ Fail "Not a git repo: $RepoRoot" }

Push-Location $RepoRoot
try {
  $n = (git config user.name) 2>$null
  $e = (git config user.email) 2>$null
  if([string]::IsNullOrWhiteSpace($n) -or [string]::IsNullOrWhiteSpace($e)){
    Fail "Missing repo-local git identity. Set git config user.name/user.email in this repo."
  }

  $raw = ''
  if($Mode -eq 'Clipboard'){
    $raw = (Get-Clipboard -Raw)
    if([string]::IsNullOrWhiteSpace($raw)){ Fail "Clipboard empty. Copy WF_DRAIN blocks first." }
  } else {
    $pendingAbs = Join-Path $RepoRoot $PendingDirRel
    if(-not (Test-Path -LiteralPath $pendingAbs)){ Fail "Pending dir missing: $pendingAbs" }
    $files = Get-ChildItem -LiteralPath $pendingAbs -File -Force | Sort-Object FullName
    if(-not $files -or $files.Count -eq 0){ Fail "No pending files in: $pendingAbs" }
    $raw = ($files | ForEach-Object { Get-Content -LiteralPath $_.FullName -Raw }) -join "`n`n"
  }

  # Capture raw always
  $capDirRel = 'docs/inbox/workflows/captures'
  $capDirAbs = Join-Path $RepoRoot $capDirRel
  EnsureDir $capDirAbs
  $capRel = Join-Path $capDirRel ("WF_DRAIN_CAPTURE__{0}__{1}.txt" -f $Mode, $utc)
  $capAbs = Join-Path $RepoRoot $capRel
  $raw | Set-Content -LiteralPath $capAbs -Encoding UTF8
  $capSha = SHA256 $capAbs

  # Parse blocks
  $blocks = ($raw -split '(?=<#\s*#\s*CoPong\s*\|)') | Where-Object { $_.Trim() -ne '' }
  if($blocks.Count -lt 1){ Fail "No '<# # CoPong |' blocks detected." }

  $rows = New-Object System.Collections.Generic.List[string]

  foreach($b in $blocks){
    $s = ($b -replace "(\r?\n)+"," ").Trim()

    $get = {
      param([string]$key)
      $k = [regex]::Escape($key)
      $pat = "(?:^|\s)$k\s*=\s*([^|]+)"
      $m = [regex]::Match($s, $pat)
      if($m.Success){ return $m.Groups[1].Value.Trim() }
      return $null
    }

    $session = & $get 'SESSION_LABEL'
    if(-not $session){ continue }

    $q = (& $get 'Q_PERSISTENCE_CLASS'); if(-not $q){ $q='UNK' }
    $r = (& $get 'R_PUBLISH_REQUIRED'); if(-not $r){ $r='UNK' }
    $t = (& $get 'T_RECOMMENDED_ACTION'); if(-not $t){ $t='UNK' }
    $p = (& $get 'P_TERMINATION_READY'); if(-not $p){ $p='UNK' }

    $rows.Add(("- SESSION={0} | Q={1} | R={2} | T={3} | TERM={4}" -f $session,$q,$r,$t,$p))
  }

  if($rows.Count -eq 0){ Fail "Parsed 0 sessions (no SESSION_LABEL= found)." }

  # Append to ledger
  $ledgerRel  = 'docs/Workflows__CoCarryDrainLedger__v0.1.md'
  $ledgerAbs  = Join-Path $RepoRoot $ledgerRel
  if(-not (Test-Path -LiteralPath $ledgerAbs)){ Fail "Ledger missing: $ledgerRel" }

  $date = (Get-Date).ToUniversalTime().ToString('yyyyMMdd')
  $sectionHeader = "### $date — ingest $utc ($Mode)"
  $section = @($sectionHeader) + $rows + @(
    ("- RAW_CAPTURE={0} sha256={1}" -f $capRel, $capSha),
    ""
  )
  Add-Content -LiteralPath $ledgerAbs -Value ("`n" + ($section -join "`n")) -Encoding UTF8
  $ledgerSha = SHA256 $ledgerAbs

  # Write CoBusLite entry
  $y = (Get-Date).ToUniversalTime().ToString('yyyy')
  $m = (Get-Date).ToUniversalTime().ToString('MM')
  $d = (Get-Date).ToUniversalTime().ToString('dd')
  $entryRel = Join-Path "docs/COBUS_LITE/entries/$y/$m/$d" ("{0}__Workflows.md" -f $utc)
  $entryAbs = Join-Path $RepoRoot $entryRel
  EnsureDir (Split-Path -Parent $entryAbs)

  @(
    'FROM: Workflows',
    "UTC: $utc",
    'STATE: doing',
    "TOPIC: WF_DRAIN ingest ($Mode) -> capture+ledger+entry",
    '',
    'SHIPPED:',
    ("- {0} sha256={1}" -f $ledgerRel, $ledgerSha),
    ("- {0} sha256={1}" -f $capRel, $capSha),
    '',
    'NEXT:',
    '- For sessions with R=Y: publish required artifacts + add pinned RAW pointers + sha256 receipts, then upgrade label to .cosourcedYYYYMMDD.<Session>.',
    '- Sessions may be labelled .liveYYYYMMDD only once the drain record is committed+pushed (this entry + ledger + capture).',
    '',
    'PTRS:',
    ("- REPO_PATH={0}" -f $ledgerRel),
    ''
  ) -join "`n" | Set-Content -LiteralPath $entryAbs -Encoding UTF8

  $entrySha = SHA256 $entryAbs

  # Commit + push
  git add $ledgerRel $entryRel $capRel | Out-Null
  $out = (git commit -m "Workflows: WF_DRAIN ingest ($Mode) $utc") 2>&1
  if($LASTEXITCODE -ne 0){ Fail "git commit failed: $out" }
  $head = (git rev-parse HEAD).Trim()
  git push | Out-Null

  Write-Host "# Pushed HEAD=$head" -ForegroundColor Green
  Write-Host (OneLine "# <# # Workflows | UTC=$utc | MODE=$Mode | HEAD=$head | LEDGER_SHA256=$ledgerSha | ENTRY_SHA256=$entrySha | CAPTURE_SHA256=$capSha | ACTION=Ingest+Ledger+Entry+Commit+Push END #>") -ForegroundColor Cyan
}
finally { Pop-Location }
