# CoAddress SPEC v0.1

UTC_UPDATED: 20260307T033304Z

## Grammar
ROLE|DOMAIN|LINEAGE",
",

- PRM : Prime / orchestration session
- GRD : Guardian (tray/supervisor)
- WCH : Watcher (event capture)
- BRG : Bridge (queue->bus)
- RTR : Router (bus->target)
- WRK : Worker

### Domains
- CORE : core orchestration
- WF   : workflows domain
- BUS  : CoBus / message surface
- INF  : infrastructure
- UX   : operator surfaces
- IDX  : index/registry

### Lineage
- YYMMDD or session lineage tag

### Examples
- FROM=PRM|CORE|260307
- TO=PRM|WF|260307

## Use in Magenta CoPong
<# # CoPong | VER=2 | FROM=PRM|CORE|260307 | TO=PRM|WF|260307 | UTC=... | STATE=... | KIND=... | PTR=... | SHA=... | SIG=⊂CoEvo #>",
",

- Designed to be short, typeable, and parseable.
- Do not invent new ROLE or DOMAIN codes without updating this spec.
