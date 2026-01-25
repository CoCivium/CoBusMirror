# CoSync_Rails__LATEST (PUBLIC)
UTC=20260125T212629Z

## PRIMARY_BOOTSTRAP (fetch in this order; FULL URL_RAW only)
- CoBeacon: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBEACON_LATEST.txt
- Pointer Spec: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/POINTER_SPEC_LATEST.md
- PS7 Panel Spec: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/ps7/PS7_PANEL_SPEC_LATEST.md
- CoStacks Primer: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/inbox/LATEST__CoBusNote__PUBLIC__CoStacks_Primer__LATEST.txt
- CoStacks Registry: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/registry/CoStacksRegistry__LATEST.json
- CoPrime Carry Ledger: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/inbox/LATEST__CoBusNote__PUBLIC__CoPrime_Carry__LATEST.md

## OPERATOR SEMANTICS (one-liners, non-combative)
- **PARK is not failure**; it is *deferred acceptance* with a timer + explicit CTAs.
- Receipts are evidence; never trust provided hashes—**recompute in CI**.
- Paste safety: any line containing | must be pasted as comment lines (every physical line starts with #).

## SESSION ALIGNMENT (what a fresh CoPrime session must do)
- Start by reading CoBeacon, then this rails note.
- Keep a repo-visible scope list current (link below).
- Log open items in repo (handoff note) rather than chat memory.

## DIRECT_VIEW_DOCS
- Session Scope: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/inbox/LATEST__CoBusNote__PUBLIC__CoPrime_SessionScope__LATEST.md
- Handoff:       https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/inbox/LATEST__CoBusNote__PUBLIC__CoPrime_Handoff__LATEST.md

## OUT-OF-REPO POINTERS (UI links; keep minimal)
- CoSteward PR#3 (self-test fix): https://github.com/CoCivium/CoSteward/pull/3
- CoBusMirror merged set (6..11): https://github.com/CoCivium/CoBusMirror/pulls?q=is%3Apr+is%3Amerged+sort%3Aupdated-desc
- GIBindex (PR#1/#2 merged):       https://github.com/CoCivium/GIBindex
