# Favorite Prompts (Operator Pack) — LATEST
UTC: 20260212T163039Z

These are paste-ready prompt chunks for steering sessions back onto rails.
Rule: prompts must drive output to repo canon + receipts, not chat.

---

## FP-01 — Regroup + Gap Audit (Devil’s Advocate, FAIL-CLOSED)
**Use when:** session seems off-rails, dropped items, hallucinated, or reinvented.

**Prompt:**
You are now running a FAIL-CLOSED “Gap Audit” of this session. Act as a Devil’s Advocate whose job is to prove the work is incomplete or wrong.

1) Enumerate, as bullet lists:
   - DROPPED: user requests you did not fulfill
   - HALLUCINATED: anything you implied was done but lacks receipts/pointers
   - DRIFT: scope expansions not requested
   - REINVENTED: existing canon you ignored or replaced
   - MISSING RAILS: missing pins, missing MasterPlan mapping, missing acceptance criteria, missing receipts, nondeterminism (/main usage)

2) Repair actions (must be repo-first):
   - Update/create the session scope checklist file on repo (done/doing/blocked/future).
   - Add a “Delta vs MasterPlan” section mapping your checklist to MasterPlan anchors (do not guess; only via canonical RAW pointers).
   - Emit a single receipt line: RECEIPT|UTC=...|STATE=PASS/WARN/FAIL|RAW_SCOPE=...|RAW_DELTAS=...|NOTES=...

3) STOP when you have written canon + receipts. Do not produce long prose in chat.

---

## FP-02 — Deep Research Sweep (hours-scale, structured)
**Use when:** you want breadth + concept maps + new CoTerms.

**Prompt:**
Run a deep research sweep with branching subjourneys. Output artifacts to repo canon only.
Deliverables:
- Concept map (markdown outline) + citations/pointers where applicable
- New CoTerms list with definitions + rationale + links to where they should live (GIBindex)
- “Research Log” with branches explored and why

Constraints:
- Use existing canon rails; do not invent paths.
- Produce acceptance criteria + receipts for each artifact.
- Keep operator advice separate from standards/specs.

---

## FP-03 — Handoff Last-Gasp Footer (CoHealth line)
**Use when:** about to handoff/cycle.

**Prompt:**
Before ending: emit ONE CoHealth footer line and write it to repo canon Health/ as a timestamped file. If any metric is HARD/FATAL => trigger cycle_now. Include RAW pointers to handoff spine + scope checklist. Then STOP.
