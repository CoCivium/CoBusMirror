# MegaWave Runner (Zero-Ask) — LATEST
- Parser-correct: param() first.
- SessionLabel may include pipes; only filesystem paths sanitized.
- **Logs are stored outside git** (default: $HOME\Downloads\_MegaWaveLogs) and referenced by SHA256 in receipts/triage.
- Git commits contain only: TRIAGE + METADATA + receipts (short paths).
