---
title: CDC-004 - Generic Verifier - Security Enforcement, AES256 Migration & Status List Gap Closure
excerpt: Affected Components Generic Verifier, swiyu Wallet
header:
  teaser: ../assets/images/none.jpg
---


{% capture notice-text %}

Status: Draft <br>
Published: <br>
Effective: <br>
Affected Components: Generic Verifier, swiyu Wallet <br>
Internal Reference: EIDARTFE-1531, EIDARTFE-1564, EIDARTFE-1717, EIDARTFE-1726 <br>

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Security Enforcement, AES256 Migration & Status List Gap Closure</h4>
  {{ notice-text | markdownify }}
</div>

This dossier bundles four related Verifier-side changes into a single migration wave. First, it closes the remaining security-enforcement gaps in OpenID for Verifiable Presentations (OID4VP) by enforcing encrypted Authorization Responses (direct_post.jwt), DCQL-only presentation queries, and Signed Presentation Requests, all of which are already implemented but currently only optionally supported under the EMC (Expand-Migrate-Contract) pattern. Second, it migrates encryption from AES128-GCM to AES256-GCM; following EMC, all components first accept both algorithms, with the Wallet required to support this ahead of the Issuer and Verifier. Third, it introduces the Verifier's role in Trust Protocol 2.0, including Trust Statements, vqPS registration, and piTLS as an alternative Trust Source. Fourth, it closes the remaining Status List gaps required for the swiyu 1.0 go-live, including status-verification configurability and caching. During the transition period, non-enforcing behavior continues to be accepted where noted; afterwards, non-compliant Verifiers can no longer participate in the ecosystem.


## Action required
Update the componets like follows.

⚠️ Required soon
🚨 Breaking
🆕 Optional
✅ Improvement
🐞 Fix

### Generic Verifier
Version 4.0.0 <br>
⚠️ Allow the Business Verifier to configure to what degree a failed status verification is accepted before rejecting a VC. <br>
⚠️ Cache Status List Tokens according to their ttl/exp claims. <br>
⚠️ Reject the Referenced Token if Status List validation fails, except where explicitly configured to accept an unknown status (e.g. age verification). <br>
🚨 Always send response_mode=direct_post.jwt so Authorization Responses are encrypted. <br>
🚨 Send DCQL only in the Presentation Request, dropping DIF Presentation Exchange support (Contract phase, after Wallet enforcement). <br>
🚨 Remove support for unencrypted (direct_post) Authorization Responses entirely (EMC Contract step). <br>
🚨 Reject unsigned Presentation Requests the aud claim must reference a signed Request Object (Signed Presentation Requests enforced). <br>

## Migration steps
1. Issuer can migrate to generic issuer 4.0.0.
2. Contract phase: Payload Encryption and signed meta data become mandatory at the swiyu Wallet; non-conforming Issuers can no longer issue credentials to the swiyu Wallet.

## Timeline
17.08.2026 Wallet-side 1.17 security enforced (payload encryption) requires the generic issuer 4.0.0.
