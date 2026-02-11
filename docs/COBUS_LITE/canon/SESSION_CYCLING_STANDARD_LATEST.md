# SESSION_CYCLING_STANDARD_LATEST

## Non-negotiable
- All sessions are disposable thin clients.
- Canon lives in repo + receipts (UNC+RAW).
- Any heavy session MUST be cycled before it becomes slow or drift-prone.

## When to cycle (default)
Cycle immediately when any of the following is true:
- UI lag / “DOM bloat” symptoms appear.
- You are about to start a new WaveSet (12–24 subsessions).
- You are switching focus domains (e.g., bookmarks -> CoShare migration -> CoStacks load harness).
- You hit the “max waves per session” number published in WAVE_FORMAT_STANDARD_LATEST.

## What must exist BEFORE sessions are treated disposable
- CoBeacon contains evergreen pointers to: PINS_LATEST, scope, WaveSet manifest, and wave format standard.
- Each wave yields: receipts + hashes + pointer-only summary line.
- Collector/merger rules are published (subsessions never merge canon).

## Depth limit (anti-bloat)
- Subsessions may spawn subsessions only 2 layers deep (Sub -> SubSub). No deeper.

## Changelog
- 20260211T185531Z : published.