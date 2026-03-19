PUBLIC_NOTE
UTC=20260319T225250Z

INTENT=
Prevent silent loss of user/session signals under overload.

FAILURE_MODES=

CoSignalDrop
DEF=High-value input not captured into CoEx or tracked
RULE=Must externalize or explicitly mark missing

CoOverrunDrop
DEF=Signal loss due to input rate exceeding processing capacity
RULE=Switch to CAPTURE_PRIORITY mode

REQUIRED_BEHAVIOR=

1) If overload detected:
   MODE=CAPTURE_PRIORITY

2) Capture all incoming signals into queue (CoInt list)

3) Externalize queue before further reasoning

4) Process after anchoring

TRUTH_RULE=
If not in RAW(main), treat as non-existent

NOTE=
No assumption of capture from chat memory

END
