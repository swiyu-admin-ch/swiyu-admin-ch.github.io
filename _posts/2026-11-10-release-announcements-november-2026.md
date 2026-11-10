---
title: "Fix for Vulnerability in DID Resolver and New Major Versions for swiyu Wallets"
categories:
  - Sandbox
---

We fixed a vulnerability found in the DID resolver and released a new version 2.10.1. We recommend to update to the newest version immediately.

## DID Resolver 2.10.1

- Fixed vulnerability "SCID not bound to DID log"

This version will already be integrated in the upcoming new swiyu Wallet version 2.0.

## swiyu Wallet Version 2.0

With this release, we'll proceed the contract steps towards the Swiss Profiles 1.0 with a strict separation of the Sandbox and Production environment.

- Restriction to Prod environment: Existing VC's from the Public Beta/Sandbox environment will be deleted
- Strict separation of Sandbox and Prod environment and respective Wallets
- Contract JSON Path
- Contract [Data Source Mapping Overlay 1.0](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/61)
- Fixes for Known Issues and Issues reported by the community
  - [Check all mandatory fields in the Trust Statement](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/33)
  - [Avoid holder tracking through self-hosted DID](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/34)
  - [Rejection of valid URLs with TLDs longer than 6 characters](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/68)

## Action required

- Update to the latest [DID Resolver 2.10.1](https://github.com/swiyu-admin-ch/didresolver/releases/tag/2.10.1)
- Depending on your current version of the generic components, you have to migrate to the 5.x versions until Mid-November. We provide migration guides for [issuer](https://github.com/swiyu-admin-ch/swiyu-issuer/tree/main/migration-guides) and [verifier](https://github.com/swiyu-admin-ch/swiyu-verifier/tree/main/migration-guides).
- Re-register in the Sandbox environment with Trust Protocol 2.0 and re-issue credentials into the Sandbox wallet.

## Timeline

- 6.11.2026: DID Resolver version 2.10.1 released 
- Mid-November: swiyu (Sandbox) Wallet for iOS & Android version 2.0
