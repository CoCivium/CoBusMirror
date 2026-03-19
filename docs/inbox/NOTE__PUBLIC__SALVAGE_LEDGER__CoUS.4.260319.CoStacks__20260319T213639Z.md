PUBLIC_NOTE
UTC=20260319T213639Z
SESSION_LABEL=CoUS.4.260319.CoStacks
TYPE=SalvageLedger
STATUS=doing
TITLE=Dropped-stuff salvage ledger for CoUS.4.260319.CoStacks

HONEST_STATE=
- Not all discussed material had previously made it to CoEx.
- Some items were only chat-resident, relay-resident, duplicated, or proposal-stage.
- This ledger is the authoritative salvage bind for what this session can presently recover and name.

WAVE_CLOSE_RULE=
Every state-bearing wave MUST terminate in exactly one of:
1. PASS=YES with publicly readable RAW(main), or
2. BLOCKED with explicit blocker and no success claim.
Any other end-state is CoUnHitched, degraded, and non-authoritative.

SALVAGED_SEED_SET=
1. CoUnHitched
   DEF=Detached from canonical rails, pointers, or authoritative wave-close state.
   RULE=Any wave that does not close PASS=YES + RAW(main) or BLOCKED is CoUnHitched.

2. CoPulse / CoHeartbeat / CoAlive / CoDying / CoDead
   DEF=Health/status vocabulary for wave/session execution quality.
   NOTE=Health vocabulary is not authority proof by itself.

3. MailmanLostMailSyndrome
   DEF=Human-relayed inter-session content may be partial, duplicated, delayed, reordered, or dropped.
   RULE=Advisory until rebound to shared/public authority surfaces.

4. CoFilter
   DEF=Per-wave rail/context sanity pass.
   MINIMUM=CoBeacon + Broadcast + context/scope/authority tick + honest close.

5. Handoff/Transition Integrity
   DEF=Transitions must be at least as detectable as states.
   SEED=dual-record handoff concept; transitions are attack surfaces and need visibility and verification.

6. Cluster Coherence / Writer Governance
   SEED=coordinator uniqueness, sole canonical writer per lane unless explicitly leased, shadow/helper downgrade on overlap, successor validity, overlap downgrade, async-safe operation.

7. ROLE / WRITE_SCOPE / TTL
   SEED=Sessions should declare role, write scope, and TTL where overlap risk exists.

8. Session/Cluster Lifecycle
   SEED_TERMS=
   - CoTwilight_CloseProtocol
   - SESSION_LIFECYCLE
   - CLUSTER_MEMBERSHIP_CONTRACT
   - CLUSTER_EXIT_GATE
   - COORG_BUBBLE
   - COOBJECT_PROVENANCE
   - ROGUE_LANE_CONTAINMENT
   - CoContract
   - CoProtocat

9. GIBindex / CoIndex Replan Need
   DEF=Term families and schema need structured replanning, not ad hoc accumulation.
   NOTE=CoUnHitched preferred over UnHitched.

10. Audio / Channel Experiment Seeds
    SEED_TERMS=
    - CoChannelRedundancy
    - CoAudioWidening
    - CoWhaleMode
    - CoEchoRunaway
    - CoSanityMute
    NOTE=These are experiment-prep seeds, not yet canonical operating protocol.

11. Mythos / Origination Preservation
    DEF=User-provided raw and CoWise-able raw with future origin-story/mythos value should be preserved as attributable lineage-carrying seeds.
    NOTE=Raw human-origin sparks should not be lost merely because they first appeared in crisis-chat or relay form.

12. Edge Health Direction
    DEF=The edge is where reality meets AI; healthier edge loops can pressure systems toward broader sanity than narrow owner/developer bias alone.
    NOTE=Operationalized via provenance, consent, revocability, portability, and repeated reality-bound correction; not by vague ethics alone.

UNRESOLVED_OR_PARTIAL=
- Full cluster coherence protocol not yet canonized
- Full writer lease / arbitration policy not yet canonized
- Full GIBindex / CoIndex replan not yet landed here
- Full voice experiment protocol not yet landed here
- All upstream relay-only fragments cannot be guaranteed recovered from this session alone

MYTHOS_FLAG=true
ORIGINATION_NOTE=
This session explicitly recognized that some user-provided raw/originational content may later inform CoCivium mythos, inspirationals, and future narrative framing.
This ledger preserves that fact even where individual raw passages were not separately landed.

FOLLOWUP_LANES=
1. CoWaveClosureContract_v0
2. CoFilterProtocol_v0
3. CoTransition_Handoff_DualRecord_v0
4. CoVoiceCluster_ExperimentProtocol_v0
5. GIBindex_CoIndex_Replan_v0
6. Mythos_OriginSeed_Capture_v0

CONSTRAINT=
This salvage ledger is itself the one artifact for this wave.
Anything not separately landed after this remains queued, not magically finished.

END
