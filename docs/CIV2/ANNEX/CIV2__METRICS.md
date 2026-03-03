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