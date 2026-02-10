# OE_SecurityInterference_SPEC_v0
> Purpose: capture endpoint/platform interference events (Defender/Malwarebytes/WebView2/proxy) as evidence packs with deterministic receipts.

## Event record (fields)
- utc
- host (redacted ok)
- tool
- tool_version (if available)
- interference_type (block | crash | quarantine | permission_denied | policy_denied)
- symptom (one-liner)
- reproduction_steps (minimal)
- mitigations_tried (bullets)
- outcome (pass | fail | partial)
- evidence_pack_raw_ptr (commit-SHA RAW pointer)
- evidence_pack_sha256
- privacy_notes (confirm: no local paths; no secrets)

## Evidence pack rules
- No local paths.
- Prefer logs trimmed to relevant lines.
- Include command outputs as text files.
- Include 'RECEIPT.json' containing the fields above.

## Pass/fail rule
- Fail-closed: if evidence pack lacks RAW ptr + sha256, treat as non-binding.
