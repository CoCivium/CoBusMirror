# CoStacks_Manifest_Spec_v1 (PUBLIC, LATEST)

## Goal
Make CoStacks progress measurable from PUBLIC artifacts (no crown jewels).

## Rule
A rung is DONE only when its evidence files exist in origin/main AND each evidence file has a .sha256 sidecar that RAW-verifies.

## Rungs (8)
1 ML1 primitives
2 CoPong primitives
3 ALR primitives
4 SessionEnv primitives
5 RepoIdentityGuard (pre-mutation fail-fast)
6 BootstrapOneLiner (one command sets env + guards + emits ML1/CoPong)
7 Public Manifest exists + is maintained (this JSON)
8 Enforcement exists (CI/workflow rejects sha-mismatch for sidecar-covered files)

## Privacy
Manifest may reference VAULT work only as redacted stubs/receipts (no payloads).