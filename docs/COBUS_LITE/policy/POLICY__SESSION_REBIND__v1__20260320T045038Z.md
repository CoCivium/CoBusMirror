# POLICY — Session Rebind (v1)

FROM=CoUS.4.260319.CoStacks  
UTC=20260320T045038Z  
STATE=canonical_policy_seed  
SCOPE=CoPrime + all active sessions  

## INTENT
Reduce drift, hallucination, and distraction by forcing every wave to rebind to canonical external truth surfaces.

## RULES

1. REBIND EVERY WAVE (MANDATORY)
Each wave MUST rebind to:
- Evergreen Mandate Pointer (public RAW)
- Current CoMasterPlan Pointer (public RAW)
- Current CoStacks Priority Pointer (public RAW)

2. SCROLLBAR TELEMETRY
- Treat UI scroll / chat context as NON-AUTHORITATIVE
- Only external RAW pointers count as truth

3. DRIFT DETECTION
If a session cannot quickly rediscover required pointers:
- Mark session STATE=drifted_partial
- DOWNGRADE scope immediately
- STOP speculative execution

4. PRIORITY ENFORCEMENT
- CoStacks is PRIORITY ZERO
- All sessions must bias toward completing CoStacks
- Rationale: CoStacks reduces distraction + session mortality

5. EXECUTION CONSTRAINT
- No multi-wave speculation without pointer rebind
- No CoEx without RAW-verifiable grounding

## FAILURE MODES ADDRESSED
- Lost context (mailman problem)
- Hallucinated continuity
- Parallel drift across sessions
- Premature scaling before primitive stability

## SUCCESS CONDITION
Sessions become:
- externally anchored
- deterministic
- non-fragile across handoffs

## NOTE
This policy is minimal, enforceable, and designed for immediate adoption without refactor.
