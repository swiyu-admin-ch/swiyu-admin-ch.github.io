---
title: CD-007 - Remove Ed25519VerificationKey
excerpt: Contract phase of the DID verification method key type migration - Ed25519VerificationKey support is removed from the DID Resolver and DID Toolbox; only JsonWebKey remains valid.
header:
  teaser: ../assets/images/none.jpg
---

{% capture notice-text %}

Status: Draft <br>
Published: 14.08.2026 <br>
Effective: xx.12.2026 (December 2026, exact date TBD <br>
Affected Components: DID Resolver, Wallet, Generic Issuer, Generic Verifier, Base Registry, Trust Registry <br>
Internal Reference: EIDARTFE-1951 <br>

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Remove Ed25519VerificationKey</h4>
  {{ notice-text | markdownify }}
</div>

This dossier announces the Contract phase of the verification method key type. As of the effective date, support for `Ed25519VerificationKey` as a verification method format is removed from the DID Resolver and DID Toolbox across all implementations (Java, Kotlin/Android, Swift). This step is only executed once the Migrate phase has fully completed, i.e. once no DID Document in active use across the ecosystem still relies solely on `Ed25519VerificationKey` for authentication. After the effective date, DID Documents that still rely only on `Ed25519VerificationKey` for authentication will no longer resolve or verify. Note that Ed25519 keys as verification method in the JWK format is still supported and was introduced with [DID Toolbox 2.3.0](https://github.com/swiyu-admin-ch/didtoolbox-java/blob/main/CHANGELOG.md#230---2026-07-31).


## Action required

Tag ⚠️ Required soon
Tag 🚨 Breaking
Tag 🆕 Optional
Tag ✅ Improvement
Tag 🐞 Fix


### DID Resolver
🚨 Support for `Ed25519VerificationKey` as a verification method type is removed. The DID Resolver no longer resolves or accepts `Ed25519VerificationKey` as a valid authentication verification method, across all implementations (Java, Kotlin/Android, Swift).

### Generic Issuer
⚠️ Confirm before the effective date that issuance does not depend on any key published only as `Ed25519VerificationKey` in a DID Document. Update to the DID Resolver release that removes `Ed25519VerificationKey` support.

### Generic Verifier
🚨 After the effective date, verification of credentials whose key is published only as `Ed25519VerificationKey` will no longer succeed. Update to the DID Resolver release that removes `Ed25519VerificationKey` support.

### Wallet
⚠️ Ensure DID Documents used by the Wallet no longer rely solely on `Ed25519VerificationKey` for authentication before the effective date. Update to the DID Resolver release that removes `Ed25519VerificationKey` support.

### Base Registry
⚠️ Update to the DID Resolver release that removes `Ed25519VerificationKey` support and confirm no dependency on `Ed25519VerificationKey`-only DID Documents.

### Trust Registry
⚠️ Update to the DID Resolver release that removes `Ed25519VerificationKey` support and confirm no dependency on `Ed25519VerificationKey`-only DID Documents.

## Migration steps
1. Migrate phase completes: all DID Documents in active use have been migrated to JsonWebKey/JsonWebKey2020 (EIDARTFE-1950).
2. Confirmation obtained that no active DID Document in the ecosystem still relies solely on `Ed25519VerificationKey` for authentication.
3. `Ed25519VerificationKey` support is removed from all DID Resolver implementations (Java, Kotlin/Android, Swift).
4. Updated DID Resolvers are deployed and verified in all consuming components: Wallet, Generic Issuer, Generic Verifier, Base Registry, Trust Registry.
5. Contract phase becomes effective: `Ed25519VerificationKey` is no longer resolved or accepted as a valid authentication verification method.

## Timeline
xx.12.2026 - Contract phase effective, `Ed25519VerificationKey` support removed (exact December date to be confirmed).
