# CoPrime Scope Checklist — 4.0|PRIME|260211 (BOOTSTRAP)
UTC: 20260212T155203Z

## Bootstrap Spine (must be deterministic)
- [x] PASS receipt exists: WaveSet_Preflight_Receipt__20260212T003244Z.txt
- [ ] Read CoBeacon RAW (SHA-pinned)
- [ ] Read PINS_LATEST (SHA-pinned)
- [ ] Confirm MasterPlan canonical RAW pointer exists (Gate A)
- [ ] Confirm WaveSet manifest determinism exists or is blocked (Gate B)

## Handoff Robustness (make routine, low-friction)
- [x] Publish CoBus Handoff Spine (single pointer hub)
- [ ] Convert ad-hoc SideNotes into pointer-only notes to the spine
- [ ] Mark older notes as superseded (avoid duplicates)

## Core CoPrime Work (pending until MasterPlan is read)
- [ ] Ingest current CoPrime scope standards from pinned canon
- [ ] Map session scope to MasterPlan sections (no reinvention)
- [ ] Produce delta list: keep / evolve / delete (with receipts)

## Active Blockers
- [ ] Prior CoPrime not returning pointer-pack yet (monitor CoBus)

## Bootstrap Artifacts (CoBus-first)
- PointerPack: \\Server\homes\RB\CoBux\INBOX\PointerPack__4.0-PRIME-260211__20260212T155455Z.txt
- GateStatus: \\Server\homes\RB\CoBux\INBOX\GateStatus__4.0-PRIME-260211__20260212T160053Z.txt

## Gates (current)
- Gate A (MasterPlan pointer present): PASS
- Gate B (WaveSet manifest pointer present): PARTIAL

