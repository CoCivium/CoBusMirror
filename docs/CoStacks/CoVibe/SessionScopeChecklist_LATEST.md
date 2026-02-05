---
title: "CoVibe Session Scope Checklist (Overall)"
version: "0.3"
owner_session: "4.0|PRIME|260129"
last_updated_utc: "20260205T133924Z"
rules:
  - "Fail-closed: no placeholder pointers; unknown => STATE=rfa/hold"
  - "Single-writer: only CoPrime edits *_LATEST; others propose via PR/new file/CoBus entry"
  - "Chat/session is volatile: ship repo receipts every wave (commit-SHA RAW + sha256)"
---

# CoVibe: Overall Session Scope Checklist

## DONE (recent)
- [x] CoBusLite rails exist (START_HERE / PROTOCOL / BOSSBOARD / BROADCAST + rollups)
- [x] Broadcast pointer files published on-repo
- [x] CoVibe scope checklist exists on-repo
- [x] Clipboard-watcher/paster is NOT core UX (optional later)

## DOING (now)
### CoStacks MVP (top priority)
- [ ] Run CoStacks MVP DoD v0 (CoBeacon -> commit-RAW fetch -> sha verify -> deterministic CoCarry zip+sha -> ONE CoBusLite entry)

### Product-set scope that MUST be represented in plans/checklists
- [ ] CoAgent
- [ ] CoAnchor
- [ ] CoGuardian / CoGuard
- [ ] CoBeacon (pointer-pack is wave authority)
- [ ] MasterPlan evergreening (MasterPlan + subordinate productization plans/roadmaps)
- [ ] Review older productization/stacks work for dropped leverage (PARK findings until MVP passes)

### Router hygiene (reduce user effort)
- [ ] Enforce "repo-as-router": sessions ack-back via exactly ONE CoBusLite entry per wave (not via rick/chris)
- [ ] Keep CoBusIndex current to the active PRIME label(s)

## BLOCKED (fail-closed)
- [!] MasterPlan canonical pointer is UNSET (do not guess)
- [!] PARK_PROGRESS_AT / canonical CoCarry pickup lane not declared (cannot publish packs safely)
- [!] Multi-writer conflicts on *_LATEST (must enforce single-writer)

## LONG-TERM
- [ ] Per-session scope files on-repo (LATEST + dated snapshots; machine-parsable)
- [ ] Minimal machine schema now; evolve to CoGibberTrue when stable
- [ ] Make “review past CoBus rollups” a formal step at start of any new PRIME session