---
title: "Swiss Profile Issuance"
toc: true
toc_sticky: true
excerpt: Specifications for OAuth 2.0 DPoP and OpenID4VCI

---


<div class="notice--info">
  Version: 1.0 <br>
  Status: draft - technically complete, but might to be reformulated
</div>


# Summary

This profile defines the capabilities required to issue **Verifiable Credentials (VCs)** to a holder’s wallet. It deliberately **does not** cover the structure or semantics of the credentials themselves, nor does it address trust establishment between wallets, issuers, or other ecosystem entities.

All underlying specifications referenced by the included standards are considered fully supported unless explicitly noted otherwise.

| Contained Specifications | Version | Link to referenced Specification |
| ---- | ---- | ---- |
| OpenID4VCI | 1.0 | [OpenID for Verifiable Credential Issuance (OID4VCI) v1.0](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html) |
| OAuth 2.0 DPoP | RFC-9449 | [RFC9449 - Demonstrating Proof of Possession (DPoP)](https://datatracker.ietf.org/doc/html/rfc9449) |

# Cryptography
To decrease complexity, initially the cryptographic options are limited to following algorithms.
- JWS algorithm MUST be ES256.
- Encryption MUST uses only ECDH-ES with P-256 Keys with A128GCM or A256GCM algorithm.
- If zipping is possible, Deflate (DEF) MUST be used.
- If using encryption is possible, it MUST be used.

  
# OpenID for Verifiable Credential Issuance (OID4VCI) v1.0

This section details the implementation notes and gaps pertaining to the supported specifications.

The specifications are fully supported by this profile (and components adhering to it) except for the specific cases mentioned in the following subsections.

<div class="notice--warning">
The below sub-sections rely on the numbering from the original reference specification for ease of reference and comparison.
</div>

3. Overview <br>
3.3. Core Concepts <br>
**3.3.1. Credential Formats and Credential Format Profiles** <br>
Swiss Profile Issuance only supports IETF SD-JWT VC (see [Swiss Profile VC](todo)) <br>
Credential Format Profiles "ISO mdoc" and "W3C VCDM" are not supported. <br>

**3.3.3 Issuance Flow Variations** <br>
Pre-Authorized Code Flow MUST be supported.<br>
Authorization Code Flow and Wallet initiated communication are not supported.<br>

**3.3.4. Identifying Credentials Being Issued Throughout the Issuance Flow** <br>
authorization_details is not used. It is expected that the credential issuer links the credential to be issued to the wallet through the pre-authorized_code.<br>
scope is NOT used.<br>

**3.4. Authorization Code Flow** <br>
Authorization Code Flow is NOT SUPPORTED.<br>

**3.5. Pre-Authorized Code Flow** <br>
(4) Token Request requires use of Demonstrating Proof of Possession (DPoP)<br>
Registering a DPoP key MUST come with a key attestation (with the same [security level](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html#name-attack-potential-resistance) as allowed by the issuer for the holder binding key) in case where a hardware-bound credential is requested. <br>
Transaction Code tx_code MUST be supported. The use of Transaction Code is optional, but recommended.<br>
Wallets MUST support 6 digit tx_codes. Issuers SHOULD invalidate a credential offer after 5 failed retries.<br>

4. Credential<br>
**4.1. Credential Offer** <br>
`credential_offer` MUST be supported.<br>
`credential_offer_uri` is NOT SUPPORTED (Warnung) Must be evaluated if part of Swiss Profile 1.0; candidate Swiss Profile 1.1<br>

**4.1.1.Credential Offer Parameters** <br>
Grant Type `authorization_code` is NOT SUPPORTED<br>
`authorization_server` is NOT SUPPORTED. It is expected that the Credential Issuer Server is also the authorization server.<br>
The array `credential_configuration_ids` SHOULD have only one (1) entry. If there are more than one entries the wallet SHOULD only use the first.<br>

**4.1.2. Sending Credential Offer by Value Using credential_offer Parameter** <br>
Both URL schemes `openid-credential-offer://` and `swiyu://` MUST be supported by wallets.<br>

**5. Authorization Endpoint** <br>
Authorization Endpoint is NOT SUPPORTED.<br>

**6. Token Endpoint**<br>
Issuers and Wallets MUST support pre-authorized_code.<br>
For Verifiable Credential Lifecycle such as renewal, Wallets MUST support refresh_token. Issuers MAY support refresh_tokens.<br>
Requests to the token endpoint MUST be sent with a DPoP Header.<br>

**6.1.1 Request Credential Issuance using authorization_details Parameter** <br>
authorization_details are NOT supported<br>

**6.2. Successful Token Response** <br>
Authorization server MUST NOT return authorization_details<br>

**7. Nonce Endpoint** <br>
It is RECOMMENDED that the nonce is a a self contained nonce, which the issuer can decern to be not valid without registering every nonce which has been requested from this public endpoint.<br>
A self-contained nonce refers to a single-use string or number that carries all necessary information for its validation within itself, eliminating the need for storing possible valid nonces which have not been used. <br>

**7.2. Nonce Response** <br>
Issuers MUST provide a DPoP nonce.<br>

**8. Credential Endpoint** <br>
Wallets MUST support key attestation.<br>

**8.2. Credential Request** <br>
Requests MUST be sent with a DPoP Header.<br>
`credential_identifier` is NOT supported.<br>
`credential_configuration_id` MUST be set to credential_configuration_id from the credential offer.<br>
`credential_response_encryption` MUST be used.<br>

**8.3. Credential Response** <br>
The number of elements in the credentials array MUST match the exact number of keys that the Wallet has provided via the proofs parameter of the Credential Request. 
`notification_id` is NOT supported.<br>

**9. Deferred Credential Endpoint** <br>
Requests MUST be sent with a DPoP Header.<br>

**11. Notification Endpoint** <br>
Notification Endpoint MUST NOT be supported by the wallet for privacy reasons.<br>

**12. Metadata**<br>
12.1. Client Metadata<br>
Client Metadata is NOT SUPPORTED.<br>

12.2. Credential Issuer Metadata<br>
**12.2.2. Credential Issuer Metadata Retrieval** <br>
Issuers and Wallets MUST support well-known URIs as described in [OID Connect Discovery](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfigurationRequest) (OIDC) with appended .well-known path.<br>

For example `https://example.com/issuer1` will lead to an HTTP call: 

``` Example for OIDC style .well-known URI
GET https://example.com/issuer1/.well-known/openid-configuration 
```

Wallets MUST support well-known URIs as described in IETF [RFC 5785](https://datatracker.ietf.org/doc/html/rfc5785) where the well-known URI is inserted at the beginning of the path component of an URI.<br>
Issuers SHOULD support these well-known URIs.<br>

For example `https://example.com/issuer1` will lead to an HTTP call: 

``` Example for RFC 5785 style .well-known URI
GET https://example.com/.well-known/openid-configuration/issuer1
```

12.2.3. Signed Metadata<br>
Issuers MUST also provide Signed Metadata.<br>
The wallet MUST request signed metadata.<br>
Signed Metadata MUST be used.<br>
The signed metadata MUST be verified according swiss trust system. <br>
The kid header claim is REQUIRED and must be a absolute fragment containing a DID as described in swiss-profile-anchor.<br>

Swiss Profile version indication with parameter `profile_version` in Credential Issuer Metadata JWT header is REQUIRED.

``` Credential Issuer Metadata JWT version
{
  // header
  "typ":"openidvci-issuer-metadata+jwt",
  "alg":"ES256",
  "profile_version": "swiss-profile-issuance:1.0.0"
}
.
{
  // payload
}
```

12.2.4. Credential Issuer Metadata Parameters
- authorization_servers is NOT SUPPORTED.
- notification_endpoint is NOT SUPPORTED.
- nonce_endpoint is REQUIRED
- credential_request_encryption is REQUIRED.
- credential_response_encryption is REQUIRED.
- batch_credential_issuance is RECOMMENDED for privacy relevant use-cases.
  - batch_size is REQUIRED. Integer value MUST be at least 10 specifying the maximum array size for the proofs parameter in a Credential Request.
    The wallet MAY send fewer proofs than defined in the batch size. The Issuer MUST create as many Credentials as proofs received.
- display is RECOMMEND to properly display issuer information to wallets
  - logo remains OPTIONAL
    - uri MUST be a Data-URL (data URI schema) with MIME-type (media type) image/jpeg or image/png and be base64 encoded.
      This means the uri must begin with data:image/png;base64  or data:image/jpeg;base64 
- credential_configurations_supported 
  - scope is NOT SUPPORTED
  - cryptographic_binding_methods_supported MUST be jwk as only JWK format for holder bindings are supported.
  - proof_types_supported MUST be jwt as only JWT format is supported.
    - key_attestations_required MUST be supported by wallets, and MAY be used by issuers.
- credential_metadata 
  - display MAY be used as fallback to OCA
    - logo remains OPTIONAL
      - uri MUST be a Data-URL (data URI schema) with MIME-type (media type) image/jpeg or image/png and be base64 encoded.
        This means the uri must begin with data:image/png;base64  or data:image/jpeg;base64  
    - background_image is NOT SUPPORTED
    - text_color  is NOT SUPPORTED
  - claims remains OPTIONAL
    - mandatory  is NOT SUPPORTED

Swiss Profile version indication with parameter profile_version in Credential Issuer Metadata JSON body is REQUIRED.

``` Credential Issuer Metadata version
{
  "profile_version": "swiss-profile-issuance:1.0.0"
  ...
}
```

12.3. OAuth 2.0 Authorization Server Metadata<br>
The OAuth 2.0 Authorization Server Metadata are provided signed the same way as defined in 12.2.3. Signed Metadata for credential issuer metadata as application/jwt.<br>

13. Security Considerations<br>
13.6. Pre-Authorized Code Flow<br>
Issuer SHOULD accept pre-authorized codes only once.<br>
When providing the Pre-Authorized Code as QR code, issuers SHOULD use the transaction code (tx_code) and provide it though a secondary channel (text message or email).<br>

13.11. Application-Layer Encryption<br>
Application-Layer encryption MUST be used for request and response.<br>
Encryption JWK MUST include the alg claim. The alg claim MUST be ECDH-ES.<br>

14. Implementation Considerations<br>
14.5. Refreshing Issued Credentials<br>
Wallets can refresh Credentials by re-requesting them at the Credential Endpoint with a valid Access Token and DPoP.<br>
Issuers can always refuse the refresh.<br>
If refused because a refresh is already in progress, Issuer MUST respond with error code 429 (Too Many Requests).<br>

14.6. Batch Issuing Credentials<br>
The Wallet MUST send at maximums the amount of proofs defined in the issuer metadata batch_size.<br>
The Issuer MUST send exactly as many credentials as proofs received.<br>
The Issuer should only use Batch Issuing if unlinkability of Verifiers is desired.<br>
Batch Issuance should not be used for credentials that rely on use cases where the data itself can be used to link different presentations.<br>
There is no guarantee that any wallet uses a credential of a batch only once. Issuers and Verifiers should not rely on the fact that a credential in a batch is only shown once in the wallet. Batch issuing is therefore not suited for a batch of credentials like e.g., day passes, multi ride tickets or loyalty cards as the content of a credential in a batch is required to be equal. <br>

14.A Batch Issuance - Batch Size<br>
The batch size MUST be at least 10, to ensure holder privacy. If holder were to refresh credentials often due to a small batch size, issuers could easily gather telemetry data.<br>
Wallets SHOULD define a limit how many credentials can be issued in one batch, to prevent being overloaded by exceedingly large batch sizes. This can be done by limiting the amount of proof of possessions being created.<br>

Appendix A. Credential Format Profiles<br>
Only Supported Credential Format Profile is IETF SD-JWT VC<br>

A.3. IETF SD-JWT VC<br>
A.3.2. Credential Issuer Metadata<br>
The following additional Credential Issuer metadata parameters are defined for this Credential Format for use in the credential_configurations_supported parameter, in addition to those defined in Section 12.2.4.
- vct REQUIRED
- vct_extends OPTIONAL - If used in the Credential being issued RECOMMENDED  todo!
- vct_metadata_uri OPTIONAL - If used in the Credential being issued RECOMMENDED

Appendix D. Key Attestations<br>
Wallets MUST support key attestations.<br>
D.1. Key Attestation in JWT format<br>

Swiss Profile version indication with parameter profile_version in the key attestation JWT header is REQUIRED.

``` Key Attestation JWT version
{
  // header
  "typ":"key-attestation+jwt",
  "alg":"ES256",
  "profile_version": "swiss-profile-issuance:1.0.0"
}
.
{
  // payload
}
```

# OAuth 2.0 Demonstrating Proof of Possession (DPoP) - RFC 9449

todo: intro<br>

4. DPoP Proof JWTs<br>
4.2. DPoP Proof JWT Syntax<br>
Swiss Profile version indication with parameter profile_version in DPoP JWT header is REQUIRED.<br>

``` DPoP JWT version
{
  // header
  "typ":"dpop+jwt",
  "alg":"ES256",
  "profile_version": "swiss-profile-issuance:1.0.0"
}
.
{
  // payload
}
```

5. DPoP Access Token Request<br>
5.1. Authorization Server Metadata<br>
If dpop_signing_alg_values_supported is missing it MUST be assumed that the list of supported JWS alg values are the ones listed in this profile under Cryptography.<br>

5.2. Client Registration Metadata<br>
Client Registration Metadata is NOT SUPPORTED. dpop_bound_access_tokens are always presumed to be true.<br>

6. Public Key Confirmation<br>
NOT SUPPORTED. It is assumed that both roles of resource server and authorization server will be fulfilled by the credential issuer.<br>

8.  Authorization Server-Provided Nonce <br>
Credential Issuers MUST provide DPoP-Nonces.<br>
Fresh DPoP Nonces MUST be provided in the response of the OID4VCI Nonce Endpoint.<br>

10. Authorization Code Binding to a DPoP Key<br>
Credential Issuer MUST bind Authorization Code to the Holder's DPoP key.<br>


Appendix <br>
DPoP is expanded with the additional features<br>

Key Attestation<br>
When the one of the credentials offered by the issuer require a key attestation for a hardware bound key (iso_18045_high) , the key used for DPoP has the same requirement. In this case, the wallet MUST provide a Key Attestation JWT as described in OID4VCI Appendix D as part of the DPoP used when registering the public key with the first DPoP Access Token Request. The Issuer MUST validate this first key attestation. If the key attestation is not valid, the Issuer MUST reject the whole DPoP.</br>
In further requests using the same key, the wallet SHOULD NOT include the key attestation in the DPoP. The issuer MUST treat these additional key attestations as unknown parameters.<br>
The key attestation is included in the JWT-Header of the DPoP as the claim key_attestation.<br>

``` Example DPoP with key attestation
{
  "typ": "dpop+jwt",
  "alg": "ES256",
  "jwk": {
      "kty": "EC",
      "crv": "P-256",
      "x": "TCAER19Zvu3OHF4j4W4vfSVoHIP1ILilDls7vCeGemc",
      "y": "ZxjiWWbZMQGHVWKVQ4hbSIirsVfuecCE6t4jT9F2HZQ"
    },
    "key_attestation": "eyJ0eXAiOiJrZXktYXR0ZXN0YXRpb24rand0IiwiYWxnIjoiRVMyNTYiLCJraWQiOiJkaWQ6d2Vidmg6ZXhhbXBsZS5jb20ja2V5LTEiLCJwcm9maWxlX3ZlcnNpb24iOiJzd2lzcy1wcm9maWxlLWlzc3VhbmNlOjEuMC4wIn0.eyJpc3MiOiJkaWQ6d2Vidmg6ZXhhbXBsZS5jb20iLCJpYXQiOjE1MTYyNDcwMjIsImV4cCI6MTU0MTQ5MzcyNCwia2V5X3N0b3JhZ2UiOlsiaXNvXzE4MDQ1X2hpZ2giXSwiYXR0ZXN0ZWRfa2V5cyI6W3sia3R5IjoiRUMiLCJjcnYiOiJQLTI1NiIsIngiOiJUQ0FFUjE5WnZ1M09IRjRqNFc0dmZTVm9ISVAxSUxpbERsczd2Q2VHZW1jIiwieSI6Ilp4amlXV2JaTVFHSFZXS1ZRNGhiU0lpcnNWZnVlY0NFNnQ0alQ5RjJIWlEifV19.sj4ulKVk8Xm-Nd-9aODEXI_YpVqPv7llM2fJqZz9R279QN-2g08Rw6U-Dy3u84BVXPYi9B1Wki7mcubO21RrXw",
    "profile_version": "swiss-profile-issuance:1.0.0"
}.{
  "jti": "-BwC3ESc6acc2lTc",
  "htm": "POST",
  "htu": "https://server.example.com/token",
  "iat": 1562262616
}
```

``` Example DPoP Access Token Request with key attestation
POST /token HTTP/1.1
Host: server.example.com
Content-Type: application/x-www-form-urlencoded
DPoP: eyJ0eXAiOiJkcG9wK2p3dCIsImFsZyI6IkVTMjU2IiwiandrIjp7Imt0eSI6IkVDIiwiY3J2IjoiUC0yNTYiLCJ4IjoiVENBRVIxOVp2dTNPSEY0ajRXNHZmU1ZvSElQMUlMaWxEbHM3dkNlR2VtYyIsInkiOiJaeGppV1diWk1RR0hWV0tWUTRoYlNJaXJzVmZ1ZWNDRTZ0NGpUOUYySFpRIn0sImtleV9hdHRlc3RhdGlvbiI6ImV5SjBlWEFpT2lKclpYa3RZWFIwWlhOMFlYUnBiMjRyYW5kMElpd2lZV3huSWpvaVJWTXlOVFlpTENKcmFXUWlPaUprYVdRNmQyVmlkbWc2WlhoaGJYQnNaUzVqYjIwamEyVjVMVEVpTENKd2NtOW1hV3hsWDNabGNuTnBiMjRpT2lKemQybHpjeTF3Y205bWFXeGxMV2x6YzNWaGJtTmxPakV1TUM0d0luMC5leUpwYzNNaU9pSmthV1E2ZDJWaWRtZzZaWGhoYlhCc1pTNWpiMjBpTENKcFlYUWlPakUxTVRZeU5EY3dNaklzSW1WNGNDSTZNVFUwTVRRNU16Y3lOQ3dpYTJWNVgzTjBiM0poWjJVaU9sc2lhWE52WHpFNE1EUTFYMmhwWjJnaVhTd2lZWFIwWlhOMFpXUmZhMlY1Y3lJNlczc2lhM1I1SWpvaVJVTWlMQ0pqY25ZaU9pSlFMVEkxTmlJc0luZ2lPaUpVUTBGRlVqRTVXbloxTTA5SVJqUnFORmMwZG1aVFZtOUlTVkF4U1V4cGJFUnNjemQyUTJWSFpXMWpJaXdpZVNJNklscDRhbWxYVjJKYVRWRkhTRlpYUzFaUk5HaGlVMGxwY25OV1puVmxZME5GTm5RMGFsUTVSakpJV2xFaWZWMTkuc2o0dWxLVms4WG0tTmQtOWFPREVYSV9ZcFZxUHY3bGxNMmZKcVp6OVIyNzlRTi0yZzA4Unc2VS1EeTN1ODRCVlhQWWk5QjFXa2k3bWN1Yk8yMVJyWHciLCJwcm9maWxlX3ZlcnNpb24iOiJzd2lzcy1wcm9maWxlLWlzc3VhbmNlOjEuMC4wIn0.eyJqdGkiOiItQndDM0VTYzZhY2MybFRjIiwiaHRtIjoiUE9TVCIsImh0dSI6Imh0dHBzOi8vc2VydmVyLmV4YW1wbGUuY29tL3Rva2VuIiwiaWF0IjoxNTYyMjYyNjE2fQ.wWQJzvfLCFqsEWN2UoiavFf_taZv33sRFFc5WuPYKn4WsJ2HKE3bppWXtkPHh20WIZiYkjH4GRW_VQAJQF9huQ

```

