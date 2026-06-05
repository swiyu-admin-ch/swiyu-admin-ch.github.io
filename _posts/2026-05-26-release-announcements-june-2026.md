---
title: "Release Announcements June 2026"
categories:
  - PublicBeta
---

We would like to inform about new and upcoming releases for the swiyu Trust Infrastructure in June 2026:

## New Wallet versions Android 1.15. and iOS 1.16. 
With the upcoming wallet releases, we proceed further steps towards the Swiss Profiles v1.0:
- [EMC-Expand for new Credential Format](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/56)
- [Enforce DCQL Presentation](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/59) 
- With the enforcement of DCQL, we also fix the issues ["Prevent bypassing vct filter rule"](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/36) and ["DIF presentation can send wrong data"](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/39)
- EMC-Expand for new DID standard and Swiss Profile Versioning (see below)
- [Invalid Credentials can no longer be presented](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/62)

Edit: the [contract step for the OCA overlays](https://github.com/swiyu-admin-ch/eidch-android-wallet/issues/61) will be in a future release

## "Sandbox" Wallet available in App Stores 
As the governance measures for the Public Beta differ from those for the future production environment, a dedicated "sandbox" wallet for the Public Beta environment will be available in the app stores. The present swiyu wallet will be restricted over the coming months to the productive environment. Existing credentials must be reissued into the sandbox wallet.

## DID Toolbox
- New standard did:webvh as specified in the [Swiss Profile Anchor 1.0](https://swiyu-admin-ch.github.io/specifications/swiss-profile-anchor/)
- [Swiss Profile Version](https://swiyu-admin-ch.github.io/specifications/introduction/#versioning-indications) in DID Log
- New DID's created with did:webvh must be resolved with the new DID-Resolver
- More details will be available in the [changelog](https://github.com/swiyu-admin-ch/didtoolbox-java/blob/main/CHANGELOG.md) 
- We'll update our documentation accordingly

## DID Resolver
- New standard did:webvh as specified in the [Swiss Profile Anchor 1.0](https://swiyu-admin-ch.github.io/specifications/swiss-profile-anchor/)
- More details will be available in the [changelog](https://github.com/swiyu-admin-ch/didresolver/blob/main/CHANGELOG.md)

## New onboarding flow
By the end of June, we'll provide new cookbooks and the new flows for the onboarding to our registries.
- New DID's must be created with new standard (and new toolbox version)
- Old DID's are still listed in the registries and VC's still work
- The cookbook for the [onboarding the swiyu Base & Trust registry](https://swiyu-admin-ch.github.io/cookbooks/onboarding-base-and-trust-registry/) will be updated

## VC migration 
Also by the end of June, we will provide new generic components (swiyu-issuer and swiyu-verifier) as well as a guide for the migration to the [Swiss Profile VC 1.0](https://swiyu-admin-ch.github.io/specifications/swiss-profile-vc/).

## Planned System Outages on 25 June
Due to internal system recovery tests, there may be disruptions of the swiyu Public Beta infrastructure on Thursday, 25 June 2026. You can find information about system outages in our [System Status Channel](https://github.com/orgs/swiyu-admin-ch/discussions/12).
