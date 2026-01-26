# ALR_v1_Spec (PUBLIC, LATEST)

## Meaning
ALR = **All Locals Redundant**: “DONE” means the work is reconstructible from canonical sources.

## DONE criteria (strict)
An item counts DONE only when ALL are true:
1) A **public manifest stub** exists (IDs, tags, hashes/receipts) without leaking protected payloads.
2) A **private vault payload** exists (if applicable).
3) Hash/receipt matches: public stub ↔ private payload ↔ build outputs (where relevant).

## NOT DONE
- “It exists somewhere in CoSources” does NOT qualify.
- “I remember doing it” does NOT qualify.

## Stealth Migration pattern
- Public redacted manifest (IDs, tags, SHA, receipt)
- Private vault payload
- DONE only when both exist AND verify

## Emission
- Show ALR_v1 only at milestones (every ~5–15 waves or when an ALR rung flips).
- Keep ALR_v1 visually distinct from ML1 (session ladders).