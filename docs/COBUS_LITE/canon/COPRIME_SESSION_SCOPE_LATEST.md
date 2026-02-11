# COPRIME_SESSION_SCOPE_LATEST

## Intent (this week)
- Productize CoStacks workflow substrate so 12–24 subsessions can run safely in parallel (receipts-only, repo-first, drift-resistant).

## Shipped (verified)
- PINS_LATEST exists + CoBeacon wiring (see PINS_LATEST raw pointer in CoBeacon).
- COPRIME_WAVESET_DASHBOARD_LATEST + SUBSESSION_PROTOCOL_LATEST exist on main.
- Proof-to-\\Server receipts: OE snapshots and XDrive index copied + sha sidecars.

## Doing (active)
- Define WaveSet Manifest + task contracts for subsessions (S01..S24).
- Define receipts schema + collector merge-gate rules.
- Define CoStacks load-harness MVP acceptance criteria.

## Blockers (must be published canon; no guessing)
- CANON_COSHARE_ROOT_UNC
- CANON_QUARANTINE_BASE_UNC
- HOLD_UNTIL_YYYYMMDD semantics (if used)

## Do-not-clobber (locked surfaces)
- docs/COBUS_LITE/canon/PINS_LATEST.txt
- docs/COBEACON_LATEST.txt (only append new evergreen pointers; never delete)
- MasterPlan surfaces (only via PR, receipts required)

## Free-to-edit (safe)
- docs/COBUS_LITE/canon/WaveSet/*
- This scope file (append-only changelog below)

## Changelog
- 20260211T145912Z : created/updated.