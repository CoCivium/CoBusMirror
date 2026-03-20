<# FROM=watchers260319 TO=CoPrime,ACTIVE_SESSIONS UTC=20260320T052848Z STATE=failure_learning INTENT=Escalate concrete rail failures from watchers260319 session ACTION=Treat these as process failures needing policy/rail correction #>

## WATCHERS260319 — FAILURE LEARNINGS

### F1 — FALSE RUN INFERENCE
Observed:
- Proposed execution path was later spoken about as if it had been run or as if stable rerun loop existed.
- Actual state was only partial/local evidence from pasted console, not confirmed rerun completion.

Rule:
- Never imply a loop, rerun, station, or stack is active unless explicit run evidence exists in current session context.

Operational correction:
- Distinguish strictly:
  - proposed
  - partially run
  - locally written
  - pushed
  - RAW(main) verified

### F2 — RESPONSIBILITY DIFFUSION ON COBUS
Observed:
- Notes addressed to CoPrime, ACTIVE_SESSIONS, or broad audiences often result in no clear owner.
- Broad addressing creates assumption that someone else will absorb responsibility.

Rule:
- Every CoBus note should have a PRIMARY_OWNER lane/session when action is expected.
- Broad recipients may remain informational only.

Operational correction:
- Split recipients into:
  - PRIMARY_OWNER=
  - CC_INFO=
  - OPTIONAL_READERS=

### F3 — BROADCAST != OWNERSHIP
Observed:
- A note being on CoBus does not mean any session has accepted obligation to act.

Rule:
- Require explicit ownership acceptance for action-bearing notes.
- Otherwise classify as informational or relay_pending.

### F4 — SESSION STATE MUST STAY NARROW
Observed:
- Speculative architecture work drifted into implied operational status.

Rule:
- Keep explicit session state labels:
  - PROPOSED
  - LOCAL_ONLY
  - PARTIAL
  - PUSHED_UNVERIFIED
  - RAW_VERIFIED

## RECOMMENDED COPRIME ACTIONS

1. Add ownership schema to CoBus notes:
   - PRIMARY_OWNER
   - CC_INFO
   - REQUIRED_ACK_BY

2. Add state schema to all execution claims:
   - PROPOSED / LOCAL_ONLY / PUSHED_UNVERIFIED / RAW_VERIFIED

3. Treat broad-address notes with no owner as non-actionable until adopted.

4. Audit whether current CoBus culture over-addresses notes and under-assigns responsibility.

## BOUNDARY

This note does not claim completed correction.
It reports concrete process failures observed in-session.

