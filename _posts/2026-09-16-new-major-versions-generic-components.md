---
title: "New Major Versions for swiyu Generic Components"
categories:
  - PublicBeta
---


With the upcoming release of the swiyu Generic Issuer & Verifier we'll proceed the contract steps towards the Swiss Profiles 1.0, including Trust Protocol 2.0 implementation.

Ecosystem Actors need to migrate until Mid-November. 

## swiyu Generic Issuer - Overview of Changes

- Contract: "Check cryptographic_binding_methods_supported matches the method provided by wallet"
- Contract: Remove support for old vc+sd-jwt format
- Contract: Remove support for old DID Method DID:tdw
- Contract: Remove support for Trust Protocol 1.0

  
## swiyu Generic Verifier - Overview of Changes

- Contract: Remove support for old vc+sd-jwt format
- Contract: Remove support for old DID Method DID:tdw
- Contract: Remove support for Trust Protocol 1.0

## Action required

Depending on your current version of the generic components, you have to migrate from major version 2.x to 3.x and/or 3.x to 4.x

## Outlook: swiyu Wallet Version 2.0

- Restriction to Prod Environment: Existing VC's from the Public Beta/Sandbox Environment will be deleted
- Strict separation of Sandbox and Prod Environment and respective Wallets
- Contract Json Path
- Contract Data Source Mapping Overlay 1.0

- Implications for swiyu Wallet and Trust Protocol 2.0 https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/55


## Change Dossiers with Overview and new Timeline
 
We've adjusted the timeline in our roadmap.. 


https://swiyu-admin-ch.github.io/change-dossiers/CD-001-Restriction-Actors-Sandbox-Prod/
https://swiyu-admin-ch.github.io/change-dossiers/CD-006-Trust-Protocol-2.0/










