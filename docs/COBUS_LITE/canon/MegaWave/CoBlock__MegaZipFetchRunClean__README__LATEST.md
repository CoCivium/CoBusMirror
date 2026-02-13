# MegaWave Default CoBlock — Fetch → Verify → Run → Clean (LATEST)

**Default wave UX:**
- Each wave MUST include:
  1) A MegaZip URL (download link) and the expected SHA256
  2) A single CoBlock that contains both the URL + SHA256 and runs the fetch/verify/unzip/run/clean

This prevents “missed link” failure and keeps bloat low.

**Rules:**
- Public links only for public-safe content.
- Anything 4★/5★ stays vault-only (use UNC or other private transport), never public URL.
- Runner commits only triage/meta/receipts (logs stay outside git).

**Template file:**
- CoBlock__MegaZipFetchRunClean__TEMPLATE__LATEST.ps1
