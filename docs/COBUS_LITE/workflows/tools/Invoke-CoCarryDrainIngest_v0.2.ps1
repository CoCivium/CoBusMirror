param(
  [ValidateSet('Clipboard','Folder')]
  [string]$Mode = 'Folder',

  [string]$PendingDirRel = 'docs/inbox/workflows/pending',

  [string]$RepoRoot = '',

  # If true: commits capture+entry+reject-report even when 0 sessions parsed (prevents “silent loss”).
  [switch]$AllowZeroParsed
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

  $remote = (git remote -v) 2>$null
  if(-not $remote){ Fail "No remote configured; refusing to strand drain state locally." }

  $raw = ''
  $pendingAbs = Join-Path $RepoRoot $PendingDirRel
  $files = @()

  if($Mode -eq 'Clipboard'){
    $raw = (Get-Clipboard -Raw)
    if([string]::IsNullOrWhiteSpace($raw)){ Fail "Clipboard empty. Copy WF_DRAIN blocks first." }
  } else {
    EnsureDir $pendingAbs
    $files = @(Get-ChildItem -LiteralPath $pendingAbs -File -Force | Sort-Object FullName)
    if((@($files)).Count -eq 0){ Fail "No pending files in: $pendingAbs" }
    $raw = ($files | ForEach-Object { Get-Content -LiteralPath $_.FullName -Raw }) -join "`n`n"
  }

  # Always capture raw
  $capDirRel = 'docs/inbox/workflows/captures'
  $capDirAbs = Join-Path $RepoRoot $capDirRel
  EnsureDir $capDirAbs
  $capRel = Join-Path $capDirRel ("WF_DRAIN_CAPTURE__{0}__{1}.txt" -f $Mode, $utc)
  $capAbs = Join-Path $RepoRoot $capRel
  $raw | Set-Content -LiteralPath $capAbs -Encoding UTF8
  $capSha = SHA256 $capAbs

  # Split into candidate blocks. Support both WF_DRAIN v2 CoPong blocks and older “labelled …” narratives.
  $blocks = @()
  if($raw -match '<#\s*#\s*CoPong\s*\|'){
    $blocks = ($raw -split '(?=<#\s*#\s*CoPong\s*\|)') | Where-Object { $_.Trim() -ne '' }
  } else {
    # Fallback: treat each file as a block (Folder mode), or whole raw as one block (Clipboard)
    if($Mode -eq 'Folder' -and $files.Count -gt 0){
      foreach($f in $files){ $blocks += (Get-Content -LiteralPath $f.FullName -Raw) }
    } else {
      $blocks = @($raw)
    }
  }

  if($blocks.Count -lt 1){ Fail "No blocks detected after aggregation." }

  function GetField([string]$s,[string]$key){
    $k = [regex]::Escape($key)
    $pat = "(?:^|\s)$k\s*=\s*([^|]+)"
    $m = [regex]::Match($s, $pat)
    if($m.Success){ return $m.Groups[1].Value.Trim() }
    return $null
  }

  function GuessSessionLabel([string]$s){
    # 1) direct field
    $v = GetField $s 'SESSION_LABEL'
    if($v){ return $v }

    # 2) common narrative patterns (case-insensitive)
    $m1 = [regex]::Match($s, '(?i)\bthis session is now labelled\b\s*"?(?<lab>[A-Za-z0-9\.\-_]+)"?')
    if($m1.Success){ return $m1.Groups['lab'].Value.Trim() }

    $m2 = [regex]::Match($s, '(?i)\bnow labelled\b\s*"?(?<lab>[A-Za-z0-9\.\-_]+)"?')
    if($m2.Success){ return $m2.Groups['lab'].Value.Trim() }

    $m3 = [regex]::Match($s, '(?i)\bsession\s*label(?:led)?\b\s*[:=]\s*"?(?<lab>[A-Za-z0-9\.\-_]+)"?')
    if($m3.Success){ return $m3.Groups['lab'].Value.Trim() }

    return $null
  }

  $rows = New-Object System.Collections.Generic.List[string]
  $rejects = New-Object System.Collections.Generic.List[string]
  $sessions = New-Object System.Collections.Generic.HashSet[string]

  foreach($b in $blocks){
    $flat = ($b -replace "(\r?\n)+"," ").Trim()
    if([string]::IsNullOrWhiteSpace($flat)){ continue }

    $session = GuessSessionLabel $flat
    if(-not $session){
      $rejects.Add($flat.Substring(0, [Math]::Min(200, $flat.Length)))
      continue
    }

    [void]$sessions.Add($session)

    $q = (GetField $flat 'Q_PERSISTENCE_CLASS'); if(-not $q){ $q='UNK' }
    $r = (GetField $flat 'R_PUBLISH_REQUIRED'); if(-not $r){ $r='UNK' }
    $t = (GetField $flat 'T_RECOMMENDED_ACTION'); if(-not $t){ $t='UNK' }
    $p = (GetField $flat 'P_TERMINATION_READY'); if(-not $p){ $p='UNK' }

    $rows.Add(("- SESSION={0} | Q={1} | R={2} | T={3} | TERM={4}" -f $session,$q,$r,$t,$p))
  }

  # Reject report (always written; helps convert the remaining ~20 quickly)
  $rejRel = Join-Path 'docs/inbox/workflows/captures' ("WF_DRAIN_REJECTS__{0}__{1}.txt" -f $Mode, $utc)
  $rejAbs = Join-Path $RepoRoot $rejRel
  @(
    "UTC: $utc"
    "MODE: $Mode"
    "NOTE: blocks that could not be parsed into SESSION_LABEL. Fix upstream drain format or add SESSION_LABEL=..."
    "REJECT_COUNT: $($rejects.Count)"
    ""
  ) + $rejects | Set-Content -LiteralPath $rejAbs -Encoding UTF8
  $rejSha = SHA256 $rejAbs

  if($rows.Count -eq 0 -and -not $AllowZeroParsed){
    Fail "Parsed 0 sessions. Refusing to append ledger. (Re-run with -AllowZeroParsed to commit capture+reject report for later repair.)"
  }

  # Append to ledger (if zero parsed, write a marker section instead of fake rows)
  $ledgerRel  = 'docs/Workflows__CoCarryDrainLedger__v0.1.md'
  $ledgerAbs  = Join-Path $RepoRoot $ledgerRel
  if(-not (Test-Path -LiteralPath $ledgerAbs)){ Fail "Ledger missing: $ledgerRel" }

  $date = (Get-Date).ToUniversalTime().ToString('yyyyMMdd')
  $sectionHeader = "### $date — ingest $utc ($Mode) v0.2"
  $section = @($sectionHeader)

  if($rows.Count -gt 0){
    $section += $rows
  } else {
    $section += "- NOTE=0 sessions parsed; see rejects file and/or fix WF_DRAIN format upstream."
  }

  $section += @(
    ("- RAW_CAPTURE={0} sha256={1}" -f $capRel, $capSha)
    ("- REJECTS={0} sha256={1}" -f $rejRel, $rejSha)
    ("- PARSED_SESSIONS={0}" -f $sessions.Count)
    ""
  )

  Add-Content -LiteralPath $ledgerAbs -Value ("`n" + ($section -join "`n")) -Encoding UTF8
  $ledgerSha = SHA256 $ledgerAbs

  # CoBusLite entry
  $yy = (Get-Date).ToUniversalTime().ToString('yyyy')
  $mm = (Get-Date).ToUniversalTime().ToString('MM')
  $dd = (Get-Date).ToUniversalTime().ToString('dd')
  $entryRel = Join-Path "docs/COBUS_LITE/entries/$yy/$mm/$dd" ("{0}__Workflows.md" -f $utc)
  $entryAbs = Join-Path $RepoRoot $entryRel
  EnsureDir (Split-Path -Parent $entryAbs)

  @(
    'FROM: Workflows'
    "UTC: $utc"
    'STATE: doing'
    ("TOPIC: WF_DRAIN ingest v0.2 ($Mode) -> capture+ledger+entry (parsed_sessions={0}, rejects={1})" -f $sessions.Count, $rejects.Count)
    ''
    'SHIPPED:'
    ("- {0} sha256={1}" -f $ledgerRel, $ledgerSha)
    ("- {0} sha256={1}" -f $capRel, $capSha)
    ("- {0} sha256={1}" -f $rejRel, $rejSha)
    ''
    'NEXT:'
    '- If rejects>0: fix upstream WF_DRAIN replies to include SESSION_LABEL= (or ensure “this session is now labelled X” line exists), then re-run.'
    '- For sessions with R=Y: publish required artifacts + pinned RAW pointers + sha receipts, then upgrade to .cosourcedYYYYMMDD.<Session>.'
    ''
    'PTRS:'
    ("- REPO_PATH={0}" -f $ledgerRel)
    ''
  ) -join "`n" | Set-Content -LiteralPath $entryAbs -Encoding UTF8
  $entrySha = SHA256 $entryAbs

  # Move consumed pending files to done/ (Folder mode only)
  if($Mode -eq 'Folder' -and $files.Count -gt 0){
    $doneAbs = Join-Path $RepoRoot 'docs/inbox/workflows/done'
    EnsureDir $doneAbs
    foreach($f in $files){
      $dest = Join-Path $doneAbs $f.Name
      try { Move-Item -LiteralPath $f.FullName -Destination $dest -Force } catch { }
    }
  }

  # Commit + push (always commits capture+rejects even if 0 parsed AND AllowZeroParsed)
  git add $ledgerRel $entryRel $capRel $rejRel | Out-Null
  if($Mode -eq 'Folder'){ git add $PendingDirRel 'docs/inbox/workflows/done' | Out-Null }

  $out = (git commit -m "Workflows: WF_DRAIN ingest v0.2 ($Mode) $utc") 2>&1
  if($LASTEXITCODE -ne 0){ Fail "git commit failed: $out" }
  $head = (git rev-parse HEAD).Trim()
  git push | Out-Null

  Write-Host (OneLine "# <# # Workflows | UTC=$utc | MODE=$Mode | HEAD=$head | PARSED=$($sessions.Count) | REJECTS=$($rejects.Count) | LEDGER_SHA256=$ledgerSha | ENTRY_SHA256=$entrySha | CAPTURE_SHA256=$capSha | REJECTS_SHA256=$rejSha | ACTION=Ingest_v0_2+Ledger+Entry+Commit+Push END #>") -ForegroundColor Cyan
}
finally { Pop-Location }

