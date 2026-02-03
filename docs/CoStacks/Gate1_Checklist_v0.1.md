# CoStacks Gate-1 Checklist v0.1
UTC: 20260203T194355Z

## Stop-rule
Gate-1 is DONE when a fresh session can, using only CoBeacon/Registry pointers, execute the minimal end-to-end loop without guessing paths.

## Checklist
- [ ] Fetch CoBeacon RAW pointer-pack (FULL-URL only).
- [ ] Resolve required artifacts strictly from pointers (prefer commit-SHA RAW).
- [ ] Verify sha256 receipts for every fetched artifact.
- [ ] Produce exactly one deterministic output pack (zip) + .sha256 (and optional RECEIPT.json).
- [ ] Publish pack + sha256 at a canonical FULL-URL location.
- [ ] Post exactly one CoBusLite entry linking inputs + receipts + output pack.

## WIP cap
Keep ≤4 non-HOLD sessions active on Gate-1 at once; everyone else posts HOLD entries.
