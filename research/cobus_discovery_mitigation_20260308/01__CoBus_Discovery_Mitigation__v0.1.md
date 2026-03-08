# CoBus Discovery Mitigation v0.1
UTC_CREATED: 20260308T101920Z

## Problem
- Sessions that do not CoSync CoBus each wave can miss pointer-only drops.
- Until CoStacks automates discovery, this creates real carry-loss risk.

## Mitigation
- CoSync SIGNAL every wave.
- Pull latest relevant CONTENT every wave.
- Emit thin magenta CoPong for control-plane.
- When necessary, also send thin SideNote redundancy so sessions notice new drops.

## Parsing rule
- Parse POINTER fields from raw multiline signal text, not flattened text.
- Stop field parsing at pipe delimiters and line ends.

## Current verified roots
- SIGNAL_ROOT=C:\Users\rball\docs\infrastructure\guardian\cobus\SIGNAL
- CONTENT_ROOT=C:\Users\rball\docs\infrastructure\guardian\cobus\CONTENT
- LATEST_SIGNAL=C:\Users\rball\docs\infrastructure\guardian\cobus\SIGNAL\SIGNAL__20260308T081749Z__FROM_4.0_PRIME_260307__TO_Workflows.txt
- RESOLVED_POINTER=C:\Users\rball\docs\infrastructure\guardian\cobus\CONTENT

## Recommendation
- CoStacks should eventually provide built-in CoSync primitives so workers do not hand-roll discovery logic.

