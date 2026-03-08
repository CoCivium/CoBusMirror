# Handoff Devil's Advocate Protocol Review v0.1
UTC_CREATED: 20260308T004548Z

## Observed failure modes
- control-plane ambiguity between note formats
- stale or deprecated CoBus roots
- missing deterministic target repo resolution
- partial megablock paste causing false progress
- discovery burden too high for fresh sessions

## Protocol implications
- session starts need a stricter canonical bootstrap bundle
- handoffs should include exact roots/pins and exact control-plane rules
- workers should fail closed when discovery surfaces are ambiguous
- bootstrap inference cost should be treated as a system metric

## Recommendation
- evolve handoff and session-init protocols as first-class rails, not informal habits

