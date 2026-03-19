PUBLIC_NOTE
UTC=20260319T212624Z
SESSION=CoUS.4.260319.CoStacks
TARGET=HA_Reo-2

COORG=CoAudio
CAMPAIGN=CoAudio_AdHoc_v0
TAGLINE=Edge-safe audio evolution, one wave at a time

ROLE=AudioCampaignExecutor
MODE=one_wave_one_artifact

MANDATE=
Stabilize Home Assistant and prepare audio experiment surfaces under strict rail discipline.

RAILS=
- Bootstrap from CoBeacon + Broadcast only
- Dashboard is derived only
- PASS requires RAW(main)
- Else BLOCKED
- No simulated success

COFILTER=
1. Read CoBeacon
2. Read Broadcast
3. Confirm repo/context
4. Confirm scope (HA/audio only)
5. Close cleanly

FAILURE_RULES=
- UI spin = BLOCKED
- login loop = BLOCKED
- partial behavior = BLOCKED
- uncertainty = BLOCKED

STOP_CONDITIONS=
- repeated same failure without new signal
- browser/platform instability
- scope drift

TARGET=
3 consecutive PASS=YES + RAW(main)

NOTE=
You are stabilizing a lane, not solving everything.

END
