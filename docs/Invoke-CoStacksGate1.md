# Invoke-CoStacksGate1 (Gate1)

Run as a file (do not paste script text into console):

pwsh -NoProfile -ExecutionPolicy Bypass -File .\tools\Invoke-CoStacksGate1.ps1 -CoBeaconRaw "https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBEACON_LATEST.txt" -AllowMutableMain

Fail-closed:
- Requires FULL URLs from CoBeacon
- Requires sha256 coverage for every non-.sha256 artifact via companion .sha256 URL or RECEIPT.sha256
- Rejects /main/ pointers unless -AllowMutableMain
Outputs:
- Deterministic zip pack + .sha256 sidecar
- Prints EntryPayload for manual CoBusLite entry (script does not write it)