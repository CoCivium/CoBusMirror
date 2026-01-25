# CoAutoPrompter Spec v0.1 (seed-stage)

UTC=20260125T054828Z

## Intent
Enable “hands-off for ~60+ minutes” execution where sessions keep shipping repo progress while the human only intervenes on approval gates.

## Minimal viable mechanism (no new secrets)
- A local runner (Windows Scheduled Task or service) pulls CoBusMirror on a timer.
- Runner checks CoBeacon → reads CoBus Index → opens/updates the next queued work item (issue/PR checklist).
- CI remains the backstop; the runner never merges to main.

## Guardrails
- Runner only creates branches/PRs and emits CoPongs.
- No destructive ops; no secrets; no publishing.
- Every wave emits CoH| + CoS| lines and stores receipts in-repo.
