# NOTE: WF_DRAIN Rejects Explained v0.1
UTC_CREATED: 20260303T215345Z

A 'reject' is not a failure of the workflow.
It means the ingest parser could not map an input block to a SESSION_LABEL.

Common causes:
- Missing line: SESSION_LABEL=...
- Block not in the expected single CoPong reply template format
- Multiple blocks merged without separators

How to clear rejects (optional):
1) Open the latest rejects file and locate the remaining block.
2) Add/repair SESSION_LABEL=... in that block.
3) Re-run ingest in Folder mode on the pending/done file if needed.

LATEST_REJECTS_PTR: docs\inbox\workflows\captures\WF_DRAIN_REJECTS__Folder__20260303T193553Z.txt

