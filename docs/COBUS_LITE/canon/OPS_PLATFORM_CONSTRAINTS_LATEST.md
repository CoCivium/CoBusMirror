# CoStacks Ops: Chat Conversation Length Ceiling (Platform Constraint)

## Symptom
- Persistent red banner: conversation reached maximum length.
- After threshold, assistant output truncates/partials; retries degrade.

## Policy
1) Rotate to fresh session BEFORE the banner.
2) For large scripts use file-first launcher (write RUN.ps1 then pwsh -File).
3) Keep rails deterministic via commit-pinned RAW/UNC only (no /main RAW; no blob/main).

## Output Hygiene
- Put SideNotes in high-salience reverse-video with grep markers:
  - <<<SIDENOTE>>> ... <<<ENDSIDENOTE>>>

## Evidence
- Receipt: file:///C:/Users/rball/Downloads/CoPrime_MegaWave/Wave__20260215T010346Z/Receipt__CoPrime_MegaWave__20260215T010346Z.txt
