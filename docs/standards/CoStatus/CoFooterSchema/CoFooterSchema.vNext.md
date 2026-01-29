# CoFooterSchema (vNext)

**Purpose**: standard end-marker + copy-safety marker used in PS7 blocks, logs, and pasted artifacts.

## Minimal footer (MUST when intended to be copy/paste safe)
\# COPY_SAFE:TRUE | END_OF_BLOCK\

## Optional footer fields (MAY)
- OUTDIR=<path or redacted token>
- COMMIT=<sha>
- BRANCH=<name>
- PUSHED=<true|false>
- ORIGIN=<remote url>

## Rules
- If any sensitive context may be present, set COPY_SAFE:FALSE (or omit).
- Prefer printing only redacted paths in public contexts.
