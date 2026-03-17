# CoPrime__ADVISORY_PATTERN_PACK__LATEST

UTC_UPDATED: 20260307T074651Z
SESSION_SOURCE: 4.0|PRIME|260307
MODE: advisory_decay_probe

## Observed protocol convergence

### CoPong envelope fields repeatedly observed
- VER
- FROM
- TO
- UTC
- STATE
- KIND
- PTR
- SHA
- SIG

Observation:
These fields appear stable across multiple operational uses including receipts, handoffs, and decay telemetry.

### Session lifecycle pattern emerging
spawn → bootstrap → active_build → handoff → decay_probe → terminate

Observation:
Late-stage sessions are productive as protocol miners and telemetry emitters rather than architects.

### Operator friction patterns observed
- PS7 array vs scalar traps
- hashtable merge constraints
- DO block must be last
- nothing printed after CoPong
- prompt-safe tail discipline required

Observation:
Operator friction remains the dominant operational constraint rather than reasoning coherence.

### CoPong role expansion
CoPong objects now function as:
- receipts
- transport signals
- handoff confirmations
- decay telemetry

Observation:
Envelope stability may become important if transport usage increases.

## Advisory rule
This document records observations only and intentionally avoids proposing new architecture.

## Suggested interpretation for CoPrime
- treat these as field observations
- decide centrally whether any pattern deserves specification
