---
title: CDC-002 - Generic Issuer - Security Enforcement, AES256 Migration, Trust Protocol 2.0 & Status List Gap Closure
excerpt: Affected Components Generic Issuer, Wallet, Status Registry, Trust Management Service, Trust Registry, Check App
header:
  teaser: ../assets/images/none.jpg
---

{% capture notice-text %}

Status: Draft <br>
Published: <br>
Effective: <br>
Affected Components: <br>
Internal Reference: EIDARTFE-1526, EIDARTFE-1564, EIDARTFE-1717, EIDARTFE-1726 <br>

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Security Enforcement, AES256 Migration, Trust Protocol 2.0 & Status List Gap Closure</h4>
  {{ notice-text | markdownify }}
</div>

This dossier bundles four related Issuer-side changes into a single migration wave. First, it enforces the security changes from swiss-profile-issuance 1.0 by enforcing DPoP, Payload Encryption, and Signed Metadata, all of which are already implemented but currently only optionally supported under the EMC (Expand-Migrate-Contract) pattern. Second, it migrates encryption from AES128-GCM to AES256-GCM; following EMC, all components first accept both algorithms, with the Wallet required to support this ahead of the Issuer and Verifier. Third, it introduces the Issuer's role in Trust Protocol 2.0, including providing Trust Statements in Issuer Metadata. Fourth, it closes the remaining Status List gaps required for the swiyu 1.0 go-live, including ttl/exp handling and Status List validation. During the transition period, non-enforcing behavior continues to be accepted where noted; afterwards, non-compliant Issuers can no longer participate in the ecosystem. 

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
🚨 Enforce the DPoP header on the Credential Endpoint and the Deferred Credential Endpoint. Swiyu wallet will enforce this with a future release. <br>
🚨 Enforce credential_request_encryption and credential_response_encryption, reject unencrypted requests/responses where encryption is required, including for the Deferred Credential Request and Response. Swiyu wallet will enforce this with a future release. <br>
🚨 Enforce Signed Metadata on the Credential Issuer Metadata endpoint. Swiyu wallet will enforce this with a future release. <br>

Supported after and should be deployed after the wallet version 1.17.0.  <br>
Must be in use until end of Q3 2026. <br>

## Migration steps
1. Wallet adds support for DPoP, encrypted requests/responses, Signed Metadata trust validation, and AES256-GCM (dual algorithm support).
2. Generic Issuer starts providing Trust Statements in Issuer Metadata and enforcing metadata parameter presence, Signed Metadata, and AES128/AES256 dual support.
3. Status Registry enforces Status List validation rules (ttl/exp, header fields, size limits).
4. Contract phase: DPoP and Payload Encryption enforcement become mandatory at the Issuer; non-conforming Issuers can no longer issue credentials.

## Timeline
xx.xx.2026 Wallet-side support available (DPoP, encryption, AES256, Signed Metadata trust) <br>
xx.xx.2026 Generic Issuer enforcement enabled (Enable/Migrate phase) <br>
30.09.2026 Contract phase on wallet and requires the generic issuer 4.0.0. <br>
