---
title: "New Releases for the swiyu Public Beta Trust Infrastructure"

---

## swiyu wallet: [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet) Version xy; [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet) Version xy

  
Please note: In an upcoming release we'll proceed the contract step for "wallet must support specified cnf claim format for [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/20) and [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/8).

## [DID Toolbox](https://github.com/swiyu-admin-ch/didtoolbox-java) Version xy

## [DID Resolver](https://github.com/swiyu-admin-ch/didresolver) Version xy
  
## Generic Issuer (Version 2.xy [swiyu-issuer](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/2.xy) repository)

We kindly ask you to migrate your components to the latest versions. In order to plan the contract step for "Token endpoint expected x-www-form-urlencoded" we created an [issue](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/112) to collect your feedback. 

## Generic Verifier ([swiyu-verifier V2.1.1](https://github.com/swiyu-admin-ch/swiyu-verifier/releases/tag/2.1.1))



- Updated ApiErrorDto and reused it for every error response. This allows for a more consistent error
  response structure. Possible breaking change could be that the `error_code` will be moved to details
- Added WebhookCallbackDto to openapi config schemas.
- Base functionality for DCQL, allowing using OID4VP v1 style along side legacy DIF PE to query credentials. 
  Verifiable presentations are validated and checked according to DCQL "credentials" query. 
  Currently only single credential submissions are supported. To maintain backwards compatibility with old wallet versions using DIF PE remains mandatory.
- Optional End2End encryption with JWE according to OID4VP 1.0. Default is currently still unencrypted to allow wallets to start supporting it. 
  Usage be chosen on verification request basis with new `response_mode` json attribute.  
- Updated didresolver dependency from 2.1.3 to 2.3.0


### Changed
- Allow both vc+sd-jwt (SD JWT VC Draft 05 and older) dc+sd-jwt (SD JWT VC Draft 06 and newer) for presented VC format 




We kindly ask you to migrate your components to the latest versions in order to prevent breaking changes in the future.

