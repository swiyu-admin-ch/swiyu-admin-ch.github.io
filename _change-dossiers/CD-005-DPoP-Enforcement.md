---
title: CD-005 - DPoP Enforcement
excerpt: We are introducing DPoP to strengthen the OpenID4VCI flow.
header:
  teaser: ../assets/images/none.jpg
---

{% capture notice-text %}

Status: Released <br>
Published: 05.08.2026 <br>
Effective: 17.08.2026 <br>
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
Generic Issuer from [version 3.2.0.](https://github.com/swiyu-admin-ch/swiyu-issuer/releases) supports enforcing DPoP via configuration. However, newest version 4.x.x. is strongly recommended for security improvements.

## Migration steps
1. Ensure Generic Issuer 3.2.x or higher is deployed.
2. swiyu Wallet enables DPoP with release 1.17.0.
3. Issuer enforces DPoP via configuration.

## Timeline
17.08.2026 - swiyu Wallet enables DPoP with release 1.17.0 on iOS and Android.
