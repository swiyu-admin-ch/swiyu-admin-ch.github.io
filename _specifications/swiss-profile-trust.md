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


# Summary

This profile concerns itself with how an public ecosystem actor can be identified and linked to a real world identity and how to protect anyone complying with this protocol from fraudsters impersonating official government institutions and VCs.

All underlying specifications referenced by the included standards are considered fully supported unless explicitly noted otherwise.

| Contained Specifications | Version | Link to referenced Specification |
| ---- | ---- | ---- |
| Trust Protocol | 2.0 | [/trust-protocol-v2-0](../trust-protocol-v2-0.md/)  |

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
Those fields require a special protection flow, as defined in [Trust Protocol 2.0](../trust-protocol-v2-0.md/), to verify them.<br>
Note: While it is still possible to issue credentials with such fields in arbitrary VCs it is not recommended to do so. A verifier needs special permission to verify this field, regardless of the VCT it belongs to.

| Description | Field name | Organisational Entity |
| --- | --- | --- |
| AHV Number | personal_administrative_number | Bundesamt für Justiz |


## Environment specific details

Public Beta Trust Registry: https://trust-reg.trust-infra.swiyu-int.admin.ch/

### Root trust anchors
| Type | DID | 
| --- | --- | 
| Trust statement issuer | to be announced |
| Public transparency statement issuer | tba |

### Trust Registries

| Name | Base URL | 
| --- | --- | 
| swiyu Trust Registry | [https://trust-reg.trust-infra.swiyu-int.admin.ch](https://trust-reg.trust-infra.swiyu-int.admin.ch) |

## Trust requirements

An actor of the ecosystem MUST validate the trust relationship, and therefore the actor knows the trust markers of the actors in the interaction.<br>
An actor of the ecosystem MUST decline any trust relationships which do have the Governmental use case Trust Mark but not the Verified governmental authorization Trust Mark.<br>
An actor of the ecosystem SHOULD decline any trust relationships which do not have the Verified Identity Trust Mark.<br>

The wallet SHOULD decline any trust relationships during the verification process which do not have the Compliant actor Trust Mark.<br>
The wallet MAY decline any trust relationships during the verification process which do not have the Transparent verification Trust Mark.<br>
Note: A good reason to not require the Transparent verification Trust Mark would be a holder contented overwrite of the required Transparent verification Trust Mark.

## Trust Statement Details

### Verification Query Public Statement (vqPS)

All vqPS issued by the swiyu trust infrastructure are valid for 6 months.




