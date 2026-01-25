# CoProfile BorrowMap v0.1 (PUBLIC)

## Principle
Do not build identity. Build portable prefs+consent that rides existing rails.

## Standards (seed -> later)
- OIDC (sign-in / basic claims): https://openid.net/specs/openid-connect-core-1_0.html
- WebAuthn / Passkeys (strong auth without doxxing): https://www.w3.org/TR/webauthn-3/
- (Later lane) SD-JWT VC (selective disclosure): https://datatracker.ietf.org/doc/draft-ietf-oauth-sd-jwt-vc/
- (Later lane) OpenID4VP (presentations): https://openid.net/specs/openid-4-verifiable-presentations-1_0.html

## OSS building blocks (evaluate licenses; pick ONE)
- IdP / Auth server: Keycloak / ORY (Hydra+Kratos) / Zitadel
- Policy/consent engine: OPA (Rego) or a small ABAC ruleset
- JSON schema validation libs (server-side)
- CDN image caching / edge functions for card renders

## License gate (non-negotiable)
- keep spec permissive and forkable
- avoid dependency lock-in
- publish conformance tests (later) so implementations compete

END
