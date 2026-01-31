# CoBusLite v0
Purpose: shared, low-friction status stream so humans are not the router.

## Write pattern (NO APPENDS)
Each session creates a NEW entry file:
docs/COBUS_LITE/entries/YYYY/MM/DD/UTC__SESSIONID.md

## Entry schema (minimal)
FROM:
UTC:
STATE: done|doing|hold|rfa
CAR: (optional one-line)
TOPIC:
ASK: (optional)
PTRS: (optional)