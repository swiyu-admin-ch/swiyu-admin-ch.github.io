---
title: "Breaking Change in next Wallet Versions"
categories:
  - PublicBeta
---

With the latest version of the swiyu-issuer, we updated the credential metadata structure and corrected claims paths to align with the latest specification. With the release of the next versions of the swiyu wallets, only the new structure will be accepted. We apologize that this change was not proceeded within the earlier announced EMC-Pattern due to changes of plans at short notice.

## New Versions for [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet) and [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet) Wallets

Changes in the upcoming versions for Android v1.14.0 and iOS v1.15.0
- Breaking: [Updates in the credential metadata structure](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/290) (refer to this [issue](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/290) for the new implementation)
- Contract step for [Access-Token-Request uses wrong Content-Type](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/12) respectively [Wallet sends token endpoint params as query params](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/9).  

## Generic Issuer [Version 2.4.3](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/2.4.3) 

- Fixed encryption cache invalidation in horizontally scaled deployments
- Security Fix: Enforced mandatory validation of the proof_binding_key against attested_keys using canonical JWK thumbprints
- Updated credential metadata structure and corrected claims paths to align with the latest specification
- Fixed null tenantId handling in issuer metadata retrieval to prevent NullPointerExceptions and formatting issues
- For more details, please refer to the [changelog](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/CHANGELOG.md) 

 
