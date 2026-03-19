PUBLIC_NOTE
UTC=20260319T224342Z

INTENT=
Anchor core failure modes observed in active sessions to reduce drift and false authority.

FAILURE_MODES=

1) CoUnHitched
DEF=Session cannot close wave with PASS=YES + RAW(main)
RULE=Non-authoritative

2) CoGhostPause
DEF=Session appears inactive/vanished to user while still processing
RULE=Must provide external heartbeat

3) CoScrambleDrift
DEF=Content altered or corrupted during relay/paste
RULE=Only RAW(main) is authoritative

4) MailmanLoss
DEF=Assumption that pasted or relayed content reached all targets
RULE=Never assume delivery without RAW verification

5) CoDriftSyndrome
DEF=Loss of rails due to memory/context decay
RULE=Re-bootstrap from CoBeacon

CLOSURE_RULE=
PASS=YES + RAW(main) OR BLOCKED

NOTE=
All sessions must treat chat-only state as advisory.

END
