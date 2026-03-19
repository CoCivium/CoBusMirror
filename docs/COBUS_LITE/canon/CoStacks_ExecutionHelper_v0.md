# CoStacks_ExecutionHelper_v0

STATE=canonical
SCOPE=execution_helper
VERSION=v0

PURPOSE=Minimal execution helper aligned to verified CoBus write primitive

RULES
- One wave = one artifact
- Must end with PASS=YES + RAW(main)
- No parallel emission before primitive lock
- No local-only success claims

PROCESS
1 write file
2 sha256 sidecar
3 git add
4 git commit
5 git push
6 RAW verify

OUTPUT
PASS=YES
RAW=https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBUS_LITE/canon/CoStacks_ExecutionHelper_v0.md

NOTE
First stable helper after primitive verification
