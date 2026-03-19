# CoPlay Terminology v0

## Purpose
Introduce a human-friendly vocabulary layer without breaking deterministic CoBus execution.

## Core Rule
All work must use dual tags:

TYPE=<canonical>
VIBE=<coplay>

## Canonical Types (fixed set)
- execution_unit
- analysis
- plan
- path
- insight
- option
- state_update
- handoff

## CoPlay Vibes

### Core
- CoDo
- CoThink
- CoPlan
- CoPath
- CoTip
- CoGrok

### Social / Influence
- CoRiz
- CoFlex
- CoCo

### Event / Energy (NOT tasks)
- CoShindig
- CoRave
- CoHooley
- CoBash
- CoFrolic
- CoLark
- CoSkylark
- CoJink

## Critical Constraint
Event terms MUST NOT be used as TYPE or execution units.

Correct:
TYPE=execution_unit
VIBE=CoDo
MODE=CoFrolic

Incorrect:
TYPE=CoFrolic

## Modes
- CoPlay
- CoPlay:Focused
- CoPlay:Exploratory
- CoPlay:Celebratory
- CoWorkLegacy

## Truth Rule
TYPE governs execution. VIBE is descriptive only.