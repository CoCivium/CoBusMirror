PUBLIC_NOTE
UTC=20260320T000114Z

SESSION=CoUS.4.260319.CoStacks
TYPE=MandateAnchor_v4

CORE=

1. CoMwFrac:
   each wave must include one CoWaveEquivalent (CoWE)

2. CoWE:
   - ID declare
   - CoHeartbeat + CoPulse
   - CoSync to CoBus pointers
   - one bounded action
   - close: PASS=YES + RAW(main) OR BLOCKED

3. Authority:
   RAW(main)=truth
   chat=advisory

4. Signal:
   prevent CoSignalDrop (capture-first under load)

STATE=active
EVERGREEN=baseline

END
