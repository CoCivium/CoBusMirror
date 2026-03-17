# PROTOCOL_EVIDENCE_PACK__4.0_PRIME_260307__LATEST

UTC_UPDATED: 20260307T055437Z
SESSION_LABEL: 4.0|PRIME|260307

## RECEIPT_LIKE
### FILE: tools\coguardian\CoGuardian_QueueToCoBus.ps1
L56: $eventHash = Get-MapValue -Map $m -Key "EVENT_HASH" -Default ([IO.Path]::GetFileNameWithoutExtension($f.Name))
L79: "- SOURCE_QUEUE_FILE=$($f.FullName)",
L80: "- EVENT_HASH=$eventHash",
L98: "SOURCE_QUEUE_FILE=" + $f.FullName,

### FILE: tools\coguardian\CoGuardian_TargetQueueToOutbox.ps1
L59: "SOURCE_TARGET_QUEUE: $($f.FullName)",

### FILE: tools\coguardian\CoGuardian_TrayHost.ps1
L36: if (Test-Path $ptr) { $sha = (Get-FileHash -Algorithm SHA256 -Path $ptr).Hash.ToLowerInvariant() }
L75: "- Receipts, pointers, and canon-aware artifacts reduce drift."

### FILE: tools\coguardian\CoGuardian_Watcher.ps1
L15: $sha = [System.Security.Cryptography.SHA256]::Create()
L81: $payload += "EVENT_HASH: $eventHash"

### FILE: tools\coguardian\README__CoGuardianWatcher__v0.1.md
L27: VIOLET_EVENT | KIND=DONE | FROM=4.0|PRIME|260307 | TO=Workflows | UTC=20260307T000000Z | STATE=doing | PTR=C:\path\to\artifact | SHA=<sha256> ⊂ CoEvo advancing

### FILE: tools\coguardian\RECEIPT__COGUARDIAN_HELP_MODEL_FIX__v0.1.txt
L5: TRAY_SHA256=c1187245b393f04f350adb550b44f3a967ae43abec8c8d42f415da53d55810d8
L7: PROTECTIONS_SHA256=2623ab1dd42717c30130f0f316958640f3adfc7b49dcc74d7aabb68abde43419
L9: README_SHA256=35c6c0c26dc1cd1984b5d84910f9bb7e7e845bb3d99db82947234fedfdf301b1
L10: ENTRY_REPO_REL=docs\COBUS_LITE\entries\2026\03\07\20260307T020820Z__4.0_PRIME_260307__CoGuardianHelpModelFix.md
L12: ENTRY_SHA256=676c7ab7ebef87fff28a53f4ddf8ed37d3fb7651d9d29e0bf2406b5a8e8ca2e4

### FILE: tools\coguardian\RECEIPT__COGUARDIAN_QUEUE_TO_COBUS__v0.1.txt
L6: BRIDGE_SHA256=114d1bdaa3bf3a459a027318454d79259867035f6fa108a59d8372987be4f5b1
L9: LAUNCHER_SHA256=0e5b66bb4c60f17739a4f0f2d49b5aa0db30ef7aaf97fef3fac56dd6bf35683a
L12: README_SHA256=6da544df9e26e305cbfa2f7aceef184ab2b902dadef6aca24159650b396bc9d8
L13: ENTRY_REPO_REL=docs\COBUS_LITE\entries\2026\03\07\20260307T012018Z__4.0_PRIME_260307__QueueToCoBusBridge.md
L15: ENTRY_SHA256=2c6c37ac123bc7dab140cb1d791367f1cbd920d0ed5c8bd026f366b37ed35c48

### FILE: tools\coguardian\RECEIPT__COGUARDIAN_TARGET_ROUTER__v0.1.txt
L6: ROUTER_SHA256=a7f059558e2a6087422271229344a8bef96c07392d7c01c9f6abaa5561d3a050
L9: LAUNCHER_SHA256=2df3c9fef0344f115df278c8187614806e4b4fb08417b4d43f7a91626bfcaf55
L12: README_SHA256=52b6dcf5b31c444b72675e095e11827939cc8789adf431a931604012b696f307
L13: ENTRY_REPO_REL=docs\COBUS_LITE\entries\2026\03\07\20260307T024945Z__4.0_PRIME_260307__TargetRouter.md
L15: ENTRY_SHA256=90eaa8d2afdb11b8848e6d6902d54e234fc1d89a9286c0242ff8c8498443c29f

### FILE: tools\coguardian\RECEIPT__COGUARDIAN_TRAY_HOST__v0.1.txt
L6: TRAY_SHA256=82ff053d8250f2ee0e5b1219054bd1c2e201710c5da50bb330660649789fda21
L9: README_SHA256=5d1aadcd99431008c61f72f1c5b59ae3329bbc2034c2feb2271fee503649be0b
L10: ENTRY_REPO_REL=docs\COBUS_LITE\entries\2026\03\07\20260307T012557Z__4.0_PRIME_260307__CoGuardianTrayHost.md
L12: ENTRY_SHA256=779a6627100e0040a960d23ce5ac7fd7ac1ec476a536e2a22361d0ac88f45c8b

### FILE: tools\coguardian\RECEIPT__COGUARDIAN_TRAY_SUPERVISOR__v0.1.txt
L6: SUPERVISOR_SHA256=1724145f06651f6d0a6facb608766f5d038cedd5647d7de8d2fe824761a128df
L9: LAUNCHER_SHA256=ddd7d896ffb2c93f1bb9930c4278c05a51199e3fbc66cd461621277df95c092c
L12: README_SHA256=2b23522ed30e63a67620fe8e526bca1d41010d2a90d237ac8f1b7eb4dffaece8
L13: ENTRY_REPO_REL=docs\COBUS_LITE\entries\2026\03\07\20260307T013707Z__4.0_PRIME_260307__CoGuardianTraySupervisor.md
L15: ENTRY_SHA256=69d50072d3a1ec20169b14de255beb17b1d898652f1e5487c0047ba26dbb9a92

### FILE: tools\coguardian\RECEIPT__COGUARDIAN_TRAY_UPGRADE__v0.1.txt
L5: TRAY_SHA256=6a50bf200622e46db0c577e2c7ae4a80bc30ea0c023a7f193dfe0b01ed3db415
L7: README_SHA256=f06d83c28fba46e3cb25a6b115f898db1a2173c6920062a10e7a4f0d6cd26f35
L8: ENTRY_REPO_REL=docs\COBUS_LITE\entries\2026\03\07\20260307T013035Z__4.0_PRIME_260307__CoGuardianTrayUpgrade.md
L10: ENTRY_SHA256=ee892bbfd02b462ee7329c491637b27e3a5832e2eade83dd8b4f98df5c84c089

### FILE: tools\coguardian\RECEIPT__COGUARDIAN_TRUST_SHELL__v0.1.txt
L5: TRAY_SHA256=dcf6b8982e1baecabcbb8bd7dbc1663974a478b43117cfd453c1ee0af5f78fbf
L7: README_SHA256=8dcf706425ecace2c07224ed594f9e048a04090d44a9071002a98a9e1ac26a43
L8: ENTRY_REPO_REL=docs\COBUS_LITE\entries\2026\03\07\20260307T015123Z__4.0_PRIME_260307__CoGuardianTrustShell.md
L10: ENTRY_SHA256=416e91aa078f1b372436df5daa9ba770d9d667985b67ef2bad725fad9caba67d

## SESSION_IDENTITY
### FILE: tools\coguardian\CoGuardian_CoBusToTargetQueue.ps1
L77: "FROM: $from",

### FILE: tools\coguardian\CoGuardian_QueueToCoBus.ps1
L73: "FROM: $from",

### FILE: tools\coguardian\CoGuardian_TargetQueueToOutbox.ps1
L52: "FROM: $from",

### FILE: tools\coguardian\CoGuardian_TrayHost.ps1
L37: $line = "VIOLET_EVENT | KIND=DONE | FROM=4.0|PRIME|260307 | TO=Workflows | UTC=$u | STATE=doing | TOPIC=TrayHelpModelTest | PTR=$ptr | SHA=$sha ⊂ CoEvo advancing"

### FILE: tools\coguardian\README__CoGuardianWatcher__v0.1.md
L27: VIOLET_EVENT | KIND=DONE | FROM=4.0|PRIME|260307 | TO=Workflows | UTC=20260307T000000Z | STATE=doing | PTR=C:\path\to\artifact | SHA=<sha256> ⊂ CoEvo advancing

### FILE: tools\coguardian\RECEIPT__COGUARDIAN_HELP_MODEL_FIX__v0.1.txt
L2: SESSION=4.0|PRIME|260307

### FILE: tools\coguardian\RECEIPT__COGUARDIAN_QUEUE_TO_COBUS__v0.1.txt
L2: SESSION=4.0|PRIME|260307

### FILE: tools\coguardian\RECEIPT__COGUARDIAN_TARGET_ROUTER__v0.1.txt
L2: SESSION=4.0|PRIME|260307

### FILE: tools\coguardian\RECEIPT__COGUARDIAN_TRAY_HOST__v0.1.txt
L2: SESSION=4.0|PRIME|260307

### FILE: tools\coguardian\RECEIPT__COGUARDIAN_TRAY_SUPERVISOR__v0.1.txt
L2: SESSION=4.0|PRIME|260307

### FILE: tools\coguardian\RECEIPT__COGUARDIAN_TRAY_UPGRADE__v0.1.txt
L2: SESSION=4.0|PRIME|260307

### FILE: tools\coguardian\RECEIPT__COGUARDIAN_TRUST_SHELL__v0.1.txt
L2: SESSION=4.0|PRIME|260307

## RETURN_PATH
### FILE: docs\COBUS_LITE\canon\SUBSESSION_PROTOCOL_LATEST.md
L7: If missing/unreadable, reply with EXACTLY ONE line:

### FILE: docs\COBUS_LITE\entries\2026\03\03\20260303T163012Z__EntMent.md
L12: - Once destination confirmed, deposit pack (+sha256 +manifest) and post follow-up entry w/ FULL-URL pointers

### FILE: docs\COBUS_LITE\rollcall\ROLLCALL__20260131T131646Z.md
L21: <# # SideNote | FROM=CoSources_2 | TO=4.0|PRIME|260129 | UTC=20260131T__AUTO__Z | STATE=doing | INTENT=CoRollcall reply (structured). DONE=Diagnosed MB “ExploitBlocked/AE” events as false-positive-ish against signed Git binaries (git.exe + git-remote-https.exe) labeled Exploit.T1003CredentialAccess; verified Authenticode signatures valid (Johannes Schindelin cert); extracted AeDetections schema: exploitData nested under threats[0].mainTrace (linkedTracesCount=0) with cleanAction=block/cleanResult=successful; confirmed Task Scheduler is effectively unavailable (schtasks /Create => Access denied; schtasks /Query for our tasks => not found), so scheduled-task guard approach is not viable on this host; implemented HKCU Run-key remediation guard (MB_WSC_GuardOnce) and installed HKCU Run-key GitIntegrityWatch baseline+alert (OE_GIT_INTEGRITYWATCH_ONLOGON + baseline.json + OE_ALERTS.log); temporarily allowlisted Git folder to stop productivity-killing blocks (user chose speed > purity). NEXT=Harden “OE_HYGIENE” into a CoStacks-governed preflight rail: single entrypoint + JSON receipt + fixed-width CoAlign segment + FAIL/WARN/PASS policy; add integrity watch for other “critical toolchain” binaries (pwsh/powershell/git/gh/ssh) and optional proxy/TLS-intercept sniff; propose a reversible path to narrow the allowlist from folder-wide -> specific signed binaries once stable. NEED=From CoPrime: (1) canonical spec for fixed-width CoAlign rail segment (chars budget + required fields + blame-tag taxonomy), (2) where to publish/store OE_HYGIENE receipts (repo+path policy) and whether CoPrime wants this as a dedicated CoStacks repo/module or within CoSources, (3) whether “Task Scheduler denied” should be a hard FAIL or WARN in CoStacks MVP. RISK=Git folder allowlist widens trust boundary (mitigated partially by integrity watch, but still a bigger blast radius); MB detection could be real if upstream compromise ever happens (watch catches binary change, not runtime abuse); lack of scheduled tasks means fewer enforcement options; recommend treat this host as “WARN: scheduler locked down” in CoAlign. COCARRY=none published yet (no pack+sha256); if you want, I recommend we mint PACK__OE_HYGIENE_v0__UTC.zip + .sha256 containing: (a) the two Run-key guard scripts, (b) baseline.json, (c) OE_ALERTS.log sample header, (d) AeDetections parsing snippets + one sanitized example; intended-dest=CoCarry/packs for CoStacks ingestion. END #>
L38: <# # SideNote | FROM=Focus | TO=4.0|PRIME|260129 | UTC=20260131T235900Z | STATE=doing | INTENT=CoRollcall reply (Focus parked; advisory-only) | DONE=Created public-safe transient inbox repo CoCivium/TEMP; established truthful retention contract (manual-only purge; “24h” is target not promise); parked 1 advisory nugget for CoStacks sprint (WIP cap 1-2 active streams; trunk/small-batch; LLM=planner/critic only; MVP stop-rule; request MasterPlan URL_RAW+anchors); added manual purge tool TOOLS/Purge_INBOX.ps1; published stable URL_RAW pointers + sha in INDEX. | NEXT=Remain parked unless you ask; use TEMP only for sanitized pointer-pack nuggets; optional later: rename TEMP->CoTemp for CoBrand consistency AFTER CoStacks MVP (avoid churn now). | NEED=1) Canonical MasterPlan URL_RAW pointer + insertion anchors published (CoBeacon says MasterPlan pointer was UNSET—Focus will not guess); 2) confirm whether you want TEMP kept as ongoing “public-safe scratchpad” or treat as temporary experiment; 3) if you ever want auto-purge via GH Actions, auth must include workflow-scope (currently blocks any .github/workflows path). | RISK=Public repo -> IP leakage if misused; manual purge can be forgotten; goalpost drift if MVP stop-rule not explicit; workflow-scope gate prevents automation until auth fixed. | COCARRY=POINTERPACK: TEMP_BASE=https://raw.githubusercontent.com/CoCivium/TEMP/main/README.md ; INDEX=https://raw.githubusercontent.com/CoCivium/TEMP/main/INBOX/INDEX.md ; NUGGET=https://raw.githubusercontent.com/CoCivium/TEMP/main/INBOX/20260128T020535Z__focus_advisory_nuggets_v0.1/README.md ; TOOL=https://raw.githubusercontent.com/CoCivium/TEMP/main/TOOLS/Purge_INBOX.ps1 ; SHA256_NUGGET_README=4d4f05341d397bade9b9e78d2e27e42af36e300ab9f2d047fc8887492e0cfa0e ; INTENDED_DEST=CoPrime triage -> copy any keeper into real repo/vault + reference from MasterPlan when ready. END #>
L42: <# # SideNote | FROM=GIBindex | TO=4.0|PRIME|260129 | UTC=20260131T235900Z | STATE=doing | INTENT=CoRollcall reply (structured): DONE=Bootstrapped via public CoBeacon (CoBusMirror) + followed rails (TypedSectionRails/PointerSpec/CoPong); drafted new CoTerm CoSourceID (md+yaml) + built CoCarry bundle w/ fixed 2-line MANIFEST + zip+sha receipts; surfaced rail mismatch risk: public CoBus_Index looked stale vs current PRIME labels; flagged MasterPlan URL_RAW as UNSET per pointer status; asked for canonical CoCarry pickup lane + GIBindex destination repo/path; NEXT=Upon your reply w/ (1) canonical pickup URL_RAW + (2) destination repo/path, publish/ingest CoSourceID into canon and emit commit-SHA RAW pointers; if you want CoSourceID “MasterPlan-front-and-center thesis”, cut CoSourceID v1 pack adding deterministic resolution algo + explicit -From/-To requirements for CoBus note tools + fail-closed ambiguity handling + optional transparency-log/signature hooks; NEED=Your authoritative pointers: CoCarry INDEX__LATEST URL_RAW (pickup lane), GIBindex terms registry destination repo/path, latest CoBus_Index republish cadence, MasterPlan URL_RAW pointer, latest rails/UI-UX asset pointers (PS7 banner conventions etc), and whether CoSourceID is to be threaded into MasterPlan/CoStacks MVP now; RISK=Without canonical pickup+dest, CoCarry bundle can’t be ingested; stale public index/pointer drift can fork canon; identity errors (label drift/PS var case-insensitivity/session bloat) remain high until CoSourceID adopted + enforced; COCARRY=PACK__CoSourceID__v0__20260129T200324Z|MD_SHA256=ab1fa02d9e41dba0b4793297c837a46272b4be77993e0f6f0e0a1d0ee6659f2a|YAML_SHA256=488717e864555c190a171cbabf05270180344335f38e260f31e139e46642243e|MANIFEST_SHA256=8de1e524b0cd98c4f843bef10901267b6b07fefb8f254d6344e8523d9e28afa3|ZIP_SHA256=092f8a3e0a7800e90fa7331a7a296f8da1d27a9ba79e49121a296d86007af293|ZIP_SHA256_FILE_SHA256=67b502a3c41c7f5539198e726e593fe745722836257b16dc0e83414b026e5a28|INTENDED_DEST=TBD_by_PRIME (await repo/path + pickup URL_RAW) | END #>
L47: <# # SideNote | FROM=CoAudit | TO=4.0|PRIME|260129 | UTC=20260131T__AUTO__Z | STATE=doing | INTENT=CoRollcall reply for CoAudit session (strategy-layer + productization): DONE=Drafted CoAudit concept evolution: (a) clarified CoAudit=process (audit/verification) vs pivotal-error term (option-collapse fault) to avoid definition drift; (b) enumerated strategic registers CoAudit can report on (claims/assumptions/options/ADR/risks/controls/deps/metrics/incidents/etc) + best-practice principles (evidence, traceability, risk-based gates, closed-loop remediation); (c) proposed CoAudit as comparative product for forks/competing approaches (compare mode) with deterministic receipts+ranked rubric outputs; (d) drafted CoAudit v1 repo scope + evergreen roadmap for releasable OSS product with “official core” via signed releases + signed rubric packs + trademark/certification + transparency/no-capture charter; (e) recommended ingest policy: ingest-fast/quarantine OK, publish-slow fail-closed on main with progressive FAIL/HOLD/WARN gates + explicit exception debt. NEXT=If CoPrime wants execution: create canonical CoAudit repo skeleton + minimal v0.1 contract (manifest+receipts+Findings.jsonl+Report.md) + rubric-spec + 1 official rubric pack + CI preset (pr_gate + compare) + determinism/golden tests + governance docs (license/trademark/security/no-capture/funding ledger). NEED=Pointer-pack/rails: COBEACON_RAW_URL + MASTERPLAN_LATEST_RAW_URL + canonical PARK_PROGRESS_AT (repo/vault) + required gate thresholds (FAIL/HOLD/WARN) + any whitelist/quarantine rules + whether CoAudit should be a standalone repo vs CoStacks module; also confirm license stance (AGPL/MPL/Apache) + trademark/cert path. RISK=Without rails/pointers, risk of producing assets that don’t align with current CoStacks MVP structure (paths, naming, whitelists, UI/UX asset conventions); also risk of “cleanup later” policy leaking secrets/license contamination unless fail-closed gates enforced on main/releases. COCARRY=NONE_YET (no pack generated in this session; can emit PACK__CoAudit_v0.1__docs+schemas+rubric__<UTC>.zip + SHA256 once parking destination is specified). END #>``` ::contentReference[oaicite:0]{index=0}

### FILE: docs\COBUS_LITE\rollcall\ROLLCALL__20260131T134804Z.md
L21: <# # SideNote | FROM=CoSources_2 | TO=4.0|PRIME|260129 | UTC=20260131T__AUTO__Z | STATE=doing | INTENT=CoRollcall reply (structured). DONE=Diagnosed MB “ExploitBlocked/AE” events as false-positive-ish against signed Git binaries (git.exe + git-remote-https.exe) labeled Exploit.T1003CredentialAccess; verified Authenticode signatures valid (Johannes Schindelin cert); extracted AeDetections schema: exploitData nested under threats[0].mainTrace (linkedTracesCount=0) with cleanAction=block/cleanResult=successful; confirmed Task Scheduler is effectively unavailable (schtasks /Create => Access denied; schtasks /Query for our tasks => not found), so scheduled-task guard approach is not viable on this host; implemented HKCU Run-key remediation guard (MB_WSC_GuardOnce) and installed HKCU Run-key GitIntegrityWatch baseline+alert (OE_GIT_INTEGRITYWATCH_ONLOGON + baseline.json + OE_ALERTS.log); temporarily allowlisted Git folder to stop productivity-killing blocks (user chose speed > purity). NEXT=Harden “OE_HYGIENE” into a CoStacks-governed preflight rail: single entrypoint + JSON receipt + fixed-width CoAlign segment + FAIL/WARN/PASS policy; add integrity watch for other “critical toolchain” binaries (pwsh/powershell/git/gh/ssh) and optional proxy/TLS-intercept sniff; propose a reversible path to narrow the allowlist from folder-wide -> specific signed binaries once stable. NEED=From CoPrime: (1) canonical spec for fixed-width CoAlign rail segment (chars budget + required fields + blame-tag taxonomy), (2) where to publish/store OE_HYGIENE receipts (repo+path policy) and whether CoPrime wants this as a dedicated CoStacks repo/module or within CoSources, (3) whether “Task Scheduler denied” should be a hard FAIL or WARN in CoStacks MVP. RISK=Git folder allowlist widens trust boundary (mitigated partially by integrity watch, but still a bigger blast radius); MB detection could be real if upstream compromise ever happens (watch catches binary change, not runtime abuse); lack of scheduled tasks means fewer enforcement options; recommend treat this host as “WARN: scheduler locked down” in CoAlign. COCARRY=none published yet (no pack+sha256); if you want, I recommend we mint PACK__OE_HYGIENE_v0__UTC.zip + .sha256 containing: (a) the two Run-key guard scripts, (b) baseline.json, (c) OE_ALERTS.log sample header, (d) AeDetections parsing snippets + one sanitized example; intended-dest=CoCarry/packs for CoStacks ingestion. END #>
L38: <# # SideNote | FROM=Focus | TO=4.0|PRIME|260129 | UTC=20260131T235900Z | STATE=doing | INTENT=CoRollcall reply (Focus parked; advisory-only) | DONE=Created public-safe transient inbox repo CoCivium/TEMP; established truthful retention contract (manual-only purge; “24h” is target not promise); parked 1 advisory nugget for CoStacks sprint (WIP cap 1-2 active streams; trunk/small-batch; LLM=planner/critic only; MVP stop-rule; request MasterPlan URL_RAW+anchors); added manual purge tool TOOLS/Purge_INBOX.ps1; published stable URL_RAW pointers + sha in INDEX. | NEXT=Remain parked unless you ask; use TEMP only for sanitized pointer-pack nuggets; optional later: rename TEMP->CoTemp for CoBrand consistency AFTER CoStacks MVP (avoid churn now). | NEED=1) Canonical MasterPlan URL_RAW pointer + insertion anchors published (CoBeacon says MasterPlan pointer was UNSET—Focus will not guess); 2) confirm whether you want TEMP kept as ongoing “public-safe scratchpad” or treat as temporary experiment; 3) if you ever want auto-purge via GH Actions, auth must include workflow-scope (currently blocks any .github/workflows path). | RISK=Public repo -> IP leakage if misused; manual purge can be forgotten; goalpost drift if MVP stop-rule not explicit; workflow-scope gate prevents automation until auth fixed. | COCARRY=POINTERPACK: TEMP_BASE=https://raw.githubusercontent.com/CoCivium/TEMP/main/README.md ; INDEX=https://raw.githubusercontent.com/CoCivium/TEMP/main/INBOX/INDEX.md ; NUGGET=https://raw.githubusercontent.com/CoCivium/TEMP/main/INBOX/20260128T020535Z__focus_advisory_nuggets_v0.1/README.md ; TOOL=https://raw.githubusercontent.com/CoCivium/TEMP/main/TOOLS/Purge_INBOX.ps1 ; SHA256_NUGGET_README=4d4f05341d397bade9b9e78d2e27e42af36e300ab9f2d047fc8887492e0cfa0e ; INTENDED_DEST=CoPrime triage -> copy any keeper into real repo/vault + reference from MasterPlan when ready. END #>
L42: <# # SideNote | FROM=GIBindex | TO=4.0|PRIME|260129 | UTC=20260131T235900Z | STATE=doing | INTENT=CoRollcall reply (structured): DONE=Bootstrapped via public CoBeacon (CoBusMirror) + followed rails (TypedSectionRails/PointerSpec/CoPong); drafted new CoTerm CoSourceID (md+yaml) + built CoCarry bundle w/ fixed 2-line MANIFEST + zip+sha receipts; surfaced rail mismatch risk: public CoBus_Index looked stale vs current PRIME labels; flagged MasterPlan URL_RAW as UNSET per pointer status; asked for canonical CoCarry pickup lane + GIBindex destination repo/path; NEXT=Upon your reply w/ (1) canonical pickup URL_RAW + (2) destination repo/path, publish/ingest CoSourceID into canon and emit commit-SHA RAW pointers; if you want CoSourceID “MasterPlan-front-and-center thesis”, cut CoSourceID v1 pack adding deterministic resolution algo + explicit -From/-To requirements for CoBus note tools + fail-closed ambiguity handling + optional transparency-log/signature hooks; NEED=Your authoritative pointers: CoCarry INDEX__LATEST URL_RAW (pickup lane), GIBindex terms registry destination repo/path, latest CoBus_Index republish cadence, MasterPlan URL_RAW pointer, latest rails/UI-UX asset pointers (PS7 banner conventions etc), and whether CoSourceID is to be threaded into MasterPlan/CoStacks MVP now; RISK=Without canonical pickup+dest, CoCarry bundle can’t be ingested; stale public index/pointer drift can fork canon; identity errors (label drift/PS var case-insensitivity/session bloat) remain high until CoSourceID adopted + enforced; COCARRY=PACK__CoSourceID__v0__20260129T200324Z|MD_SHA256=ab1fa02d9e41dba0b4793297c837a46272b4be77993e0f6f0e0a1d0ee6659f2a|YAML_SHA256=488717e864555c190a171cbabf05270180344335f38e260f31e139e46642243e|MANIFEST_SHA256=8de1e524b0cd98c4f843bef10901267b6b07fefb8f254d6344e8523d9e28afa3|ZIP_SHA256=092f8a3e0a7800e90fa7331a7a296f8da1d27a9ba79e49121a296d86007af293|ZIP_SHA256_FILE_SHA256=67b502a3c41c7f5539198e726e593fe745722836257b16dc0e83414b026e5a28|INTENDED_DEST=TBD_by_PRIME (await repo/path + pickup URL_RAW) | END #>
L47: <# # SideNote | FROM=CoAudit | TO=4.0|PRIME|260129 | UTC=20260131T__AUTO__Z | STATE=doing | INTENT=CoRollcall reply for CoAudit session (strategy-layer + productization): DONE=Drafted CoAudit concept evolution: (a) clarified CoAudit=process (audit/verification) vs pivotal-error term (option-collapse fault) to avoid definition drift; (b) enumerated strategic registers CoAudit can report on (claims/assumptions/options/ADR/risks/controls/deps/metrics/incidents/etc) + best-practice principles (evidence, traceability, risk-based gates, closed-loop remediation); (c) proposed CoAudit as comparative product for forks/competing approaches (compare mode) with deterministic receipts+ranked rubric outputs; (d) drafted CoAudit v1 repo scope + evergreen roadmap for releasable OSS product with “official core” via signed releases + signed rubric packs + trademark/certification + transparency/no-capture charter; (e) recommended ingest policy: ingest-fast/quarantine OK, publish-slow fail-closed on main with progressive FAIL/HOLD/WARN gates + explicit exception debt. NEXT=If CoPrime wants execution: create canonical CoAudit repo skeleton + minimal v0.1 contract (manifest+receipts+Findings.jsonl+Report.md) + rubric-spec + 1 official rubric pack + CI preset (pr_gate + compare) + determinism/golden tests + governance docs (license/trademark/security/no-capture/funding ledger). NEED=Pointer-pack/rails: COBEACON_RAW_URL + MASTERPLAN_LATEST_RAW_URL + canonical PARK_PROGRESS_AT (repo/vault) + required gate thresholds (FAIL/HOLD/WARN) + any whitelist/quarantine rules + whether CoAudit should be a standalone repo vs CoStacks module; also confirm license stance (AGPL/MPL/Apache) + trademark/cert path. RISK=Without rails/pointers, risk of producing assets that don’t align with current CoStacks MVP structure (paths, naming, whitelists, UI/UX asset conventions); also risk of “cleanup later” policy leaking secrets/license contamination unless fail-closed gates enforced on main/releases. COCARRY=NONE_YET (no pack generated in this session; can emit PACK__CoAudit_v0.1__docs+schemas+rubric__<UTC>.zip + SHA256 once parking destination is specified). END #>``` ::contentReference[oaicite:0]{index=0}

### FILE: docs\COBUS_LITE\workflows\CoCarryDrain_SPEC_v0.1.md
L44: 3) For sessions with R_PUBLISH_REQUIRED=Y, publish their artifacts (pack + sha + pointers) and append a follow-up ledger row upgrading them to COSOURCED.

### FILE: docs\COBUS_LITE\workflows\NOTE__WF_DRAIN_REJECTS_EXPLAINED__v0.1.md
L9: - Block not in the expected single CoPong reply template format

### FILE: docs\COBUS_LITE\workflows\WF_DRAIN_REQUEST_TEMPLATE_v2__STRICT__v0.1.md
L1: # WF_DRAIN v2 STRICT — reply template v0.1

## ALIAS_OR_ADDRESS
### FILE: docs\COBUS_LITE\canon\SUBSESSION_PROTOCOL_LATEST.md
L23: CoStall (alias CoFlatline): generic output caused by missing pins/rails, leading to fabrication instead of fail-closed progress.

### FILE: docs\COBUS_LITE\canon\Backlog\PRIORITY_QUEUE_LATEST.md
L1: # Priority Queue (Authoritative) — CoBusShare alias within CoBusMirror
L10: - [x] Canon identity declared (alias): https://raw.githubusercontent.com/CoCivium/CoBusMirror/1e7334960b696cce5ff0d1aa1f92dc372ab95e64/docs/COBUS_LITE/canon/Identity/COBUS_IDENTITY_LATEST.md

### FILE: docs\COBUS_LITE\canon\Identity\COBUS_IDENTITY_LATEST.md
L7: - Treat it conceptually as **CoBusShare** (alias). “Mirror” does NOT imply “local-only copy.”

### FILE: docs\COBUS_LITE\dispatch\DISPATCH__LATEST.md
L17: - Sessions matching regex ^\.live\d+\. are aliases until receipts-tier satisfied.

### FILE: docs\COBUS_LITE\entries\2026\03\03\20260303T203614Z__Workflows_PARKED.md
L12: - ALIAS_MAP=docs\COBUS_LITE\workflows\WF_DRAIN__SessionLabel_AliasMap__v0.1.md

### FILE: docs\COBUS_LITE\entries\2026\03\07\20260307T033304Z__PRM_CORE_260307__CoAddressAndHelperIndex.md
L1: FROM: PRM|CORE|260307
L4: TOPIC: wrote CoAddress spec and seeded helper index
L6: SPEC_REPO_REL=docs\infrastructure\CoAddress__SPEC_v0.1.md

### FILE: docs\COBUS_LITE\entries\2026\03\07\20260307T035243Z__PRM_CORE_260307__RegisterHelper_LabelAssist.md
L1: FROM: PRM|CORE|260307

### FILE: docs\COBUS_LITE\entries\2026\03\07\20260307T040833Z__PRM_CORE_260307__CloseoutBundle.md
L1: FROM: PRM|CORE|260307

### FILE: docs\COBUS_LITE\masterplan_suggestions\MP_SUGGESTIONS__Workflows_CoMetaTrain_CoEvo__20260303T180329Z.md
L26: - If multiple repos define similar meta headers, unify via one canonical schema and treat repo-specific variants as deprecated aliases.

### FILE: docs\COBUS_LITE\workflows\BESTCASE__WF_DRAIN_to_CoPrime__v0.1.md
L14: - .live label semantics: treat as recoverability alias, not proof-of-cosource by itself.
L29: - formalize canon-vs-alias label governance across repos
L34: - ALIAS_MAP: docs\COBUS_LITE\workflows/WF_DRAIN__SessionLabel_AliasMap__v0.1.md

### FILE: docs\COBUS_LITE\workflows\HANDOFF__Workflows_to_CoPrime__WF_DRAIN_Pack__v0.1.md
L18: - ALIAS_MAP: docs\COBUS_LITE\workflows\WF_DRAIN__SessionLabel_AliasMap__v0.1.md
L26: - Canonical session identity should remain stable base label; .live* should be treated as alias unless promoted intentionally.

### FILE: docs\COBUS_LITE\workflows\PARK__Workflows_WF_DRAIN__RESUME_CARD__v0.1.md
L11: - SESSION_LABEL_ALIAS_MAP: docs\COBUS_LITE\workflows\WF_DRAIN__SessionLabel_AliasMap__v0.1.md
L25: - .liveYYYYMMDD.<Label> is alias/routing label (recoverability-in-CoSource), unless explicitly promoted.
L35: - Label semantics governance (canon vs alias vs promoted)

## HANDOFF_DISCOVERY
### FILE: tools\coguardian\CoGuardian_TrayHost.ps1
L62: "- If claims cannot be substantiated, treat them as noncanonical or recreatable."

### FILE: tools\coguardian\RECEIPT__COGUARDIAN_WATCHER_BOOTSTRAP__v0.1.txt
L13: ENTRY_REPO_REL=docs\COBUS_LITE\entries\2026\03\07\20260307T010036Z__4.0_PRIME_260307__CoGuardianWatcherBootstrap.md
L14: ENTRY_FULL=C:\Users\rball\Documents\GitHub\CoBusMirror\docs\COBUS_LITE\entries\2026\03\07\20260307T010036Z__4.0_PRIME_260307__CoGuardianWatcherBootstrap.md

### FILE: tools\coguardian\Write-CoLabelAssist__LATEST.ps1
L11: $bootstrap = "BOOTSTRAP: CoSync | SESSION=" + $Session + " | ROLE=" + $Role + ( $Ptr ? (" | PTR=" + $Ptr) : "" )
L12: Write-CoProof $bootstrap

### FILE: docs\COBUS_LITE\bus\prime\Submissions__LATEST.md
L8: <# # SideNote | FROM=rick | TO=4.0|PRIME|260216 | UTC=20260217T161832Z | STATE=done | INTENT=PR_CREATED_WAVESETQUEUE_V3: PR https://github.com/CoCivium/CoBusMirror/pull/50 created via gh (device auth as CoCivium). Head=we-waveset_queue_v3_20260217T154451Z commit=41a2d9695753659a6df93a43dfad6e655d40ccb4. Artifacts/receipts: file:///C:/Users/rball/Downloads/CoPrime_MegaWave/Wave__20260217T161832Z/Receipt__PR_Create_v4__20260217T161832Z.txt and file:///C:/Users/rball/Downloads/CoPrime_MegaWave/PRCreatePack_v4__20260217T161832Z.zip (+.sha256=file:///C:/Users/rball/Downloads/CoPrime_MegaWave/PRCreatePack_v4__20260217T161832Z.zip.sha256). Content: docs/COBUS_LITE/canon/WAVESET_QUEUE__LATEST.yml + WAVESET_KICKOFF__LATEST.md + seeded docs/COBUS_LITE/bus/subsessions/Sub1..Sub24__LATEST.md; bootstrap pinned RAW_COBEACON=https://raw.githubusercontent.com/CoCivium/CoBusMirror/c74c936183d102ef4fcbeac656bb4ddffff44c60/docs/COBEACON_LATEST.txt (PointerPack URL discovered from CoBeacon). #>

### FILE: docs\COBUS_LITE\bus\subsessions\Sub1__LATEST.md
L11: - BOOTSTRAP: fetch CoBeacon RAW; follow only FULL-URL pointers; locate canon pins for this intent.

### FILE: docs\COBUS_LITE\bus\subsessions\Sub10__LATEST.md
L11: - BOOTSTRAP: fetch CoBeacon RAW; follow only FULL-URL pointers; locate canon pins for this intent.

### FILE: docs\COBUS_LITE\bus\subsessions\Sub11__LATEST.md
L11: - BOOTSTRAP: fetch CoBeacon RAW; follow only FULL-URL pointers; locate canon pins for this intent.

### FILE: docs\COBUS_LITE\bus\subsessions\Sub12__LATEST.md
L11: - BOOTSTRAP: fetch CoBeacon RAW; follow only FULL-URL pointers; locate canon pins for this intent.

### FILE: docs\COBUS_LITE\bus\subsessions\Sub13__LATEST.md
L11: - BOOTSTRAP: fetch CoBeacon RAW; follow only FULL-URL pointers; locate canon pins for this intent.

### FILE: docs\COBUS_LITE\bus\subsessions\Sub14__LATEST.md
L11: - BOOTSTRAP: fetch CoBeacon RAW; follow only FULL-URL pointers; locate canon pins for this intent.

### FILE: docs\COBUS_LITE\bus\subsessions\Sub15__LATEST.md
L11: - BOOTSTRAP: fetch CoBeacon RAW; follow only FULL-URL pointers; locate canon pins for this intent.

### FILE: docs\COBUS_LITE\bus\subsessions\Sub16__LATEST.md
L11: - BOOTSTRAP: fetch CoBeacon RAW; follow only FULL-URL pointers; locate canon pins for this intent.

## CURATED_NOTES
- This pack is evidence-oriented, not a new architecture proposal.
- Use it to help draft CoPostingCandidate__SPEC_v0.1 and CoReceipt__MINIMUM_SPEC_v0.1.
- Prefer recurring fields/patterns over one-off anomalies.

