---
title: CD-007 - Remove Ed25519VerificationKey
excerpt: Remove Ed25519VerificationKey
header:
  teaser: ../assets/images/none.jpg
---

{% capture notice-text %}

Status: Draft <br>
Published: <br>
Effective: <br>
Affected Components: DID Resolver, Wallet, Generic Issuer, Generic Verifier <br>
Internal Reference: EIDARTFE-1951 <br>

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Remove Ed25519VerificationKey</h4>
  {{ notice-text | markdownify }}
</div>

As part of the Contract phase the support for `Ed25519VerificationKey` as a verification method type will be removed from the DID Resolver across the swiyu ecosystem. JsonWebKey2020 and JsonWebKey are now supported ecosystem-wide, and `Ed25519VerificationKey` is no longer needed as a parallel representation. From the effective date, DID Documents that still rely solely on `Ed25519VerificationKey` for authentication will no longer resolve correctly.

## Action required

⚠️ Required soon
🚨 Breaking
🆕 Optional
✅ Improvement
🐞 Fix

### DID Resolver
Version: x.x.x <br>
🚨 `Ed25519VerificationKey` will be removed as a supported verification method type. Update to the DID Resolver version (Java, Kotlin Android, Swift) that supports only JsonWebKey2020 and JsonWebKey.

### Generic Issuer
Version: x.x.x <br>
🚨 Confirm that issuance does not depend on any DID Document using `Ed25519VerificationKey`.

### Generic Verifier
Version: x.x.x <br>
🚨 Verification of DID Documents using `Ed25519VerificationKey` will no longer succeed afterward.

### Wallet
Version: x.x.x <br>
🚨 Update the DID Resolver dependency before the effective date.

## Migration steps
1.	Update the DID Resolver dependency to the version that no longer supports `Ed25519VerificationKey`.
2.	Check existing DID Documents across the ecosystem (Base Registry, Trust Registry, Wallet) for any verification method still referencing `Ed25519VerificationKey`.
3.	Migrate any DID Documents found still using `Ed25519VerificationKey` to JsonWebKey2020/JsonWebKey before the effective date.

## Timeline
End of November 2026	`Ed25519VerificationKey` support removed (Effective)
