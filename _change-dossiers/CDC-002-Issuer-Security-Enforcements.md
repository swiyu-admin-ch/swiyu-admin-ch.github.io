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

This dossier bundles three related Issuer-side changes into a single migration wave. 
1. It enforces the security changes from swiss-profile-issuance 1.0 by enforcing Payload Encryption, and Signed Metadata, all of which are already implemented since version 3.0.0 and set as default.
2. It migrates encryption from AES128-GCM to AES256-GCM; following EMC, all components first accept both algorithms, with the Wallet required to support this ahead of the Issuer and Verifier.
3. It closes the remaining Status List gaps required for the swiyu 1.0 go-live, including ttl/exp handling and Status List validation. During the transition period, non-enforcing behavior continues to be accepted where noted; afterwards, non-compliant Issuers can no longer participate in the ecosystem. 

## Action required

⚠️ Required soon
🚨 Breaking
🆕 Optional
✅ Improvement
🐞 Fix

### Generic Issuer
Version: 4.0.x <br>
1. See: [Releasenotes](https://github.com/swiyu-admin-ch/swiyu-issuer/releases)

The generic Issuer 4.0.x should be deployed as soon wallet 1.17.x is published. <br>
Must be in use until end of Q3 2026. <br>

## Migration steps
1. Migrate to generic Issuer 4.0.x. See [migrations guides](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/migration-guides/guide-3.2.x-to-4.0.x.md)
2. Contract phase: Payload Encryption and signed meta data become mandatory at the swiyu Wallet; non-conforming Issuers can no longer issue credentials to the swiyu Wallet.

## Timeline
17.08.2026:  Wallet-side 1.17.x security enforced (payload encryption, Signed Metadata trust) requires the generic issuer 4.0.x. <br>
