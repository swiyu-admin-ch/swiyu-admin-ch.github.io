---
title: "New Releases and repositories for the swiyu Public Beta Trust Infrastructure"
categories:
  - PublicBeta
---

Some components of the swiyu Public Beta Trust Infrastructure got new releases we would like you to inform about. If you are running older versions of the generic issuer or verifier, you have to update these components immediatly. 

In addition, we've published new repositories for testing against generic components and verifiable credentials.

## New Versions for [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet) and [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet) Wallets


Android v1.13.1
- Feature: Payload encription feature toggle
- Fix: do not overwrite claims when parsing jwt https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/24
- Update to OID4VCI 1.0
- Fix: Harden JsonPath validator regex https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/29


iOS v1.14.0
- Feature Flag for Payload encryption
- Feature: Signed Metadata
- Fix: Avoid decompression bomb https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/22
- Fix: Enforce "isBetaIssuer" check https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/28

feature: deferred credential for OIDVCI 1.0 (EIDNUCLEUS-574) (#773) by Sven-Bjarne Seiffert
feature: request and response for OID4VCI 1.0 (EIDNUCLEUS-572) (#769) by Sven-Bjarne Seiffert
feature: nonce and token endpoint according to OID4VCI 1.0 (EIDNUCLEUS-571) (#767) by Sven-Bjarne Seiffert


Contract-step from the wallet with the next release! https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/12 and https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/9 

## DID Toolbox 

(letzte Info: 1.7.0)

## DID Resolver [Version 2.6.0](https://github.com/swiyu-admin-ch/didresolver/releases/tag/2.6.0) 
- Fix: https://github.com/swiyu-admin-ch/didresolver/issues/7 ?
  
## Generic Issuer [Version 2.4.2](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/2.4.2) 
- [contract step for "Token endpoint expected x-www-form-urlencoded"](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/112) 

- Fixed: [Issue, when content length not set](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/97)
- Fixed: [Possibly invalid credentials on bad usage](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/52)
- For the complete overview, please refer to the [changelog](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/CHANGELOG.md)

- Signed Issuer Metadata: https://github.com/swiyu-admin-ch/swiyu-issuer/issues/3
- 

https://confluence.bit.admin.ch/spaces/EIDTEAM/pages/1324352409/7.2.+Generic+Components+Releases


Please note upcoming breaking changes:
- Remove old nonce endpoint
- Remove deprecated OID4VCI Draft 13 endpoints


## Generic Verifier [Version 2.3.0](https://github.com/swiyu-admin-ch/swiyu-verifier/releases/tag/2.3.0)
- Breaking! Either accepted_issuer_dids or trust_anchors must contain a value. The list itself cannot be empty, as this would implicate that nothing is trusted. This is to improve security by avoiding misconfigurations that would lead to accepting any issuer.
- Status list resolving does no longer accept http urls for status lists. Only https urls are allowed now.

https://github.com/swiyu-admin-ch/swiyu-verifier/issues/89 ??
- https://github.com/swiyu-admin-ch/swiyu-verifier/issues/90 ??
- Fix: "Split" function removes empty strings https://github.com/swiyu-admin-ch/swiyu-verifier/issues/90

- Other minor fixes and improvements, as you can read in the [changelog](https://github.com/swiyu-admin-ch/swiyu-verifier/blob/main/CHANGELOG.md)

?? 

Please note: This version is not yet pentested and thus not marked as "latest".

## New Repositories for a better test coverage 

Getting the generic components up and running 

### Generic Application Test
The [Generic Application Test](https://github.com/swiyu-admin-ch/swiyu-generic-application-test) is a test system designed to run end-to-end (E2E) tests against the generic swiyu Issuer and Verifier components. Its primary goal is to validate the generic behavior of these components in isolation, without relying on a full trust infrastructure or real wallets. The system focuses on testing the issuance and verification flows, independently of any specific ecosystem or deployment.

### Test Wallet
The [swiyu Generic Test Wallet](https://github.com/swiyu-admin-ch/swiyu-generic-test-wallet) is a web application that simulates a wallet to test credential issuance and verification flows based on OIDC4VCI and OIDC4VP. It is primarily intended to validate your own deployment of the swiyu Generic Issuer and Verifier components. 




