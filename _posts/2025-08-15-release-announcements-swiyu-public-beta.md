---
title: Release announcements swiyu Public Beta August 2025
---

With the upcoming releases in the different repositories we will fix some issues raised by the community and deliver also features from the initial gaps of the swiyu Public Beta Trust Infrastructure.  We also announce first steps related to the [Expand-Migrate-Contract](https://github.com/swiyu-admin-ch/community/blob/main/tech-concepts/expand-migrate-contract-pattern.md) pattern to avoid breaking changes. For a more detailled view please refer to the CHANGELOG.md in each repository.

## swiyu wallet: [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet) Version 1.7.3; [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet) Version 1.8.1 

- Expand step for "send client_id in aud claim of holder binding jwt for a presentation response" for [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/19) and [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/6) 
- Expand step for "wallet must support specified cnf claim format for [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/20) and [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/8)
- Remove "format" property in credential response for [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/16)
- Feature: [Issuer and verifier trust statement support and visualization](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/21) in the Android wallet 
- Feature: [Online e-ID issuing process](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/18) (Implemented, but not yet activated)
- Feature: [Software-based device binding](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/20)
- Fix: [Harden JsonPath validator regex](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/29)
- Fix: [Avoid decompression bomb when parsing Status List](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/22)

## [DID Toolbox](https://github.com/swiyu-admin-ch/didtoolbox-java) Version 1.5.0

- Feature: [Proof-of-possession helper](https://github.com/swiyu-admin-ch/didtoolbox-java/issues/12)
- Improvement: Enforcement of the swiyu specific DID log/doc conformity
- Improvement: Added support for macOS on Intel x86-64 CPUs
- Improvement: [Input validation of CLI parameters](https://github.com/swiyu-admin-ch/didtoolbox-java/issues/18)
- Fix: [Storing/exporting generated private keys into files with restricted access](https://github.com/swiyu-admin-ch/didtoolbox-java/issues/17)
- Integration of DID Resolver 2.1.3
- Backward compatibility with older versions of DID Toolbox

## [DID Resolver](https://github.com/swiyu-admin-ch/didresolver) Version 2.1.3

- Improvement: [Support for the x86_64 architecture](https://github.com/swiyu-admin-ch/didresolver/issues/2)

## Generic Issuer & Generic Verifier

We put together the management- and signer-service on the issuer side (resulting in a new repository "swiyu-issuer") as well as the management- and validator-service on the verifier side (resulting in a new repository "swiyu-verifier"). The cookbooks will be adjusted accordingly. The existing issues on the deprecated components will be moved to the new repositories.

### Generic Issuer (Version 1.0 on [new repository](https://github.com/swiyu-admin-ch/swiyu-issuer))

- Expand step for [Access-Token-Request" with wrong Content-Type](https://github.com/swiyu-admin-ch/eidch-issuer-agent-oid4vci/issues/4)
- Expand step for [providing openid metadata also under correct "/.well-known/oauth-authorization-server"](https://github.com/swiyu-admin-ch/eidch-issuer-agent-oid4vci/issues/5)
- Feature: [Client and key attestation to ensure HW binding](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/6)
- Fix: [Issuer metadata property "cryptographic_binding_methods" is incorrect](https://github.com/swiyu-admin-ch/eidch-issuer-agent-oid4vci/issues/2)
- Fix: [Malformed "cnf" claim in issued SD-JWT VCs](https://github.com/swiyu-admin-ch/eidch-issuer-agent-oid4vci/issues/3)
- Fix: [Block disallowed disclosures](https://github.com/swiyu-admin-ch/eidch-issuer-agent-management/issues/9)

### Generic Verifier (Version 1.0 on [new repository](https://github.com/swiyu-admin-ch/swiyu-verifier))

- Expand step to handle malformed and correct "cnf" claim 
- Fix: [Verifier_did used instead client_id in sample.compose.yml](https://github.com/swiyu-admin-ch/eidch-verifier-agent-management/issues/3)
- Fix: [Two config vars with different names but same meaning/content](https://github.com/swiyu-admin-ch/eidch-verifier-agent-management/issues/5)
- Fix: ["Client_metadata" does not contain required "vp_formats" property](https://github.com/swiyu-admin-ch/eidch-verifier-agent-oid4vp/issues/6)
- Fix: [Missing error handling when parsing status list at verifier](https://github.com/swiyu-admin-ch/eidch-verifier-agent-oid4vp/issues/13)
- Fix: [Possible compression bomb attack](https://github.com/swiyu-admin-ch/eidch-verifier-agent-oid4vp/issues/3)
- Fix: [Provide request_uri functionality as described in Swiss Profile](https://github.com/swiyu-admin-ch/eidch-verifier-agent-oid4vp/issues/2)

## Specifications

- Upcoming: Trust Protocol Version 1.0
- [OID4VP Version 1.0](https://openid.net/specs/openid-4-verifiable-presentations-1_0-final.html) has been published. We will plan the updates on our side and will announce the changes as soon as possible.
