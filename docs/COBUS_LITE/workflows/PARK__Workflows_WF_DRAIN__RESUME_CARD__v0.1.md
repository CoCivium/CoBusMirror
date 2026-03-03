# PARK / RESUME CARD — Workflows WF_DRAIN v0.1
UTC_CREATED: 20260303T203614Z
STATE: PARKED
INTENT: Provide deterministic resume instructions for this session + CoPrime

## Current pin
- HEAD_PIN: 468d73fc5bc79e04851fe8331b6bfddc2d995cb0

## Canonical artifacts (paths)
- HANDOFF_PACK: docs\COBUS_LITE\workflows\HANDOFF__Workflows_to_CoPrime__WF_DRAIN_Pack__v0.1.md
- SESSION_LABEL_ALIAS_MAP: docs\COBUS_LITE\workflows\WF_DRAIN__SessionLabel_AliasMap__v0.1.md
- DRAIN_LEDGER: docs\Workflows__CoCarryDrainLedger__v0.1.md
- INGEST_TOOL: docs\COBUS_LITE\workflows/tools/Invoke-CoCarryDrainIngest_v0.2.ps1
- STRICT_TEMPLATE: docs\COBUS_LITE\workflows/WF_DRAIN_REQUEST_TEMPLATE_v2__STRICT__v0.1.md
- COMETATRAIN_THIN_POLICY: docs\COBUS_LITE\workflows/CoMetaTrain_THIN_POLICY__v0.1.md
- LATEST_REJECTS_PTR: docs\inbox\workflows\captures\WF_DRAIN_REJECTS__Folder__20260303T193553Z.txt

## What remains (must-do)
1) Fix remaining reject(s)
- Open latest rejects file and ensure each block has SESSION_LABEL=.
- Re-run ingest Folder mode after fixing input format.

2) Enforce label governance
- Base label is canonical ID.
- .liveYYYYMMDD.<Label> is alias/routing label (recoverability-in-CoSource), unless explicitly promoted.

3) Publish-required follow-through
- If any ingested session has R_PUBLISH_REQUIRED=Y, CoPrime must handle publish+pin work.

## What CoPrime should do (when CoStacks MVP is stable)
- Pull this repo at HEAD_PIN or newer.
- Read HANDOFF_PACK and follow Remaining section.
- Consider sub-sessions:
  - Parser hardening / reject elimination
  - Label semantics governance (canon vs alias vs promoted)
  - Receipts-tier gate enforcement
  - Port MP suggestion snippets into MasterPlan source-of-truth (additive only)

## What NOT to do
- Do not treat .live* prefix as proof of anything by itself.
- Do not overwrite MasterPlan from these suggestion files; port selectively, additive only.

