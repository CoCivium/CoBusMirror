# BEST CASE: WF_DRAIN -> CoPrime v0.1
UTC_CREATED: 20260303T215345Z
STATE: PARKED (READY_FOR_COPRIME_PICKUP)
HEAD_PIN_AT_CREATION: 5e82122012b12bfe5a0c7c7eca279188989e36d3

## What is DONE (verified)
- Bulk WF_DRAIN ingest succeeded and produced durable artifacts:
  - Drain ledger (structured summary of parsed session replies)
  - Raw capture file(s) of inputs for reconstruction
  - CoBusLite entry records for traceability
- Ingest tool v0.2 was patched to be array-safe in Folder mode.
- WF_DRAIN STRICT request template shipped (enforces SESSION_LABEL).
- CoMetaTrain THIN policy shipped (prevents header bloat; pushes tangents into pointer-linked captures/ledgers).
- .live label semantics: treat as recoverability alias, not proof-of-cosource by itself.

## What is NOT DONE (optional cleanup)
- Latest rejects file indicates 1 remaining unparsed block.
- Meaning: one session response did not include SESSION_LABEL= (or format deviated) so it was not ingested.
- Fix is trivial but optional: edit rejects input to include SESSION_LABEL= then rerun ingest Folder mode.

## What CoPrime should do (best case, when CoStacks MVP is stable)
1) Pull CoBusMirror at/after HEAD pin above.
2) Read HANDOFF_PACK and RESUME_CARD first; follow their 'Remaining' section.
3) If any ingested items show R_PUBLISH_REQUIRED=Y, treat as publish+pin tasks under CoPrime.
4) Port MasterPlan suggestion snippets ADDITIVELY (do not overwrite MasterPlan from suggestion files).
5) (Optional) Create a CoStacks-adjacent sub-session to:
   - harden the parser to eliminate rejects
   - enforce receipts-tier gates (STRUCTURAL -> HASH_ONLY -> EXECUTION -> SEMANTIC)
   - formalize canon-vs-alias label governance across repos

## Pins (paths)
- RESUME_CARD: docs\COBUS_LITE\workflows/PARK__Workflows_WF_DRAIN__RESUME_CARD__v0.1.md
- HANDOFF_PACK: docs\COBUS_LITE\workflows/HANDOFF__Workflows_to_CoPrime__WF_DRAIN_Pack__v0.1.md
- ALIAS_MAP: docs\COBUS_LITE\workflows/WF_DRAIN__SessionLabel_AliasMap__v0.1.md
- LEDGER: docs\Workflows__CoCarryDrainLedger__v0.1.md
- INGEST_TOOL: docs\COBUS_LITE\workflows/tools/Invoke-CoCarryDrainIngest_v0.2.ps1
- STRICT_TEMPLATE: docs\COBUS_LITE\workflows/WF_DRAIN_REQUEST_TEMPLATE_v2__STRICT__v0.1.md
- CMT_THIN_POLICY: docs\COBUS_LITE\workflows/CoMetaTrain_THIN_POLICY__v0.1.md
- LATEST_REJECTS_PTR: docs\inbox\workflows\captures\WF_DRAIN_REJECTS__Folder__20260303T193553Z.txt

