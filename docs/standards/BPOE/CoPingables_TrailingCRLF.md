# BPOE — CoPingables must be paste-executable

Rule: Any CoPingable (SideNote / CoPong / CoPing line) MUST end with a trailing CRLF.
Goal: Pasting into PS7/terminal returns to the prompt with zero manual Enter.

Enforcement points:
- CoSideNote.ps1 MUST Set-Clipboard with ($line + "`r`n") / ($sn + "`r`n").
- CoBusRelay.ps1 MUST Set-Clipboard with ($sn + "`r`n").

Operator rule: Prefer generating CoPingables via tools (clipboard), not by copying from chat output.

