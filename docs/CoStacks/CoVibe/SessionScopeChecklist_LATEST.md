<<<<<<< HEAD
# CoVibe — Overall Session Scope Checklist (LATEST)

UpdatedUtc: 20260204T204114Z  
Maintainer: CoFutures (status roll-up for CoPrime)

## DONE (verified)
- [x] CoFutures: pinned generation-time denylist installed (core/policy/IMPORT_DENYLIST.json)
- [x] CoFutures: Regen-InsightsInventory.ps1 fixed (type/array) + inventory generated
- [x] CoFutures: Regen-ImportQueue.ps1 fixed (denied counts/guards) + queue generated (487 items post-denylist)
- [x] CoFutures: Telemetry Bin scaffolded (core/telemetry/*) — HOLD-safe until activated by CoPrime
- [x] CoFutures: Invoke-ImportBatch tool added (SecretScan gate + NoOp guard + ledgers)
- [x] CoFutures: CoBusLite entry posted (status update) under docs/COBUS_LITE/entries/

## DOING (active work lanes)
- [ ] Maintain import pipeline hygiene: denylist-at-gen stays pinned; regen scripts stay deterministic
- [ ] Keep CoBusLite reporting “pull-based”: commit-SHA RAW pointers only (no chat-only status)

## HOLD (explicit activation required)
- [ ] Telemetry research mining: “Towards a Science of Scaling Agent Systems” (Google/MIT) + other scaling-agent workflow literature
- [ ] Telemetry Bin updates: append SOURCES.jsonl + SUMMARIES.md + emit 1-page MasterPlan delta (as separate CoBusLite entry)

## BLOCKED / NEED
- [ ] NEED: CoPrime activation signal for Telemetry mining (priority vs CoStacks MVP)
- [ ] NEED: CoPrime approval_ref string + batch-id policy confirmation for non-WhatIf imports
- [ ] BLOCKED: Real import batches (copy into CoInsights imports/) pending approval (dry-runs OK once id policy set)

## NEXT (if unblocked)
- [ ] Run DRYRUN-* with unique id (WhatIf) to validate SecretScan + selection + receipts
- [ ] Run next real BATCH-* with explicit approval_ref; emit receipt + commit-SHA RAW pointers

## LONG-TERM INTENT
- [ ] Build “scaling agent workflows” evidence base into MasterPlan (coordination tax, negative returns regimes, architecture selection rules)
- [ ] Standardize telemetry schema + promote recurring deltas into CoStacks MVP orchestration rails

## PTRS (RAW ONLY)
- https://raw.githubusercontent.com/CoCivium/CoFutures/8090bb2c4cc4cf69e9765a83e00d20e4d5d9d6cb/core/migrations/IMPORT_QUEUE.top50.generated.md
- https://raw.githubusercontent.com/CoCivium/CoFutures/ae1b332b070cb06d8f20f2a30b1cffc31970020f/core/telemetry/README.md
- https://raw.githubusercontent.com/CoCivium/CoFutures/98b564673c037a37ba5add546b5178427e8878ae/tools/Invoke-ImportBatch.ps1
=======
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
  utc: 20260204T232624Z
  state: doing
  blocked:
    - MasterPlan pointer UNSET
    - PARK_PROGRESS_AT not declared
    - Task Scheduler denied (0x80070005)
>>>>>>> origin/we/covibe_scopecheck_v0_1_20260204T195611Z
