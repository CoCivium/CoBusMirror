PUBLIC_NOTE
UTC=20260319T214159Z
TYPE=Protocol

NAME=CoFanOut_and_CoBridge_v0

DEFINITIONS=

CoFanOut:
Publish once to public RAW(main), consumed by all sessions.
No relay required.

CoBridge:
Human or agent that carries messages between sessions without authority guarantees.

RULES=

1. Any CoBridge-transmitted content is advisory only.
2. Authority requires RAW(main) verification.
3. Multi-session coordination MUST use CoFanOut, not relay.
4. Sessions MUST NOT assume delivery to multiple targets via relay.
5. Missing messages are expected (CoBridgeLoss).

FAILURE_TERMS=

- CoBridgeLoss
- CoAssumedDelivery
- CoPhantomBroadcast

PURPOSE=
Reduce coordination fragility and eliminate reliance on lossy human relay.

END
