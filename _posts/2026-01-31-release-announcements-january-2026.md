---
title: "New Releases for the swiyu Public Beta Trust Infrastructure"
categories:
  - PublicBeta
---

Some components of the swiyu Public Beta Trust Infrastructure got new releases or will get a new version in the next days we would like you to inform about.

## Upcoming: New Versions for [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet) and [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet) Wallets


## DID Resolver [Version 2.6.0](https://github.com/swiyu-admin-ch/didresolver/releases/tag/2.6.0) 

  
## Generic Issuer [Version 2.3.0](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/2.3.0) 
- Fixed: [Issue, when content length not set](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/97)

- For the complete overview, please refer to the [changelog](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/CHANGELOG.md)

Please note: This version is not yet pentested and thus not marked as "latest". The [contract step for "Token endpoint expected x-www-form-urlencoded"](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/112) is in our backlog and will be planned for an upcoming sprint. 

## Generic Verifier [Version 2.2.0](https://github.com/swiyu-admin-ch/swiyu-verifier/releases/tag/2.2.0)
- Breaking! Either accepted_issuer_dids or trust_anchors must contain a value. The list itself cannot be empty, as this would implicate that nothing is trusted. This is to improve security by avoiding misconfigurations that would lead to accepting any issuer.
- Status list resolving does no longer accept http urls for status lists. Only https urls are allowed now.

- Other minor fixes and improvements, as you can read in the [changelog](https://github.com/swiyu-admin-ch/swiyu-verifier/blob/main/CHANGELOG.md)

Please note: This version is not yet pentested and thus not marked as "latest".


