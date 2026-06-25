---
title: "New Versions Released"
categories:
  - PublicBeta
---

We released new versions of the swiyu Wallets, the Beta Credential Service, and the generic components.

## New swiyu Wallet Releases Version 1.16.0

With this release, we have aligned the version numbers. This means that we have skipped Android 1.15 and both wallets are now on version 1.16. The most important changes are, as previously [announced](https://swiyu-admin-ch.github.io/publicbeta/release-announcements-june-2026/): 
- EMC-Expand for new Credential Format "dc+sd-jwt"
- Enforce DCQL Presentation (DIF presentation exchange is no longer supported)
- EMC-Expand for new DID standard and Swiss Profile Versioning 
- Invalid Credentials can no longer be presented

Both versions are compatible with the swiyu Generic Issuer version 3.1.1. and higher. If you are using the **swiyu Generic Issuer version 3.2.x DPoP has to be deactivated manually** (APPLICATION_DPOP_ENFORCE: false).

## Beta Credential Service (BCS)

We have deployed a new version of the BCS to the Public Beta/Sandbox environment. The most relevant changes are:
- Integration of swyiu Generic Issuer 3.2.4
  - Payload encryption is configured to be mandatory
  - DPoP enforcement is **deactivated** 
- Integration of swiyu Generic Verifier 3.0.2
  - Response mode for verifications has been changed from "direct_post" to "direct_post.jwt", as a consequence, payload encryption is activated 
- New vct "ch.admin.bcs.betaid" is activated
  
## swiyu Generic Issuer [Version 3.2.4](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/3.2.4)
- Security fixes and updated dependencies
- For more details, please refer to the [changelog](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/CHANGELOG.md)

We provide a [Migration Guide 3.1 to 3.2](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/3.2.0/migration-guides/guide-3.1.x-to-3.2.x.md) and also as previously announced from [2.4 to 3.0](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/3.2.0/migration-guides/guide-2.4.x-3.0.0.md).

## swiyu Generic Verifier [Version 3.0.3](https://github.com/swiyu-admin-ch/swiyu-verifier/releases/tag/3.0.3)
- Security fixes and updated dependencies
- For more details, please refer to the [changelog](https://github.com/swiyu-admin-ch/swiyu-verifier/blob/main/CHANGELOG.md)

## Test Application and Test Wallet

We provide two test repositories with components to validate the behavior of the swiyu Generic Issuer and swiyu Generic Verifier, without relying on a full trust infrastructure or real wallets.
- The [Generic Application Test](https://github.com/swiyu-admin-ch/swiyu-generic-application-test) is a test system designed to run end-to-end (E2E) tests against the generic swiyu Issuer and Verifier components.
- The [swiyu Generic Test Wallet](https://github.com/swiyu-admin-ch/swiyu-generic-test-wallet) is a web application that simulates a wallet to test credential issuance and verification flows based on OIDC4VCI and OIDC4VP.


## Roadmap

Due to the postponement of the internal trial phase, the roadmap is being revised. We will announce the new dates as soon as possible on this channel.

## Component Compatibility Overview

We adjusted the overview with the updated versioning of the swiyu Android Wallet:
- Enforce DCQL, Contract DIF presentation
  - swiyu Wallet 1.16
  - swiyu Generic Verifier 3.0
- Allow SD-JWT to contain structured nested data to selectively disclose a single element of an array
  - swiyu Wallet 1.16
  - swiyu Generic Verifier 3.0
- Expand-Migrate for [new credential format](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/56)
  - swiyu Wallet 1.16
  - swiyu Generic Issuer 3.2
- Enforcement of JWT-Secured Authorization Request (JAR)
  - swiyu Wallet 1.16
- DPoP implementation
  - swiyu Wallet 1.16
  - swiyu Generic Issuer 3.0 (for versions 3.2 and higher, please note the manual deactivation mentioned above) 
- Contract [OCA overlays](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/61)
  - swiyu Wallet 1.17
- Expand-Migrate to Trust Protocol 2.0
  - swiyu Wallet 1.18
  - swiyu Generic Issuer 3.1
  - swiyu Generic Verifier 3.0
- Security Enforcements (Signed Metadata, Payload encryption, Status List)
  - swiyu Wallet 1.18
  - swiyu Generic Issuer 3.2
- Finalization Swiss Profiles 1.0 (Metadata, configurations)
  - swiyu Wallet 1.18
  - swiyu Generic Issuer 3.3
- Enforce Key Attestation for Hardware Binding
  - swiyu Generic Issuer 3.3

