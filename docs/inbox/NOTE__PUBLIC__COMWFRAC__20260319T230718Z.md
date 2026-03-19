PUBLIC_NOTE
UTC=20260319T230718Z
TYPE=ProtocolSeed
TITLE=CoMwFrac default wave discipline

TERM=CoMwFrac
EXPANSION=CoMegawaveFractal
AKA=CoExFrac|CoXFrac

DEF=
Think and delegate in many lanes, but require every wave to include at least one complete CoWaveEquivalent (CoWE) that closes honestly.

CORE_RULE=
Every wave must contain at least one CoWE:
1. ID declare
2. CoHeartbeat + CoPulse
3. CoSync to CoBus and pinned rails/stacks pointers
4. one bounded lane action (write or readverify)
5. honest close:
   - PASS=YES + RAW(main), or
   - BLOCKED with explicit blocker

WHY=
This preserves CoMegawave behavior without allowing waves to become unverifiable chaos.

DEFAULT=
CoMwFrac is recommended as the default operating stance for future sessions.

NOTE=
Larger megawaves may exist around the CoWE core, but the core must still close honestly.
Chat-only delegation and unsent notes are non-authoritative.

END
