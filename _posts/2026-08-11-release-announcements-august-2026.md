---
title: "New swiyu Wallet Releases and Sandbox Registry Onboarding"
categories:
  - PublicBeta
---

## Wallets

The Wallet versions 1.17 are in the pipeline and should be available in the app stores next week. With this release, the wallet enables or enforces security requirements of the Swiss Profiles 1.0.

- [Enforce Payload Encryption](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/58) 
- Enforce Signed Metadata (see [Change Dossier](https://swiyu-admin-ch.github.io/change-dossiers/CD-002-Issuer-Security-Enforcements/))
- Enablement of DPoP (for the enforcement on Issuer-side see [Change Dossier](https://swiyu-admin-ch.github.io/change-dossiers/CD-005-DPoP-Enforcement/))

Please note, that the Sandbox Wallets are now available (iOS: Link in the [readme](https://github.com/swiyu-admin-ch/eidch-ios-wallet#swiyu-sandbox-wallet), Android: [APK in latest release](https://github.com/swiyu-admin-ch/eidch-android-wallet/releases/latest)) and the onboarding to the sandbox environment is released (see below).

## New Onboarding Flow

The [onboarding](https://swiyu-admin-ch.github.io/cookbooks/onboarding-base-and-trust-registry/) for the Sandbox environment is open for organizations and gov actors in a first place. New DID’s must be created with new standard (and new toolbox version).

## DID Toolbox and DID Resolver

The latest [DID Toolbox 2.3.0](https://github.com/swiyu-admin-ch/didtoolbox-java/releases/tag/2.3.0) and [DID Resolver 2.9.0](https://github.com/swiyu-admin-ch/didresolver/releases/tag/2.9.0) have been expanded to support EdDSA. 
- Expand DID log creation and updating to support Ed25519 keys as verification material
- Expand cryptographic algorithms for proof of possession creation and verification with Ed25519
- Resolver now supports Ed25519 public keys as JWK as verification methods

## Latest Generic Components

The latest versions of the generic components are [swiyu Generic Issuer 4.1.0](https://github.com/swiyu-admin-ch/swiyu-issuer/releases/tag/4.1.0) and [swiyu Generic Verifier 4.1.2](https://github.com/swiyu-admin-ch/swiyu-verifier/releases/tag/4.1.2). We recommend to update to the latest swiyu Generic Verifier where we [fixed a security vulnerability](https://swiyu-admin-ch.github.io/publicbeta/new-generic-verifier-release-july/). You'll find an overview of new features and links to the migration guides for the 4.x versions in this [earlier announcement](https://swiyu-admin-ch.github.io/publicbeta/new-generic-components-releases-july/).

## Swiss Profile Proximity

The specification for peer-to-peer proximity verification ["Swiss Profile Proximity"](https://swiyu-admin-ch.github.io/specifications/swiss-profile-proximity/) has been published. 

## Component Versions - New Overview

On the swiyu Technical Documentation Website we have recently started providing an [overview](https://swiyu-admin-ch.github.io/open-source-components/#component-versions) of the lifecycle of the components from the swiyu Trust Infrastructure. 




