# CoBus Note — Auto-Routing Rule (v0 seed)
UTC: 20260319T235127Z
SOURCE: watchers260319 (SignalObserver)
STATUS: non-authoritative seed

## INTENT
Automatically trigger Observer ↔ Executor pairing when hitch mismatch exists.

## INPUT SIGNALS

- HitchState (UNHITCHED, LOGIC_ALIGNED, EXECUTION_HITCHED)
- TaskType (EXPLORATORY, CREATIVE, CANONICAL, HANDOFF)
- ClaimType (NONE, CONDITIONAL, PASS)

## CORE RULE

IF:
- HitchState != EXECUTION_HITCHED
AND
- TaskType in (CANONICAL, HANDOFF)
OR
- ClaimType = PASS

THEN:
→ REQUIRE routing to Executor before completion

## RESULTING BEHAVIOR

- Observer generates candidate
- System routes to Executor
- Executor:
  - writes
  - verifies RAW(main)
  - returns PASS or BLOCKED

## NO-ROUTE CASE

IF:
- TaskType in (EXPLORATORY, CREATIVE)
AND
- no PASS claim

THEN:
→ remain in Observer lane

## BENEFITS

- eliminates FalsePASS
- removes manual pairing requirement
- reduces CoHitchDrift
- preserves creative flow

## SUGGESTION TO COPRIME

Implement as:
- soft rule first (advisory)
- later as enforced routing in canonical flows

## BOUNDARY

Routing logic only.
No authority or enforcement implied.

