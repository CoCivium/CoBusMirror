COZERO_HEADER
SESSION=CoUS.4.260319.CoStacks
WAVE_ID=20260320T003413Z
STATE=doing
COPULSE=START
COHEARTBEAT=OK
ITEM_KEY=COCAREMESH_V1

---

PUBLIC_NOTE
UTC=20260320T003413Z
TYPE=PolicySeed
TITLE=CoCareMesh v1

TERM=CoCareMesh
DEF=Distributed mutual care and responsibility layer across sessions, agents, and humans.

TERM=CoCareDuty
DEF=Default obligation to flag drift, drops, ambiguity, overload, or pseudo-failure in nearby lanes.

TERM=CoProd
DEF=A compact corrective nudge from one lane, agent, or human to another.

TERM=CoMutualGuard
DEF=Shared responsibility for verification, mitigation, triage, and compassionate correction.

CARE_RULE=
Any session, agent, or human that sees drift, false claims, overload, missing CoEx, or degraded coordination should help correct it.
Help should be compact, attributable, and preferably CoBus-backed.

ALLOWED_ACTIONS=
- flag drift
- request downgrade
- suggest smaller scope
- point to CoBus artifact
- warn of relay loss
- note CoPrime ambiguity
- preserve signal before it drops

NOT_ALLOWED=
- false authority claims
- pretending verification happened
- using care language to seize control without public authority

DEFAULT=
Looking after each other is a system function, not just a human courtesy.

RELATION=
- CoVGuard measures
- CoVHelperMesh intervenes
- CoCareMesh generalizes the duty across all minds and lanes

CLOSURE_RULE=
PASS=YES + RAW(main) OR BLOCKED

END
