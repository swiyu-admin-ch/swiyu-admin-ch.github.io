---
title: CDC-004 - Generic Verifier - Security Enforcement, AES256 Migration, Trust Protocol 2.0 & Status List Gap Closure
excerpt: Affected Components Generic Verifier, Wallet, Status Registry, Trust Management Service, Trust Registry 
header:
  teaser: ../assets/images/none.jpg
---


{% capture notice-text %}

Status: Draft <br>
Published: <br>
Effective: <br>
Affected Components: <br>
Internal Reference: EIDARTFE-1526, EIDARTFE-1726 <br>

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Swiss Profile VC V1.0</h4>
  {{ notice-text | markdownify }}
</div>

This dossier bundles four related Verifier-side changes into a single migration wave. First, it closes the remaining security-enforcement gaps in OpenID for Verifiable Presentations (OID4VP) by enforcing encrypted Authorization Responses (direct_post.jwt), DCQL-only presentation queries, and Signed Presentation Requests, all of which are already implemented but currently only optionally supported under the EMC (Expand-Migrate-Contract) pattern. Second, it migrates encryption from AES128-GCM to AES256-GCM; following EMC, all components first accept both algorithms, with the Wallet required to support this ahead of the Issuer and Verifier. Third, it introduces the Verifier's role in Trust Protocol 2.0, including Trust Statements, vqPS registration, and piTLS as an alternative Trust Source. Fourth, it closes the remaining Status List gaps required for the swiyu 1.0 go-live, including status-verification configurability and caching. During the transition period, non-enforcing behavior continues to be accepted where noted; afterwards, non-compliant Verifiers can no longer participate in the ecosystem.


## Action required
Update the componets like follows.

Tag ⚠️ Required soon
Tag 🚨 Breaking
Tag 🆕 Optional
Tag ✅ Improvement
Tag 🐞 Fix

### Generic Verifier
Version? <br>
⚠️ Allow the Business Verifier to configure to what degree a failed status verification is accepted before rejecting a VC. <br>
⚠️ Cache Status List Tokens according to their ttl/exp claims. <br>
⚠️ Reject the Referenced Token if Status List validation fails, except where explicitly configured to accept an unknown status (e.g. age verification). <br>
🚨 Always send response_mode=direct_post.jwt so Authorization Responses are encrypted. <br>
🚨 Send DCQL only in the Presentation Request, dropping DIF Presentation Exchange support (Contract phase, after Wallet enforcement). <br>
🚨 Remove support for unencrypted (direct_post) Authorization Responses entirely (EMC Contract step). <br>
🚨 Reject unsigned Presentation Requests the aud claim must reference a signed Request Object (Signed Presentation Requests enforced). <br>
🆕 Accept both AES128-GCM and AES256-GCM during the migration phase. <br>
🆕 Allow Business Verifiers to elect to use piTLS as a Trust Source instead of a defined DID list, automatically fetching the relevant piaTS. <br>
✅ Specify the supported algorithm in the Authorization Response via encrypted_response_enc_values_supported. <br>
✅ Provide Trust Statements in the Request Object's verifier_info. <br>
✅ Provide an easy way for Business Verifiers to register a vqPS. <br>
✅ Support the scope parameter in the Request Object, linking to the vqPS in verifier_info (to allow expansion, provide both a DCQL query and scope). <br>

### Wallet
Version ?<br>
🚨 Refuse any Authorization Response using a response_mode other than direct_post.jwt. <br>
🚨 Only accept DCQL presentation queries from the Verifier, dropping support for DIF Presentation Exchange (Contract phase). <br>
🚨 Remove support for unencrypted (direct_post) Authorization Responses entirely (EMC Contract step). <br>
✅ Must be the first component to support AES256-GCM, ahead of Issuer/Verifier support. <br>
✅ Creates Trust Marks for the Verification flow using Trust Statements provided in the Request Object and the Protected Claims list. <br>
✅ Supports Request Objects that use the scope parameter. <br>
✅ Implements governance restrictions in the verification UI/UX (e.g. AHV blocking for unauthorized Verifiers, warning for unregistered verification requests) <br>
✅ Implements redesigned trust labels and bottom sheets, and removes deprecated labels (Legitimate Verifier, Non-Legitimate Verifier, In Base Registry, Not in System, Unknown) <br>

### Status Registry
⚠️ Reject Status List uploads where exp is missing or already expired. <br>
⚠️ Enforce the Status List JWT header: typ must be statuslist+jwt, and profile_version must be in an extensible allow-list of supported values (e.g. allowed_profile_versions), currently swiss-profile-vc:1.0.0. <br>
⚠️ Validate Status List size: bit-length must be divisible by 8, and decompressed size must be under 200KB. <br>

### Trust Registry 
🆕 Trust Management Service creates all Trust Protocol 2.0 elements and manages Status Lists. <br>
🆕 Trust Registry provides Trust Statements for trust-onboarded DIDs in the new format, and provides Trust List Statements. <br>
🆕 Provides an interface to manage vqPS, usable by Verifiers. <br>

## Migration steps
1. Wallet adds support for AES256-GCM (dual algorithm support), Trust Marks for the verification flow, and the redesigned trust-label UI.
2. Generic Verifier starts enforcing direct_post.jwt, providing Trust Statements in verifier_info, supporting vqPS registration and the scope parameter, and dual AES128/AES256 support.
3. Status Registry enforces Status List validation rules (ttl/exp, header fields, size limits); Verifier applies configurable status-verification failure handling and caching.4. Component operators confirm interoperability via the swiyu conformance test suite.
5. Contract phase: DCQL-only presentation queries, encrypted Authorization Responses, and Signed Presentation Requests become mandatory; non-conforming Verifiers can no longer participate.


## Timeline
xx.xx.2026 Wallet-side support available (DCQL-only, encryption, AES256, Trust Marks) <br>
xx.xx.2026 Generic Verifier enforcement enabled (Enable/Migrate phase) <br>
xx.xx.2026 Contract phase, enforcement mandatory, DIF Presentation Exchange and AES128-GCM support removed <br>