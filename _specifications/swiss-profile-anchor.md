---
title: "Swiss Profile Anchor "
toc: true
toc_sticky: true
excerpt: Swiss Profile Anchor with specifications for DID Core and DID:webvh
header:
  teaser: ../assets/images/swiss-profile-anchor.jpg
---

<div class="notice--info">
  Version 1.0 <br>
  Status: draft - technically complete, but might to be reformulated <br>
  Last edited: 2026-05-22
</div>


# Introduction

This profile concerns itself with how a public ecosystem actor can be identified by other actors and how they can exchange basic cryptographic details to verify integrity and authenticity of exchanged data.

## Cryptography
To decrease complexity, initially the cryptographic options are limited to following algorithms.

- JWS algorithm MUST be ES256.

As per did:webvh:1.0 specification:

- Permitted hash algorithms: SHA-256
- Permitted Data Integrity cryptosuites: eddsa-jcs-2022

## Specifications

All underlying specifications referenced by the included standards are considered fully supported unless explicitly noted otherwise.

| Contained Specifications | Version | Link to referenced Specification |
| ---- | ---- | ---- |
| DID Core | 1.0 | [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-1.0/) |
| did:webvh DID Method | 1.0 | [did:web + Verifiable History v1.0](https://identity.foundation/didwebvh/v1.0/) |

**KEY WORDS** for this swiss profile expand on RFC 2119 "Key words for use in RFCs to Indicate Requirement Levels". They are explained in the [general introduction for the specifications](https://swiyu-admin-ch.github.io/specifications/introduction/#key-words). They are to be interpreted as such when, and only when, they appear **bold** and CAPITALIZED.

  
# Decentralized Identifiers (DIDs) v1.0

The specification is fully supported by this profile (and components adhering to it) except for the specific cases mentioned in the following subsections. <br>

<div class="notice--warning">
The below sub-sections rely on the numbering from the original reference specification for ease of reference and comparison.
</div>

## 3 Identifier
### 3.2 DID Syntax
#### 3.2.1 DID Parameters
DID Parameters **MUST NOT** be used. 

#### 3.2.2 Relative DID URLs
Relative DID URLs is **NOT SUPPORTED**.

## 5. Core Properties
DID Document properties <br>
The following properties **MUST NOT** be used:
- alsoKnownAs
- service
  
The property controller **SHOULD NOT** be used, if it is, it **MUST** point to the DID itself.<br>

### 5.1 Identifiers
#### 5.1.2 DID Controller
While the Base Registry supports setting the controller property, it always needs to point to the DID itself.

#### 5.1.3 Also Known As
`alsoKnownAs` in the DIDDoc is **NOT SUPPORTED** by the Base Registry.

### 5.2 Verification Methods
Field `controller` **MUST** point to the DID itself. 

<div class="notice--warning">
⚙️ Implementation Note: This controller property and the one from 5.1.2 are not the same but we define them implicitly to be equal.
</div>

#### 5.2.1 Verification Material
`publicKeyMultibase` **MUST NOT** be used<br>
`publicKeyJwk` is **REQUIRED**<br>

### 5.3 Verification Relationships
#### 5.3.1 Authentification
It is **RECOMMENDED** to have at least one key in the "`authentication`" [verification relationship](https://www.w3.org/TR/did-1.0/#dfn-verification-relationship).

#### 5.3.3 Key Agreement
Setting the verification relationship `keyAgreement` in the DIDDoc is **NOT SUPPORTED** by the Base Registry.

#### 5.3.4 Capability Invocation
Setting the verification relationship `capabilityInvocation` in the DIDDoc is **NOT SUPPORTED** by the Base Registry. 

#### 5.3.5 Capability Delegation
Setting the verification relationship `capabilityDelegation` in the DIDDoc is **NOT SUPPORTED** by the Base Registry.  

### 5.4 Services
`services` in the DIDDoc is **NOT SUPPORTED** by the Base Registry. 

## 6 Representations
### 6.2 JSON
The JSON Representation **MUST** be used.

### 6.3 JSON-LD
The JSON-LD Representation **MUST NOT** be used.

## 7 Resolution
### 7.1 DID Resolution
DID Resolution **MUST** be used.<br>

### 7.2 DID URL Dereferencing
DID URL Dereferencing is **NOT SUPPORTED** by the swiyu DIDResolver.

## Appendix

### DID Log Entry Version

Swiss Profile version indication with property `profile_version` in every DID Document entry _body_ is **REQUIRED**.

```
{
  "profile_version": "swiss-profile-anchor:1.0.0",
  "id": "did:example:123456789abcdefghi",
  "verificationMethod": [{
    "id": "did:example:123456789abcdefghi#key-20260101",
    "type": "JsonWebKey",
    "controller": "did:example:123456789abcdefghi",
    "publicKeyJwk": {
      "kid": "key-20260101",
      "kty": "EC",
      "crv": "P-256",
      "alg": "ES256",
      "x": "f83OJ3D2xF1Bg8vub9tLe1gHMzV76e8Tus9uPHvRVEU",
      "y": "x_FEzRu9m36HLN_tue659LNpXW6pCyStikYjKIWI5a0"
    }
  }],
  "authentication": ["did:example:123456789abcdefghi#key-20260101"]
}

```

# did:webvh DID Method 

The specification is fully supported by this profile (and components adhering to it) except for the specific cases mentioned in the following subsections.

<div class="notice--warning">
The below sub-sections rely on the numbering from the original reference specification for ease of reference and comparison.
</div>

## 2 Overview
### 2.1 The /whois Use Case
The /whois Use Case is **NOT SUPPORTED** in the Base Registry.

Instead the [Trust Protocol](../trust-protocol-v2-0/) mechanisms **SHOULD** be used to validate trustworthiness of the DID.<br>

## 3 did:webvh DID Method Specification
### 3.7 DID Method Processes
#### 3.7.1 did:webvh DID Method Parameters
DID Portability is **NOT SUPPORTED** in the Base Registry. .<br>
- The parameter `portable` MUST be set to false.<br>
Witnesses is **NOT SUPPORTED** in the Base Registry.<br>
- The parameter `witness` MUST be set to {}.<br>
Watchers is **NOT SUPPORTED** in the Base Registry.<br>
- The parameter `watchers` MUST be set to []<br>

#### 3.7.5 Authorized Keys
Use of Pre-rotation of keys is **RECOMMENDED**.

#### 3.7.6 DID Portability
DID Portability is **NOT SUPPORTED** in the Base Registry.

#### 3.7.8 DID Witnesses
Witnesses is **NOT SUPPORTED** in the Base Registry.

#### 3.7.9 DID Watchers
Watchers is **NOT SUPPORTED** in the Base Registry.

#### 3.7.10 Publishing a Parallel did:web DID
publishing a parallel did:web is **NOT SUPPORTED** in the Base Registry.

### 3.8 DID URL Resolution
The did:web fallback is **NOT SUPPORTED** by the DIDResolver and the Base Registry.<br>
A did:web fallback **SHOULD NOT** be utilized.

### 3.9 DID URL Path Resolution
DID URL Path Resolution is **NOT SUPPORTED**.

### 3.10 WHOIS Resolution
WHOIS resolution is **NOT SUPPORTED** by the Base Registry and the swiyu wallet.<br>
Instead, use the mechanisms defined in the [swiss-profile-trust](../swiss-profile-trust/) to validate trustworthiness of the DID.

## JWT Validation with cryptographic keys from DIDs

Whenever cryptographic material from a DID is used to sign a JWT the following rules hold throughout the ecosystem:

- The `kid` JWT header claim is **REQUIRED** and **MUST** be an absolute identifier of the form "[{DID}#{key identifier}](https://www.w3.org/TR/did-1.0/)".
  - Additionally, both the DID and the key identifier **MUST NOT** contain a # symbol. Implementations **SHOULD** ensure this to prevent parsing differential attacks.
  - The `kid` JWT header **MUST** be used to perform signature validation.
  - Any authorization or trust information checks of the entity issuing the JWT **MUST** be done on the DID part of the `kid` (If two `kid` are different but have matching DIDs they are considered to be signed by the same entity).
- The `iss` JWT claim is always **OPTIONAL** but **MUST** be ignored if it is set. 
