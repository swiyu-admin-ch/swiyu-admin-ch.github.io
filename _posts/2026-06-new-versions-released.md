---
title: "New Versions Released"
categories:
  - PublicBeta
---

We released new versions of the swiyu Wallets, the Beta Credential Service, and other components.

## New swiyu Wallet Releases Version 1.16.0

With this release, we have aligned the version numbers. This means that we have skipped Android 1.15 and both wallets are now on version 1.16.0. The most important changes are, as previously [announced for June 2026](https://swiyu-admin-ch.github.io/publicbeta/release-announcements-june-2026/): 

- EMC-Expand for new Credential Format
- Enforce DCQL Presentation (DIF presentation exchange is no longer supported)
- EMC-Expand for new DID standard and Swiss Profile Versioning (see below)
- Invalid Credentials can no longer be presented

Both versions are compatible with the swiyu Generic Issuer version 3.1.1. and higher. If you are using the swiyu Generic Issuer version 3.2.x DPoP has to be deactivated manually (APPLICATION_DPOP_ENFORCE: false).

## Beta Credential Service (BCS)

We have deployed a new version of the BCS to Public Beta/Sandbox environment. The most relevant changes are:
- Integration of swyiu Generic Issuer 3.2.4
  - Payload encryption is configured to be mandatory
  - DPoP enforcement is deactivated 
- Integration of swiyu Generic Verifier 3.0.2
  - Response mode for verifications has been changed from "direct_post" to "direct_post.jwt", as a consequence, payload encryption is activated 
- New vct "ch.admin.bcs.betaid" is activated
  
## Generic Issuer [Version 3.2.4](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/3.2.4)




- OID4VCI Credential Format: Newly issued SD-JWT VCs now use typ: dc+sd-jwt
- Configuration: Some defaults have changed with the evolving ecosystem
  -  Enabled signed metadata by default
  -  Require Encryption to be used by default
  -  Require DPoP to be used by default
- Hardened Docker Image  

Please refer to the [changelog](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/CHANGELOG.md) for a complete overview of new features and changes.

We provide a [Migration Guide 3.1 to 3.2](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/3.2.0/migration-guides/guide-3.1.x-to-3.2.x.md) and also as previously announced from [2.4 to 3.0](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/3.2.0/migration-guides/guide-2.4.x-3.0.0.md).

## Component Compatibility Overview

- Enforce DCQL, Contract DIF presentation: iOS 1.16, Android 1.16, swiyu-verifier 3.0
- Allow SD-JWT to contain structured nested data to selectively disclose a single element of an array: iOS 1.16, Android 1.16, swiyu-verifier 3.0
- Expand-Migrate for [new credential format](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/56): iOS 1.16, Android 1.16, swiyu-issuer 3.2
- Enforcement of JWT-Secured Authorization Request (JAR): iOS 1.16, Android 1.16
- DPoP implementation: iOS 1.16, Android 1.16, swiyu-issuer 3.0 (for swiyu-issuer 3.2 and higher, please XXXXXXXXXX) 
- [Contract OCA overlays](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/61): iOS 1.17, Android 1.17
- Expand-Migrate to Trust Protocol 2.0: iOS 1.18, Android 1.18, swiyu-issuer 3.1, swiyu-verifier 3.0
- Security Enforcements (Signed Metadata, Payload encryption, Status List): iOS 1.18, Android 1.18, swiyu-issuer 3.2
- Finalization Swiss Profiles 1.0 (Metadata, configurations): iOS 1.18, Android 1.18, swiyu-issuer 3.3
- Enforce Key Attestation for Hardware Binding: swiyu-issuer 3.3

