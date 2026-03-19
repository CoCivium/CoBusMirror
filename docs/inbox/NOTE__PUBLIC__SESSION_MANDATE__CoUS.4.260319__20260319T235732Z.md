PUBLIC_NOTE
UTC=20260319T235732Z

SESSION=CoUS.4.260319.CoStacks
TYPE=MandateAnchor_v3

RULES=

1. CoMwFrac:
   every wave must contain one CoWaveEquivalent (CoWE)

2. CoWE:
   - ID declare
   - CoHeartbeat + CoPulse
   - CoSync to CoBus pointers
   - one bounded action (write or readverify)
   - close: PASS=YES + RAW(main) OR BLOCKED

3. Authority:
   RAW(main) = truth
   chat-only = advisory

4. Signal:
   prevent CoSignalDrop (capture-first under load)

STATE=active
EVERGREEN=target

END
