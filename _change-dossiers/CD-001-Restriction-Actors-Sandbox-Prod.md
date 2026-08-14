---
title: CD-001 - Actors Restriction in Prod and Sandbox environment
excerpt: Affected Components: swiyu Wallet, swiyu Sandbox Wallet, Registry.
header:
  teaser: ../assets/images/none.jpg
---

{% capture notice-text %} 

Status: Released <br>
Published: 14.08.2026 <br>
Effective: End-October (tba) <br>
Affected Components: swiyu Wallet, swiyu Sandbox (Public Beta) registries <br>
Internal Reference: EIDARTFE-1679 <br>

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Governance Enforcement, new Onboarding and re-issuance of VC's</h4>
  {{ notice-text | markdownify }}
</div>

When the swiyu Public Beta was launched, the swiyu Wallet could be used with both the production environment (e.g. for eLDP) and the Public Beta environment. To implement the governance measures, these environments will be strictly separated from mid-September. At the same time, the current public beta environment will be renamed ‘Sandbox’. To ensure that comprehensive testing can continue in the Sandbox environment, a dedicated swiyu Sandbox Wallet has been made available.

## Action required

⚠️ Required soon
🚨 Breaking
🆕 Optional
✅ Improvement
🐞 Fix

Actors, who want to continue their existing use cases in the Sandbox environment must take the following steps: 

- New onboarding with new DID standard to registries (see [cookbook](https://swiyu-admin-ch.github.io/cookbooks/onboarding-base-and-trust-registry/))
  - We recommend to also migrate to [Trust Protocol 2.0](https://swiyu-admin-ch.github.io/change-dossiers/CD-006-Trust-Protocol-2.0/) in this step
- Installation of swiyu Sandbox Wallet for [iOS](https://apps.apple.com/us/app/swiyu-sandbox-wallet/id6771296857) and [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet/releases)
- Re-issuance of VC's into swiyu Sandbox Wallet
- All existing Public Beta VC's in the swiyu Wallet will be deleted from our side!

### swiyu Wallet 

- 🚨 With the enforcement of the governance measures the swiyu Wallet only can interact with the productive environment 
- 🚨 Existing non-prod credentials in the swiyu Wallet will be deleted

### swiyu Sandbox Wallet 

- ⚠️ Actors need to re-onboard the swiyu Base & Trust Registry
- ⚠️ Credentials need to be re-issued to the swiyu Sandbox Wallet
- 🚨 We are restricting the Sandbox Wallet to our Sandbox environment. Thus, it will no longer be possible to host one’s DID on a private registry.

### DID Toolbox and DID Resolver

- To be conform with Swiss Profiles Version 1.0 new DIDs must use DID::webvh as standard
- Use the DID Toolbox Version 2.1.0 or higher
- Use the DID Resolver Version 2.8.0 or higher

## Migration steps

There is no migration path. A new onboarding and re-issuance of VC's is necessary.

## Timeline

[![actors-restriction-roadmap](/assets/images/trust-protocol-2-0-roadmap_v2.png)](/assets/images/trust-protocol-2-0-roadmap_v2.png)

- 19.08.2026 Swiyu Sandbox Wallet with expand for TP2.0 is available 
- 08.07.2026 New Sandbox onboarding flow is published
- 27.05.2026 DID Tools are available
- End-October (tba): existing credentials in swiyu Wallet will be deleted
- End-October (tba): swiyu Wallet will be restricted to prod environment




