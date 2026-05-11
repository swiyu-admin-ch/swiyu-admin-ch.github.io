---
title: "Swiss Profile Trust"
toc: true
toc_sticky: true
excerpt: Specifications for Trust Protocol and Non-compliance Protocol
header:
  teaser: ../assets/images/swiss-profile-trust.jpg
---

<div class="notice--info">
  Version 1.0 <br>
  Status: draft - technically complete, but might to be reformulated
</div>


# Introduction

This profile concerns itself with how a public ecosystem actor can be identified and linked to a real world identity and how to protect anyone complying with this protocol from fraudsters impersonating official government institutions and VCs.

All underlying specifications referenced by the included standards are considered fully supported unless explicitly noted otherwise.

## Specifications

This section details the implementation notes and gaps pertaining to the supported specifications.

The specifications are fully supported by this profile (and components adhering to it) except for the specific cases mentioned in the following section.

| Contained Specifications | Version | Link to referenced Specification |
| ---- | ---- | ---- |
| Trust Protocol | 2.0 | [trust-protocol-v2-0](../trust-protocol-v2-0/)  |

<div class="notice--primary">

What is the difference between the Trust Protocol and the Swiss Profile Trust?

The Trust Protocol provides a foundational framework for establishing and propagating trust within a distributed credential ecosystem such as swiyu. It defines how trust mechanisms work, without prescribing specific outcomes or policies.

The Swiss Profile Trust, in contrast, specifies how the Trust Protocol is applied within the swiyu ecosystem. It defines the expected behavior of actors – issuers, holders, and verifiers – based on the presence or absence of defined trust markers.

</div>

# Trust Protocol 2.0

The specification is fully supported by this profile (and components adhering to it).

In addition the following details are defined as active providers for the Trust Protocol:

## Protected fields
Protected fields are claims of VCs in the swiss ecosystem which do require special permission to verify.<br>
Those fields require a special protection flow, as defined in [Trust Protocol 2.0](../trust-protocol-v2-0/), to verify them.<br>
Note: While it is still possible to issue credentials with such fields in arbitrary VCs it is not recommended to do so. A verifier needs special permission to verify this field, regardless of the VCT it belongs to.

| Description | Field name | 
| --- | --- | 
| AHV Number | personal_administrative_number |


## Environment specific details

Public Beta Trust Registry: https://trust-reg.trust-infra.swiyu-int.admin.ch/

### Root trust anchors

| Type | DID | 
| --- | --- | 
| Trust statement issuer | did:webvh:QmRCTm94HZCq2YL1kjCDXRQ1ved4cb3Q3FiEao1nRSbp3A:identifier-reg.trust-infra.swiyu-int.admin.ch:api:v1:did:75b5d64d-6de0-426e-b5aa-9e9e4452f11a |
| Public transparency statement issuer | did:webvh:QmaQHULUL7HbM76k2T42QhBDtnYM96Dj8cCwpVfvJ2pyCb:identifier-reg.trust-infra.swiyu-int.admin.ch:api:v1:did:71c14e91-2637-4dbd-a7dd-4de7254b936d |

### Trust Registries

| Name | Base URL | 
| --- | --- | 
| swiyu Trust Registry | [https://trust-reg.trust-infra.swiyu-int.admin.ch](https://trust-reg.trust-infra.swiyu-int.admin.ch) |

## Trust requirements

An actor of the ecosystem **MUST** validate the trust relationship, and therefore the actor knows the trust markers of the actors in the interaction.<br>
An actor of the ecosystem **MUST** decline any trust relationships which do have the [Governed use case Trust Marker](../trust-protocol-v2-0/#governed-use-case-trust-marker-guctm/) but not the [Governed use case authorization Trust Marker](../trust-protocol-v2-0/#governed-use-case-authorization-trust-marker-gucatm/).<br>
An actor of the ecosystem **SHOULD** decline any trust relationships which do not have the [Verified Identity Trust Marker](../trust-protocol-v2-0/#verified-identity-trust-marker-vitm/).<br>

The wallet **MAY** decline any trust relationships during the verification process which do not have the [Compliant actor Trust Marker](/trust-protocol-v2-0/#compliant-actor-trust-marker-catm/).<br>
The wallet **MAY** decline any trust relationships during the verification process which do not have the [Transparent verification Trust Marker](trust-protocol-v2-0/#transparent-verification-trust-marker-tvtm/).<br>
Note: A good reason to not require the Transparent verification Trust Mark would be a holder consented overwrite of the required Transparent verification Trust Mark.






