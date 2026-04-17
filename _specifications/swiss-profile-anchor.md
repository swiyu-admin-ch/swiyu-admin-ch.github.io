---
title: "Swiss Profile Anchor "
toc: true
toc_sticky: true
excerpt: Swiss Profile Anchor with specifications for DID Core and DID:webvh
---

<div class="notice--info">
  Version 1.0
  Status: draft - technically complete, but might to be reformulated
</div>


# Summary

This profile concerns itself with how an public ecosystem actor can be identified by other actors and how they can exchange basic cryptographic details to verify integrity and authenticity of exchanged data.

All underlying specifications referenced by the included standards are considered fully supported unless explicitly noted otherwise.

| Contained Specifications | Version | Link to referenced Specification |
| ---- | ---- | ---- |
| DID Core | 1.0 | [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-1.0/) |
| did:webvh DID Method | 1.0 | [did:web + Verifiable History v1.0](https://identity.foundation/didwebvh/v1.0/) |

# Cryptography
To decrease complexity, initially the cryptographic options are limited to following algorithms.

- JWS algorithm used is ES256.

As per did:webvh:1.0 specification:

- Permitted hash algorithms: SHA-256
- Permitted Data Integrity cryptosuites: eddsa-jcs-2022

  
# Decentralized Identifiers (DIDs) v1.0

The specification is fully supported by this profile (and components adhering to it) except for the specific cases mentioned in the following subsections. <br>

<div class="notice--warning">
The below sub-sections rely on the numbering from the original reference specification for ease of reference and comparison.
</div>


**3.2.1 DID Parameters** <br>
DID Parameters MUST NOT be used. <br>

**3.2.2 Relative DID URLs** <br>
Relative DID URLs is NOT SUPPORTED.<br>

**5 Core Properties** <br>
DID Document properties <br>
The following properties MUST NOT be used:
- alsoKnownAs
- service
  
The property controller SHOULD NOT be used, if it is it MUST point to the DID itself.<br>

**5.1.2 DID Controller** <br>
While the Base Register supports setting the controller property, it always needs to point to the DID itself. <br>

**5.1.3 Also Known As** <br>
The Base Register does not support alsoKnownAs in the DIDDoc. <br>

**5.2 Verification Methods** <br>
Field controller MUST point to the DID itself. <br>

<div class="notice--warning">
⚙️ Implementation Note: This controller property and the one from 5.1.2 are not the same but we define them implicitly to be equal.
</div>

**5.2.1 Verification Material**<br>
publicKeyMultibase MUST NOT be used<br>
publicKeyJwk is REQUIRED<br>

**5.3.3 Key Agreement** <br>
The verification relationship keyAgreement MUST NOT be used.<br>

**5.3.4 Capability Invocation**<br>
The verification relationship capabilityInvocation MUST NOT be used.<br>

**5.3.5 Capability Delegation**<br>
The verification relationship capabilityDelegation  MUST NOT be used.<br>

**5.4 Services**<br>
The property service MUST NOT be used.<br>

**6.2 JSON** <br>
The JSON Representation MUST be used.<br>

**6.3 JSON-LD**<br>
The JSON-LD Representation MUST NOT be used.<br>

**7.1 DID Resolution**<br>
DID Resolution MUST be used.<br>

**7.2 DID URL Dereferencing**<br>
DID URL Dereferencing is not supported by the swiyu DIDResolver.<br>

# DID Method did:webvh

The specification is fully supported by this profile (and components adhering to it) except for the specific cases mentioned in the following subsections.

<div class="notice--warning">
The below sub-sections rely on the numbering from the original reference specification for ease of reference and comparison.
</div>


**2.1 The /whois Use Case**<br>
The /whois Use Case is not supportet in the Base Register.<br>

Instead use the [Trust Protocol] mechanisms to validate trustworthiness of the DID.<br>

**3.7.1 did:webvh DID Method Parameters**<br>
The Base Register does not support DID Portability.<br>
The parameter portable MUST be set to false.<br>
The Base Register does not support Witnesses.<br>
The parameter witness MUST be set to {}.<br>
The Base Register does not support Watchers.<br>
The parameter watchers MUST be set to []<br>
Swiss Profile version indication with property profile_version in first DID Log entry body is REQUIRED.<br>

```
DID Log Entry Version
{
  "portable": true,
  "updateKeys": ["z82LkqR25TU88tztBEiFye"],
  "nextKeyHashes": ["enkkrohe5ccxyc7zghic6qux5iny"],
  "method": "did:webvh:1.0",
  "profile_version": "swiss-profile-anchor:1.0.0",
  "scid": "{SCID}"
}
```
<br>
**3.7.5 Authorized Keys**<br>
We do recommend to utilize Pre-rotation of keys.<br>

**3.7.6 DID Portability**<br>
The Base Register does not support DID Portability.<br>

**3.7.8 DID Witnesses**<br>
The Base Register does not support Witnesses.<br>

**3.7.9 DID Watchers**<br>
The Base Register does not support Watchers.<br>

**3.7.10 Publishing a Parallel did:web DID**<br>
The Base Register does not support publishing a parallel did:web.<br>

**3.8 DID URL Resolution**<br>
The DIDResolver and Base Registry does not support the did:web fallback<br>
We do recommend to NOT utilize a did:web fallback.<br>

**3.9 DID URL Path Resolution**<br>
DID URL Path Resolution is not supported<br>

**3.10 WHOIS Resolution**<br>
The Base Register and Wallets do not support WHOIS resolution.<br>
Instead use the mechanisms defined in the swiss-profile-trust to validate trustworthiness of the DID.
