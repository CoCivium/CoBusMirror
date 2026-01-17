# PS7 Panel Spec (PUBLIC LATEST, seed-stage stub)
UTC=20260117T205811Z

Purpose:
- Human grants scoped permission for the AI to act.
- The AI responds with reversible diffs and receipts (sha sidecars, commit SHAs, file SHAs).

Minimum requirements:
A) A human-visible permission statement (scope).
B) A machine-readable receipt object matching: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/ps7/ps7-panel.schema.json
C) The receipt must be referenced in any subsequent privileged action.

Gating rule:
- Enhanced endpoints/features are enabled only when a valid PS7 receipt exists.

Seed note:
- This is a stub until the canonical PS7 panel format is finalized.

END
