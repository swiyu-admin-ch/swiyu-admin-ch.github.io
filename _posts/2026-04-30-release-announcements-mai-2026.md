---
title: "Release Announcement for May 2026"
categories:
  - PublicBeta
---

A new version of the [Beta Credential Service](https://bcs.admin.ch/bcs-web/#/) (BCS) is expected to be installed in the first week of May. This new version includes the next steps in the development of ‘Swiss Profile 1.0’.
This release requires the upcoming swiyu Wallet versions iOS 1.15.0 and Android 1.14.0 and is not backwards compatible with older versions of the swiyu Wallet. **To avoid breaking changes, we ask the community to migrate to the latest components.** 

As various adjustments to the infrastructure will also be made during the installation of the new release, the Beta Credential Service will only be available to a limited extent on that day. We will announce the date in the [System Status channel](https://github.com/orgs/swiyu-admin-ch/discussions/12) page.

## Release Notes BCS:

- New vct metadata claims: (vct_version, vct_metadata_uri, vct_metadata_uri#integrity)
- Issuer metadata extended to include a new element ‘credential_metadata’, which contains the information ‘display‘ and ‘claims’ (more details [here](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/290)) 
- Major upgrade to [swiyu-issuer 3.0.3](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/3.0.3)
  - for more details, please refer to the notes about the swiyu Generic Issuer below  
- Minor upgrade to [swiyu-verifier 2.3.3](https://github.com/swiyu-admin-ch/swiyu-verifier/releases/tag/2.3.3)
- Optional payload encryption during issuance

Please note our prior [announcement](https://swiyu-admin-ch.github.io/publicbeta/breaking-changes-in-next-wallet-versions/) about the potential breaking change with the next wallet releases. You'll find more details about the changes in the [changelog](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/CHANGELOG.md).

## swiyu Generic Issuer Version 3.0.3

New major release for the swiyu Generic Issuer for the implementation of the OID4VCI specifications. 
- Contract Steps (potentially breaking changes):
  - Removed c_nonce from OAuthTokenDto the nonce can be retrieved from the nonce endpoint.
    - [The nonce column from credential_offer table is also removed.](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/322)
  - [Removed Deprecated OID4VCI Draft 13 Endpoints](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/323)
  - Removed support for did:jwk, as it is not part of the swiss-profiles anymore
- Use OID4VCI 1.0 compliant error codes for credential_endpoint and deferred_credential_endpoint error responses.
- Validation uses now the credential_metadata.claims as default for the validation and the claims as fallback amd don't check surplus.
- Contracted cnf to now only provide the correct shape as defined in RFC 7800.
- When not providing any key attestation provider, no key attestations are accepted instead of all.
- For further fixes and new functions please refer to the [changelog](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/CHANGELOG.md).

We provide a [migration guide](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/migration-guides/guide-2.4.x-3.0.0.md) for the upgrade from version 2.4.x to 3.0.x.

## New Specifications (available as draft)

We have updated our specifications e.g. with reference to the Versions 1.0 from OID4VCI and OID4VP, our Trust Protocol 2.0, and OCA 1.0. In order to better distinguish the different standards and versions, the initial "Interoperability Profile" has been divided into different new Swiss Profiles:

- [Swiss Profile Anchor](https://swiyu-admin-ch.github.io/specifications/swiss-profile-anchor)
- [Swiss Profile VC](https://swiyu-admin-ch.github.io/specifications/swiss-profile-vc)
- [Swiss Profile Trust](https://swiyu-admin-ch.github.io/specifications/swiss-profile-trust)
- [Swiss Profile Issuance](https://swiyu-admin-ch.github.io/specifications/swiss-profile-issuance)
- [Swiss Profile Verification](https://swiyu-admin-ch.github.io/specifications/swiss-profile-verification)
- [Swiss Profile Proximity](https://swiyu-admin-ch.github.io/specifications/swiss-profile-proximity)

We recommend to read the introductions for the new [Swiss-Profiles](https://swiyu-admin-ch.github.io/specifications/introduction/) and the new [trust artefacts].

These specifications are a first draft, which we wanted to publish at an early stage. Once the versions are finalised, we will outline the next steps in the roadmap and announce them in this channel.

The information is also available in German on [GitHub]().
