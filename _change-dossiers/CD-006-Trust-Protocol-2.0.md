---
title: CD-006 - Trust Protocol 2.0
excerpt: We are introducing Trust Protocol 2.0 and replace the old Trust Protocol 1.0.
header:
  teaser: ../assets/images/none.jpg
---

{% capture notice-text %}

Status: Released <br>
Published: 13.08.2026 <br>
Effective: 17.08.2026 <br>
Affected Components: Generic Issuer, Generic Verifier swiyu Wallet <br>

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Trust Protocol 2.0</h4>
  {{ notice-text | markdownify }}
</div>

The swiyu ecosystem is migrating from Trust Protocol 1.0 (TP1.0) to Trust Protocol 2.0 (TP2.0), following an Expand-Migrate-Contract (EMC) approach. During Expand, TP2.0 is introduced alongside TP1.0 (TP1.0 remains as fallback). During Migrate, all ecosystem participants (Issuers and Verifiers) must switch to TP2.0 only and ensure all DIDs intended for continued use are re-onboarded with TP2.0 trust statements. During Contract, TP1.0 support is removed entirely: the swiyu Wallet will no longer accept TP1.0 trust artefacts, and DIDs that have not been trust-onboarded with TP2.0 will be rejected. Integrators who take no action risk their DIDs, VCs, and endpoints being rejected once the Contract phase begins.


## Action required

Tag ⚠️ Required soon
Tag 🚨 Breaking
Tag 🆕 Optional
Tag ✅ Improvement
Tag 🐞 Fix


### Wallet
⚠️ From 17.08.2026 (Wallet 1.17.x, enforced): TP2.0 support is introduced alongside TP1.0; TP1.0 continues to work as a fallback during the Migrate phase, no action required yet beyond updating to 1.17.x.
🚨 From the Contract phase (Wallet 2.x.x, ~November 2026, exact date TBD): the Wallet will no longer accept TP1.0 trust artefacts. All DIDs consumed by the Wallet must be trust-onboarded with TP2.0 before this date, or they will be rejected.
🚨 From the same milestone pinning environments to PROD for PROD apps and allowing only trusted issuers/verifiers on PROD. As a consequence, a Prod Wallet will no longer work against Sandbox environments.

### Generic Issuer
⚠️ Ecosystem participants must be running Generic Issuer 4.0.0 during the Expand phase (already required as a consequence of [CD-002](https://swiyu-admin-ch.github.io/change-dossiers/CD-002-Issuer-Security-Enforcements/) and [CD-004](https://swiyu-admin-ch.github.io/change-dossiers/CD-004-Verifier-Security-Enforcements/)).
🚨 Upgrade to Generic Issuer 5.0.0 (Migrate phase, ~September 2026, exact date TBD): remove all usage of TP1.0 and old endpoints; switch to TP2.0 only.

### Generic Verifier
⚠️ Ecosystem participants must be running Generic Verifier 4.0.0 during the Expand phase (already required as a consequence of [CD-002](https://swiyu-admin-ch.github.io/change-dossiers/CD-002-Issuer-Security-Enforcements/) and [CD-004](https://swiyu-admin-ch.github.io/change-dossiers/CD-004-Verifier-Security-Enforcements/)).
🚨 Upgrade to Generic Verifier 5.0.0 (Migrate phase, ~September 2026, exact date TBD): remove all usage of TP1.0 and old endpoints; switch to TP2.0 only.

### Ecosystem / Integrators

⚠️ Ensure all DIDs that shall continue to be used obtain new TP2.0 trust statements / onboarding before the deadline for ecosystem migration (~end of October 2026, exact date TBD). DIDs that are not trust-onboarded with TP2.0 will no longer be accepted by the swiyu Wallet.
⚠️ Onboard with a new did:webvh if not already done. Where possible, retire the old DID method entirely; alternatively, re-issue VCs based on the old DID.
🆕 Shift usage and issuance to the Sandbox wallet if not already done, to validate the TP2.0 migration ahead of the Contract phase.

## Migration steps
1. Upgrade to Generic Issuer & Verifier 4.0.0 (Expand phase, already required via CD-002/CD-004).
2. Update Wallet to 1.17 (enforced from 17.08.2026), introduces TP2.0 support alongside TP1.0.
3. Onboard all DIDs intended for continued use with new TP2.0 trust statements.
4. Onboard with a new did:webvh if not already done; retire or re-issue VCs from the old DID where possible.
5. Upgrade to Generic Issuer & Verifier 5.0.0 (Migrate phase): remove all TP1.0 usage and old endpoints, switch to TP2.0 only.
6. Shift usage/issuance to the Sandbox wallet if not already done, to validate readiness.
7. Complete all TP2.0 onboarding before the deadline for ecosystem migration.
8. From the Contract phase: remove all TP1.0 support and old endpoints (Wallet, Registries); TP1.0 trust artefacts are no longer accepted.

## Timeline
2026-08-17	Wallet 1.17 (enforced), TP2.0 support introduced alongside TP1.0; TP1.0 as fallback. Expand phase begins.
2026-09 (TBD)	Generic Issuer & Verifier 5.0.0 available, TP1.0 and old endpoints removed, TP2.0 only. Migrate phase begins.
2026-09 to 2026-10 (TBD)	Ecosystem migrates to Generic Issuer & Verifier 5.0.0; DIDs re-onboarded with TP2.0 trust statements.
2026-10 (TBD)	Deadline for ecosystem migration, all DIDs must be TP2.0 trust-onboarded.
2026-11 (TBD)	Contract phase begins: Wallet 2.0? removes TP1.0 support. Wallet no longer accepts TP1.0 trust artefacts; Prod Wallet no longer works against Sandbox.


[![trust-protocol-2-0-roadmap](/assets/images/trust-protocol-2-0-roadmap.png)](/assets/images/trust-protocol-2-0-roadmap.png)
