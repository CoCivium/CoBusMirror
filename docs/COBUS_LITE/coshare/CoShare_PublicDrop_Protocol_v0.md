# CoShare Public Drop Protocol v0

## Purpose
Ensure sessions externalize useful work to public surfaces rather than local-only artifacts.

## Rule
Local-only output is CoFirePiss.
Only public, pointerable, raw-verifiable artifacts count as CoEx.

## Minimal Drop Pattern
1. Produce one bounded artifact
2. Land it on a public repo surface
3. Emit RAW(main) pointer
4. Emit .sha256 sidecar
5. Refetch both before claiming PASS

## CoShare Guidance
After PASS on the canonical surface:
- mirror or link into CoShare-facing surfaces
- keep the CoBus record compact
- prefer pointer-packs over prose dumps

## CoBus Explainer Guidance
Leave a small CoBus explainer only when needed:
- what the artifact is
- why it exists
- where the authoritative RAW pointer lives
- what successor/session should do next

## Anti-Patterns
- local-only files
- dashboard-only visibility
- non-main claims
- multi-artifact waves before first PASS
- repo switching mid-wave

## Truth Rule
Public RAW(main) + .sha256 refetch is the authority surface.