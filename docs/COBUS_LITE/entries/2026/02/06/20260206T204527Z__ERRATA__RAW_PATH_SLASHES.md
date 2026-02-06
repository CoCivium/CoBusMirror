# ERRATA — RAW path slashes (20260206T204527Z)

A prior shell output printed an ENTRY_RAW using Windows backslashes, which breaks the RAW URL.

## Correct RAW (slashes)
- https://raw.githubusercontent.com/CoCivium/CoBusMirror/5dd6352cf3da72ec5dc0a3b23947a61a95648b7f/docs/COBUS_LITE/entries/2026/02/06/20260206T190052Z__CoPrime__WAVE.md

## Note
The commit SHA remains valid; only the printed URL path separator was wrong.