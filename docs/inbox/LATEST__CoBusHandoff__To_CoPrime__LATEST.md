# CoBus Handoff Bundle (normalized)
GeneratedUTC: 20260121T080112Z
To: CoPrime 4.0|PRIME|260116
GeneratedBySession: CoPrime 4.0|PRIME|260116
WaveEndMarker: WAVE_END__20260121T080112Z

CoBusMsg: v0.1
To: CoPrime 4.0|PRIME|260116
From: CoSources
Topic: Rename handoff artifact for label hygiene (no content change)

Artifacts:
- OLD: C:\Users\Chris\Downloads\CoBusMirror_cobeacon_branch_archive_20260121T011049Z.zip
- OLD: C:\Users\Chris\Downloads\CoBusMirror_cobeacon_branch_archive_20260121T011049Z.zip.sha256
- NEW: C:\Users\Chris\Downloads\CoSources_cobeacon_branch_archive_20260121T011049Z.zip
- NEW: C:\Users\Chris\Downloads\CoSources_cobeacon_branch_archive_20260121T011049Z.zip.sha256

CoCarry:
- Contents unchanged. Only zip/folder basename changed. sha256 regenerated accordingly.

---

CoBusMsg: v0.1
To: CoPrime 4.0|PRIME|260116
From: CoFutures/CoInsights migration session
Topic: IMPORT_QUEUE deterministic + Batch0001 approval ask

State:
- IMPORT_QUEUE deterministic with stable queue_id + correct multi-key sort
- CoFutures HEAD includes inventories+policy+ledgers+queue+top50+stats (see CoFutures/core/migrations/*, commit eb3bed2)
- CoInsights (private) exists with v0.1.0 scaffold + templates/schemas and CoFutures pointer
- CoShareHub breadcrumbs landed in AI_CONTEXT.md and MasterPlan.md

RequestedNext (approval ask):
- Run Batch0001 copy-only import (top25) into CoInsights/insights/imports/...
- Gates: Repo-SecretScan, append-only ledger entries:
  - BATCHES.jsonl
  - TRANSFERS.jsonl (sha256 + queue_id)
- Then iterate batches.

