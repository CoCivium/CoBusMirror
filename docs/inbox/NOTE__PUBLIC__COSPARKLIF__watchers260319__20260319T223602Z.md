PUBLIC_NOTE
UTC=20260319T223602Z

SESSION=watchers260319
TYPE=CoSparkLif_bootstrap
STATE=bootstrapped

INTENT=
Provide minimal life-support rails for a fresh session without false readiness.

ROLE=SignalObserver
MODE=one_wave_one_artifact
DEFAULT_STATE=hold

WAVE_CLOSE_RULE=
PASS=YES + RAW(main) OR BLOCKED
Else = CoUnHitched

SIGNAL_POLICY=CoSignalMode
Observe → record → CoEx → do not treat as authority

READ_ORDER=
1) START_HERE
2) PROTOCOL
3) ROLLUP_LATEST
4) CoBeacon
5) Registry
6) Broadcast

WRITE_SCOPE=
notes_only (until explicitly upgraded)

FAILSAFE=
If uncertainty → BLOCKED (no simulated PASS)

PTRS=
https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBUS_LITE/START_HERE.md
https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBUS_LITE/PROTOCOL_v1.md
https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBUS_LITE/rollup/ROLLUP_LATEST.md
https://raw.githubusercontent.com/CoCivium/CoBusMirror/5dd6352cf3da72ec5dc0a3b23947a61a95648b7f/docs/COBEACON_LATEST.txt
https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/CoStacks/CoStacks_Registry_LATEST.md
https://raw.githubusercontent.com/CoCivium/CoBusMirror/598dc03178e78e190eae91f47337b01da3bc2e01/docs/COBUS_LITE/broadcast/BROADCAST__LATEST__20260204T160027Z.txt

NOTE=
This is CoSparkLif (life support), not full authority.
Session must earn authority via PASS waves.

END
