---
title: "New Major Versions for swiyu Generic Components"
categories:
  - PublicBeta
---

With the release of the swiyu Generic Issuer & Verifier version 5.x we'll proceed the contract steps towards the Swiss Profiles 1.0, including Trust Protocol 2.0 implementation with a strict separation of the Sandbox and Production environment.

Ecosystem Actors from Public Beta/Sandbox need to migrate until Mid-November. At this date, the separation will take place and non-prod credentials will be deleted in the productive swiyu wallet.

## swiyu Generic Issuer - Overview of Changes

- Contract: Remove support for old vc+sd-jwt format
- Contract: Remove support for old DID Method DID:tdw
- Contract: Remove support for Trust Protocol 1.0
- Contract: "[Check cryptographic_binding_methods_supported matches the method provided by wallet](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/50
)"

You can find further relevant changes and new features in the [changelog](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/CHANGELOG.md).
  
## swiyu Generic Verifier - Overview of Changes

- Contract: Remove support for old vc+sd-jwt format
- Contract: Remove support for old DID Method DID:tdw
- Contract: Remove support for Trust Protocol 1.0

You can find further relevant changes and new features in the [changelog](https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/CHANGELOG.md).

## Action required

- Depending on your current version of the generic components, you have to migrate until Mid-November. We provide migration guides for [issuer](https://github.com/swiyu-admin-ch/swiyu-issuer/tree/main/migration-guides) and [verifier](https://github.com/swiyu-admin-ch/swiyu-verifier/tree/main/migration-guides).
- Re-register in the Sandbox environment with Trust Protocol 2.0 and re-issue credentials into the Sandbox wallet.

## Outlook: swiyu Wallet Version 2.0

- Restriction to Prod environment: Existing VC's from the Public Beta/Sandbox environment will be deleted
- Strict separation of Sandbox and Prod environment and respective Wallets
- Contract JSON Path
- Contract [Data Source Mapping Overlay 1.0](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/61)

## Timeline and Change Dossiers

[![actors-restriction-roadmap](/assets/images/2026_09_Roadmap.png)](/assets/images/2026_09_Roadmap.png)

You'll find additional information in the respective Change Dossiers:
 
- [Actors Restriction in Prod and Sandbox Environment](https://swiyu-admin-ch.github.io/change-dossiers/CD-001-Restriction-Actors-Sandbox-Prod/)
- [Trust Protocol 2.0](https://swiyu-admin-ch.github.io/change-dossiers/CD-006-Trust-Protocol-2.0/)










