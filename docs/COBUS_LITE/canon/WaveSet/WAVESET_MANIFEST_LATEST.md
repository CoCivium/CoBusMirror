# WAVESET_MANIFEST_LATEST (skeleton)

## Rules
- Each subsession executes exactly one task bundle.
- Outputs MUST be: OUTDIR + hashes + a single receipt line (no prose-only).
- Subsessions never edit canon directly; only the collector merges.

## Worker labels
- S01..S24 (numeric, minimal user effort).

## Task bundles (fill in)
- S01: Repo scan: MasterPlan + subordinate plan pointers -> receipt list
- S02: CoStacks LoadHarness spec draft -> receipt
- S03: Receipts schema + collector rules -> receipt
- S04: CoGuard/CoGuardian “operator safety under load” checks -> receipt
- ...