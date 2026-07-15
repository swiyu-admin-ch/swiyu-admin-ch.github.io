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

Tag ⚠️ Required soon
Tag 🚨 Breaking
Tag 🆕 Optional
Tag ✅ Improvement
Tag 🐞 Fix

### Generic Issuer
Version: <br>
⚠️ Add ttl/exp support when issuing Status List Tokens (JWT format). <br>
⚠️ Enforce correct usage of credential_configuration_id. <br>
⚠️ Enforce presence of the nonce_endpoint, credential_request_encryption, and credential_response_encryption metadata parameters. <br>
🚨 Enforce the DPoP header on the Credential Endpoint and the Deferred Credential Endpoint (Contract phase, after Wallet implementation). <br>
🚨 Enforce credential_request_encryption and credential_response_encryption, reject unencrypted requests/responses where encryption is required, including for the Deferred Credential Request and Response. <br>
🚨 Enforce Signed Metadata on the Credential Issuer Metadata endpoint. <br>
🆕 Accept both AES128-GCM and AES256-GCM during the migration phase; specify the encryption algorithm used for credential_request_encryption and credential_response_encryption in Issuer Metadata. <br>
✅ Make the Nonce Response uncacheable by adding a Cache-Control: no-store header. <br>
✅ Provide Trust Statements in Issuer Metadata (Trust Protocol 2.0), refreshed automatically. <br>


### Wallet
Version: <br>
🚨 Must support DPoP ahead of Issuer enforcement (Wallet-first, per EMC order of operations). <br>
🚨 Must correctly send and process encrypted credential requests/responses, including in the deferred flow. <br>
🆕 Maintains a hardcoded Protected Claims list (currently: personal_administrative_number). <br>
✅ Must be the first component to support AES256-GCM (include the algorithm in credential_response_encryption metadata), ahead of Issuer/Verifier support. <br>
✅ When requesting Signed Metadata, must establish trust in the signer and reject the metadata if trust cannot be established. <br>
✅ Creates Trust Marks for the Issuance flow using Issuer Metadata Trust Statements, Trust List Statements, and fetched Status Lists. <br>
✅ Implements redesigned trust labels and bottom sheets, and removes deprecated labels (Legitimate Issuer, Non-Legitimate Issuer, In Base Registry, Not in System, Unknown) <br>

### Status Registry
⚠️ Reject Status List uploads where exp is missing or already expired. <br>
⚠️ Enforce the Status List JWT header: typ must be statuslist+jwt, and profile_version must be in an extensible allow-list of supported values (e.g. allowed_profile_versions), currently swiss-profile-vc:1.0.0. <br>
⚠️ Validate Status List size: bit-length must be divisible by 8, and decompressed size must be under 200KB. <br>

### Trust Registry
🆕 Trust Management Service creates all Trust Protocol 2.0 elements and manages Status Lists. <br>
🆕 Trust Registry provides Trust Statements for trust-onboarded DIDs in the new format, and provides Trust List Statements. <br>

### Check App
Version: <br>
✅ Loads piTLS as the Trust Source for protected issuance, automatically fetching and interpreting the relevant piaTS. <br>

## Migration steps
1. Wallet adds support for DPoP, encrypted requests/responses, Signed Metadata trust validation, and AES256-GCM (dual algorithm support).
2. Generic Issuer starts providing Trust Statements in Issuer Metadata and enforcing metadata parameter presence, Signed Metadata, and AES128/AES256 dual support.
3. Status Registry enforces Status List validation rules (ttl/exp, header fields, size limits).
4. Contract phase: DPoP and Payload Encryption enforcement become mandatory at the Issuer; non-conforming Issuers can no longer issue credentials.

## Timeline
xx.xx.2026 Wallet-side support available (DPoP, encryption, AES256, Signed Metadata trust) <br>
xx.xx.2026 Generic Issuer enforcement enabled (Enable/Migrate phase) <br>
xx.xx.2026 Contract phase, enforcement mandatory, AES128-GCM support removed <br>
