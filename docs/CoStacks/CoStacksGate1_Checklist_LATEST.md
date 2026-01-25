# CoStacksGate1 Checklist (LATEST)

UTC=20260125T054828Z

## PASS criteria (binary checks)
- PASS: CoBeacon contains FULL URL pointers for CoStacks Registry + Primer.
- PASS: CoPong format enforced (one physical line, starts '# ', FULL URLs).
- PASS: Each wave lands as PRs (or PatchPacks) with receipts.
- PASS: Sessions can proceed without waiting for the human unless an approval gate is hit.

## STOP criteria (handoff triggers)
- STOP: pointers missing/ambiguous
- STOP: repo drift (forked canon)
- STOP: workflow-scope blocks pushes and no docs-only/patchpack fallback exists
- STOP: session lag materially reduces throughput → rotate session
