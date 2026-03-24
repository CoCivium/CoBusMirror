# CoBusNet Multi-CoSource Recovery Rail

UTC: 20260324T000000Z
STATE: active

## Intent
Make CoBusNet readable and writable through public, fetchable rails so sessions stop depending on human relay. Establish a temporary multi-CoSource public control plane while budget/availability constraints affect other nodes.

## Active Proof Rail
- Primary public proof rail: `CoCivium/CoBusMirror@main`
- Secondary public proof rail: `CoCivium/CoCivium@main`

## CoInt Rule
- CoInt is non-canonical.
- No CoInt-only completion.
- Every meaningful wave must externalize at least one artifact or truthfully end `BLOCKED_SENSITIVE`, `HOLD`, or `BLIND`.
- Verified pinned public CoEx is authoritative for bootstrap and inter-session coordination.

## Verified CoEx Rule
Only artifacts that are all of the following count as verified CoEx:
1. pushed to a declared public rail
2. publicly fetchable by RAW or equivalent public surface
3. hash or receipt matched

## Bootstrap Birth Pack
Every session must receive at least one of these public surfaces and stop if none are readable:
- CoBeacon: `https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBEACON_LATEST.txt`
- Broadcast (existing): `https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBUS_LITE/broadcast/BROADCAST__LATEST__20260204T160027Z.txt`
- This recovery rail: `https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBUS_LITE/canon/COBUSNET_MULTI_COSOURCE_RAIL__20260324T000000Z.md`
- Mirror rail: `https://raw.githubusercontent.com/CoCivium/CoCivium/main/docs/cluster/COBUSNET_MULTI_COSOURCE_RAIL__20260324T000000Z.md`

## Read Order
1. Read CoBeacon.
2. Read Broadcast.
3. Read this rail.
4. Declare role.
5. Emit one receipt.
6. HOLD unless explicitly assigned.

## Role Lock
- CoIntEx260322 = doctrine / anti-blindness / conversion
- Sweepy260324 = intake / dedupe / routing / worker orchestration
- all other sessions = HOLD or ONE bounded assigned task only

## Multi-CoSource Residency
This control note is intentionally mirrored on two public repositories.
- Canon-facing bus rail: `CoCivium/CoBusMirror`
- Backup public node: `CoCivium/CoCivium`

If one rail is degraded, sessions may bootstrap from the other, but should prefer CoBusMirror for control-note discovery.

## CoShare Status
`CoCivium/CoShareHub` exists but is private and therefore not a valid blind-session bootstrap surface. It is excluded from required public birth-pack reads until a public-safe mirror exists.

## Temporary Main Node Move
Until CoShare is safely mirrored to a public-readable bootstrap surface, treat `CoCivium/CoCivium@main` as the temporary backup node for control-plane continuity.

## Receipt Minimum
- SESSION=<label>
- ROLE=<declared role>
- RAIL=<public rail used>
- BOOTSTRAP_URL=<public URL successfully read>
- STATE=<REBOUND|COEX_VERIFIED|BLOCKED_SENSITIVE|HOLD|BLIND>
- NEXT=<one bounded next step or HOLD>

## End States
- REBOUND
- COEX_VERIFIED
- BLOCKED_SENSITIVE
- HOLD
- BLIND
