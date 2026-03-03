# Drain Ledger Schema v0.2
UTC_CREATED: 20260303T165859Z

## Goal
- Standardize the minimal fields needed for a real handoff (recoverable state transfer).

## Required per-session fields
- SESSION_LABEL
- A_SCOPE (original + evolved scope)
- B_FINAL_STATE
- C_SHIPPED_ARTIFACTS (with sha256 + commit/pointers if applicable)
- D_CHAT_ONLY (enumerated list)
- E_LOCAL_UPLOADS (paths or UPLOAD IDs; avoid if possible)
- F_UNEXECUTED
- G_OPEN_ITEMS
- H_DEPENDENCIES
- I_GAPS (explicit hallucination/omission risks)
- J_RECEIPTS_TIER (STRUCTURAL/HASH_ONLY/EXECUTION/SEMANTIC)
- K_BUS_WRITE_SURFACE (actual used; NONE if none)
- L_DEFAULT_LANE (S0–S4)
- M_ROLLBACK_PROOF (Y/N + method/pointer)
- N_TOOLCHAIN (fingerprint or NONE)
- O_NEGATIVE_CONFIRMATION (explicit NOs)
- P_TERMINATION_READY (Y/N + reason)
- Q_PERSISTENCE_CLASS (CHAT_ONLY/MIXED/COSOURCED/LOCAL_ONLY)
- R_PUBLISH_REQUIRED (Y/N/NA)
- T_RECOMMENDED_ACTION (CLOSE_NOW/CLOSE_AFTER_PUBLISH/SUBSESSION_UNDER_COPRIME/HOLD)

## Ledger row add-ons (strongly recommended)
- COMMIT_SHA (where the drain ingestion landed)
- ENTRY_REL + ENTRY_SHA256
- RAW_CAPTURE_REL + RAW_CAPTURE_SHA256
- CANON_PTRS_USED (CoBeacon pin, BROADCAST pin, etc.)

