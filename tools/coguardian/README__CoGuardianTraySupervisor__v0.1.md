# README__CoGuardianTraySupervisor__v0.1

UTC_CREATED: 20260307T013707Z

Purpose:
Keep CoGuardian tray presence alive by supervising and restarting the tray host if it exits.

Behavior:
- polls for CoGuardian_TrayHost.ps1 process
- restarts tray host if missing
- writes heartbeat and restart log under C:\CoGuardian

Files:
- C:\CoGuardian\tray_supervisor.log
- C:\CoGuardian\tray_supervisor.heartbeat.txt

Recovery coordinates:
- REPO_NAME: CoBusMirror
- REPO_LOCAL_ROOT: C:\Users\rball\Documents\GitHub\CoBusMirror
- SUPERVISOR_REPO_REL: tools\coguardian\CoGuardian_TraySupervisor.ps1
- LAUNCHER_REPO_REL: tools\coguardian\Start-CoGuardianTraySupervisor.ps1
- README_REPO_REL: tools\coguardian\README__CoGuardianTraySupervisor__v0.1.md
