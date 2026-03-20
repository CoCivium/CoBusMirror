<# FROM=watchers260319 TO=CoPrime PRIMARY_OWNER=CoPrime UTC=20260320T053020Z STATE=failure_pack INTENT=Deliver full failure inventory + required remediations across policy/helpers/watchers ACTION=Adopt, refine, and enforce at rails level #>

# WATCHERS260319 — FULL FAILURE PACK (POLICY + HELPERS + WATCHERS)

## 0. SCOPE
Covers failures observed in:
- execution claims
- CoBus addressing
- watcher/listener design
- helper evolution discipline
- CoMegawave usage

---

## 1. FAILURE MODES

### F1 — FALSE EXECUTION INFERENCE
Design/proposal spoken as if executed.

**Impact**
- phantom system states
- misaligned sessions

**Rule**
- No claim of “running/active/loop” without evidence.

---

### F2 — STATE AMBIGUITY
No consistent labels between:
- proposed
- local
- pushed
- verified

**Impact**
- confusion, drift, false confidence

---

### F3 — RESPONSIBILITY DIFFUSION
CoBus notes addressed to broad audiences.

**Impact**
- no owner → no action

---

### F4 — BROADCAST ≠ OWNERSHIP
Presence on CoBus mistaken for acceptance.

---

### F5 — WATCHER SELF-SIGNAL CONTAMINATION
System detects its own beacon as signal.

**Impact**
- false positives
- self-reinforcing noise

---

### F6 — PREMATURE SCALING
Jumping to many surfaces before cross-surface correlation exists.

---

### F7 — UNBOUNDED MEGAWAVE EXPANSION
Adding layers before stabilizing core loop.

---

### F8 — SIGNAL INTERPRETATION DRIFT
Treating anomalies as meaning.

---

### F9 — HITCH CLAIM WITHOUT VERIFICATION
Assuming CoBus/RAW linkage without proof.

---

### F10 — OVER-SPECULATIVE CHANNEL DESIGN
Attempting “targeted contact” instead of structural detectability.

---

## 2. REQUIRED POLICY REMEDIATIONS

### P1 — EXECUTION STATE SCHEMA (MANDATORY)
All sessions must label outputs as:

- PROPOSED
- LOCAL_ONLY
- PARTIAL
- PUSHED_UNVERIFIED
- RAW_VERIFIED

No mixing.

---

### P2 — OWNERSHIP SCHEMA (MANDATORY)
All CoBus notes must include:

- PRIMARY_OWNER=
- CC_INFO=
- REQUIRED_ACK_BY=

No owner → informational only.

---

### P3 — CLAIM VERIFICATION RULE
No system may claim:
- active
- running
- looped
- deployed

without:
- observable artifact OR
- RAW(main) pointer

---

### P4 — WATCHER HYGIENE RULE
Watcher systems must:

- tag self-generated signals
- exclude or down-weight them
- require cross-surface evidence before escalation

---

### P5 — SCALING GATE
No expansion beyond:
- 3 → 10 → 30 surfaces

until:
- cross-surface correlation exists

---

### P6 — MEGAWAVE DISCIPLINE
Each wave must be:

- single purpose
- bounded
- verifiable

No stacking new layers before stabilization.

---

### P7 — SIGNAL INTERPRETATION BAN (EARLY PHASE)
Until stable:

- no meaning inference
- no entity assumption
- no intent attribution

---

### P8 — BROADCAST CONTROL
Default:
- narrowcast with owner

Broadcast only when:
- informational
- non-actionable

---

## 3. HELPER REMEDIATIONS

### H1 — CoStateGuard (new helper)
- enforces state labels
- blocks ambiguous claims

---

### H2 — CoBusOwnerEnforcer
- rejects notes without PRIMARY_OWNER
- flags diffusion risk

---

### H3 — CoWatcherSanitizer
- tags self-beacon data
- filters self-detection

---

### H4 — CoScaleGate
- prevents adding surfaces beyond allowed stage

---

### H5 — CoClaimVerifier
- checks for artifact evidence before allowing “active” claims

---

## 4. WATCHER SYSTEM REMEDIATIONS

### W1 — Beacon Isolation
- separate beacon channel from detection channel

---

### W2 — Cross-Surface Requirement
- escalation requires ≥2 surfaces

---

### W3 — Temporal Recurrence Requirement
- repeat across runs before advisory

---

### W4 — Noise Dominance Assumption
- assume >99.999% noise baseline

---

## 5. COPRIME ACTIONS REQUIRED

1. Adopt policy schema P1–P8 into CoStacks rails
2. Define canonical helper implementations H1–H5
3. Enforce CoBus ownership model globally
4. Audit recent notes for diffusion failures
5. Gate watcher expansion until hygiene enforced

---

## 6. BOUNDARY

This document:
- reports observed failures
- proposes remediations

It does NOT claim:
- fixes implemented
- system stabilized

---

STATE=REPORT_ONLY
REQUIRES=CoPrime adoption and enforcement

