---
title: "Swiss Profile Verification"
toc: true
toc_sticky: true
excerpt: Specifications for OpenID4VP and JAR
header:
  teaser: ../assets/images/swiss-profile-verification.jpg
---


<div class="notice--info">
  Version 1.0 <br>
  Status: draft - technically complete, but might to be reformulated
</div>


# Introduction

This profile concerns itself with how a wallet is **presenting VCs** to a relying party, henceforth called verifier. It excludes the details on the VC or establishing trust between wallet and verifier.

## Cryptography
To decrease complexity, initially the cryptographic options are limited to following algorithms.
- JWS algorithm **MUST** be ES256.
- Encryption **MUST** use only ECDH-ES with P-256 Keys with A256GCM algorithm.
- If using encryption is possible, it **MUST** be used.

## Specifications

All underlying specifications referenced by the included standards are considered fully supported unless explicitly noted otherwise.

The following sections point out implementation notes and gaps pertaining to the supported specifications.

The specifications are fully supported by this profile (and components adhering to it) except for the specific cases mentioned in the following sections.

| Contained Specifications | Version | Link to referenced Specification |
| ---- | ---- | ---- |
| OpenID4VP | 1.0 | [OpenID for Verifiable Credential Presentation (OID4VP) v1.0](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html) |
| JAR | RFC-9101 | [RFC9101 - The OAuth Authorization Framework: JWT-Secured Authorization Request (JAR)](https://www.rfc-editor.org/rfc/rfc9101) |

**KEY WORDS** for this swiss profile expand on RFC 2119 "Key words for use in RFCs to Indicate Requirement Levels". They are explained in the [general introduction for the specifications](https://swiyu-admin-ch.github.io/specifications/introduction/#key-words). They are to be interpreted as such when, and only when, they appear **bold** and CAPITALIZED.


# OpenID for Verifiable Presentations 1.0

The specification is fully supported by this profile (and components adhering to it) except for the specific cases mentioned in the following subsections.

<div class="notice--warning">
The below sub-sections rely on the numbering from the original reference specification for ease of reference and comparison.
</div>

## 5. Authorization Request

Verifiers **MUST** send Verification Requests as a JWT-Secured Authorization Request (JAR).
- `client_id` **MUST** be the key id (`kid`) JAR without suffix fragment. If the `client_id` contains the prefix "`decentralized_identifier:`" it **MUST** be removed before the comparison.
- `client_id` **MUST** be the verifier's identifier as defined in [swiss-profile-anchor](/swiss-profile-anchor/) And **MAY** be prefixed with the Client Identifier Prefix.
- The client ID values in the `client_id` request parameter and in the Request Object `client_id` claim **MUST** be identical, as defined in RFC 9101

For Online Verification only passing a request object by reference is supported.

Swiss Profile version indication with parameter profile_version in JWT-Secured Authorization Request header is **REQUIRED**.

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

- `jwks` is **REQUIRED**
- `encrypted_response_enc_values_supported` is **REQUIRED**
- `vp_formats_supported` is **NOT SUPPORTED**, credential format identifier is determined in DCQL query's `format` parameter
- `request_uri_method` is **NOT SUPPORTED**, HTTP GET request is made by the Wallet
- `transaction_data` is **NOT SUPPORTED**
- `verifier_info` is **RECOMMENDED**
  - `verifier_info.credential_ids` is **NOT SUPPORTED**


Swiss Profile version indication with new parameter `profile_version` is **REQUIRED**.

### 5.2 Existing Parameters
- `response_mode` **MUST** be direct_post.jwt

### 5.5 Using scope Parameter to Request Presentations
`scope` parameter **MUST** be supported.<br>
When `scope` parameter is set, an object in the `verifier_info` **MUST** contain the scope with the DCQL query.

### 5.8. aud of a Request Object
As the verifier cannot identify the wallet any further before preparing the Request Object, only Static Discovery metadata is used.<br>
The `aud` claim of the signed Request Object **MUST** be "https://self-issued.me/v2", 

### 5.9. Client Identifier Prefix and Verifier Metadata Management
#### 5.9.2. Fallback
Fallback when no / an unknown Client Identifier Prefix is present **MUST** be intepreted as `decentralized_identifier`.

#### 5.9.3. Defined Client Identifier Prefixes
Client Identifier Prefix `decentralized_identifier` **MUST** be supported and **SHOULD** be used.<br>

Example: `decentralized_identifier:did:webvh:.....`<br>

### 5.10. Request URI Method post
Request URI method `post` is **NOT SUPPORTED**. 

## 6. Digital Credentials Query Language (DCQL)
### 6.1. Credential Query
`multiple` is **NOT SUPPORTED** - only a single credential can be used in a verification.

#### 6.1.1. Trusted Authorities Query
None of the trusted_authorities defined in the spec apply for the swiyu Trust Infrastructure, instead a new DID based authorities query is used.


Type: "did"

Value: A list of VC issuer DIDs that the Verifier will accept

```
{
  "type": "did",
  "values": ["did:webvh:<scid>:www.example.com", "did:webvh:<scid>:www.admin.ch", "did:webvh:<scid>:www.ch.ch"]
}
```

## 7. Claims Path Pointer
### 7.2. Semantics for ISO mdoc-based credentials
ISO mdoc-based credentials are **NOT SUPPORTED**.

## 8. Response
Response type **MUST** be `vp_token`.<br>
Response mode **MUST** be `direct_post.jwt`.<br>
The usage of encryption **MUST** be enforced.

### 8.4 Transaction Data
Transaction Data is **NOT SUPPORTED** and **SHOULD NOT** be used in this swiss-profile-verification version.

### 8.5 Error Response
- `invalid_request_uri_method` is **NOT SUPPORTED**
- `invalid_transaction_data` is **NOT SUPPORTED**
- `vp_formats_not_supported` is **NOT SUPPORTED**
- `wallet_unavailable` is **NOT SUPPORTED**

## 9. Wallet Invocation
URL scheme `openid4vp://` and `swiyu-verify://` **MUST** be supported.

## 10 Wallet Metadata
### 10.2 Obtaining Wallet's Metadata
Verifier has pre-obtained a static set of the Wallet's metadata as defined by this swiss profile verification.<br>
Dynamic fetching of the wallet's metadata is **NOT SUPPORTED**.<br>
The vp_formats_supported of the static metadata is: <br>

```
{
  "vp_formats_supported": {
    "dc+sd-jwt": {
      "sd-jwt_alg_values": ["ES256", "EdDSA"]
}
```

## 11 Verifier Metadata (Client Metadata)
The following client metadata fields **MUST** be supported

- `client_name`: **OPTIONAL**. Human-readable string name of the Verifier to be presented to the end-user during authorization. The field **MAY** be internationalized, as described in [Section 2.2](https://datatracker.ietf.org/doc/html/rfc7591#section-2.2).
- `logo_uri`: **OPTIONAL**. URL string that references a logo for the Verifier. **MUST** be a Data-URL (data URI schema) with MIME type `image/jpeg` or `image/png` and be base64 encoded. The field **MAY** be internationalized, as described in [Section 2.2](https://datatracker.ietf.org/doc/html/rfc7591#section-2.2).

## 12 Verifier Attestation JWT
Verifier Attestation JWT **SHOULD** be used by the Wallet to validate authenticity of the Verifier in proximity use cases.<br>

Otherwise, the Wallet **SHOULD** use Trust Protocol mechanisms instead to validate authenticity of the Verifier.

## Implementation Considerations

### Authorization Response Size

{% capture notice-text %}

Generally verifiers are recommended to tailor the size of accepted presentations to their use case and to keep them small enough to prevent the risk of overloading systems/DoS.

The recommended supported authorization response (aka presentation) size is the current [max payload limit](/swiss-profile-issuance/#83-credential-response) of accepted VCs plus one MB.

In order to be guaranteed to work with VCs presented by the swiyu Wallet a verifier needs to support a <b>presentation size of 21MB</b>.

{% endcapture %}

<div class="notice--info">
  <h3 class="no_toc">Implementation Recommendation</h3>
  {{ notice-text | markdownify }}
</div>

# RFC 9101 The OAuth 2.0 Authorization Framework: JWT-Secured Authorization Request (JAR)
## 6. Validating JWT-Based Requests
### 6.1. JWE Encrypted Request Object
JWE Encrypted Request Objects are **NOT SUPPORTED**.
