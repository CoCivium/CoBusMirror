# SessionStart v0 — Subsession Bootstrap Pack (Draft v0.1)

## Purpose
Provide a deterministic, pin-driven startup routine for new subsessions:
- user can tweak preferences/profiles,
- but the session also sees any conflicts vs RepTag/CoHalo observable signals,
- and the session stays aligned to CoStacks rails via pinned canon assets.

## Inputs (REQUIRED_PINS)
1) COBEACON_RAW_PIN
   - FULL raw URL (preferred) or FULL UNC path.
   - Must be immutable receipt where possible (commit-SHA raw preferred).
2) POINTER_SPEC_RAW_PIN
   - Defines pointer grammar, allowed schemes, and “FULL-only” rule.
3) COPRE_WAVEHEADER_RAW_PIN
   - Defines standardized wave header/footer schema and CoHealth/CoStatus one-liner conventions.

## Optional Pins
- COBUS_DROP_UNC_PIN
  - UNC folder where subsessions may write a single entry payload file + sha256 receipt.
- REPTAG_SIGNAL_SPEC_PIN
  - Defines what “observable doings” / “signals” are allowed to influence behavior.
- SESSIONSTART_POLICY_PIN
  - Defines default decisions for conflicts, privacy levels, and trust semantics.

## Outputs
A) BootstrapReceipt (required)
- One text file containing:
  - UTC timestamp
  - the exact pins received
  - resolved canonical pointers extracted from CoBeacon
  - local environment probes (minimal, non-invasive)
  - PASS/FAIL gate result
- SHA256 sidecar.

B) Optional CoBus Drop (if COBUS_DROP_UNC_PIN is supplied)
- One entry file written to the drop folder:
  - filenames include UTC stamp + FROM/TO fields
  - includes RAW/UNC receipts and SHA256
- SHA256 sidecar.

## Behavioral Policy Knobs (must be explicit)
- ConflictPolicy:
  - SURFACE_ONLY (default): show mismatches between user-stated prefs and RepTag/CoHalo signals; do not override.
  - NUDGE: propose a correction but still do not override.
  - ENFORCE: fail-closed if mismatch exceeds threshold (requires explicit approval pin).
- PrivacyPolicy:
  - PRIVATE / CONSENTED / PUBLIC signals; default PRIVATE unless pin says otherwise.
- PositiveOnlyRep:
  - If “positive-only” reputation is required, then comparability must be expressed as:
    - presence/absence of positive attestations,
    - recency,
    - breadth (distinct issuers),
    - proof strength,
    - without publishing negative claims.

## Gates (Fail-Closed)
- Any pin not FULL raw/UNC => FAIL.
- If POINTER_SPEC forbids a scheme => FAIL.
- If CoBeacon cannot be fetched/read => FAIL.
- If any referenced pointer expands surface area outside whitelist => FAIL.

## One-Deliverable Rule
Each run produces exactly ONE primary deliverable bundle:
- BootstrapReceipt.txt (+ .sha256), and optionally:
- CoBus entry payload file (+ .sha256).
No other files are required; anything else is debug-only.

## Non-Goals (v0)
- No git/gh requirements.
- No attempt to auto-install tooling.
- No background schedulers/agents/tasks.
