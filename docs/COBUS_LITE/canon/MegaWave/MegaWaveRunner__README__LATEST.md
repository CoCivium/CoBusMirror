# MegaWave Runner (Zero-Ask) — LATEST
UTC: 20260212T182455Z

## What it fixes
- SessionLabel can contain pipes (|) and other symbols; **label remains verbatim** for TRIAGE/metadata.
- Only filesystem paths use a sanitized PathLabel.
- Each MegaRun emits TRIAGE + METADATA.

## Run
- Local zip:
  - pwsh -File docs/COBUS_LITE/canon/MegaWave/MegaWaveRunner__LATEST.ps1 -MegaZipPath <path> -SessionLabel '<label>'
- RAW zip:
  - pwsh -File docs/COBUS_LITE/canon/MegaWave/MegaWaveRunner__LATEST.ps1 -MegaZipRawUrl <raw_zip_url> -SessionLabel '<label>'

## Fail-closed
- Missing MANIFEST.json => NOT_A_MEGAZIP and STOP.
