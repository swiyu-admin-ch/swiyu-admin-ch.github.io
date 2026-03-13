---
title: "New Releases and repositories for the swiyu Public Beta Trust Infrastructure"
categories:
  - PublicBeta
---

Some components of the swiyu Public Beta Trust Infrastructure got new releases we would like you to inform about. If you are running older versions of the generic issuer or verifier, you have to update these components immediatly. In addition, we've published new repositories for testing your deployments as well as credential issuance and verification flows.

## New Versions for [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet) and [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet) Wallets

With the latest versions Android v1.13.1 and iOS v1.14.0 we've fixed some issues that have been raised by the community:
- Android: [Do not overwrite claims when parsing jwt](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/24)
- Android: [Implement Whitelist for supported Hash Algorithms](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/36)
- iOS: [Enforce "isBetaIssuer" check](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/28)

With the next wallet releases, we'll proceed the contract-step for the issues [Access-Token-Request uses wrong Content-Type](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/12) respectively [Wallet sends token endpoint params as query params](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/9).  

## Generic Issuer [Version 2.4.2](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/2.4.2) 
- Contract step for [Token endpoint expected x-www-form-urlencoded](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/112)
- Contract change: Removed c_nonce from OAuthTokenDto the nonce can be retrieved from the nonce endpoint. The nonce column from credential_offer table is also removed.
- Feature: [Signed Issuer Metadata](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/3)
- Fixed: [Issue, when content length not set](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/97)
- Fixed: [Possibly invalid credentials on bad usage](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/52)
- A lot of new endpoints, fixes, and changes - please refer to the [changelog](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/CHANGELOG.md) 

## Generic Verifier [Version 2.3.1](https://github.com/swiyu-admin-ch/swiyu-verifier/releases/tag/2.3.1)
- Breaking change introduced with version 2.2.0: Either accepted_issuer_dids or trust_anchors must contain a value. The list itself cannot be empty, as this would implicate that nothing is trusted. This is to improve security by avoiding misconfigurations that would lead to accepting any issuer.
- Status list resolving does no longer accept http urls for status lists. Only https urls are allowed now.
- Feature: [Payload encryption during verification flow](https://github.com/swiyu-admin-ch/swiyu-verifier/issues/1)
- Fix: ["Split" function removes empty strings](https://github.com/swiyu-admin-ch/swiyu-verifier/issues/90)
- Fix: [Bad error handling if vp_formats is missing in verifier_metadata](https://github.com/swiyu-admin-ch/swiyu-verifier/issues/87)
- Several changes and fixes - for the complete overview, please refer to the [changelog](https://github.com/swiyu-admin-ch/swiyu-verifier/blob/main/CHANGELOG.md)

## DID Toolbox [Version 1.9.0](https://github.com/swiyu-admin-ch/didtoolbox-java/releases/tag/1.9.0)
- Feature: The DID Toolbox Java API enhanced - supplying [verification material](https://www.w3.org/TR/did-1.0/#verification-material) for [verification methods](https://www.w3.org/TR/did-1.0/#verification-methods) (of a DID Document) unambiguously (no default values) using new and more potent fluent methods `assertionMethods`/`authentications` (for `DidLog[Creator\|Updater]Context` classes). Deprecations introduced accordingly.
- Feature: Changed [Proof-of-Possession (PoP)](https://www.rfc-editor.org/rfc/rfc7800.html) creation to include a resolvable `kid` in the JWT header.     

## DID Resolver [Version 2.6.0](https://github.com/swiyu-admin-ch/didresolver/releases/tag/2.6.0) 
- Fix: [Potential problems in "replaceAll"](https://github.com/swiyu-admin-ch/didresolver/issues/7)
- Feature: Further UniFFI language bindings added

## New Repositories for a better test coverage 

To better support the implementation of our generic components and the validation of your own deployments we've released two new repositories. We hope these are helpful to our community and we look forward to hearing your feedback.

### Generic Application Test
The [Generic Application Test](https://github.com/swiyu-admin-ch/swiyu-generic-application-test) is a test system designed to run end-to-end (E2E) tests against the generic swiyu Issuer and Verifier components. Its primary goal is to validate the generic behavior of these components in isolation, without relying on a full trust infrastructure or real wallets. The system focuses on testing the issuance and verification flows, independently of any specific ecosystem or deployment.

### Test Wallet
The [swiyu Generic Test Wallet](https://github.com/swiyu-admin-ch/swiyu-generic-test-wallet) is a web application that simulates a wallet to test credential issuance and verification flows based on OIDC4VCI and OIDC4VP. It is primarily intended to validate your own deployment of the swiyu Generic Issuer and Verifier components. 

