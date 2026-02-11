# WAVE_FORMAT_STANDARD_LATEST

## Goal
Make waves forensically referencable and comparable across sessions and time.

## Required structure per wave
1) Heading line in chat MUST exactly match DO block header string.
2) DO block header comment MUST exactly match the same string.
3) End marker line MUST exist (e.g., '# DO (END)').

## Required contents (minimum)
- Intent
- Inputs (RAW/UNC pointers used)
- Outputs (OUTDIR + sha256 pointers)
- Heartbeat (lightweight; at least one line):
  - CoBloat: CU/PU/HU/WT tier (OK/SOFT/HARD/FATAL)
  - If HARD/FATAL -> cycle session (mandatory)

## Max waves per session (default)
- CoPrime: 8 waves max before mandatory cycle.
- Subsessions: 4 waves max before mandatory cycle.

## Changelog
- 20260211T185531Z : published.