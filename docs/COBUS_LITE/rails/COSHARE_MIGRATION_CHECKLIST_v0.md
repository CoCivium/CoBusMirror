# COSHARE_MIGRATION_CHECKLIST_v0
> Receipt-only, deterministic, and reversible.

## Preconditions (must be true)
- [ ] COSHARE pins are published in canon (COSHARE_PINS_*), with PASS_CRITERIA chosen
- [ ] IP Theme Map/Taxonomy is published as binding input (or explicit statement: 'no IP constraints')
- [ ] OE_SecurityInterference rail is active (spec exists + evidence pack format agreed)

## Migration rules (always)
- [ ] Every moved artifact gets: origin_commit_sha + sha256 + created_utc + actor/session
- [ ] No silent moves; every batch creates an evidence pack + CoBusLite entry
- [ ] Default PASS_CRITERIA = HASH_ONLY (paths optional only if approved + redacted)

## Execution steps (per batch)
- [ ] Enumerate candidate set (IDs only; no sensitive paths)
- [ ] Generate sha256 list
- [ ] Create evidence pack (includes sha list + provenance)
- [ ] Commit to branch; PR; link RAW ptrs in CoBusLite entry
- [ ] Verify after-merge (sha match)

## Abort conditions (stop immediately)
- [ ] Any tool crash/quarantine/policy denial without captured evidence pack
- [ ] Any disagreement about pins/PASS_CRITERIA/IP classification
