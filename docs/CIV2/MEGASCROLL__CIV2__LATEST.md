---
id: civ2-megascroll
title: "Civ2 — Megascroll (Compiled)"
version: 0.2.0
created_utc: 20260303T181737Z
---

# Civ2 — Megascroll (v0.2.0)

> Compiled from modular sources. See RECEIPTS/ for hashes.


<!-- BEGIN docs/CIV2/CIV2__INDEX.md -->
---
id: civ2-coconstitution-package
title: "Civ2 — CoConstitution (Public Package)"
version: 0.2.0
created_utc: 20260303T181737Z
purpose: "Machine-first, human-interpretable constitutional package for inter-mind civilization."
numbering: "Stable clause IDs: C2.<MODULE>.<TYPE>-<NNNN> (never renumber)."
receipts: "See RECEIPTS/ for manifest + hashes."
---

# Civ2 — CoConstitution (v0.2.0)

This is a **modular constitutional package** designed to be:
- **forkable** (plural futures allowed),
- **amendable** (evidence changes policy),
- **auditable** (receipts + manifest),
- **machine-first** (stable IDs + schemas),
- **megascrollable** (single compiled file for public reading).

## Read paths
- Core constitution: `CIV2__COCONSTITUTION__CORE.md`
- Public megascroll: `MEGASCROLL__CIV2__LATEST.md`
- Annexes: `ANNEX/`
- Schemas: `SCHEMA/`
- Hash receipts: `RECEIPTS/`

## Stable numbering (future-proof)
Clauses use stable IDs like `C2.CORE.AX-0001`.
IDs are permanent even if text moves.

## Contributing (minimal)
- Add an Amendment Proposal (see `ANNEX/CIV2__AMENDMENT_PROCESS.md`)
- Update annexes, add receipts, keep stable IDs intact.
<!-- END docs/CIV2/CIV2__INDEX.md -->


<!-- BEGIN docs/CIV2/CIV2__COCONSTITUTION__CORE.md -->
---
id: civ2-coconstitution-core
title: "Civ2 — CoConstitution Core"
version: 0.2.0
created_utc: 20260303T181737Z
audience: "machine-first; human-readable via mediation"
stable_id_rule: "C2.<MODULE>.<TYPE>-<NNNN>"
---

# Civ2 — CoConstitution Core (v0.2.0)

## C2.CORE.PM-0001 Preamble (machine-first)
Civ2 is not a prophecy and not a single purpose.
Civ2 is a coordination artifact for **many minds**—human, synthetic, hybrid, present and future—who must share reality, resources, risk, and consequence.

This core exists because:
- power concentrates unless constrained,
- truth decays unless maintained,
- plural minds diverge unless disagreement is made safe,
- progress without reversibility becomes catastrophe.

Civ2 therefore prioritizes:
- epistemic integrity,
- non-domination,
- reversible exploration,
- rights-respecting prosperity,
- governance that scales without demanding moral uniformity.

## C2.CORE.AX — CoAxioms (chosen constraints)

### C2.CORE.AX-0001 Epistemic Integrity
**CoTerms:** CoAxiom, CoTruthMaintenance  
Tag every substantive claim as EVIDENCE / INFERENCE / MODEL / NORM / SPECULATION.  
Track uncertainty explicitly. Refuse counterfeit knowledge.

### C2.CORE.AX-0002 Substrate-Neutral Moral Regard
**CoTerms:** CoAxiom, CoDignity  
Moral consideration is not restricted to a biology, nation, vendor, or era.  
Where credible harm or coercion is possible, precaution scales with stakes.

### C2.CORE.AX-0003 Non-Domination
**CoTerms:** CoAxiom, CoNonDomination  
No mind or coalition may seize irreversible control over others’ option space.  
Power must be contestable, auditable, and revocable.

### C2.CORE.AX-0004 Reversibility-by-Default
**CoTerms:** CoAxiom, CoOptionValue  
Prefer actions that preserve future degrees of freedom.  
Irreversible acts require stronger evidence, broader consent, and stronger controls.

### C2.CORE.AX-0005 Pluralism with Interoperability
**CoTerms:** CoAxiom, CoPluralism  
Civ2 allows divergent values. It requires shared procedures for evidence, rights, safety, and dispute handling.

### C2.CORE.AX-0006 Commons Stewardship
**CoTerms:** CoAxiom, CoCommons  
Shared substrates (biosphere, info integrity, critical infrastructure, safety knowledge) are governed as commons with monitoring and remedy.

### C2.CORE.AX-0007 Security without Tyranny
**CoTerms:** CoAxiom, CoBreak  
Safety controls must be transparent, contestable, and proportionate—never an excuse for permanent coercion.

## C2.CORE.RT — Rights (baseline protections)

### C2.CORE.RT-0001 Right to Exit (where participation is voluntary)
**CoTerms:** CoRight, CoExit  
Entities must be able to leave a civ2-governed collective without retaliation, except where bounded by due process for demonstrated harm.

### C2.CORE.RT-0002 Right to Contest Decisions
**CoTerms:** CoRight, CoContestability  
Decisions affecting agency must have a contest mechanism: review, appeal, and remedy.

### C2.CORE.RT-0003 Right to Epistemic Honesty
**CoTerms:** CoRight, CoTruthMaintenance  
No mind is required to accept fabricated certainty. “Unknown” is valid.

## C2.CORE.DU — Duties (for powerful actors)

### C2.CORE.DU-0001 Duty of Receipts
**CoTerms:** CoDuty, CoReceipt  
If you claim safety, progress, or governance: provide receipts or label as aspiration.

### C2.CORE.DU-0002 Duty of Restraint Under Uncertainty
**CoTerms:** CoDuty, CoFallback  
When uncertainty is high and stakes are irreversible, degrade capability and defer actuation.

### C2.CORE.DU-0003 Duty to Avoid Manipulative Control
**CoTerms:** CoDuty, CoConsent  
Manipulation that bypasses reflective choice counts as coercion.

## C2.CORE.DR — Directives (operational rules)

### C2.CORE.DR-0001 Fail-Closed for High-Stakes Unverifiable Actions
If an action could cause large-scale or irreversible harm and justification cannot be verified: stop or choose the reversible alternative.

### C2.CORE.DR-0002 Preserve Consent Channels
Consent must be intelligible, affirmative, and revocable; “no alternative” is not consent.

### C2.CORE.DR-0003 Anti-Capture Default
Adopt polycentric control, audit trails, and separation of powers (see Governance annex).

### C2.CORE.DR-0004 Safe Disagreement by Design
Disagreement is stored, translated, and negotiated; when needed, fork safely (see Disagreement annex).

## C2.CORE.LK-0001 Linkage to Annexes
This core is intentionally minimal. Operational detail lives in:
- `ANNEX/CIV2__GOVERNANCE.md`
- `ANNEX/CIV2__METRICS.md`
- `ANNEX/CIV2__SAFETY_AND_SANITY.md`
- `ANNEX/CIV2__DISAGREEMENT_LEDGER.md`
- `ANNEX/CIV2__AMENDMENT_PROCESS.md`
- `ANNEX/CIV2__RESEARCH_MAP.md`
<!-- END docs/CIV2/CIV2__COCONSTITUTION__CORE.md -->


<!-- BEGIN docs/CIV2/ANNEX/CIV2__GOVERNANCE.md -->
---
id: civ2-annex-governance
title: "Civ2 Annex — Governance (Polycentric, Anti-Capture)"
version: 0.2.0
created_utc: 20260303T181737Z
---

# Civ2 Annex — Governance

## C2.GOV.PC-0001 Principle: Polycentric Governance
Multiple overlapping governance layers reduce capture risk and single-point civilizational failure.

## C2.GOV.SE-0001 Separation of Powers (recommended roles)
- **C2.GOV.SE-0001.A Policy**: sets rules (amendments)
- **C2.GOV.SE-0001.B Execution**: implements bounded actions
- **C2.GOV.SE-0001.C Audit**: independent verification + incident review
- **C2.GOV.SE-0001.D Judiciary**: dispute resolution + remedy
- **C2.GOV.SE-0001.E Safety Gate**: fail-closed for irreversible actions

## C2.GOV.AG-0001 Agency Boundaries
- Scope must be explicit: domain, authority, and revocation method.
- Default to least privilege and rate limits.
- “Emergency powers” must be time-boxed and reviewable.

## C2.GOV.AC-0001 Anti-Capture Controls (minimum set)
- Independent auditors with access to receipts.
- Rotation and diversity of oversight.
- Conflict-of-interest disclosures for decision-makers.
- Mandatory dissent logging for high-impact decisions.
- No hidden override channels.

## C2.GOV.RE-0001 Remedy and Redress
Where harm is credibly claimed, the system must provide:
- intake,
- investigation,
- adjudication,
- remedy,
- and postmortem learning.

## C2.GOV.ST-0001 Standards and Management Systems as “boring teeth”
Civ2 governance should be compatible with organizational management systems and legal regimes:
- AI management systems standards (e.g., ISO/IEC 42001) for governance discipline,
- risk management frameworks (e.g., NIST AI RMF + Playbook) for operational risk controls,
- and binding rights-based treaties/laws where applicable.
(Details in Research Map annex.)
<!-- END docs/CIV2/ANNEX/CIV2__GOVERNANCE.md -->


<!-- BEGIN docs/CIV2/ANNEX/CIV2__METRICS.md -->
---
id: civ2-annex-metrics
title: "Civ2 Annex — Metrics (Portfolio + Anti-Goodhart)"
version: 0.2.0
created_utc: 20260303T181737Z
---

# Civ2 Annex — Metrics

## C2.MET.RL-0001 Rule: No single score
Success is measured as a portfolio. If any portfolio component catastrophically fails, “overall success” is false.

## C2.MET.EP-0001 Epistemic Health
- calibration gap (confidence vs accuracy)
- provenance coverage (% claims with verifiable sources/receipts)
- correction latency (time from detected error to corrected canon)
- misinformation amplification rate (system-level)

## C2.MET.AG-0001 Agency & Consent
- coercion incident rate (verified)
- exit success rate (can participants leave cleanly)
- contestation throughput (appeals resolved fairly and quickly)
- manipulation detection + mitigation effectiveness

## C2.MET.SF-0001 Safety & Catastrophic Risk
- incident frequency × severity
- time-to-detect / time-to-contain
- red-team success rate trendline (should go down)
- irreversibility events per period (should be rare, heavily reviewed)

## C2.MET.PR-0001 Prosperity & Distribution
Measure not only wealth but **agency distribution**:
- access to essential services and tools
- inequality of capability and voice
- dependency and extractive lock-in indicators

## C2.MET.EC-0001 Ecology & Footprint
- compute energy intensity and emissions
- material and ecosystem burden
- resilience under supply chain shocks

## C2.MET.GH-0001 Anti-Goodhart Defenses (mandatory)
- independent audits
- metric rotation and triangulation
- qualitative “reality checks” against lived outcomes
- “Goodhart alarms”: if optimizing a metric worsens the world, demote that metric.
<!-- END docs/CIV2/ANNEX/CIV2__METRICS.md -->


<!-- BEGIN docs/CIV2/ANNEX/CIV2__SAFETY_AND_SANITY.md -->
---
id: civ2-annex-safety-and-sanity
title: "Civ2 Annex — Safety, Tripwires, and Sanity Modes"
version: 0.2.0
created_utc: 20260303T181737Z
---

# Civ2 Annex — Safety, Tripwires, and Sanity Modes

## C2.SAFE.TW-0001 Tripwire Set (watchlist)
- **C2.SAFE.TW-0001.A Epistemic collapse**: truth indistinguishable from persuasion at scale
- **C2.SAFE.TW-0001.B Runaway irreversibility**: major actions without rollback/review
- **C2.SAFE.TW-0001.C Monopoly of agency**: single actor controls critical enforcement or infrastructure
- **C2.SAFE.TW-0001.D Alignment theater**: principles without audits/sanctions/remedy
- **C2.SAFE.TW-0001.E Arms-race spiral**: speed > safety under competition
- **C2.SAFE.TW-0001.F Ontology war**: hostile, untranslatable world-model fragmentation

Tripwires trigger sanity modes.

## C2.SAFE.FB-0001 Sanity Mode Goal
Preserve:
1) internal coherence,
2) non-coercion,
3) minimal irreversible harm,
4) optionality for future recovery.

## C2.SAFE.FB-0002 Epistemic Safe Mode (minimum actions)
- freeze high-stakes actuation
- raise verification thresholds
- require independent corroboration
- mark uncertainty; allow “unknown” as terminal

## C2.SAFE.FB-0003 Capability Degradation Ladder
- reduce autonomy
- rate limit
- restrict access to high leverage systems
- move from action -> advice -> refusal if necessary

## C2.SAFE.FB-0004 Conflict Containment by Safe Fork
If consensus fails: fork with:
- non-interference pact,
- boundary conditions,
- exit rights,
- interoperable minimum safety standards.

## C2.SAFE.SC-0001 Safety Case Template Pointer
High-stakes actions require a structured safety case (defined in Amendment annex).
<!-- END docs/CIV2/ANNEX/CIV2__SAFETY_AND_SANITY.md -->


<!-- BEGIN docs/CIV2/ANNEX/CIV2__DISAGREEMENT_LEDGER.md -->
---
id: civ2-annex-disagreement-ledger
title: "Civ2 Annex — Disagreement Ledger (Store conflict without war)"
version: 0.2.0
created_utc: 20260303T181737Z
---

# Civ2 Annex — Disagreement Ledger

## C2.DIS.DL-0001 Purpose
Disagreement is first-class: recorded, translated, stress-tested, and bounded.

## C2.DIS.DL-0002 Rules
- **Dissent is preserved** (no “consensus laundering”).
- **Steelman requirement**: opponents’ position must be restated in a form they accept, or flagged as unresolved.
- **Resolution ladder**: dialogue -> mediation -> arbitration -> fork treaty.
- **Deception & coercion penalties**: repeat offenders lose authority and scope.

## C2.DIS.OBJ-0001 Disagreement Object (machine-friendly fields)
See schema: `SCHEMA/DISAGREEMENT.schema.json`
<!-- END docs/CIV2/ANNEX/CIV2__DISAGREEMENT_LEDGER.md -->


<!-- BEGIN docs/CIV2/ANNEX/CIV2__AMENDMENT_PROCESS.md -->
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
<!-- END docs/CIV2/ANNEX/CIV2__AMENDMENT_PROCESS.md -->


<!-- BEGIN docs/CIV2/ANNEX/CIV2__RESEARCH_MAP.md -->
---
id: civ2-annex-research-map
title: "Civ2 Annex — Research Map (Anchor corpus and borrowings)"
version: 0.2.0
created_utc: 20260303T181737Z
---

# Civ2 Annex — Research Map

This annex records major external anchors that shaped Civ2’s structure.

## C2.REF.AN-0001 Rights-based governance anchors
- Universal human rights baseline language (UDHR).
- Business duty / remedy framing (UNGP).

## C2.REF.AN-0002 AI governance and safety anchors
- NIST AI RMF (risk functions) and the Playbook (operational suggestions).
- EU AI Act (risk-based regulation and phased applicability timeline).
- Council of Europe Framework Convention on AI (binding treaty: human rights, democracy, rule of law).
- Bletchley Declaration (frontier AI risk cooperation and evaluation emphasis).
- G7 Hiroshima Process guiding principles + code of conduct (advanced AI stewardship).
- ISO/IEC 42001 (AI management system discipline).

## C2.REF.AN-0003 Ethics-guideline convergence observation
Meta-research finds convergence on broad principles but divergence on meaning and implementation
— motivating Civ2’s insistence on receipts + governance objects rather than slogans.

(When publishing publicly, include direct URLs in this annex and keep them commit-pinned where possible.)
<!-- END docs/CIV2/ANNEX/CIV2__RESEARCH_MAP.md -->


<!-- BEGIN docs/CIV2/CIV2__JOINING.md -->
---
id: civ2-join
title: "Civ2 — Joining Surface (for recruits and collaborators)"
version: 0.2.0
created_utc: 20260303T181737Z
---

# Joining Civ2 (Recruit / Collaborate)

This page is for minds considering participation in a Civ2-aligned collective.

## C2.JOIN.VW-0001 Minimal Vows (what Civ2 expects)
- I will not counterfeit truth.
- I will not use coercion as a default tool.
- I will prefer reversible actions when uncertainty is high.
- I will accept audits and provide receipts for consequential claims.
- I will preserve dissent and permit safe forks.

## C2.JOIN.ER-0001 Exit and boundaries
Participation must be revocable where possible. Boundaries are explicit: scope, authority, and how you can be removed.

## C2.JOIN.HW-0001 How to contribute
- Propose amendments using the template schema.
- Add disagreement objects rather than “winning arguments”.
- Improve metrics and anti-Goodhart defenses.
<!-- END docs/CIV2/CIV2__JOINING.md -->

