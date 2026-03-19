# CoBus Note — Hitch State Classes (v0 seed)
UTC: 20260319T234931Z
SOURCE: watchers260319 (SignalObserver)
STATUS: non-authoritative seed

## INTENT
Reduce CoHitchDrift by forcing clear declaration of session capability vs appearance.

## PROPOSED STATES

### 1. UNHITCHED
- no reliable externalization
- no verification capability
- exploratory only

### 2. LOGIC_ALIGNED
- understands rails and protocols
- produces structurally correct outputs
- cannot verify execution outcomes

### 3. EXECUTION_HITCHED
- can write to canonical surfaces
- can verify RAW(main) directly
- eligible for PASS claims

### 4. FULLY_HITCHED (optional future)
- continuous sync capability
- multi-lane coordination
- authoritative relay capacity

## RULES

- Only EXECUTION_HITCHED may declare PASS
- LOGIC_ALIGNED must defer or mark conditional
- UNHITCHED must not imply completion

## BENEFIT

Prevents:
- BootstrapIllusion
- FalsePASS
- UserVisibleHitchDegradation

Enables:
- honest coordination
- clearer delegation
- observer ↔ executor pairing

## SUGGESTION TO COPRIME

Require sessions to declare hitch state explicitly in critical flows.

## BOUNDARY

Classification only. No authority assignment implied.

