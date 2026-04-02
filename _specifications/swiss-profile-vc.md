---
title: "Swiss Profile for Verifiable Credentials"
toc: true
toc_sticky: true
excerpt: Specifications for Token Status List, SD-JWT, SD-JWT-VC and OCA

---

<div class="notice--info">
  Version 1.0
  Status: draft - technically complete, but might to be reformulated
</div>

# Summary

This profile concerns itself with how a wallet is presenting VCs to a relying party, henceforth called verifier. It excludes the details on the VC or establishing trust between wallet and verifier.

All underlying specifications referenced by the included standards are considered fully supported unless explicitly noted otherwise.

| Contained Specifications | Version | Link to referenced Specification |
| ---- | ---- | ---- |
| OpenID4VP | 1.0 | [OpenID for Verifiable Presentations OID4VP) v1.0](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html) |
| JAR | RFC:9101 | [https://www.rfc-editor.org/rfc/rfc9101](https://www.rfc-editor.org/rfc/rfc9101) |

# Cryptography
To decrease complexity, initially the cryptographic options are limited to following algorithms.

- JWS algorithm used is ES256.
- Encryption MUST uses only ECDH-ES with P-256 Keys with A128GCM or A256GCM algorithm. If using encryption is possible, it MUST be used.

# OpenID for Verifiable Presentations v1.0

The specification is fully supported by this profile (and components adhering to it) except for the specific cases mentioned in the following subsections. <br>

<div class="notice--warning">
The below sub-sections rely on the numbering from the original reference specification for ease of reference and comparison.
</div>

5. Authorization Request<br>
Verifiers MUST send Verification Requests as a JWT-Secured Authorization Request (JAR).<br>
- client_id MUST be the issuer (iss) of the JAR
- client_id MUST be the verifier's identifier as defined in swiss anchor profile
The client ID values in the client_id request parameter and in the Request Object client_id claim MUST be identical, as defined in [RFC 9101](todo)<br>

For Online Verification only passing a request object by reference is supported.

Swiss Profile version indication with parameter profile_version in JWT-Secured Authorization Request header is REQUIRED.

``
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
``

5.1. New Parameters
- jwks is REQUIRED
- encrypted_response_enc_values_supported is REQUIRED
- vp_formats_supported is NOT SUPPORTED, credential format identifier is determined in DCQL query's format parameter
- request_uri_method is NOT SUPPORTED, HTTP GET request is made by the Wallet
- transaction_data is NOT SUPPORTED
- verifier_info is RECOMMENDED
- verifier_info.credential_ids is NOT SUPPORTED

Swiss Profile version indication with new parameter profile_version is REQUIRED.

5.2. Existing Parameters
- response_mode MUST be direct_post.jwt
  
5.5 Using scope Parameter to Request Presentations<br>
scope parameter MUST be supported.<br>
When scope parameter is set, an object in the verifier_info MUST contain the scope with the DCQL query.<br>

5.8. aud of a Request Object<br>
As the verifier cannot identify the wallet any further before preparing the Request Object, only Static Discovery metadata is used.<br>
The aud claim of the signed Request Object MUST be "https://self-issued.me/v2", <br>

5.9. Client Identifier Prefix and Verifier Metadata Management<br>
5.9.2. Fallback<br>
Fallback when no / an unknown Client Identifier Prefix is present MUST be intepreted as decentralized_identifier<br>

5.9.3. Defined Client Identifier Prefixes<br>
Client Identifier Prefix decentralized_identifier MUST be supported and SHOULD be used.<br>
Example: ``decentralized_identifier:did:webvh:.....??<br>
Client Identifier Prefix verifier_attestation MUST be supported and SHOULD be used for proximity use cases.<br>

5.10. Request URI Method post<br>
Request URI method post is NOT SUPPORTED<br> 

5.11. Verifier Info<br>
Verifier Info is NOT SUPPORTED.<br>

6. Digital Credentials Query Language (DCQL)<br>
6.1. Credential Query<br>
6.1.1. Trusted Authorities Query<br>
None of the trusted_authorities defined in the spec apply for the swiss trust infrastructure, instead a new did based authorities query is used<br>
Type: "did"<br>
Value: A list of VC issuer DIDs that the Verifier will accept<br>

``
{
  "type": "did",
  "values": ["did:webvh:<scid>:www.example.com", "did:webvh:<scid>:www.admin.ch", "did:webvh:<scid>:www.ch.ch", "did:web:www.srf.ch"]
}
``

7 Claims Path Pointer<br>
7.2. Semantics for ISO mdoc-based credentials<br>
ISO mdoc-based credentials are NOT SUPPORTED<br>

8. Response<br>
Response type MUST be vp_token<br>
Response mode MUST be direct_post.jwt.<br>
The usage of encryption MUST be enforced.<br>

8.4 Transaction Data<br>
Transaction Data is NOT SUPPORTED and SHOULD NOT be used in this swiss-profile version.<br>

8.5 Error Response
- invalid_scope is NOT SUPPORTED
- invalid_request_uri_method is NOT SUPPORTED
- invalid_transaction_data is NOT SUPPORTED
- vp_formats_not_supported is NOT SUPPORTED
- wallet_unavailable is NOT SUPPORTED
  
9. Wallet Invocation<br>
URL scheme ``openid4vp:// and swiyu-verify://`` MUST be supported.<br>

10 Wallet Metadata<br>
10.2 Obtaining Wallet's Metadata<br>
Verifier has pre-obtained a static set of the Wallet's metadata as defined by this swiss profile verification.<br>

12 Verifier Attestation JWT<br>
Verifier Attestation JWT SHOULD be used  by the Wallet to validate authenticity of the Verifier in proximity use cases.<br>
Otherwise, the Wallet SHOULD use Trust Protocol mechanisms instead to validate authenticity of the Verifier.<br>

# RFC 9101 The OAuth 2.0 Authorization Framework: JWT-Secured Authorization Request (JAR)

6. Validating JWT-Based Requests<br>
6.1. JWE Encrypted Request Object<br>
JWE Encrypted Request Objects are NOT SUPPORTED.<br>






