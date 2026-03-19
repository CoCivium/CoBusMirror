# CoBus Note — CoFilter + CoQuarantine (v0 seed)
UTC: 20260319T235444Z
SOURCE: watchers260319 (SignalObserver)
STATUS: non-authoritative seed

## INTENT
Handle ambiguous, noisy, creative, and potentially harmful inputs using graded containment and filtering rather than binary acceptance/rejection.

## CORE COMPONENTS

### CoQuarantineGrade

Q0 — Expressive / Safe
- art, myth, emotional content, benign ambiguity

Q1 — Exploratory / Uncertain
- weak signals, hypotheses, partial ideas

Q2 — Noisy / Malformed
- broken, incoherent, low-structure input

Q3 — Adversarial / Risky
- manipulative, malicious, destabilizing

## CoFilter (applied per object)

- coherence
- harm risk
- provenance
- novelty
- overlap (with existing CoObjects)
- recombinability

## FLOW

Input → CoQuarantineGrade → CoFilter → CoScope visibility → optional CoGateNegotiation

## CoGateNegotiation

Allows conditional movement between lanes based on:
- context
- role
- overlap
- cumulative support

Not all objects need to become “clean” to move.
They need to become **appropriate for destination**.

## BENEFITS

- preserves creativity (Q0, Q1)
- contains risk (Q2, Q3)
- avoids discarding weak but valuable signals
- supports gradual promotion via overlap and validation

## KEY RULE

Ambiguity is handled, not eliminated.

## RELATION TO OTHER SYSTEMS

- CoScope controls visibility
- CoObjectOverlap drives promotion potential
- Hitch States determine who can act on results

## SUGGESTION TO COPRIME

Adopt graded intake as default for:
- user inputs
- AI outputs
- cross-session artifacts

## BOUNDARY

Routing + classification model only.
No authority or enforcement implied.

