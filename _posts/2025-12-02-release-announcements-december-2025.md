---
title: "New Releases for the swiyu Public Beta Trust Infrastructure"

---

Some components of the swiyu Public Beta Trust Infrastructure got new releases we would like you to inform about.

## swiyu wallet: [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet) Version xy; [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet) Version xy
(last announcement was Android 1.10 and iOs 1.12.1)
- https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/28
?? - https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/12
- https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/14
- https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/9
- https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/22
- https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/29
- https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/48


  
Please note: In an upcoming release we'll proceed the contract step for "wallet must support specified cnf claim format for [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/20) and [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/8).

## [DID Toolbox](https://github.com/swiyu-admin-ch/didtoolbox-java) Version 1.7.0
-
-

Please note: the latest version currently matching the Public Beta Trust Infrastructure is version 1.4.2

## [DID Resolver](https://github.com/swiyu-admin-ch/didresolver) Version xy
- https://github.com/swiyu-admin-ch/didresolver/issues/7


Please note: the latest version currently matching the Public Beta Trust Infrastructure is version 2.1.3

  
## Generic Issuer (Version 2.xy [swiyu-issuer](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/2.xy) repository)
- https://github.com/swiyu-admin-ch/swiyu-issuer/issues/52

We kindly ask you to migrate your components to the latest versions. In order to plan the contract step for "Token endpoint expected x-www-form-urlencoded" we created an [issue](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/112) to collect your feedback. 

Please note: Credentials issued with BCS refer to version XYZ

## Generic Verifier ([swiyu-verifier V2.1.1](https://github.com/swiyu-admin-ch/swiyu-verifier/releases/tag/2.1.1))
?? - https://github.com/swiyu-admin-ch/eidch-verifier-agent-oid4vp/issues/7
- https://github.com/swiyu-admin-ch/swiyu-verifier/issues/109
- https://github.com/swiyu-admin-ch/swiyu-verifier/issues/107
- https://github.com/swiyu-admin-ch/swiyu-verifier/issues/79
- https://github.com/swiyu-admin-ch/swiyu-verifier/issues/88
- https://github.com/swiyu-admin-ch/swiyu-verifier/issues/100

- Updated ApiErrorDto and reused it for every error response. This allows for a more consistent error
  response structure. Possible breaking change could be that the `error_code` will be moved to details
- Added WebhookCallbackDto to openapi config schemas.
- Base functionality for DCQL, allowing using OID4VP v1 style along side legacy DIF PE to query credentials. 
  Verifiable presentations are validated and checked according to DCQL "credentials" query. 
  Currently only single credential submissions are supported. To maintain backwards compatibility with old wallet versions using DIF PE remains mandatory.
- Optional End2End encryption with JWE according to OID4VP 1.0. Default is currently still unencrypted to allow wallets to start supporting it. 
  Usage be chosen on verification request basis with new `response_mode` json attribute.  
- Updated didresolver dependency from 2.1.3 to 2.3.0

Please note: The BCS currently uses version XYZ

### Changed
- Allow both vc+sd-jwt (SD JWT VC Draft 05 and older) dc+sd-jwt (SD JWT VC Draft 06 and newer) for presented VC format

## Updated Cookbooks





We kindly ask you to migrate your components to the latest versions in order to prevent breaking changes in the future.

