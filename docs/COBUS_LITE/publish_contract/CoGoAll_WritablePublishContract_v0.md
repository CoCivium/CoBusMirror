# CoGoAll Writable Publish Contract v0

## Purpose
Define the **only valid path** to claim write_attached on CoBus.

## Required Conditions

1. MUST run inside CoBusMirror repo
2. MUST write exactly one EntryPayload to:
   docs/COBUS_LITE/presence/

3. MUST create SHA256 sidecar

4. MUST:
   - git add intended files only
   - git commit
   - git push

5. MUST verify:
   - RAW EntryPayload returns 200
   - RAW .sha256 returns 200

## State Transitions

- bootstrapped → read_attached (read surfaces resolved)
- read_attached → write_attached (all conditions above met)
- else → local_receipt_only or blocked

## Invalid Claims

- local files
- commit without correct file
- push without raw verification
- dashboard/UI confirmation

## Truth Rule

Only public RAW pointer + SHA verification constitutes CoEx truth.