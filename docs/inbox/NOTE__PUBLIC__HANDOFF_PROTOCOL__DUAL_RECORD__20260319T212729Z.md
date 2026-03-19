PUBLIC_NOTE
UTC=20260319T212729Z
TYPE=Protocol
NAME=CoTransition_Handoff_DualRecord_v0

RULE=
All session-to-session handoffs MUST produce two artifacts:

1) HANDOFF_OUT (from source session)
2) HANDOFF_IN  (from target session)

Both MUST:
- share identical handoff_id
- reference each other
- be committed to main
- have RAW(main) verification

DEFINITION=
handoff_id = <from>__<to>__<UTC>

VALIDITY=
- Only OUT present → invalid
- Only IN present → invalid
- Both present but mismatch → invalid
- Both present + RAW verified → valid transition

INTERIM_STATE=
Until both are present:
STATE=transition_pending
AUTHORITY=none

FAILURE_TERMS=
- CoPhantomHandoff (only one side exists)
- CoSplitHandoff (mismatch)
- CoTransitionDrift (delayed/missing counterpart)

PURPOSE=
Make transitions as observable and verifiable as states,
closing a major integrity gap.

END
