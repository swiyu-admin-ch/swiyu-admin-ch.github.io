---
title: "Swiss Profile Anchor "
toc: true
toc_sticky: true
excerpt: Swiss Profile Anchor with specifications for DID Core and DID:webvh
---

<div class="notice--warning">
  ⚙️ The generated PEM file <code>.didtoolbox/assert-key-01</code> will be referenced as <code>"assert-key-01"</code>
</div>


<div class="notice--info">
  Version 1.0
  Status: draft 
</div>


# Summary

This profile concerns itself with how an public ecosystem actor can be identified by other actors and how they can exchange basic cryptographic details to verify integrity and authenticity of exchanged data.

All underlying specifications referenced by the included standards are considered fully supported unless explicitly noted otherwise.

| Contained Specifications | Version | Link to referenced Specification |
| ---- | ---- | ---- |
| DID Core | 1.0 | [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-1.0/) |
| did:webvh DID Method | 1.0 | [did:web + Verifiable History v1.0](https://identity.foundation/didwebvh/v1.0/)

# Cryptography
To decrease complexity, initially the cryptographic options are limited to following algorithms.

- JWS algorithm used is ES256.

As per did:webvh:1.0 specification:

- Permitted hash algorithms: SHA-256
- Permitted Data Integrity cryptosuites: eddsa-jcs-2022

  
# Decentralized Identifiers (DIDs) v1.0
The specification is fully supported by this profile (and components adhering to it) except for the specific cases mentioned in the following subsections.

<div class="notice--warning">
The below sub-sections rely on the numbering from the original reference specification for ease of reference and comparison.
</div>

3.2.1 DID Parameters
DID Parameters MUST NOT be used.

3.2.2 Relative DID URLs
Relative DID URLs is NOT SUPPORTED.

5.1.2 Core Properties
The property controller SHOULD NOT be used, if you do so, it MUST point to the DID itself.

5.1.3 Also Known As
The property alsoKnownAs MUST NOT be used.

5.2 Verification Methods
Field controller MUST point to the DID itself. 

<div class="notice--warning">
(Warnung) Implementation Note: This controller property and the one from 5.1.2 are not the same but we define them implicitly to be equal.
</div>

5.2.1 Verification Material
publicKeyMultibase MUST NOT be used

publicKeyJwk is REQUIRED

5.3.3 Key Agreement
The verification relationship keyAgreement MUST NOT be used.

5.3.4 Capability Invocation
The verification relationship capabilityInvocation MUST NOT be used.

5.3.5 Capability Delegation
The verification relationship capabilityDelegation  MUST NOT be used.

5.4 Services
The property service MUST NOT be used.

6.2 JSON
The JSON Representation MUST be used.

6.3 JSON-LD
The JSON-LD Representation MUST NOT be used.

7.1 DID Resolution
DID Resolution MUST be used.

7.2 DID URL Dereferencing
DID URL Dereferencing is not supported by the swiyu DIDResolver.

# DID Method did:webvh
