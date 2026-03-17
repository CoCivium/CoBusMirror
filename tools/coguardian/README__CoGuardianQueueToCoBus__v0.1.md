# README__CoGuardianQueueToCoBus__v0.1

UTC_CREATED: 20260307T012018Z

Purpose:
First local bridge from watcher_queue captures into real CoBusLite entries.

What it does:
- scans docs/COBUS_LITE/watcher_queue recursively for .txt captures
- ignores files that already have a .processed sidecar
- converts each capture into a CoBusLite entry under docs/COBUS_LITE/entries/YYYY/MM/DD/
- writes a .processed sidecar with the resulting entry path

What it does not do yet:
- no authority validation
- no direct target-session posting
- no retry policy beyond unprocessed file scanning

Suggested usage:
1. Keep CoGuardian watcher running.
2. Emit VIOLET_EVENT lines.
3. Run Start-CoGuardianQueueToCoBus.ps1 periodically or from scheduler.
4. Inspect new CoBusLite entries and .processed sidecars.

Recovery coordinates:
- REPO_NAME: CoBusMirror
- REPO_LOCAL_ROOT: C:\Users\rball\Documents\GitHub\CoBusMirror
- BRIDGE_REPO_REL: tools\coguardian\CoGuardian_QueueToCoBus.ps1
- LAUNCHER_REPO_REL: tools\coguardian\Start-CoGuardianQueueToCoBus.ps1
- README_REPO_REL: tools\coguardian\README__CoGuardianQueueToCoBus__v0.1.md
