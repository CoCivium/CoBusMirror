# CoPrime WaveSet Dashboard — LATEST

## Goal
Provide a stable “view window” over a WaveSet (parallel subsessions finishing out-of-sync) without chat-bloat.

## Required fields (every CoPrime wave)
- WAVE_ID=<CoPrime wave id>
- WAVESET_ID=<stable id for grouping>
- PINS_USED=[... commit-SHA RAW only ...]
- TASKS:
  - [ ] task_id / owner / state / last_receipt
  - [ ] ...
- INBOX (staged tasks): count + top N pointers
- BLOCKERS: explicit (missing pins / missing toolchain / policy needed)
- DONE_CRITERIA: explicit
- FOOTER_HEALTH: CoHealth + stall signals + next-do invariant

## Task states
- queued | doing | blocked | done | deprecated

## Reporting contract (subsessions)
Subsessions must report via artifacts, not prose:
- Prefer CoBusMirror entry file (commit-SHA RAW receipt)
- Otherwise vault-first artifact + SHA256 + a single CoBus-ready one-liner payload

## Term
**CoWaveSet**: a bounded batch of parallelizable work units orchestrated by a CoPrime wave stream, with asynchronous completion and artifact-first reporting.