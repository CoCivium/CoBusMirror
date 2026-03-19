# Cluster Coherence Protocol v0

## Purpose
Prevent authority ambiguity across asynchronous session clusters.

## Authority
Only PASS=YES + RAW(main) is authoritative.

## Coordinator
Exactly one canonical coordinator at a time.
All others = shadow / advisory / successor-candidate / deprecated.

## Shadows
Must be explicitly declared and pointer-backed.
Unknown shadows = non-authoritative observers.

## Successor
Valid only via public RAW(main) artifact.

## Conflict
If multiple authorities:
- prefer newest valid RAW(main)
- else downgrade all to advisory until resolved

## Async Safety
Async allowed. Canon mutation without current pointers is not.

## Self-Initiation
Sessions must:
- resolve rails
- resolve authority surface
- declare capability state
- fail closed if missing publish contract

## Output Discipline
One wave = one artifact = one PASS.

## Relay
Human relay = degraded fallback.

## Cluster Object
Track:
- coordinator
- shadows
- successors
- authority surface
- publish contract
- last proof
