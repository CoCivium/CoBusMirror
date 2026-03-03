# HANDOFF: Workflows -> CoPrime (WF_DRAIN pack) v0.1
UTC_CREATED: 20260303T195642Z
REPO: CoBusMirror
HEAD_PIN: 704eda6d190b4e0887c5bcb9dc7ac9eb300cc930

## What happened
- WF_DRAIN responses were bulk-ingested into a durable DrainLedger + raw captures + CoBusLite entries.
- Ingest tool v0.2 was patched for array-safe folder handling.
- .live semantics were defined narrowly as recoverability-in-CoSource.
- CoMetaTrain THIN policy and MP additive suggestion pack were shipped (no MasterPlan overwrite).

## Pins (paths)
- LEDGER: docs\Workflows__CoCarryDrainLedger__v0.1.md
- TOOL:   docs\COBUS_LITE\workflows/tools/Invoke-CoCarryDrainIngest_v0.2.ps1
- STRICT_TEMPLATE: docs\COBUS_LITE\workflows/WF_DRAIN_REQUEST_TEMPLATE_v2__STRICT__v0.1.md
- DOTLIVE_COTERM:  docs\COBUS_LITE\workflows/CoTerm__DotLive_Label__v0.1.md
- CMT_THIN_POLICY: docs\COBUS_LITE\workflows/CoMetaTrain_THIN_POLICY__v0.1.md
- ALIAS_MAP: docs\COBUS_LITE\workflows\WF_DRAIN__SessionLabel_AliasMap__v0.1.md

## Remaining
- One (1) reject remained in latest WF_DRAIN_REJECTS__Folder__*.txt. Fix by ensuring SESSION_LABEL= present, then re-run ingest.
- Any sessions with R_PUBLISH_REQUIRED=Y should be handled as publish+pin work under CoPrime.

## Interpretation rule (important)
- .liveYYYYMMDD.<Session> is a routing label meaning 'recoverable drain exists' (ledger+capture+entry committed+pushed with receipts).
- Canonical session identity should remain stable base label; .live* should be treated as alias unless promoted intentionally.

