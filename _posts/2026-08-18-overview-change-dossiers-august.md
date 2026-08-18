---
title: "Overview and Timeline for Major Changes"
categories:
  - PublicBeta
---

We would like to give an overview of the current Change Dossiers, which summarize major changes to the swiyu Sandbox Trust Infrastructure.

## For existing Actors

With the release of swiyu Sandbox Wallet version 1.17, existing actors on the swiyu Sandbox (Public Beta) Trust Infrastructure can start the re-onboarding and re-issuance of existing credentials with respect to the [implementation gaps](https://github.com/swiyu-admin-ch/swiyu-admin-ch.github.io/issues/63) for the [Swiss Profiles 1.0](https://swiyu-admin-ch.github.io/specifications/) .
- [CD-001](https://swiyu-admin-ch.github.io/change-dossiers/CD-001-Restriction-Actors-Sandbox-Prod/) Separation of Public Beta/Sandbox and productive environment with restriction to registered actors
- [CD-006](https://swiyu-admin-ch.github.io/change-dossiers/CD-006-Trust-Protocol-2.0/) Migration to Trust Protocol 2.0

It is foreseen that the restriction of the swiyu Wallet to the productive environment will take place by the end of October 2026. After this date, all existing non-productive credentials in the swiyu Wallet will be deleted.

Issuer
- [CD-002](https://swiyu-admin-ch.github.io/change-dossiers/CD-002-Issuer-Security-Enforcements/) Security Enforcements, AES256 Migration & Status List Gap Closure
- [CD-005](https://swiyu-admin-ch.github.io/change-dossiers/CD-005-DPoP-Enforcement/) DPoP Enforcement

The security enforcements will be released with swiyu (Sandbox) Wallet version 1.17. This version also enables DPoP which now may be enforced via configuration of the swiyu Generic Issuer.

Verifier
- [CD-004](https://swiyu-admin-ch.github.io/change-dossiers/CD-004-Verifier-Security-Enforcements/) Security Enforcements, AES256 Migration & Status List Gap Closure

The security enforcements will be released with swiyu (Sandbox) Wallet version 1.17.

## For new Actors

New actors may start their swiyu Sanbox onboarding now with respect to the [implementation gaps](https://github.com/swiyu-admin-ch/swiyu-admin-ch.github.io/issues/63) for [Swiss Profiles 1.0](https://swiyu-admin-ch.github.io/specifications/). We recommend to follow the steps from the [onboarding cookbook](https://swiyu-admin-ch.github.io/cookbooks/onboarding-base-and-trust-registry/) and the integration instructions for the [swiyu Generic Issuer](https://swiyu-admin-ch.github.io/cookbooks/onboarding-generic-issuer/) and the [swiyu Generic Verifier](https://swiyu-admin-ch.github.io/cookbooks/onboarding-generic-verifier/).    


# VC Migration Concept published

We published a [cookbook for VC Migration](https://swiyu-admin-ch.github.io/cookbooks/vc-migration/) with different types for transitioning a Verifiable Credential (VC) from one technical version to another. The document should help Issuers with VCs that are intended to be valid for a longer period to find a compatible strategy. 




