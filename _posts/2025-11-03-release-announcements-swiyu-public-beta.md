
With the latest releases in the different repositories we fixed some issues raised by the community. We also took further steps related to the [Expand-Migrate-Contract](https://github.com/swiyu-admin-ch/community/blob/main/tech-concepts/expand-migrate-contract-pattern.md) pattern to avoid breaking changes. For a more detailled view please refer to the CHANGELOG.md in each repository.

## swiyu wallet: [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet) Version 1.10.0; [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet) Version 1.21.1 
- https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/17 (fixed with Android 1.9.0)
- https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/15 (fixed with Android 1.9.0)
- https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/16
- https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/6

Please note: In the upcoming releases we'll 
- Contract step for "wallet must support specified cnf claim format for [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/20) and [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/8)

## Beta Credential Service (BCS)
- A [health check endpoint](https://bcs.admin.ch/bcs-web/rest/ping) is available; it returns a response code 200 if the BCS is up and running.
- When displaying a verification QR code on a mobile device, a button is displayed to directly open the verification URL in the swiyu app.
- When requesting all attributes during verification, the nationality is now also displayed.
- The BCS currently runs the version 2.0.1 of the swiyu generic issuer & generic verifier and related to it the DID resolver v.XYZ

## [DID Toolbox](https://github.com/swiyu-admin-ch/didtoolbox-java) Version 1.6.0
- Support for DID Web + Verifiable History (did:webvh) - v1.0 introduced, which is now the default DID method when running create command (instead of legacy did:tdw:0.3)
- Fix: Eliminate duplicate parsing https://github.com/swiyu-admin-ch/didtoolbox-java/issues/15
- Improvement: Added support for macOS on Intel x86-64 CPUs
- Integration of DID Resolver xyz
  

## [DID Resolver](https://github.com/swiyu-admin-ch/didresolver) Version 2.3.0

- Fix: Perform strict domain and URL validation https://github.com/swiyu-admin-ch/didresolver/issues/6
- FEATURE: Added support for Key Pre-Rotation for did:webvh.
- FEATURE: Added support for DID Web + Verifiable History (did:webvh:1.0).

## Generic Issuer (Version 2.0.2 on [new repository](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/2.0.2))

- Breaking changes with regard to the deprecated repositories of xyz. For more details, see the full [changelog](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/CHANGELOG.md)
- Upgraded to new DID Resolver Library with 2.0.1 
- Security Fixes:
- ??new features?

## Generic Verifier (Version 2.0.2 on [new repository](https://github.com/swiyu-admin-ch/swiyu-verifier/releases/tag/2.0.2))

- Breaking changes with regard to the deprecated repositories of xyz. For more details, see the full [changelog](https://github.com/swiyu-admin-ch/swiyu-verifier/blob/main/CHANGELOG.md)
- Expand step to handle malformed and correct "cnf" claim 
- Securtiy Fixes:


## Specifications

- Upcoming: Trust Protocol Version 1.0
- [OID4VCI Version 1.0](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0-final.html) has been published. We will plan the updates on our side and will announce the changes as soon as possible.


