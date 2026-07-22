---
title: CD-004 - Generic Verifier - Security Enforcement, AES256 Migration & Status List Gap Closure
excerpt: Affected Components Generic Verifier, swiyu Wallet
header:
  teaser: ../assets/images/none.jpg
---


{% capture notice-text %}

Status: Released <br>
Published: 22.07.2026 <br>
Effective: 17.08.2026 <br>
Affected Components: Generic Verifier, swiyu Wallet <br>
Internal Reference: EIDARTFE-1531, EIDARTFE-1564, EIDARTFE-1717, EIDARTFE-1726 <br>

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Security Enforcement, AES256 Migration & Status List Gap Closure</h4>
  {{ notice-text | markdownify }}
</div>

This dossier bundles three related Verifier-side changes into a single migration wave. 
1. It closes the remaining security-enforcement gaps in OpenID for Verifiable Presentations (OID4VP) by enforcing encrypted Authorization Responses (direct_post.jwt), DCQL-only presentation queries, and Signed Presentation Requests, all of which are already implemented but currently only optionally supported under the EMC (Expand-Migrate-Contract) pattern.
2. It migrates encryption from AES128-GCM to AES256-GCM; following EMC, all components first accept both algorithms, with the Wallet required to support this ahead of the Issuer and Verifier.
3. It closes the remaining Status List gaps required for the swiyu 1.0 go-live, including status-verification configurability and caching. During the transition period, non-enforcing behavior continues to be accepted where noted; afterwards, non-compliant Verifiers can no longer participate in the ecosystem.


## Action required

⚠️ Required soon
🚨 Breaking
🆕 Optional
✅ Improvement
🐞 Fix

### Generic Verifier
Version 4.0.x <br>
1. See: [Release notes](https://github.com/swiyu-admin-ch/swiyu-verifier/releases)

## Migration steps
1. Migrate to generic Verifier 4.0.x. See [migrations guides](https://github.com/swiyu-admin-ch/swiyu-verifier/blob/main/migration-guides/v3.0.x-to-v4.0.x.md)
2. Contract phase: Payload Encryption and signed meta data become mandatory at the swiyu Wallet; non-conforming Verifier can no longer verify credentials from a swiyu Wallet.

## Timeline
17.08.2026 Wallet-side 1.17.x security enforced (payload encryption) requires the generic Verifier 4.0.x.
