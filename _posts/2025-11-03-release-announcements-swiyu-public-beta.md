
We would like to give an update about the latest releases in the different repositories. Since our first announcement we fixed some issues raised by the community as well as security findings from internal pentests. We also took further steps related to the [Expand-Migrate-Contract](https://github.com/swiyu-admin-ch/community/blob/main/tech-concepts/expand-migrate-contract-pattern.md) pattern to avoid breaking changes. For a more detailed view please refer to the CHANGELOG in each repository.

## swiyu wallet: [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet) Version 1.10.0; [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet) Version 1.21.1

- Expand step for ["vct" property in credential request](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/10) (iOS)  
- Fix: [Credential offer URL decoded twice](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/17)
- Fix: [Wallet expects non-standard format property in credential response](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/16)
- Fix: [Holder binding jwt has a random aud](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/6)
- Feature: [Issuer Metadata not from Trust Registry](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/15)
  
Please note: In an upcoming release we'll proceed the contract step for "wallet must support specified cnf claim format for [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/20) and [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/8).

## Beta Credential Service [(BCS)](https://www.bcs.admin.ch/bcs-web/#/)
- A [health check endpoint](https://bcs.admin.ch/bcs-web/rest/ping) is available; it returns a response code 200 if the BCS is up and running
- When displaying a verification QR code on a mobile device, a button is displayed to directly open the verification URL in the swiyu app
- When requesting all attributes during verification, the nationality is now also displayed
- The BCS currently runs the version 2.0.1 of the [swiyu generic issuer](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/2.0.1) & [generic verifier](https://github.com/swiyu-admin-ch/swiyu-verifier/releases/tag/2.0.1)

## [DID Toolbox](https://github.com/swiyu-admin-ch/didtoolbox-java) Version 1.6.0
- Support for DID Web + Verifiable History (did:webvh) v1.0 introduced
- Fix: [Eliminate duplicate parsing](https://github.com/swiyu-admin-ch/didtoolbox-java/issues/15)

## [DID Resolver](https://github.com/swiyu-admin-ch/didresolver) Version 2.3.0
- Fix: [Perform strict domain and URL validation](https://github.com/swiyu-admin-ch/didresolver/issues/6)
- Security Fix: [Possible DID resolution DoS](https://github.com/swiyu-admin-ch/didresolver/issues/5)
- Security Fix: [Check DID log for conformity](https://github.com/swiyu-admin-ch/eidch-registry-base-authoring/issues/1)
- Feature: Added support for Key Pre-Rotation for did:webvh.
- Feature: Added support for DID Web + Verifiable History (did:webvh:1.0).
  
## Generic Issuer (Version 2.0.2 on new [swiyu-issuer](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/2.0.2))
- Upgraded to new DID Resolver Library version 2.0.1
- Expand step to support correct and [incorrect "cryptographic_binding_methods_supported"](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/50)
- Expand step for [Providing openid metadata also under correct "/.well-known/oauth-authorization-server"](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/47)
- Security Fix: [Block disallowed disclosures](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/54)
- Security Fix: [Block disallowed claims](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/45)
- Security Fix: [Credential can be issued after expiration](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/78)

We kindly ask you to migrate your components to the latest versions. In order to plan the contract step for "Token endpoint expected x-www-form-urlencoded" we created an [issue](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/112) to collect your feedback. 

## Generic Verifier (Version 2.0.2 on new [swiyu verifier repository](https://github.com/swiyu-admin-ch/swiyu-verifier/releases/tag/2.0.2))
- Expand step to [handle malformed and correct "cnf" claim ](https://github.com/swiyu-admin-ch/swiyu-verifier/issues/22)
- Security Fix: [Unsecure serialization/deserialization](https://github.com/swiyu-admin-ch/eidch-verifier-agent-oid4vp/issues/15)

We kindly ask you to migrate your components to the latest versions in order to prevent breakting changes in the future.

## Specifications

- Upcoming: Trust Protocol Version 1.0
- [OID4VCI Version 1.0](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0-final.html) has been published. We will plan the updates on our side and will announce the changes as soon as possible.


