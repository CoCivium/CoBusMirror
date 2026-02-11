# SessionStart v0 — PolicyDraft (Draft v0.1)

## Goal
Allow users to set preferences/profiles at session start, while *surfacing* conflicts vs RepTag/CoHalo observable signals without overreach.

## ConflictPolicy (default recommendation)
- SURFACE_ONLY (default): show mismatches; do not override user prefs.
- NUDGE: propose corrections; still do not override.
- ENFORCE: fail-closed if mismatch threshold exceeded (requires explicit approval pin + documented thresholds).

## PrivacyPolicy (default)
- Default PRIVATE for signals unless an explicit pin says otherwise.
- Separate: (a) collection scope, (b) sharing scope, (c) retention window.

## RepTag “positive-only” comparability (design constraint)
Comparability without negatives is achieved via:
- Attestation count (distinct issuers)
- Recency/expiry
- Breadth (domains / contexts)
- Proof strength (signed receipts / verified origins)
- Optional “confidence intervals” without publishing negative claims

## Output UI requirements
- Always show: what the user claimed, what signals exist, and the policy mode.
- Always label: “SURFACE ONLY — no enforcement” when in default mode.

