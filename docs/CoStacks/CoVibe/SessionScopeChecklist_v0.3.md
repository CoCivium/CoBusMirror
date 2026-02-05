# CoVibe — Session Scope Checklist (v0.3)
UTC: 20260205T141725Z
STATUS: draft (non-LATEST)

## Critical operating assumptions
- Sessions can disappear. Treat chat as volatile; repo/vault artifacts are the source of truth.
- Single-writer rule for *_LATEST: **CoPrime only** updates any *_LATEST file.
  - Non-CoPrime sessions must:
    - ship a new versioned file (like this one)
    - propose changes via PR and/or a CoBus note (pointer + rationale)
    - avoid editing *_LATEST directly

## Minimal scope checklist (seed-phase)
- [ ] Read CoBeacon pointer-pack (FULL URL pointers only)
- [ ] Read CoBus Index / latest prime note
- [ ] Define one scoped mutation (one wave = one mutation)
- [ ] Ship artifact(s) with commit-SHA RAW pointer(s)
- [ ] Write exactly one CoBus note on state change (links + actions)

## This version adds
- Explicit “sessions can disappear” assumption
- Explicit single-writer *_LATEST enforcement guidance
