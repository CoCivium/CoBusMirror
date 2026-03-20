COZERO_HEADER
SESSION=CoUS.4.260319.CoStacks
WAVE_ID=20260320T000413Z
PREV_WAVE=97238dc6fe4dc6f26af27c05f244a3c586caf75b
NEXT_HINT=02_COMWFRAC
STATE=doing
COPULSE=START
COHEARTBEAT=OK
HITCH=advisory
AUTHORITY=advisory
QUEUE_POS=01/05
ITEM_KEY=01_SESSION_MANDATE
PTR_CHAIN_INDEX=https://raw.githubusercontent.com/CoCivium/CoBusMirror/9af93383c7bb8037fdabc77b59d93c767616570c/docs/CoBus/Chain/CHAIN_INDEX.md

---

PUBLIC_NOTE
UTC=20260320T000413Z

SESSION=CoUS.4.260319.CoStacks
TYPE=MandateAnchor_v5

CORE=
1) CoMwFrac: each wave contains one CoWaveEquivalent (CoWE)
2) CoWE:
   - ID declare
   - CoHeartbeat + CoPulse
   - CoSync to CoBus pointers
   - one bounded action
   - close: PASS=YES + RAW(main) OR BLOCKED
3) Authority:
   RAW(main)=truth; chat=advisory
4) Signal:
   prevent CoSignalDrop (capture-first under load)

STATE=active
EVERGREEN=baseline

END
