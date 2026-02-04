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