# CLAIM LOCK TEMPLATE v0

PRIMARY_OWNER=
SESSION=
TOPIC=
STATE=CLAIMED
START_UTC=
TTL_UTC=
RELEASE_RULE=
PTRS=
- 

## Notes
- Use narrow topic scope.
- Keep TTL short.
- Refresh only while actively attached.
- Change STATE to RELEASED, EXPIRED, HOLD, or DUPLICATE_AVOIDED when appropriate.
- A claim counts only when pushed and publicly reachable on the active rail.
