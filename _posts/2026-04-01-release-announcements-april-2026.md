---
title: "Release Announcement for BCS April 2026"
categories:
  - PublicBeta
---


A new version of the [Beta Credential Service](https://bcs.admin.ch/bcs-web/#/) (BCS) will be installed mid April. This new version includes the next steps in the development of ‘Swiss Profile 1.0’.
This release requires the upcoming swiyu Wallet versions iOS 1.15.0 and Android 1.14.0 and is not backwards compatible with older versions of the swiyu Wallet.

As various adjustments to the infrastructure will also be made during the installation of the new release, the Beta Credential Service will only be available to a limited extent on that day. We will announce the date in the [System Status channel](https://github.com/orgs/swiyu-admin-ch/discussions/12) page.

## Release Notes BCS:

- New vct metadata claims: (vct_version, vct_metadata_uri, vct_metadata_uri#integrity)
- Issuer metadata extended to include a new element ‘credential_metadata’, which contains the information ‘display‘ and ‘claims’
- Minor upgrade to [swiyu-issuer 2.4.3](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/2.4.3)
- Minor upgrade to [swiyu-verifier 2.3.3](https://github.com/swiyu-admin-ch/swiyu-verifier/releases/tag/2.3.3)
- Optional payload encryption during issuance

Please note our prior [announcement](https://swiyu-admin-ch.github.io/publicbeta/breaking-changes-in-next-wallet-versions/) about the potential breaking change with the next wallet releases. You'll find more details about the changes in the [changelog](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/CHANGELOG.md).

The information is also available in German on [GitHub](https://github.com/orgs/swiyu-admin-ch/discussions/11#discussioncomment-16408450).
