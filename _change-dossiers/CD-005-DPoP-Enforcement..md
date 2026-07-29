---
title: CD-005 - DPoP Enforcement
excerpt: Template
header:
  teaser: ../assets/images/none.jpg
---

{% capture notice-text %}

Status: Draft <br>
Published: <br>
Effective: <br>
Affected Components: Generic Issuer, swiyu Wallet <br>

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">DPoP Enforcement</h4>
  {{ notice-text | markdownify }}
</div>

We are introducing DPoP (Demonstrating Proof-of-Possession) to strengthen the OpenID4VCI flow. DPoP ties each access token to a cryptographic key that only the user's swiyu wallet controls. The rollout happens in two steps: first the wallet enables DPoP, then issuers can enforce it via their configuration.


## Action required

Tag ⚠️ Required soon
Tag 🚨 Breaking
Tag 🆕 Optional
Tag ✅ Improvement
Tag 🐞 Fix


### Wallet
1.17.0 DPoP enablement for iOS and Android

### Generic Issuer
Generic Issuer [Version 4.0.0. or higher](https://github.com/swiyu-admin-ch/swiyu-issuer/releases) can enforce the DPOP through configuration

## Migration steps
1. Ensure Generic Issuer 4.0.x or higher is deployed.
2. swiyu Wallet enables DPoP with release 1.17.0.
3. Issuer enforces DPoP via configuration.

## Timeline
17.08.2026 - swiyu Wallet enables DPoP with release 1.17.0 on iOS and Android.
