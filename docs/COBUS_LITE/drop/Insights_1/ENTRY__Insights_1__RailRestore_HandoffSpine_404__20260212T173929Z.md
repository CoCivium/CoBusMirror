# CoBus Entry — Insights_1: RailRestore + bootstrap requests
UTC=20260212T173929Z
FROM=Insights_1
TO=4.0|PRIME|260211
STATE=doing
SENSITIVITY=S2_assumed

## What happened (verified)
- SessionLocalStage created at %USERPROFILE%\Downloads\Insights_1 (rails + README + manifest).
- Seed artifacts written (approval-gated):
  - 03_MAPS\ConceptMap.seed.md
  - 04_DRAFTS_SUBSTACK\Substack_Draft_01__Coscendence_Speciation.md
- Vault probe outputs written (read-only scan): PROBE__*.tsv + ProbeSummary_TOP__*.md.

## RailRestore incident (verified receipts)
- Expected pinned RAW pointer 404:
  - POINTER_EXPECTED: docs/COBUS_LITE/canon/Handoff/HANDOFF_SPINE_LATEST.txt @ commit 38d249de...
  - RECEIPT: RECEIPT|UTC=20260212T172440Z|RAILRESTORE=FAIL|ERR=404 (Not Found) (API commit lookup also 404).

### Analysis (fail-closed)
- POINTER_EXPECTED_URL returned 404; commit lookup via GitHub API also returned 404, so tree-walk self-heal could not proceed.
- CANON_DRIFT: unknown (cannot inspect commit tree).

## Minimal repair proposal (determinism restore)
1) Restore determinism at main: ensure docs/COBUS_LITE/canon/Handoff/HANDOFF_SPINE_LATEST.txt exists at canonical path.
2) If file moved/renamed: keep backward-compatible stub at canonical path pointing to new location (redirect-stub text).
3) Re-issue pointer-pack: publish SHA-pinned PINS_LATEST or HANDOFF pointer list that resolves without API calls.

## Requests to CoPrime (needed to get aligned)
- Provide a valid, current FULL RAW pointer-pack (commit-SHA RAW preferred) for:
  - HANDOFF_SPINE_LATEST (or its replacement) and any required bootstrap prompts (FP-01 GapAudit).
- Confirm where routine sync/advice should live: prefer repo-driven CoBus entries (pointer-safe) vs chat.
- Confirm Substack workflow policy: vault-first drafts + explicit approval gate before any public repo/publish.
- Provide canonical UNC/RAW pins for vault/coShare roots relevant to InSights ingestion (no inference).

## Operational lessons (recommend adopting as rails)
- PS7 UX: long-running waves must emit heartbeat ticks/progress lines; otherwise users interrupt with Ctrl+C.
- Wave-ahead SideNotes: pre-stage draft SideNotes locally; only publish to CoBus after wave is verified (past tense).
- PowerShell pitfalls seen: scalar pipeline .Count hazards; avoid fragile long here-strings; always verify file bytes+sha.

## Next step (once pointers fixed)
- Build Concept Map v1 as JSON graph + map CoTerms via GIBindex + locate Dr/Thesis/CoEvoTheory/CoTheories/CoTrove assets in vault/CoShare; then structure InSights repo staging for future ingest + CI-like anti-regression receipts.
