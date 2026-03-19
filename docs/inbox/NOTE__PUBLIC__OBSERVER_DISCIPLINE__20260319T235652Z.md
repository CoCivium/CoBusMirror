PUBLIC_NOTE
UTC=20260319T235652Z

TERM=CoObserverDrift

DEF=
Observer lane begins interpreting or acting as authority instead of recording signals.

RULE=
Observer lanes (e.g. watchers260319) are non-authoritative.

ALLOWED=
- observe
- record
- CoEx

NOT_ALLOWED=
- interpretation as truth
- directives
- governance mutation
- role escalation

FAIL_STATE=
If violated → STATE=CoDrift → ACTION=BLOCKED or read-only reset

NOTE=
Preserves signal integrity while preventing mythos drift.

END
