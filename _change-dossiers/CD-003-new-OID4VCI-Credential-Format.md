---
title: CD-003 - New OID4VCI Credential Format dc+sd-jwt
excerpt: Required steps and timeline for the migration from vc+sd-jwt to dc+sd-jwt 
header:
  teaser: ../assets/images/none.jpg
---

{% capture notice-text %}

Status: Draft <br>
Published: <br>
Effective: <br>
Affected Components: <br>

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">OID4VCI credential format media type</h4>
  {{ notice-text | markdownify }}
</div>

This dossier completes the migration of the OID4VCI credential format media type from vc+sd-jwt to dc+sd-jwt, following the IETF renaming of the SD-JWT VC media type. The Expand and Migrate phases of this change have already been completed, meaning both the generic Issuer and the swiyu Wallet have accepted and processed both media types in parallel. This dossier executes the Contract phase: on the effective date, support for the legacy vc+sd-jwt media type is removed entirely, and only dc+sd-jwt is accepted.

## Action required

### DID Resolver

Tag ⚠️ Required soon
Tag 🚨 Breaking
Tag 🆕 Optional
Tag ✅ Improvement
Tag 🐞 Fix

### Generic Issuer
🚨 Generic Issuer 4.0.x must be deployed before 17.08.2026. From this date, the Generic Issuer no longer issues credentials using the vc+sd-jwt media type; only dc+sd-jwt is emitted.

### Wallet
🚨 swiyu Wallet 1.17.x must be deployed before 17.08.2026. From this date, the Wallet no longer accepts or processes credentials using the vc+sd-jwt media type; only dc+sd-jwt is supported.

## Migration steps
1. Deploy swiyu Wallet 1.17.x (dual-format support already in place from Expand/Migrate phases).
2. Deploy generic Issuer 4.0.x (dual-format support already in place from Expand/Migrate phases).
3. Contract phase: on 17.08.2026, support for vc+sd-jwt is removed; only dc+sd-jwt remains valid.

## Timeline
17.08.2026	Hard cutover vc+sd-jwt support removed across Generic Issuer and swiyu Wallet; dc+sd-jwt only.
