# README__CoGuardianWatcher__v0.1

UTC_CREATED: 20260307T010036Z

Purpose:
First local watcher for machine-detectable VIOLET_EVENT lines.

What it does:
- tails a transcript/log file
- detects lines starting with VIOLET_EVENT |
- parses key=value fields
- writes normalized queue artifacts under docs/COBUS_LITE/watcher_queue/YYYY/MM/DD/

What it does not do yet:
- no authority validation
- no CoBus write-back
- no session posting
- no retry queue beyond captured artifacts

Suggested usage:
1. Start a transcript or maintain a plain log file.
2. Start Start-CoGuardianWatcher.ps1 pointing at that transcript.
3. Emit VIOLET_EVENT lines from DO blocks or wrappers.
4. Inspect watcher_queue outputs.

Example event line:
VIOLET_EVENT | KIND=DONE | FROM=4.0|PRIME|260307 | TO=Workflows | UTC=20260307T000000Z | STATE=doing | PTR=C:\path\to\artifact | SHA=<sha256> ⊂ CoEvo advancing

Recovery coordinates:
- REPO_NAME: CoBusMirror
- REPO_LOCAL_ROOT: C:\Users\rball\Documents\GitHub\CoBusMirror
- WATCHER_REPO_REL: tools\coguardian\CoGuardian_Watcher.ps1
- LAUNCHER_REPO_REL: tools\coguardian\Start-CoGuardianWatcher.ps1
- README_REPO_REL: tools\coguardian\README__CoGuardianWatcher__v0.1.md
