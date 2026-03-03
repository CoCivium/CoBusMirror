# WF_DRAIN SessionLabel Alias Map v0.1
UTC_CREATED: 20260303T195642Z

## Rule
- Treat base label as canonical stable ID (e.g., CoFutures).
- Treat .liveYYYYMMDD.<Label> as a recoverability-state alias unless explicitly promoted.

## Observed collisions (base vs .live alias)
- CANON=WisestAdvisor | ALIASES=.live260303.WisestAdvisor
- CANON=EntMent       | ALIASES=.live260303.EntMent
- CANON=CoFutures     | ALIASES=.live260303.CoFutures
- CANON=CoDex-ish     | ALIASES=.live260303.CoDex-ish
- CANON=Insights_1    | ALIASES=.live260303.Insights_1

## TODO
- If any .live* label was applied before cosourcing actually occurred, keep it as alias but do not treat it as proof-of-cosource unless ledger+capture+entry pins exist.

