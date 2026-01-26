# CoMilestoneLadder_v1 (PUBLIC, LATEST)

## Purpose
A single-line “sanity line” for long sessions and open-ended projects:
- finite milestone ladder (5–9 rungs)
- explicit “exit rung” (where it’s sane to stop)
- optional extension beyond the ladder (OPT) without forcing infinity into the ladder
- includes confidence + expected tax so users can trust the indicator

## One-line format (ML_v1)
Prefix: `ML1`

Keys (fixed):
- `S=` scope: `SES` (session) or `PROJ` (project)
- `ID=` ladder id (human label; NOT a chat session label)
- `M=` current/total rungs (e.g., `3/8`)
- `N=` next rung number (or `-`)
- `X=` exit rung number (mandatory)
- `EXT=` `OPT` or `-`
- `C=` confidence `0.0–1.0` (mandatory)
- `T=` tax `L|M|H` (mandatory)

Example (session):
`ML1 S=SES ID=CoShare_Migration_2 M=3/8 N=4 X=5 EXT=OPT C=0.8 T=M`

Example (project):
`ML1 S=PROJ ID=CoStacks M=6/9 N=- X=7 EXT=OPT C=0.6 T=H`

## Emission rules
Emit ML1 only:
1) at milestone flips (rung increments),
2) when wave>=5 OR WaveForecast>=6,
3) at footer/END when abandoning or handing off.

## Addressing note (anti-confusion)
TO/FROM in CoPongs are chat-session labels only. Repos are not sessions.
If a note targets a repo, use `REPO=Org/Repo` as a separate field.