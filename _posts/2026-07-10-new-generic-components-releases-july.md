---
title: "New swiyu Generic Issuer and Verifier"
categories:
  - PublicBeta
---

We released two new versions of our generic components and the source code for the latest wallet releases has been published.

## Generic Issuer [Version 4.0.1](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/4.0.1)
- Status list tokens (statuslist+jwt) now include a ttl claim and proper exp/iat timestamps derived from the application.status-list properties. This allows operators to control how long published status lists are considered valid and how long cached status list entries are retained by the wallet.
- Expanded enc_values_supported to allow A256GCM encryption in addition to A128GCM.
- Removed the vars SWIYU_TRUST_REGISTRY_CUSTOMER_KEY and SWIYU_TRUST_REGISTRY_CUSTOMER_SECRET as they are not required by the read-only trust registry.
- Removed support for claims in credential_configurations_supported details for claims can now be found in credential_metadata.claims instead as announced earlier. Please update your metadata accordingly. 
- Removed vct#integrity from issuer metadata as it is no longer used -> use vct_metadata_uri and vct_metadata_uri#integrity instead.

Please refer to the [Changelog](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/CHANGELOG.md) for a complete overview of new features and changes and the [Migration Guide 3.2 to 4.0](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/migration-guides/guide-3.2.x-to-4.0.x.md) for more details.

## Generic Verifier [Version 4.0.1](https://github.com/swiyu-admin-ch/swiyu-verifier/releases/tag/4.0.1)
- Removed the  client_id_scheme from the application configuration as it is no longer used and replaced by the client_id_prefix configuration property with default value decentralized_identifier, which can be changed or set to null. Therefore, the client_id will be ${client_id_prefix}:${client_id}.
- Removed the vars SWIYU_TRUST_REGISTRY_CUSTOMER_KEY and SWIYU_TRUST_REGISTRY_CUSTOMER_SECRET as they are not required by the read-only trust registry.
- oauthState must be sent in verification response otherwise the verifier rejects the response.
- Fetching an expired Verification Management Object will now return an error instead of returning it one last time.
- Uses A256GCM instead of A128GCM for encryption.

Please refer to the [Changelog](https://github.com/swiyu-admin-ch/swiyu-verifier/blob/main/CHANGELOG.md) for a complete overview of new features and changes and the [Migration Guide 3.0 to 4.0](https://github.com/swiyu-admin-ch/swiyu-verifier/blob/main/migration-guides/v3.0.x-to-v4.0.x.md) for more details.

## Source Code and Changelog for latest swiyu Wallet Releases 
- The source code for the latest swyiu Wallet releases for [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet/releases/tag/v1.16.2) (hotfix) and [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet/releases/tag/v1.16.0) is published.
- The full changelog is available under the version 1.16.0 for [Android](https://github.com/swiyu-admin-ch/eidch-android-wallet/releases/tag/v1.16.0) and [iOS](https://github.com/swiyu-admin-ch/eidch-ios-wallet/releases/tag/v1.16.0).
- The new generic components are compatible with these versions.

  
