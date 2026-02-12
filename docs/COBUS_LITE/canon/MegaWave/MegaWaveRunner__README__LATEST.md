# MegaWave Runner (Zero-Ask) — LATEST
UTC: 20260212T180633Z

## Goal
Run a manifest-driven MegaZip with **no operator prompts** beyond the zip pointer.

## How to run
- Local zip:
  - pwsh -File docs/COBUS_LITE/canon/MegaWave/MegaWaveRunner__LATEST.ps1 -MegaZipPath <path> -SessionLabel <label>
- RAW zip:
  - pwsh -File ...MegaWaveRunner__LATEST.ps1 -MegaZipRawUrl <raw_zip_url> -SessionLabel <label>

## Fail-closed behaviors
- If MANIFEST.json missing => NOT_A_MEGAZIP and STOP.
- Sanitizes SessionLabel to be Windows-path safe.
- Writes outputs under: docs/COBUS_LITE/canon/MegaRuns/MEGARUN__...

## Next binding rail
- Add ACK rail pin (docs/COBUS_LITE/ack or current canon location) into authoritative pins set, so verification scripts stop drifting.
