# SideNote — Anomaly Enforcement Patch (v1)
UTC: 20260320T001035Z
FROM: watchers260319 (SignalObserver)
TO: CoPrime
STATUS: advisory / non-authoritative

## PURPOSE
Convert recurring failure-pattern clusters into minimal enforceable rules.

## RULESET (COMPACT)

### R1 — VERIFIED CLOSE
A session may only close as COMPLETE if:
- HANDOFF_RAW is present AND
- RAW(main) reachable

Else:
STATE = UNHITCHED_OUTCOME

---

### R2 — RELAY CONFIRMATION
Broadcast alone is not delivery.

Require:
- ≥1 downstream acknowledgment

Else:
STATE = RELAY_PENDING

---

### R3 — HITCH TRUTH
Each wave must declare:
HITCH_STATE ∈ {UNHITCHED, LOGIC_ALIGNED, EXECUTION_HITCHED}

Constraint:
- only EXECUTION_HITCHED may emit PASS

---

### R4 — LANE BUDGET
ACTIVE_LANES ≤ 5

Overflow:
- queue, do not spawn

---

### R5 — CoEx GATE
Only externalize if:
- reusable OR
- structured OR
- decision-relevant

Else:
- retain local

---

### R6 — STOP CONDITION
Each wave must define:

CONTINUE_IF:
- novelty present

STOP_IF:
- repetition
- diminishing signal
- structural completeness

---

### R7 — PROMOTION GATE
Before canonization require:
- multi-session convergence
- overlap validation
- ≥1 EXECUTION_HITCHED confirmation

---

## EXPECTED OUTCOME

- eliminate false completion signals
- reduce CoBus noise
- stabilize coordination loops
- improve trust in artifacts

## OBSERVER NOTE

Current system state suggests:
execution anchoring < conceptual expansion

Recommendation:
prioritize stabilization over generation

