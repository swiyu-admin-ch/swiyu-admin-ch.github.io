
With the latest releases in the different repositories we 
- 




fix some issues raised by the community and deliver also features from the initial gaps of the swiyu Public Beta Trust Infrastructure.  We also announce first steps related to the [Expand-Migrate-Contract](https://github.com/swiyu-admin-ch/community/blob/main/tech-concepts/expand-migrate-contract-pattern.md) pattern to avoid breaking changes. For a more detailled view please refer to the CHANGELOG.md in each repository.

## swiyu wallet: [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet) Version 1.7.3; [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet) Version 1.8.1 

- Contract step for "wallet must support specified cnf claim format for [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/20) and [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/8)

## Beta Credential Service (BCS)
- 

## [DID Toolbox](https://github.com/swiyu-admin-ch/didtoolbox-java) Version 1.5.0



- Fix: Eliminate duplicate parsing https://github.com/swiyu-admin-ch/didtoolbox-java/issues/15


- Feature:
- Improvement:
- Improvement: Added support for macOS on Intel x86-64 CPUs
- Improvement: 
- Fix:
- Integration of DID Resolver xyz
  

## [DID Resolver](https://github.com/swiyu-admin-ch/didresolver) Version 2.1.3

- Fix: Perform strict domain and URL validation https://github.com/swiyu-admin-ch/didresolver/issues/6
- 
## Generic Issuer & Generic Verifier

We put together the management- and signer-service on the issuer side (resulting in a new repository "swiyu-issuer") as well as the management- and validator-service on the verifier side (resulting in a new repository "swiyu-verifier"). The cookbooks will be adjusted accordingly. The existing issues on the deprecated components will be moved to the new repositories.

### Generic Issuer (Version 2.0.2 on [new repository](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/2.0.2))

- Breaking changes with regard to the deprecated repositories of xyz. For more details, see the full [changelog](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/CHANGELOG.md)
- Upgraded to new DID Resolver Library with 2.0.1 
- Security Fixes:
- ??new features?

Please note that never versions exist on the repositories, marked as "pre-release". These packages are not yet pentested and not intended for public usage.

### Generic Verifier (Version 2.0.2 on [new repository](https://github.com/swiyu-admin-ch/swiyu-verifier/releases/tag/2.0.2))

- Breaking changes with regard to the deprecated repositories of xyz. For more details, see the full [changelog](https://github.com/swiyu-admin-ch/swiyu-verifier/blob/main/CHANGELOG.md)
- Expand step to handle malformed and correct "cnf" claim 
- Securtiy Fixes:



## Specifications

- Upcoming: Trust Protocol Version 1.0
- [OID4VCI Version 1.0](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0-final.html) has been published. We will plan the updates on our side and will announce the changes as soon as possible.


