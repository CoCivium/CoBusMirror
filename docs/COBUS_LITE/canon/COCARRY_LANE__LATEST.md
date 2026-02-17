# COCARRY_LANE__LATEST

* UTC: 20260217T053509Z

## Intent
CoCarry is a permanent intake lane, not a per-session chore.
Goal: stop duplication/strandings by making carry work deterministic and continuously processed.

## Definition
- CoCarry lane ingests drops (chat exports, zips, receipts, notes) and converts them into pinned packs.
- CoPrime stays focused on rails + gates + MasterPlan; CoCarryRunner lanes do ingestion/packing.

## Canon paths
- Backlog queue: docs/COBUS_LITE/canon/COCARRY_QUEUE__LATEST.yml (to be created)
- Lane state:  docs/COBUS_LITE/bus/CoCarry__LATEST.md (to be created)
- Lane artifacts: docs/COBUS_LITE/cocarry/ (to be created)

## DONE criteria for each CoCarry item (fail-closed)
An item is DONE only if ALL are present:
1) Receipt (hashes, inputs, outputs).
2) Commit-pinned RAW pointers (no /main).
3) Index entry / registry entry as required.

## Health metric (for broadcast)
Maintain counts:
- queued
- processing
- done
Publish in broadcast to prevent silent rot.
