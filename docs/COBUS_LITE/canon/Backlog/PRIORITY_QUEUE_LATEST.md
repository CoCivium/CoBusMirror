# Priority Queue (Authoritative) — CoBusShare alias within CoBusMirror
UTC: 20260212T161950Z

## P0 — Naming / Authority
- [ ] **Repo rename/migration decision**: CoBusMirror → CoBusShare (or equivalent).  
  - Rationale: "Mirror" implies non-authoritative sync; conflicts with "authoritative bus" semantics.
  - Constraint: must preserve commit-SHA RAW pin discipline and not break existing CoBeacon/PINS pointers.

## P0 — Handoff hardening (must stay routine)
- [x] Canon identity declared (alias): https://raw.githubusercontent.com/CoCivium/CoBusMirror/1e7334960b696cce5ff0d1aa1f92dc372ab95e64/docs/COBUS_LITE/canon/Identity/COBUS_IDENTITY_LATEST.md
- [x] Transport spine added (RAW-per-line): https://raw.githubusercontent.com/CoCivium/CoBusMirror/38d249de7bf56d309c7e914af5a4d0ceec2556bd/docs/COBUS_LITE/canon/Handoff/HANDOFF_SPINE_LATEST.txt
- [ ] Update CoBeacon/PINS to include HANDOFF_SPINE_LATEST_RAW_PIN (commit-SHA pinned, not /main)
- [ ] Add “handoff last-gasp CoHealth line” requirement to handoff canon (not chat)

## P1 — PS7 / Prompt conventions
- [ ] Default PS7 prompt should visually signal “on rails” (yellow prompt) and default to CoShare/repo context.  
  - Action: locate existing prompt/profile asset in pinned canon, patch minimally + reversibly.
