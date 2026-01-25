# CoWorkQueue Spec v0.1

UTC=20260125T060943Z

## Intent
A simple, repo-hosted queue that a local runner (or session) can read to keep shipping work while the human is mostly observing.

## Rules
- Queue items are append/update safe; no merges-to-main are performed by the runner.
- Items must include approval gates (e.g., "merge_to_main") so humans/CoPrime can intervene.
- All pointers are FULL URLs (prefer URL_RAW).

## JSON shape (CoWorkQueue_LATEST.json)
- version: string
- utc: string
- items: array of objects:
  - id: string
  - repo: string (UI URL)
  - branch: string
  - pr_url: string (UI URL)
  - state: "todo"|"doing"|"blocked"|"done"
  - next_action: string (imperative)
  - approval_gate: "none"|"merge_to_main"|"publish"|"secrets"|"destructive"
  - notes: string (short)
