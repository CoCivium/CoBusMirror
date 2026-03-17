# README__CoGuardianTargetQueueToOutbox__v0.1

UTC_CREATED: 20260307T040833Z

Purpose:
First stub layer from target_queue into outbox.

Behavior:
- scans target_queue for un-outboxed artifacts
- writes outbox artifacts grouped by TO
- writes .outboxed sidecars
- does not post to session surfaces yet

Recovery coordinates:
- REPO_NAME: CoBusMirror
- REPO_LOCAL_ROOT: C:\Users\rball\Documents\GitHub\CoBusMirror
- ROUTER_REPO_REL: tools\coguardian\CoGuardian_TargetQueueToOutbox.ps1
- LAUNCHER_REPO_REL: tools\coguardian\Start-CoGuardianTargetQueueToOutbox.ps1
- README_REPO_REL: tools\coguardian\README__CoGuardianTargetQueueToOutbox__v0.1.md
