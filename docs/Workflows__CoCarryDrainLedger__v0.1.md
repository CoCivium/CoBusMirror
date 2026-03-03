# Workflows CoCarry Drain Ledger v0.1
UTC_CREATED: 20260303T163732Z
NOTE: This ledger records drained sessions and routing. `.liveYYYYMMDD` is valid only when a bus/repo artifact exists with commit-SHA RAW pointers + receipts.

## Entries (append-only)

### 20260303 — initial
- SESSION=CoAudit | Q=CHAT_ONLY | R=NA | S=Y | T=CLOSE_NOW | NOTE=chat-only; no CoSource artifacts
- SESSION=CoTask  | Q=MIXED     | R=Y  | S=Y | T=CLOSE_AFTER_PUBLISH | NOTE=has local/sandbox pack; must publish before `.live`


### 20260303 — ingest 20260303T165030Z (clipboard)
- SESSION=found). Wrong clipboard content?" }     # 4) Append to ledger     $ledgerRel  = 'docs\Workflows__CoCarryDrainLedger__v0.1.md'     $ledgerPath = Join-Path $repo $ledgerRel     if(-not (Test-Path -LiteralPath $ledgerPath)){ Fail "Ledger missing: $ledgerRel" }     $date = (Get-Date).ToUniversalTime().ToString('yyyyMMdd')     $sectionHeader = "### $date — ingest $utc (clipboard)"     $section = @($sectionHeader) + $rows + @(       ("- RAW_CAPTURE={0} sha256={1}" -f $capRel, $capSha),       ""     )     Add-Content -LiteralPath $ledgerPath -Value ("`n" + ($section -join "`n")) -Encoding UTF8     $ledgerSha = SHA256 $ledgerPath     # 5) Write CoBusLite entry     $entryRel  = Join-Path "docs\COBUS_LITE\entries\2026\03\03" ("{0}__Workflows.md" -f $utc)     $entryPath = Join-Path $repo $entryRel     EnsureDir (Split-Path -Parent $entryPath)     @(       'FROM: Workflows',       "UTC: $utc",       'STATE: doing',       'TOPIC: WF_DRAIN v2 clipboard ingested into drain ledger',       '',       'SHIPPED:',       ("- {0} sha256={1}" -f $ledgerRel, $ledgerSha),       ("- {0} sha256={1}" -f $capRel, $capSha),       '',       'NEXT:',       '- For any session with R=Y, publish required artifacts to CoSource and add pinned RAW pointers to ledger.',       '- Only then relabel sessions to .liveYYYYMMDD.<Session>.',       '',       'PTRS:',       ("- REPO_PATH={0}" -f $ledgerRel),       ''     ) -join "`n" | Q=UNK | R=UNK | T=UNK | TERM=UNK
- RAW_CAPTURE=docs\inbox\workflows\captures\WF_DRAIN_v2_CLIP__20260303T165030Z.txt sha256=7de6ba5282bb7824942b9d783b972c724f02d0dd6efd726f9e911d5d63d53e35

