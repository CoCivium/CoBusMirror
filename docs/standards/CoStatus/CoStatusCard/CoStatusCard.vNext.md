# CoStatusCard (vNext)

**Purpose**: a compact, copy-safe status unit that is readable by humans *and* parseable by AIs.

## Human lane (MUST)
Top line (single line):
\# CoStatusCard | ID=<id> | UTC=<yyyyMMddTHHmmssZ> | CoHealth=<OK|SOFT|HARD|FATAL>\

Sections (recommended order):
- DONE: bullets (past-tense, verified)
- DOING: bullets (present-tense)
- NEXT: bullets (future-tense)
- RISKS: bullets (optional)
- CANON: pointers (optional but strongly recommended when artifacts exist)
  - MAIN_COMMIT=<sha>
  - RAW_POINTERS=<commit-sha raw urls>

## Machine lane (MAY, recommended)
Embed one JSON payload as an HTML comment so it stays invisible in most renderers:

\\\html
<!-- CoGibberNote BEGIN
{"id":"...","utc":"...","cohealth":"OK","done":[...],"doing":[...],"next":[...],"canon":{"main_commit":"...","raw_pointers":[...]}}
CoGibberNote END -->
\\\

## Constraints
- MUST remain short enough to review quickly (aim: <= ~80 lines).
- MUST be safe to paste into issues/PRs/logs.
- MUST include UTC in canonical format for sorting + audit.
