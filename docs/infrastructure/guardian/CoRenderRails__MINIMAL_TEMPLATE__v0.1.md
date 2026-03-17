# CoRenderRails__MINIMAL_TEMPLATE__v0.1

UTC_UPDATED: 20260307T070803Z

## Intent
Use minimal on-rails render discipline for CoPrime / CoGuardian operator outputs.

## Positive rules
1. Start with one short numbered section line.
2. That line should carry SESSION / ROLE / INTENT / RISK.
3. Optional second numbered section line for state, one line max.
4. DO block must be the last major element in the message.
5. Inside the DO block, print only cyan proof lines plus one Magenta CoPong via Write-CoPongAndReturn__LATEST.ps1.
6. Prompt should return immediately after the Magenta CoPong.

## Negative rules
- Do not use the word 'Header' in section titles.
- Do not place prose after the DO block.
- Do not print a second signal line after the Magenta CoPong.
- Do not print duplicate CoPongs.
- Do not use enter-operator scaffolding or trailing comment hacks.

## Minimal shape
1) Intent | SESSION=... | ROLE=... | INTENT=... | RISK=...
2) State | optional, one line max

`powershell
<# DO [...] #>
& {
...
Write-CoProof ("ENTRY_SHA: " + $entrySha)
$copong = "<# # CoPong | ... | SIG=⊂CoEvo #>"
& ...\Write-CoPongAndReturn__LATEST.ps1 -CoPong $copong
}
`",
",

- SIG=⊂CoEvo lives inside the CoPong line.
- Receipt style remains cyan key-value path / SHA lines.
