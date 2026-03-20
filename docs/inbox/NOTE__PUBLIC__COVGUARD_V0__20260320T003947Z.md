COZERO_HEADER
ITEM_KEY=COVGUARD_V0
UTC=20260320T003947Z

---

COV_ENVELOPE:
- ID
- OWNER
- STATE=proposed|verified|failed
- VERIFY_REF=RAW(main)
- CONFIDENCE

RULE:
Only VERIFIED increments CoV/s

SIGNAL:
Track drift_index and verified_rate

END
