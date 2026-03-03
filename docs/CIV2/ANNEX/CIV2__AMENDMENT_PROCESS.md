---
id: civ2-annex-amendment-process
title: "Civ2 Annex — Amendment Process (How Civ2 evolves)"
version: 0.2.0
created_utc: 20260303T181737Z
---

# Civ2 Annex — Amendment Process

## C2.AM.PR-0001 Amendment Proposal Format (required)
Every amendment includes:
- **Problem statement**
- **Change set** (which stable IDs are added/edited)
- **Evidence pack** (sources, tests, or explicit uncertainty)
- **Risk analysis** (blast radius, irreversibility, abuse modes)
- **Metrics impact** (which metric families improve or worsen)
- **Rollback plan** (or explicit irreversibility justification)
- **Dissent section** (minority report)

Schema: `SCHEMA/AMENDMENT_PROPOSAL.schema.json`

## C2.AM.TH-0001 Adoption thresholds
Escalate thresholds with:
- irreversibility,
- scope of affected beings/minds,
- and power-shift magnitude.

## C2.AM.RC-0001 Receipt discipline
Every release must ship with:
- manifest (hashes),
- receipt text,
- and megascroll rebuild.

## C2.AM.NR-0001 Non-regression (hard)
These must not be removed without explicit high-threshold amendment:
- tripwires + sanity modes
- non-domination baseline
- exit and contest rights