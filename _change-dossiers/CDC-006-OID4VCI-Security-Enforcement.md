---
title: CDC-006 - OID4VCI Security Enforcement
excerpt: Required steps and timeline for Enforcement of the OID4VCI Security Requirements 
header:
  teaser: ../assets/images/none.jpg
---

{% capture notice-text %}

Status: Draft <br>
Published: <br>
Effective: <br>
Affected Components: <br>
Internal Reference: EIDARTFE-1526 <br>

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Swiss Profile Issuance V1.0</h4>
  {{ notice-text | markdownify }}
</div>

Payload Encryption, Signed Metadata, and DPoP were previously introduced as optional security features and are now moving from "migrate" to "enforce". These features only provide their intended security benefit once they are actually enforced across the ecosystem rather than merely supported. This change closes the remaining security enforcement gaps against swiss-profile-issuance 1.0: the Credential Issuer will require DPoP, encrypted credential requests/responses (including deferred flows), and signed, trusted Metadata; Wallets must correspondingly establish trust in Metadata signers and reject non-compliant responses.

## Action required

### DID Resolver

Tag ⚠️ Required soon
Tag 🚨 Breaking
Tag 🆕 Optional
Tag ✅ Improvement
Tag 🐞 Fix

### Generic Issuer
🚨 Nonce Response: the response MUST be made uncacheable by including a Cache-Control: no-store header. <br>
🚨 Credential Request: enforce the DPoP header (planned to take effect once Wallets have implemented DPoP support). <br>
🚨 Enforce credential_response_encryption on Credential Responses. <br>
🚨 Enforce credential_request_encryption on Credential Requests (planned to take effect once Wallets have implemented request encryption). <br>
🚨 Enforce correct usage of credential_configuration_id. <br>
🚨 Deferred Credential Endpoint: enforce the DPoP header (planned to take effect once Wallets have implemented DPoP support). <br>
🚨 Enforce Payload Encryption on Deferred Credential Requests, and require that Deferred Credential Responses are encrypted as well. <br>
🚨 Reject any message that is unencrypted when encryption was required (applies to both requests and responses). <br>
🚨 Enforce Signed Metadata for the Credential Issuer Metadata. <br>
🚨 Enforce presence of the following Credential Issuer Metadata parameters: $.nonce_endpoint, $.credential_request_encryption, $.credential_response_encryption. <br>

### Generic Verifier
-- <br>

### Wallet
🚨 When requesting signed Metadata, establish trust in the signer of that Metadata (via the applicable trust protocol); reject the signed Metadata if trust cannot be established. <br>
🚨 Enforce presence of the required Credential Issuer Metadata parameters ($.nonce_endpoint, $.credential_request_encryption, $.credential_response_encryption) when reading issuer Metadata. <br>
⚠️ Implement DPoP support, Credential Request encryption, and Deferred Credential Request/Response encryption ahead of the corresponding enforcement taking effect at the Issuer. <br>

### Status Registry
-- <br>

## Migration steps
1. Wallets implement DPoP, Credential Request encryption, and Deferred Credential Request/Response encryption.
2. Wallets implement Metadata signature verification and trust establishment for the Metadata signer.
3. Issuers enforce Signed Metadata, required Metadata parameters, and correct credential_configuration_id usage.
4. Issuers enforce DPoP and Payload Encryption (Credential Request/Response and Deferred Credential Request/Response), rejecting unencrypted messages where encryption is required.
5. Issuers make Nonce Endpoint responses uncacheable (Cache-Control: no-store).


## Timeline
{DATE} {Wallet-side support (DPoP, encryption, Metadata trust) complete} <br>
{DATE} {Issuer-side enforcement effective} <br>