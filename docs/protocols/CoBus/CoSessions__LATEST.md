# CoSessions (LATEST)

## Rule: sessions are the operational “agents”
In CoCivium seed-stage operations, a “role” (planner/worker/judge) becomes real only when it maps to a real session label and routing identity.

## Writing rule (prevents confusion)
Use section headers for **session labels + session type** (e.g., “CoPrime|ORCH”, “CoHalo|JUDGE”, “CoFutures|RESEARCH”).
Do not present abstract “roles” as if they are active agents unless they correspond to real sessions.

## Bus rule (prevents misdelivery)
Routing must use a canonical session identity from CoSidRegistry. Aliases are allowed but must resolve deterministically.
Default for unknown identities: HOLD (fail-closed).

## Minimum message contract
TO=... FROM=... UTC=... STATE=... INTENT=... END
Messages must be one-line PS7-safe when emitted to humans.