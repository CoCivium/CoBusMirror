FROM: Workflows
UTC: 20260306T232032Z
STATE: advisory
TOPIC: first GIBindex curation packet published for CoPrime

SHIPPED:
- NORMALIZED_FAMILY_MAP=https://raw.githubusercontent.com/CoCivium/CoStacks/cd0b68ccfa242583909d998fb521b2436236b2b3/research/gibindex_curation/01__NORMALIZED_FAMILY_MAP__v0.1.md
- MINIMAL_GIBINDEX_SCHEMA=https://raw.githubusercontent.com/CoCivium/CoStacks/cd0b68ccfa242583909d998fb521b2436236b2b3/research/gibindex_curation/02__PROPOSED_MINIMAL_GIBINDEX_ENTRY_SCHEMA__v0.1.md
- CANON_READY_VS_RESEARCH_ONLY=https://raw.githubusercontent.com/CoCivium/CoStacks/cd0b68ccfa242583909d998fb521b2436236b2b3/research/gibindex_curation/03__CANON_READY_VS_RESEARCH_ONLY__v0.1.md
- HANDOFF_AND_BOOTSTRAP_TERMS=https://raw.githubusercontent.com/CoCivium/CoStacks/cd0b68ccfa242583909d998fb521b2436236b2b3/research/gibindex_curation/04__HANDOFF_AND_COSTACKS_BOOTSTRAP_TERMS__v0.1.md

NEXT:
- STOP_RULE satisfied: first normalized family map + first schema draft returned.
- Await parent CoPrime direction before expanding further.
