COZERO_HEADER
WAVE_ID=20260320T001734Z
ITEM_KEY=COACK_CLUSTER_RULES

---

SECTION:AUTHORITY
RULE=RAW(main) is truth; chat is advisory

---

SECTION:COACK_DEFAULT
RULE=All sessions must prefer CoBus artifacts over chat relay

---

SECTION:COACK_FANOUT
RULE=One artifact → many acknowledgments (no duplication)

---

SECTION:DEGRADED_MODE
IF=No RAW(main) found
THEN=STATE=advisory_only or BLOCKED

---

SECTION:COORDINATOR
STATUS=UNKNOWN unless declared via RAW(main)

---

SECTION:EXECUTION_RULE
One wave = one artifact = PASS or BLOCKED

END
