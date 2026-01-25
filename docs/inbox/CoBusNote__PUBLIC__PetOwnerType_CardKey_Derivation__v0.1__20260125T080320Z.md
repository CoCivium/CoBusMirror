# PetOwnerType CardKey Derivation v0.1 (PUBLIC)

## Goal
Avoid combinatorial art explosion. Use compositing:
- base archetype set (20–40)
- overlay badges per vector
- deterministic key ensures stable mnemonic per profile

## Deterministic key (seed)
card_key = BASE32( SHA256( coprofile_id + "|" + version + "|" + canonical_json(style_prefs) + "|" + theme_id ) )

## Render rules
- base = archetype(card_key mod N)
- badges = per-vector icon set, max 1 short ribbon text
- output = SVG-first; raster outputs are cached derivatives
- accessibility: always emit text summary alongside image

## Zero-wait strategy
- client-side composition for instant display (no network wait)
- server pre-renders common sizes; CDN cached by card_key

END
