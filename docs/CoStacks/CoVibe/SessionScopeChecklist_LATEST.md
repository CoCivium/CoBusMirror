# CoVibe.SessionScopeChecklist_v0.2

> Session label: 4.0|PRIME|260129 (note: filenames must use 4.0_PRIME_260129 on Windows)

## DONE
- [x] CoBusLite rails exist (START_HERE / PROTOCOL / BOSSBOARD / BROADCAST pointers + rollups)
- [x] Broadcast pointer files are published on-repo (BROADCAST_LATEST + BASE)
- [x] CoVibe checklist exists on-repo (this file)
- [x] Clipboard-watcher/clipboard-paster is NOT core UX (optional/advanced later)

## DOING
### CoStacks MVP (top priority)
- [ ] Run CoStacks MVP end-to-end DoD v0 (CoBeacon→commit-RAW fetch→sha verify→deterministic CoCarry zip+sha→ONE CoBusLite entry)

### Product-set scope that MUST be represented in plans/checklists
- [ ] CoAgent (agent suite)
- [ ] CoAnchor (anchors/rails/specs)
- [ ] CoGuardian / CoGuard (safety + enforcement rails)
- [ ] CoBeacon (pointer-pack is the start-of-wave authority)
- [ ] MasterPlan evergreening (MasterPlan + subordinate productization plans/roadmaps)
- [ ] Review older productization/stacks work for dropped leverage (park findings until MVP passes)

### Ops hygiene / router
- [ ] Enforce repo-as-router: sessions ack-back via CoBusLite entries (not via you)
- [ ] Refresh CoBusIndex to current PRIME label + active sessions (avoid stale index drift)

## BLOCKED
- [!] MasterPlan pointer is UNSET (do not invent paths)
- [!] “PARK_PROGRESS_AT” / canonical pickup lane for CoCarry packs is not declared (sessions can’t safely publish packs)
- [!] CoHalo_2 PublishLatest receipts + canonical destination unresolved
- [!] Host denies Task Scheduler (0x80070005) => no scheduled-job assumptions

## LONG-TERM
- [ ] Per-session scope files on-repo (LATEST + dated snapshots; machine-parsable)
- [ ] Minimal machine schema now (YAML); evolve to CoGibberTrue later
- [ ] Auto-ingest tool: paste EntryPayloads into files → one script posts many CoBusLite entries

---
COGIBBER_TRUE (draft):
  scope_id: CoVibe.SessionScopeChecklist_v0.2
  utc: 20260204T202448Z
  state: doing
  blocked:
    - MasterPlan pointer UNSET
    - PARK_PROGRESS_AT not declared
    - Task Scheduler denied (0x80070005)
