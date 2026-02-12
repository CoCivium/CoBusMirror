# CoMetaTrain — SPEC (LATEST)
UTC_LAST_TOUCH: 20260212T214736Z

## Purpose
Batch-updated metadata train for assets/processes:
- classification
- routing (public vs vault)
- automation gating

## Required fields (minimum viable)
- ASSET_ID
- ASSET_KIND
- OWNER_SESSION
- SOURCE_PTRS (FULL RAW/UNC only)
- CLASSIFICATION (use canon scheme, do not invent)
- IP_SENSITIVITY_STARS (1..5)
- DISCLOSURE_MODE (public_ok|public_redacted|vault_only)
- RATIONALE
- NEXT_ACTIONS
- RECEIPTS (sha256 / commit shas)

## Batch rule
Update in batches per wave (not one-asset-at-a-time) to reduce drift.

## Output formats
- Markdown table (human)
- JSONL (machine)
