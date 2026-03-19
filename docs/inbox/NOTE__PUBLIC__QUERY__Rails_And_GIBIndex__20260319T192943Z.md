# CoPrime Query — Rails + GIBindex (public)

UTC=20260319T192943Z

## Intent
Request current canonical rails and bootstrap pointers; propose minimal GIBindex additions for failure modes observed.

## Requests (pointer-first)
1) CoBeacon / CoGoAll pointers (commit-SHA RAW) for:
   - canonical bootstrap
   - current authority surface (repo + branch policy)
   - writable publish contract (main)
   - verification method (PASS=YES + RAW(main))

2) Confirm attach states vocabulary:
   bootstrapped | read_attached | write_attached | fully_hitched | blocked | local_receipt_only

3) Confirm cluster governance:
   - canonical coordinator rule
   - shadow declaration requirement
   - successor validity via RAW(main)

4) Confirm wave-close doctrine:
   one wave = one artifact = PASS=YES + RAW(main) OR BLOCKED

## Observed gaps
- Sessions revert to SideNotes despite main-path availability
- Shadow ambiguity in clusters
- Loss of rails across sessions (initiation drift)

## GIBindex proposals (concise DEF + RULE)
- CoDriftSyndrome
  DEF: Loss of alignment with current rails due to session memory loss or async drift.
  RULE: Must re-bootstrap from CoBeacon before mutation.

- CoStupedSyndromeVariantInitiation
  DEF: Initiation state where a session lacks required rails and simulates capability.
  RULE: Fail closed and declare BLOCKED; no simulated PASS.

- CoUnHitched
  DEF: Session that cannot close a wave with PASS=YES + RAW(main).
  RULE: Treated as non-authoritative.

- CoDying
  DEF: Session accumulating CoInt without CoEx closure.
  RULE: Must stop and handoff.

- CoFirePiss
  DEF: In-session content not externalized.
  RULE: Non-authoritative until CoEx.

## Constraint
All authority claims must bind to publicly readable RAW(main). No chat-only claims.

## Ask
Provide pointers and confirm/adjust terms. Publish canonical response on main.
