---
title: Verifiable Credential Migration 
toc: true
toc_sticky: true
excerpt: Learn how to transition a VC from one technical version to another
header:
  teaser: ../assets/images/cookbook_verifiablecredential.jpg
---

# Introduction

VC migration refers to the process of transitioning a Verifiable Credential (VC) from one technical version to another. Because VCs are cryptographically signed and therefore immutable, migration cannot be performed in place. Instead, it requires re-issuing the credential in the new format.

## Conventions and Terminology

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [BCP 14] [RFC 2119] [RFC 8174] when, and only when, they appear in all capitals, as shown here.

## Why VC Migration Matters

Every Verifiable Credential is built on a specific technical stack, typically defined by a version of the swiss-profile-vc. As a result, wallets and verifiers must support the corresponding version to process the credential correctly.

As these components evolve – e.g., by adopting newer versions of the swiss-profile-vc – older credentials may lose compatibility. This can lead to degraded functionality or, in the worst case, render credentials unusable.

This is especially critical given that some VCs are intended to remain valid for long periods. For example, an e-ID may be valid for five years, while a university diploma may have indefinite validity. To preserve their usability over time, a reliable migration path to newer, supported versions of the swiss-profile-vc is essential.

## Types of VC Migration
There are two primary approaches to initiating VC migration: active re-issuance and automated migration.

### Active VC Re-Issuance
In this model, the issuer proactively re-issues credentials that are at risk of becoming incompatible. Existing VCs are replaced with newly issued credentials that conform to the latest supported version of the Swiss Profile.

The responsibility lies entirely with the issuer. This includes:
- Monitoring the technical compatibility and lifecycle of issued credentials
- Identifying credentials that require migration
- Contacting holders and re-issuing updated VCs

(Glühbirne) Note: Active re-issuance could also be used by issuers to re-issue VCs for business reasons.

### Automated VC Migration
In this approach, the issuer provides a renewal endpoint that enables automated re-issuance of credentials.

Wallets take on a more active role by:
- Monitoring the compatibility of stored VCs (e.g., comparing their swiss-profile-vc version with currently supported versions)
- Anticipating upcoming compatibility changes

When a VC is nearing or has reached its technical end-of-life, the wallet can automatically trigger re-issuance via the issuer’s renewal endpoint. This typically follows a flow similar to Batch Issuance with renewal key - Renewal .

## Absence or Failure of VC Migration
It is important to note that successful VC migration cannot be guaranteed. There are many scenarios in which a VC might not be migrated, ever. This can be a deliberate decision, or it can be a symptom of organisational or technical failings - see the examples below:

### Deliberate
- A deliberate decision by the issuer to never renew VCs – e.g. for short lived VCs that are only valid a limited time (e.g. concert tickets).
- The issuer decides not to renew a VC, for example because it has expired since.

### Organisational Failings
- A lack of foresight and planning on the part of the issuer.
- The issuer does not support automated renewal (no refresh endpoint) and does not allow active re-issuance.
- An issuer going out of business, or otherwise ending their VC renewal support.

### Technical Failings
- The credential was issued without use of the swiyu Generic Issuer or does not contain a valid swiss-profile-vc version (e.g., missing or incorrect metadata).
- Failures occur within the automated refresh flow (e.g., technical errors or misconfigurations).
- The holder does not open their wallet for an extended period, or the device remains offline for too long.

As a result, systems relying on VCs should account for potential migration failures and handle such cases appropriately.

→ VC migration is a best-effort process and cannot be guaranteed.

## VC Versioning
In order to enable VC migration the issued VCs MUST be issued with a technical version. This version points to the corresponding Swiss Profiles, with which the VC was issued, in case of SD-JWT swiss-profile-vc.

Example:

`"profile_version": "swiss-profile-vc:1.0.0"`

This version denotes a purely technical version and is completely independent from the business validity of a credential.

See [Versioning Indications in Swiss Profile - VC](todo) for more details.


# Ecosystem Policies
The following rules shall govern how actors deal with VCs.

## Issuer
- Issuers SHOULD set an exp date on all of their issued VCs and the exp date should not be more than 3 months in the future.
- For VCs with an expected business and/or technical validity of more than 3 months the issuer SHOULD offer at least one comprehensive VC migration strategy which does not place the burden of migration upon holders.
- Issuers MUST ensure that their VCs contain a profile_version as per Versioning Indications in Swiss Profile - VC. (Note: the Generic Issuer component ensures this by default.)

## Verifiers
- Verifiers who rely on VCs not within their control (i.e. not issued by the same organisation) are RECOMMENDED to prepare mitigating measures for users whose VCs can no longer be processed.
- Verifiers are RECOMMENDED to attempt to process VCs leniently.
- Verifiers SHOULD rely on as few features of the VC as their business case allows to reduce dependencies and chances of breaking changes in VCs down the line.


## Behaviour on unsupported VCs
This section defines the behaviour when actors encounter unsupported VCs, i.e. VCs whose swiss-profile-vc version is end-of-life.

### Wallet
- Attempt to process the VC when possible (even if swiss-profile version is "deprecated" or "retired").
- Allow holders to present outdated VCs, potentially after showing a warning.

### Verifier
- Accept VCs even if their swiss-profile version is "deprecated" or "retired". Attempt to process the VC when possible in a best-effort way (degrade gracefully).




# Migration Strategies
This section the VC migration strategies which are currently planned in the swiyu ecosystem.

An expanded set of possible but currently unsupported VC migration strategies can be found in the following ADR: PARENT-ADR-033 - VC Migration Strategies

## Mitigations for Missing Re-Issuance
It must be acknowledged that some VCs may never be migrated (see Absence or Failure of VC Migration above for possible reasons).

The strategies outlined in this section are intended to mitigate the impact of such cases and preserve, as far as possible, the usability of affected credentials.

### Compatibility and Backward Support (VCM-00a)
Wherever possible old VC versions should continue to be supported, as this is the only way to ensure keeping the VCs usable.

This will over time lead to an accumulation of tech debt - this trade-off will have to be analysed and assessed periodically.

### Graceful Degradation (VCM-00b)
Whenever possible an actor encountering a no-longer-supported VC version shall attempt to process it to the best of its abilities.

This can mean that certain functionality is still available, which might be better than outright rejecting a VC.

## Active Re-Issuance
### Issuers notify Holders Out-of-Band (VCM-01)
The issuer keeps track of all issued VCs on their end, as well as keeping some out-of-band channel of communication to their holders.

The issuer can then use this communication channel to ask holders to go through whatever process is necessary for re-issuance of VCs.


| **Responsibility for tracking VC compatibility** |	Issuer |
| **Responsibility for initiating migration** |	Issuer |
| **On-demand migrations for issuers** |	Yes |
| **Requires renewal endpoint?** |	No |
| **Notes** |	The issuer must have an out-of-band connection to the holders to inform them about migrations. (The security of this out-of-band connection is the sole responsibility of the issuer). |

## Automated Migration
### Wallet triggers VC Migration based on swiss-profile-vc (VCM-04)

Periodically / upon every startup the wallet would check all VCs. Then for each VC that has a swiss-profile-vc version about to expire the wallet will attempt a migration.

The wallet could be kept up to date on the currently supported swiss-profile-vc versions via the Mobile Versioning service that could give a supported/deprecated/end-of-life verdict on swiss-profile-vc versions.

| **Responsibility for tracking VC compatibility** |	Wallet - based on known swiss-profile-vc support lifecycle. |
| **Responsibility for initiating migration** |	Wallet - based on old swiss-profile-vc version. |
| **On-demand migrations for issuers** |	No |
| **Requires renewal endpoint?** |	Yes (same as credential_endpoint) |
| **Notes** | - |

### Wallet triggers VC Migration based on exp + auto-renewal=true flag (VCM-05)

Periodically / upon every startup the wallet would check all VCs. For wallets all VCs that have initially a "auto-renewal-flag" set to true. If a credential with an exp date is about to expire with auto-renewal-flag set to true, the wallet would attempt a migration. 

If the wallet's call to the credential_endpoint fails with a 400 Bad Request with the body error=credential_request_denied, the wallet will mark the credential with auto-renewal-flag=false. This allows to wallet to track which credential renewals have been refused by the issuer and not re-attempt them.

| **Responsibility for tracking VC compatibility** | Issuer |
| **Responsibility for initiating migration** |	Wallet |
| **On-demand migrations for issuers** |	No |
| **Requires renewal endpoint?** |	Yes (same as credential_endpoint) |
| **Notes** | Setting an exp date is not guaranteed (currently it is not mandatory as per swiss-profile-vc 1.0). If exp date is given it could be well into the future. |





 

