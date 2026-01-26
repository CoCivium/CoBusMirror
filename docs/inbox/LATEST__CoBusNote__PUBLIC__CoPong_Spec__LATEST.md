# CoPong_Spec_v1 (PUBLIC, LATEST)

## Goal
Make inter-session notes *addressable, verifiable, paste-safe*.

## Hard rules
- A CoPong MUST be **one physical line** wrapped as a PowerShell block comment: <# ... #>.
- Inside the CoPong header: TO= and FROM= MUST be **chat session labels only**.
- Repos are NOT sessions. If targeting a repo, include REPO=Org/Repo as a separate field.
- Optional stability fields: CHAT_URL= and/or CHAT_UID=.

## Canonical header skeleton (single line)
<# # CoPong | FROM=<sessionLabel> | TO=<sessionLabel> | UTC=<yyyyMMddTHHmmssZ> | STATE=<doing|done|hold> | INTENT=<free text> | REPO=<Org/Repo optional> | CHAT_URL=<optional> | CHAT_UID=<optional> END #>

## Typed section rails (assistant outputs)
- Assistant outputs SHOULD use sequential headers: ## N[TypeLabel]
- ## N[Footer] is mandatory for any “wave” response.
- Suggested TypeLabels: Header, Diagnosis, Design, DO, SideNote, Footer.