---
title: "New Generic Components and More Details for our Roadmap"
categories:
  - PublicBeta
---

We released two new versions of our generic components and would like to add more details to our roadmap. This announcement complements the new releases we [announced for June 2026](https://swiyu-admin-ch.github.io/publicbeta/release-announcements-june-2026/).

## Generic Issuer [Version 3.2.0](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/3.2.0)
- OID4VCI Credential Format: Newly issued SD-JWT VCs now use typ: dc+sd-jwt
- Configuration: Some defaults have changed with the evolving ecosystem
  -  Enabled signed metadata by default
  -  Require Encryption to be used by default
  -  Require DPoP to be used by default
- Hardened Docker Image  

Please refer to the [changelog](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/CHANGELOG.md) for a complete overview of new features and changes.

We provide a [Migration Guide 3.1 to 3.2](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/3.2.0/migration-guides/guide-3.1.x-to-3.2.x.md) and also as previously announced from [2.4 to 3.0](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/3.2.0/migration-guides/guide-2.4.x-3.0.0.md).

## Generic Verifier [Version 3.0.0](https://github.com/swiyu-admin-ch/swiyu-verifier/releases/tag/3.0.0)
- EMC-Expand for Trust Protocol 2.0
- EMC-Expand: Documentation and examples updated to use dc+sd-jwt as the canonical SD-JWT VC media type
  - The verifier continues to accept vc+sd-jwt on the credential typ header during the migration window
- Renamed the configuration property application.accepted-status-list-hosts to application.accepted-registry-hosts
- Dropped support for unsigned request objects (not supported by Swiss Profiles 1.0 anymore)
- Dropped support for SWIYU-API-Version 1, which was using DIF Presentation Exchange. Now only DCQL can be used for verification as defined in OID4VP 1.0
- Migration to Spring Boot 4.0.6 (Spring Framework 7)

Please refer to the [changelog](https://github.com/swiyu-admin-ch/swiyu-verifier/blob/main/CHANGELOG.md) for a complete overview of new features and changes.

## Roadmap 

The roadmap shows the current plan and is not binding. The dates and contents of new releases will be communicated on this channel as early as possible.

### July 
- Wallets ((Android 1.16 and iOS 1.17)[^1])
  - Remove support for OCA Overlays label
  - Minimal version of Android will be Android 12

### August 
- New Onboarding Flow (later as previously announced)
- Wallets (Android 1.17 and iOS 1.18))[^1]
  - Finalization Swiss Profiles 1.0 (Metadata, configurations)
  - Security Enforcements (Signed Metadata, Payload encryption, Status List)
  - Trust Protocol 2.0

[^1]: The versioning of the upcoming "Sandbox Wallet" is not yet defined.

### Component overview

- Enforce DCQL, Contract DIF presentation: iOS 1.16, Android 1.15, swiyu-verifier 3.0
- Allow SD-JWT to contain structured nested data to selectively disclose a single element of an array: iOS 1.16, Android 1.15, swiyu-verifier 3.0
- Expand-Migrate for [new credential format](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/56): iOS 1.16, Android 1.15, swiyu-issuer 3.2
- Enforcement of JWT-Secured Authorization Request (JAR): iOS 1.16, Android 1.15
- DPoP implementation: iOS 1.16, Android 1.15, swiyu-issuer 3.0
- [Contract OCA overlays](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/61): iOS 1.17, Android 1.16
- Expand-Migrate to Trust Protocol 2.0: iOS 1.18, Android 1.17, swiyu-issuer 3.1, swiyu-verifier 3.0
- Security Enforcements (Signed Metadata, Payload encryption, Status List): iOS 1.18, Android 1.17, swiyu-issuer 3.2
- Finalization Swiss Profiles 1.0 (Metadata, configurations): iOS 1.18, Android 1.17, swiyu-issuer 3.3
- Enforce Key Attestation for Hardware Binding: swiyu-issuer 3.3

