---
title: "Swiss Profile Verification"
toc: true
toc_sticky: true
excerpt: Specifications for OpenID4VP and JAR

---


<div class="notice--info">
  Version 1.0 <br>
  Status: draft - technically complete, but might to be reformulated
</div>


# Summary

This profile concerns itself with how a wallet is presenting VCs to a relying party, henceforth called verifier. It excludes the details on the VC or establishing trust between wallet and verifier.

All underlying specifications referenced by the included standards are considered fully supported unless explicitly noted otherwise.

| Contained Specifications | Version | Link to referenced Specification |
| ---- | ---- | ---- |
| OpenID4VP | 1.0 | [OpenID for Verifiable Credential Presentation (OID4VP) v1.0](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html) |
| JAR | RFC-9101 | [RFC9101 - The OAuth Authorization Framework: JWT-Secured Authorization Request (JAR)](https://www.rfc-editor.org/rfc/rfc9101) |

# Cryptography
To decrease complexity, initially the cryptographic options are limited to following algorithms.
- JWS algorithm MUST be ES256.
- Encryption MUST use only ECDH-ES with P-256 Keys with A128GCM or A256GCM algorithm.
- If using encryption is possible, it MUST be used.

# OpenID for Verifiable Presentations 1.0

The specification is fully supported by this profile (and components adhering to it) except for the specific cases mentioned in the following subsections.

<div class="notice--warning">
The below sub-sections rely on the numbering from the original reference specification for ease of reference and comparison.
</div>

## 5. Authorization Request

todo: check comments

```
{
  // header
  "typ":"oauth-authz-req+jwt",
  "alg":"ES256",
  "profile_version": "swiss-profile-verification:1.0.0" 
}
.
{
  // payload
}
```


### 5.1 New Parameters

- `jwks` is REQUIRED
- `encrypted_response_enc_values_supported` is REQUIRED
- `vp_formats_supported` is NOT SUPPORTED, credential format identifier is determined in DCQL query's `format` parameter
- `request_uri_method` is NOT SUPPORTED, HTTP GET request is made by the Wallet
- `transaction_data` is NOT SUPPORTED
- `verifier_info` is RECOMMENDED
  - `verifier_info.credential_ids` is NOT SUPPORTED


Swiss Profile version indication with new parameter `profile_version` is REQUIRED.

### 5.2 Existing Parameters
- `response_mode` MUST be direct_post.jwt

### 5.5 Using scope Parameter to Request Presentations
`scope` parameter MUST be supported.

When `scope` parameter is set, an object in the `verifier_info` MUST contain the scope with the DCQL query.

### 5.8. aud of a Request Object
As the verifier cannot identify the wallet any further before preparing the Request Object, only Static Discovery metadata is used.
The aud claim of the signed Request Object MUST be "https://self-issued.me/v2", 

### 5.9. Client Identifier Prefix and Verifier Metadata Management
#### 5.9.2. Fallback
Fallback when no / an unknown Client Identifier Prefix is present MUST be intepreted as `decentralized_identifier`

#### 5.9.3. Defined Client Identifier Prefixes
Client Identifier Prefix `decentralized_identifier` MUST be supported and SHOULD be used.

Example: `decentralized_identifier:did:webvh:.....`

?? state? (Warnung) Change since discussion - Remove statement about other client identifier prefixes: Any other Client Identifier Prefix is NOT be supported. 

Client Identifier Prefix `verifier_attestation` MUST be supported and SHOULD be used for proximity use cases.

### 5.10. Request URI Method post
Request URI method `post` is NOT SUPPORTED 

### 5.11. Verifier Info
Verifier Info is NOT SUPPORTED.

## 6. Digital Credentials Query Language (DCQL)
### 6.1. Credential Query
#### 6.1.1. Trusted Authorities Query
None of the trusted_authorities defined in the spec apply for the swiss trust infrastructure, instead a new did based authorities query is used.


Type: "did"

Value: A list of VC issuer DIDs that the Verifier will accept

```
{
  "type": "did",
  "values": ["did:webvh:<scid>:www.example.com", "did:webvh:<scid>:www.admin.ch", "did:webvh:<scid>:www.ch.ch", "did:web:www.srf.ch"]
}
```

?? should the note be published?

## 7. Claims Path Pointer
### 7.2. Semantics for ISO mdoc-based credentials
ISO mdoc-based credentials are NOT SUPPORTED

## 8. Response
Response type MUST be `vp_token`.

Response mode MUST be `direct_post.jwt`.

The usage of encryption MUST be enforced.

### 8.4 Transaction Data
Transaction Data is NOT SUPPORTED and SHOULD NOT be used in this swiss-profile version.

### 8.5 Error Response
- `invalid_request_uri_method` is NOT SUPPORTED
- `invalid_transaction_data` is NOT SUPPORTED
- `vp_formats_not_supported` is NOT SUPPORTED
- `wallet_unavailable` is NOT SUPPORTED

## 9. Wallet Invocation
URL scheme `openid4vp://` and `swiyu-verify://` MUST be supported.

## 10 Wallet Metadata
### 10.2 Obtaining Wallet's Metadata
Verifier has pre-obtained a static set of the Wallet's metadata as defined by this swiss profile verification.

## 12 Verifier Attestation JWT
Verifier Attestation JWT SHOULD be used by the Wallet to validate authenticity of the Verifier in proximity use cases.

Otherwise, the Wallet SHOULD use Trust Protocol mechanisms instead to validate authenticity of the Verifier.

??(Warnung)  MISSING: Verification Deep Link Concept Data Egger Fabrice BIT Amrein Patrick BIT 

# RFC 9101 The OAuth 2.0 Authorization Framework: JWT-Secured Authorization Request (JAR)
## 6. Validating JWT-Based Requests
### 6.1. JWE Encrypted Request Object
JWE Encrypted Request Objects are NOT SUPPORTED.
