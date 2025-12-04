---
title: "New Releases for the swiyu Public Beta Trust Infrastructure"
categories:
  - PublicBeta
---

Some components of the swiyu Public Beta Trust Infrastructure got new releases or will get a new version in the next days we would like you to inform about.

## Upcoming: New versions for [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet) and [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet) wallets: 
- Expand step for Android wallet to [allow "jwk" in "cryptographic_binding_methods_supported"](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/50)
- Contract step for iOS wallet to [remove support for malformed "cnf" claim](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/8)
- Feature: [Activity List in swiyu wallets](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/15)
- Feature: [Issuer and verifier trust statement visualization](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/21)
- Fix: [Mark issuer & verifier as unknown](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/28)
- Fix: [Wallet fails on unsupported signing algorithms on issuer metadata](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/14)
- Fix: [Checked checkbox in darkmode no contrast](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/48)

## [DID Toolbox](https://github.com/swiyu-admin-ch/didtoolbox-java) Version 1.7.0
- Support for the post-quantum safe technique called Key Rotation with Pre-Rotation introduced. More details in [changelog](https://github.com/swiyu-admin-ch/didtoolbox-java/blob/main/CHANGELOG.md)
- Minor fixes and refactoring, for details see [all recent changes](https://github.com/swiyu-admin-ch/didtoolbox-java/compare/1.6.0...1.7.0) 

Please note: New versions marked as "pre-release" may be not in-sync with the Public Beta environment. 

## [DID Resolver](https://github.com/swiyu-admin-ch/didresolver) Version 2.4.0
- Fixed: ["replaceAll" has problems with potentially occurring $ and \ ](https://github.com/swiyu-admin-ch/didresolver/issues/7)
- Feature: Large scale workspace-based refactoring (further did_* crates added) to enable build automation
- Feature: New UniFFI-compliant method added: DidDoc::to_json(&self) 
  
## Generic Issuer [swiyu-issuer version 2.2.0](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/2.2.0) 
- Fixed: [Possibly invalid credentials on bad usage](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/52)
- Expand: Credential endpoint.....
- Other minor fixes and improvements as mentioned in the [changelog](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/CHANGELOG.md)

Please note: This version is not yet pentested and thus not marked as "latest". The [contract step for "Token endpoint expected x-www-form-urlencoded"](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/112) is in our backlog and will be planned for an upcoming sprint. 

## Generic Verifier [swiyu-verifier version 2.1.1](https://github.com/swiyu-admin-ch/swiyu-verifier/releases/tag/2.1.1)
- Fixed: [Validation of the "aud" claim in the holder binding jwt](https://github.com/swiyu-admin-ch/eidch-verifier-agent-oid4vp/issues/7)
- Fixed: [Add verification, if issuer is legitimate](https://github.com/swiyu-admin-ch/swiyu-verifier/issues/109)
- Fixed: [Only allow https status list requests](https://github.com/swiyu-admin-ch/swiyu-verifier/issues/107)
- Fixed: [configuration_override field causes DataIntegrityViolationException](https://github.com/swiyu-admin-ch/swiyu-verifier/issues/88)
- Fixed: [Secure by Default: accepted_issuer_dids](https://github.com/swiyu-admin-ch/swiyu-verifier/issues/100)
- Base functionality for DCQL, allowing using OID4VP v1 style alongside legacy DIF PE to query credentials. 
- Optional End2End encryption with JWE according to OID4VP 1.0. Default is currently still unencrypted to allow wallets to start supporting it.
- Allow both vc+sd-jwt (SD JWT VC Draft 05 and older) dc+sd-jwt (SD JWT VC Draft 06 and newer) for presented VC format
- Other minor fixes and improvements, as you can read in the [changelog](https://github.com/swiyu-admin-ch/swiyu-verifier/blob/main/CHANGELOG.md)

Please note: This version is not yet pentested and thus not marked as "latest".

## Updated Cookbooks
- [Getting started with the swiyu Generic Issuer](https://swiyu-admin-ch.github.io/cookbooks/onboarding-generic-issuer/) has been updated to match the new swiyu-issuer repository
- [Getting started with the swiyu Generic Verifier](https://swiyu-admin-ch.github.io/cookbooks/onboarding-generic-verifier/) has been updated to match the new swiyu-verifier repository

Thanky you all for your patience during the migration phase of the Generic Issuer- and Verifier-repositories and your constructive feedback how we might [improve the developer experience](https://github.com/swiyu-admin-ch/swiyu-verifier/issues/79). It's also great to see how the community engages and how you help each other. 


