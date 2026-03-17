# README__CoGuardianCoBusToTargetQueue__v0.1

UTC_CREATED: 20260307T024945Z

Purpose:
First local router from WatcherEvent CoBusLite entries into target-specific queue folders.

What it does:
- scans CoBusLite entries for WatcherEvent files not yet targeted
- reads TO, FROM, KIND, PTR, SHA, UTC
- writes target_queue artifacts under docs/COBUS_LITE/target_queue/<TO>/YYYY/MM/DD/
- writes .targeted sidecars on processed CoBus entries

What it does not do yet:
- no direct session posting
- no policy/authority validation
- no retry escalation

Recovery coordinates:
- REPO_NAME: CoBusMirror
- REPO_LOCAL_ROOT: C:\Users\rball\Documents\GitHub\CoBusMirror
- ROUTER_REPO_REL: tools\coguardian\CoGuardian_CoBusToTargetQueue.ps1
- LAUNCHER_REPO_REL: tools\coguardian\Start-CoGuardianCoBusToTargetQueue.ps1
- README_REPO_REL: tools\coguardian\README__CoGuardianCoBusToTargetQueue__v0.1.md
