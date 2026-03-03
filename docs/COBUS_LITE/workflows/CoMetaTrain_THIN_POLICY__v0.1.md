# CoMetaTrain THIN Policy v0.1
UTC_CREATED: 20260303T180329Z

## Intent
- Make every durable CoSource asset evolvable without becoming self-bloating.
- Keep headers deterministic and routable; move tangents into pointer-linked captures/ledgers/CoTrove.

## Binding rules (seed-stage default)
1) Durable assets SHOULD carry a CoMetaTrain header (or a sidecar for binaries).
2) CoMetaTrain must stay thin: purpose, lane/owner, status, inputs/outputs, pointers, receipts.
3) Do not inline tangential history. Instead: point to a capture/ledger/CoTrove entry with sha256.
4) Deprecation must be cheap: mark DEPRECATED + point to successor + keep receipts.
5) Fitness is operational: if it does not reduce operator effort or increase determinism/recoverability, it loses.

## Recommended header fields (minimal)
- PURPOSE
- OWNER/LANE
- STATUS (doing/done/hold) + DATE
- INPUT_PTRS (commit-SHA RAW preferred)
- OUTPUT_PTRS
- RECEIPTS (sha256, commit SHA)
- DEPRECATION (if applicable)

## CoEvo mapping (why this exists)
- Mutation = new wave / new asset version.
- Selection = gates + receipts tiers + adoption.
- Inheritance = CoMetaTrain pointers + receipts.

## Non-goal
- CoMetaTrain is NOT a transcript archive; that belongs in captures/ledgers (hashed, pointer-linked).

