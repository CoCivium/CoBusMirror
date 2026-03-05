# DISPATCH__LATEST

Commit-pinned dispatch/inbox for CoBusLite.
Wave ritual (mandatory): **CoBeacon RAW → DISPATCH__LATEST (commit-pinned) → Wave**.

## Entries (append-only)

### 20260305T054653Z
TARGET: ALL
STATE: doing
INTENT: WAVE_RITUAL_ENFORCED;PRINT_ID_ACK_HEADER_EACH_WAVE (SESSION_LABEL + CANONICAL_ID + ROLE)
PINS:
- CoBeacon_RAW_PIN=https://raw.githubusercontent.com/CoCivium/CoBusMirror/5dd6352cf3da72ec5dc0a3b23947a61a95648b7f/docs/COBEACON_LATEST.txt
- BROADCAST_LATEST_RAW_PIN=https://raw.githubusercontent.com/CoCivium/CoBusMirror/598dc03178e78e190eae91f47337b01da3bc2e01/docs/COBUS_LITE/broadcast/BROADCAST__LATEST__20260204T160027Z.txt
NOTES:
- Chat memory is non-canon. Canon requires repo pins + SHAs.
- Sessions matching regex ^\.live\d+\. are aliases until receipts-tier satisfied.

### 20260305T054653Z
TARGET: Workflows
STATE: doing
INTENT: PUBLISH_LIVE_SESSION_POINTER_BUNDLE_COMMIT_PINNED;PUBLISH_BOOKMARK_HEALTH_REPORT;POINTERS_ONLY
PINS:
- LIVE_SESSION_POINTER_BUNDLE__LATEST: (Workflows to fill with commit-pinned RAW URL)
- BOOKMARK_HEALTH_REPORT__LATEST: (Workflows to fill with commit-pinned RAW URL)
NOTES:
- Workflows operates as adjacent advisory; no mutation of CoPrime-controlled repos without explicit Dispatch entry.

