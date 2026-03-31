---
title: "Breaking Change in next Wallet Versions"
categories:
  - PublicBeta
---

With the latest version of the swiyu Generic Issuer, we updated the credential metadata structure and corrected claims paths to align with the latest specification. The "expand" step (as defined in the [EMC-Pattern](https://github.com/swiyu-admin-ch/community/blob/main/tech-concepts/expand-migrate-contract-pattern.md) has been released with the latest wallet versions. All users of the swiyu Generic Issuer must migrate to the latest release (see below) as a matter of urgency to avoid a breaking change. With the release of the next versions of the swiyu wallets - scheduled for early April, only the new structure will be accepted. We apologise for the short notice.

## New Versions for [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet) and [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet) Wallets

Changes in the upcoming versions for Android v1.14.0 and iOS v1.15.0
- Breaking: [Updates in the credential metadata structure](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/290) (refer to this issue for the new implementation)
- Contract step for [Access-Token-Request uses wrong Content-Type](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/12) respectively [Wallet sends token endpoint params as query params](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/9).  

## Generic Issuer [Version 2.4.3](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/2.4.3) 

- Fixed encryption cache invalidation in horizontally scaled deployments
- Security Fix: Enforced mandatory validation of the proof_binding_key against attested_keys using canonical JWK thumbprints
- Updated credential metadata structure and corrected claims paths to align with the latest specification
- Fixed null tenantId handling in issuer metadata retrieval to prevent NullPointerExceptions and formatting issues
- For more details, please refer to the [changelog](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/CHANGELOG.md) 

## DID Toolbox [Version 2.0.0](https://github.com/swiyu-admin-ch/didtoolbox-java/releases/tag/2.0.0)

New Major-Version due to potential breaking changes: 
- Feature: Added controller to verification methods in DID Document
- Breaking change: Removed ``@context`` from DID Document
- Dependency: Requires DID Resolver Version 2.7.0 or newer for DID Log resolving

Please note: This is a "pre-release" and not yet compatible with the swiyu Public Beta Trust Infrastructure

## DID Resolver [Version 2.7.0](https://github.com/swiyu-admin-ch/didresolver/releases/tag/2.7.0)
- Feature: Added support for controller in did document and verification method
- Feature: Loosened schema validation for DID logs
- Field ``@context`` in DID document is now optional
- Added function ``get_did_from_absolute_kid``


