# CoStacks Primer (LATEST)

UTC=20260125T054828Z

## CoStacksGate1 (milestone definition)
Orchestration is considered **secured** when:
1) A CoPrime session can coordinate repo work across multiple sessions with minimal human intervention.
2) Cross-session coordination is pointer-driven (FULL URLs) and reproducible from repo state.
3) CI + scripted rails catch most regressions automatically.
4) Productivity scales (goal: ~100x) via proactive sessions hammering repos while human is mostly observing.

## Required rails
- Always start from CoBeacon (FULL URL pointers only).
- CoPong for quick one-line handoffs; SideNotes for multi-line, but never re-emit inbound notes as “new” ones.
- Prefer “docs-only” PRs when workflow-scope restrictions block pushes.

## Next moves
- Land CoStacks Registry + Primer into CoBusMirror, then fill CoBeacon blanks.
- Add a Gate-1 checklist + an AutoPrompter spec (seed-stage) for “hands-off for an hour” runs.
