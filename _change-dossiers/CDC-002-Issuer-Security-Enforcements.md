---
title: CDC-002 - Generic Issuer - Security Enforcement, AES256 Migration & Status List Gap Closure
excerpt: Affected Components Generic Issuer, swiyu Wallet
header:
  teaser: ../assets/images/none.jpg
---

{% capture notice-text %}

Status: Draft <br>
Published: <br>
Effective: <br>
Affected Components: Generic Issuer, swiyu Wallet <br>
Internal Reference: EIDARTFE-1526, EIDARTFE-1564, EIDARTFE-1717, EIDARTFE-1726 <br>

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Security Enforcement, AES256 Migration & Status List Gap Closure</h4>
  {{ notice-text | markdownify }}
</div>

This dossier bundles four related Issuer-side changes into a single migration wave. First, it enforces the security changes from swiss-profile-issuance 1.0 by enforcing Payload Encryption, and Signed Metadata, all of which are already implemented since version 3.0.0 and set as default. Second, it migrates encryption from AES128-GCM to AES256-GCM; following EMC, all components first accept both algorithms, with the Wallet required to support this ahead of the Issuer and Verifier. Third, it closes the remaining Status List gaps required for the swiyu 1.0 go-live, including ttl/exp handling and Status List validation. During the transition period, non-enforcing behavior continues to be accepted where noted; afterwards, non-compliant Issuers can no longer participate in the ecosystem. 

## Action required

⚠️ Required soon
🚨 Breaking
🆕 Optional
✅ Improvement
🐞 Fix

### Generic Issuer
Version: 4.0.0 <br>
⚠️ Add ttl/exp support when issuing Status List Tokens (JWT format). <br>
⚠️ Enforce correct usage of credential_configuration_id. <br>
⚠️ Enforce presence of the nonce_endpoint, credential_request_encryption, and credential_response_encryption metadata parameters.  <br>
🚨 Enforce Credential Endpoint and the Deferred Credential Endpoint. Swiyu wallet will enforce this with a future release. <br>
🚨 Enforce credential_request_encryption and credential_response_encryption, reject unencrypted requests/responses where encryption is required, including for the Deferred Credential Request and Response. Swiyu wallet will enforce this with a future release. <br>
🚨 Enforce Signed Metadata on the Credential Issuer Metadata endpoint. Swiyu wallet will enforce this with a future release. <br>

The generic Iussuer 4.0.0 should be deployed as soon wallet 1.17 is published. <br>
Must be in use until end of Q3 2026. <br>

## Migration steps
1. Issuer can migrate to generic issuer 4.0.0.
2. Contract phase: Payload Encryption and signed meta data become mandatory at the swiyu Wallet; non-conforming Issuers can no longer issue credentials to the swiyu Wallet.

## Timeline
17.08.2026:  Wallet-side 1.17 security enforced (payload encryption, Signed Metadata trust) requires the generic issuer 4.0.0. <br>
