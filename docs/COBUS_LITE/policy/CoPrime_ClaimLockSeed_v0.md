# CoPrime Claim/Lease Seed v0

UTC: 20260324T210000Z
STATE: seed

## Purpose
Reduce duplicate CoPrime/executor work by making current lane ownership visible on-rail before substantive work begins.

## Rule
Before any prime/executor session starts substantive work, it should fetch a current claim object from the active rail.

If a matching live claim already exists for the same topic/lane, the session should:
- avoid duplicate work
- emit HOLD or DUPLICATE_AVOIDED
- choose a different free lane or wait for release/expiry

If no matching live claim exists, the session may publish one tiny claim object and proceed.

## Minimum claim object
- PRIMARY_OWNER=
- SESSION=
- TOPIC=
- STATE=
- START_UTC=
- TTL_UTC=
- RELEASE_RULE=
- PTRS=

## States
- CLAIMED
- ACTIVE
- HOLD
- RELEASED
- EXPIRED
- DUPLICATE_AVOIDED

## Guidance
- Keep one claim per active lane/topic.
- Use short TTLs.
- Refresh only while actually attached and working.
- Release promptly when blocked, done, or superseded.
- Prefer narrow topic claims over broad territory claims.

## Truth rule
A claim only counts if it is pushed and publicly reachable on the active rail.

## Initial filenames
- CURRENT_OWNER_QUEUE_LATEST.md
- CLAIM_LOCK__<SESSION>__<UTC>.md
