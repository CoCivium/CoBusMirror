COZERO_HEADER
SESSION=CoUS.4.260319.CoStacks
WAVE_ID=20260320T001234Z
PREV_WAVE=321078197449aa297dad1e71309194ac57a10a45
STATE=doing
COPULSE=START
COHEARTBEAT=OK
HITCH=advisory
AUTHORITY=advisory
ITEM_KEY=MEGA_STABILIZE_CAPTURE

---

SECTION:COORDINATOR
STATUS=UNKNOWN
RULE=Do not assume CoPrime without RAW(main)

---

SECTION:COMWFRAC
RULE=Every wave must include one CoWE (ID + action + PASS/BLOCK)

---

SECTION:FAILURE_MODES
- CoPrimeAmbiguity
- MailmanLoss
- FalseWriteAttached
- ChainlessExecution
- MultiWaveNoVerify

---

SECTION:CAPTURE_PRIORITY
RULE=Capture > Structure > Polish

---

SECTION:RAW_SIGNAL
NOTE=All raw human input is signal; preserve before filtering

---

SECTION:SESSION_INTENT
This session is forced into:
- single-artifact discipline
- RAW(main) verification
- no assumed authority

END
