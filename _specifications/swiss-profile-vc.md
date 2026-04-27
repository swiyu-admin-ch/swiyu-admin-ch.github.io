---
title: "Swiss Profile for Verifiable Credentials"
toc: true
toc_sticky: true
excerpt: Specifications for Token Status List, SD-JWT, SD-JWT-VC, and OCA

---

<div class="notice--info">
  Version 1.0
  Status: draft - technically complete, but might to be reformulated
</div>

# Summary

This profile concerns itself with how a **Verifiable Credential" (VC) in the swiyu Trust Infrastructure is structured. Components of the swiyu Trust Infrastructure can use verifiable credentials only if they satisfy the following specifications.

All underlying specifications referenced by the included standards are considered fully supported / needed unless explicitly noted otherwise.

| Contained Specifications | Version | Link to referenced Specification |
| ---- | ---- | ---- |
| Token Status List (TSL) | Standards Track (Draft 15) | [Token Status List (TSL) - Standards Track](https://www.ietf.org/archive/id/draft-ietf-oauth-status-list-15.html)) |
| SD-JWT | RFC-9901 | [RFC 9901: Selective Disclosure for JSON Web Tokens](https://www.rfc-editor.org/rfc/rfc9901.html) |
| SD-JWT-VC | Standards Track (Draft 15) | [SD-JWT-based Verifiable Digital Credentials (SD-JWT VC) - Standards Track](https://www.ietf.org/archive/id/draft-ietf-oauth-sd-jwt-vc-15.html) |
| Visualisation of Verifiable Credentials with OCA | 1.0 | Visualization of Verifiable Credentials with OCA |


# Cryptography
To decrease complexity, initially the cryptographic options are limited to following algorithms.
- JWS algorithm MUST use ES256.
- Hash function MUST be sha-256
- Encryption MUST use ECDH-ES with P-256 Keys with A128GCM algorithm.

If using encryption is possible, it MUST be used.

# Token Status List (TSL) Draft 15

This section details the implementation notes and gaps pertaining to the supported specifications.

The specification is fully supported by this profile (and components adhering to it) except for the specific cases mentioned in the following subsections. <br>

<div class="notice--warning">
The below sub-sections rely on the numbering from the original reference specification for ease of reference and comparison.
</div>

## 1. Introduction
In the swiyu Trust Infrastructure the roles of Issuer and Status Issuer are fulfilled by the same entity. The Base Registry, provided by FOITT, acts as the Status Provider.

## 4. Status List

4.2. Status List in JSON Format<br>
`aggreation_uri` is NOT supported<br>

4.3. Status List in CBOR Format<br>
Status List in CBOR Format is NOT supported<br>

## 5. Status List Token

5.1. Status List Token in JWT Format<br>
In addition to the already specified claims the JWT Claims Set MUST contain:
- `exp`: REQUIRED. As generally defined in [RFC7519]. The `exp` (expiration time) MUST be set and can be any time in the future.

The JWT header of the Status List Token MUST contain: 
- `kid`: REQUIRED. Must be an absolute `kid` as specified in [swiss-profile-anchor](#JWTValidationwithcryptographickeysfromDIDs).

The Status List Token MUST be signed by the same entity as the Referenced Token inside the SD-JWT VC but CAN use a different key.<br>

Swiss Profile version indication with parameter `profile_version` in Status List Token JWT header is REQUIRED.<br>

```
{
  // header
  "typ": "statuslist+jwt",
  "alg": "ES256",
  "profile_version": "swiss-profile-vc:1.0.0"
}
.
{
  // payload
}
```

5.2. Status List Token in CWT Format<br>
Status List Token in CWT Format is NOT SUPPORTED.<br>

## 6. Referenced Token

6.3. Referenced Token in COSE<br>
References Token in COSE is NOT SUPPORTED.<br>

## 7. Status Types

7.1. Status Types Values<br>
Accepted Status Types include only 0x00 - "VALID", 0x01 - "INVALID", and 0x02 - "SUSPENDED".<br>
All other Status Types are technically valid and shown as "UNKNOWN" in the swiyu Wallet.<br>

## 8. Verification and Processing

Only "application/statuslist+jwt" for Status List Token in JWT format is supported.<br>

8.4. Historical resolution<br>
Historical resolution is NOT SUPPORTED.<br>

## 9. Status List Aggregation

Status List Aggregation is NOT SUPPORTED.<br>

## 10. X.509 Certificate Extended Key Usage Extension

X.509 Certificate Extended Key Usage Extension is NOT SUPPORTED.<br>

## 11. Security Considerations

11.3. Key Resolution and Trust Management<br>
As specified above, the Status List Token MUST be signed by the same entity as the Referenced Token inside the SD-JWT VC. Issuers CAN use a different key for the signature. See [swiss-profile-anchor](JWTValidationwithcryptographickeysfromDIDs) for more detail.<br>

## 12. Privacy Considerations

12.1. Observability of Issuers<br>
To prevent observability of Issuers, the Status Provider MUST be the registry provided by FOITT. Participants MAY reject resolution if the URI inside the Reference Token points to another endpoint.  <br>

12.2. Issuer Tracking of Reference Tokens<br>
This risk is completely eliminated by forcing the Status Provider to be the registry and therefore different from the Issuer. <br>

12.6. External Status Provider for Privacy<br>
Status Issuer and Status Provider are forced to be different entities as the Status Provider MUST be the registry provided by FOITT. <br>

12.8. Status Types<br>
The decision whether use of the supported Status Type "SUSPENDED" is at the discretion of the Issuer. Information published to the Status List is considered to be public.<br>

## 13. Implementation Considerations

In addition to conformity checks documented in the standard, the registry performs additional checks on upload of a Status List:<br>

**Size Limits**: The Status List Token size MUST be greater than **200 bytes** and MUST NOT exceed **200 KB*. The decompressed Byte Array also MUST NOT exceed 200KB (~100'000 entries when using 2 bits per status). This ensures the registry remains performant while preventing the upload of empty or malformed headers.<br>
**Cryptographic Integrity**: The document MUST include a **valid digital signature**. Submissions with invalid, expired, or unsupported signature formats MUST be rejected.<br>

Additional checks to the content of the Status List Token are performed:

| Claim |	Requirement Type |	Validation Logic |
|-----|-----|-----|
| `kid` (Key Identifier) |	Initial Upload |	MUST match a Decentralized Identifier (DID) currently authorized and assigned to the submitting swiyu business partner. |
| `kid` (Key Identifier) | Subsequent Updates |	MUST be identical to the iss value of the previously recorded version of the Status List. |
| `iat` (Issued At) |	Freshness Check |	MUST be greater than T - 24 hours (where T represents the current system time). Documents older than 24 hours cannot be uploaded. |
| `exp` (Expiration) |	Validity Window |	MUST be present and MUST be greater than the current system time (T). |

# RFC 9901: Selective Disclosure for JSON Web Tokens

The specification is fully supported by this profile (and components adhering to it) except for the specific cases mentioned in the following subsections. <br>

<div class="notice--warning">
The below sub-sections rely on the numbering from the original reference specification for ease of reference and comparison.
</div>

## 4. SD-JWT and SD-JWT+KB Data Formats

4.1. Issuer-Signed JWT<br>
The payload MUST NOT contain one or more permanently disclosed claims.<br>

4.1.1. Hash Function Claim<br>
When used, the _sd_alg claim MUST be sha-256. Any other hash algorithm is NOT SUPPORTED.<br>

4.1.2. Key Binding<br>
The cnf claim with the jwk confirmation method MUST be used if the Issuer wants to enable Key Binding in the SD-JWT.<br>
Multiple bound keys in the same SD-JWT are NOT SUPPORTED.<br>

4.2. Disclosures<br>
4.2.2 Disclosures for Array Elements<br>
Disclosures for array elements MUST be supported and SHOULD be used when dealing with selectively disclosable arrays.<br>

4.2.5. Decoy Digests<br>
Decoy Digests are NOT SUPPORTED <br>

4.2.6. Recursive Disclosures<br>
Recursive Disclosures MUST be supported and SHOULD be used when dealing with nested selectively disclosable objects.<br>

4.3. Key Binding JWT<br>
JWT payload:
- aud: REQUIRED. The aud claim MUST be client_id that was sent in the JAR of the verifier (see swiss-profile-verification 1.0). Please respect the security considerations in the implementation: ValidationofaudclaiminKeyBindingJWT.
  
## 6 Considerations on Nested Data in SD-JWTs

6.1 Example: Flat SD-JWT<br>
Flat SD-JWT MUST be supported.<br>

6.3 Example: Structured SD-JWT<br>
Structured SD-JWT is NOT SUPPORTED.<br>

6.3 Example: SD-JWT with Recursive Disclosures<br>
Recursive SD-JWT disclosures MUST be supported and SHOULD be preferred.<br>

## 8. JWS JSON Serialization

JWS JSON Serialization is NOT SUPPORTED.<br>

## 9. Security Considerations

9.11. Explicit Typing<br>
As specified in chapter 3.1 of the SD-JWT-VC standard, the media type MUST be `application/dc+sd-jwt`.<br>

Validation of aud claim in Key Binding JWT<br>
The wallet MUST verify that the client_id belongs to the verifier to prevent identity fraud attacks. This SHOULD done by checking that the client_id refers to the same entity that signed the JWT Secured Authorization Requests (JAR) as outlined in [swiss-profile-anchor](#JWTValidationwithcryptographickeysfromDIDs).<br> 
Only after a successful verification SHOULD the wallet include this client_id into the aud claim of the Key Binding JWT. <br>

The verifier MUST ensure that the Key Binding JWT received during a presentation is intended for this verifier by checking the aud claim specified by the wallet.<br>

# SD-JWT-based Verifiable Credentials (SD-JWT VC)

<div class="notice--warning">
The below sub-sections rely on the numbering from the original reference specification for ease of reference and comparison.
</div>

## 3. Verifiable Digital Credentials based on SD-JWT

3.2. Data Format<br>
3.2.1. JOSE Header<br>

Swiss Profile version indication with parameter `profile_version` in SD-JWT-VC header is REQUIRED.<br>

```
{
  // header
  "typ": "dc+sd-jwt",
  "alg": "ES256",
  "profile_version": "swiss-profile-vc:1.0.0" 
}
.
{
  // payload
}
```

3.2.2. JWT Claims Set<br>
3.2.2.2  Registered JWT Claims<br>
The following additional JWT claims are used within the SD-JWT component of the SD-JWT VC and MUST NOT be included in Disclosures, i.e., cannot be selectively disclosed:
- `vct_metadata_uri`: OPTIONAL. URI pointing towards where the VC Type Metadata can be fetched. Takes precedence over vct claim Type Metadata resolution.
- `vct_metadata_uri#integrity`: OPTIONAL. SRI integrity hash for the resources loaded from the `vct_metadata_uri`.
- `iat`: OPTIONAL. Meaning as specified in the standard. Contrary to the standard, this claim is NOT allowed to be set as a disclosure.

  
The following registered JWT claims MUST be included in Disclosures:
- `sub`: OPTIONAL. Meaning as specified in the standard. Contrary to the standard, this claim is ONLY allowed to be set as a disclosure.
- `aud`: OPTIONAL. Meaning as specified in the standard. 
- `jti`: OPTIONAL. Meaning as specified in the standard. 

Additionally, if present for some use-cases, the following (business) claims MUST be included in disclosures
- `vct_version`: OPTIONAL. value is version (semver) of the `vct`.
- `vct_subtype`: OPTIONAL. value that can describe an adaption (more specific context) of the `vct`, that defines another standard that can be used by issuers, referenced in the standardization.
- `vct_subtype_version`: OPTIONAL. value is version (semver) of the `vct_subtype`.
- `expiry_date`: OPTIONAL. a date according to [RFC 8943] full-date. The validity of the business expiry is up to and including the entire day.
  
3.2.2.3 Public and Private JWT claims<br>
The only binary data claims supported are: 
- `data:image/png;base64,`
- `data:image/jpeg;base64,`

3.2.2.4. SD-JWT VC without Selectively Disclosable Claims<br>
An SD-JWT VC MUST NOT have no selectively disclosable claims. Any claim without Disclosure except listed in [3.2.2.2 Registered JWT Claims] MUST NOT be supported and MUST be rejected.<br>

3.5. Issuer Signature Mechanisms<br>
The Issuer Signature mechanism is described in [swiss-profile-anchor].<br>

## 4. JWT VC Issuer Metadata

JWT VC Issuer Metadata is NOT SUPPORTED.<br>

## 5. SD-JWT VC Type Metadata

Usage of SD-JWT VC Type Metadata is RECOMMENDED.<br>

Swiss Profile version indication with parameter `profile_version` in VCT body is REQUIRED.

```
{
  "vct": "https://betelgeuse.example.com/education_credential/v1",
  "name": "Betelgeuse Education Credential - First Version",
  "description": "This is our first version of the education credential.",
  "display": [
    {
      "locale": "en-US",
      "name": "Betelgeuse Education Credential",
      "description": "An education credential for all carbon-based life forms on Betelgeuse.",
      "rendering": {
        "oca": {
          "uri":"https://betelgeuse.example.com/education_credential/oca/oca-bundle.json",
          "uri#integrity":"sha256-9cLlJNXN-TsMk-PmKjZ5t0WRL5ca_xGgX3c1VLmXfh-WRL5"
        }
	  }
    }
  ],
  "profile_version": "swiss-profile-vc:1.0.0"
}
```

5.2. Type Metadata Format<br>
Property extends and extends#integrity are NOT SUPPORTED.<br>

The additional new properties are defined:
- `schema_uri`: OPTIONAL. a URI pointing to a JSON Schema describing the vct and its claims. If provided, Wallet MAY perform JSON Schema validation against the issued verifiable credential.
  
Additionally, `schema_uri#integrity` MAY be present as defined in [Section 6].<br>

5.3. Retrieving Type Metadata<br>
5.3.2. From a Registry<br>
Registry retrieval is NOT SUPPORTED.<br>

5.3.3. Using a Defined Retrieval Method<br>
A Consumer MAY use claim `vct_metadata_uri` to retrieve Type Metadata for a SD-JWT VC type. If `vct_metadata_uri` is present in the SD-JWT VC on root level (same level like claim vct), this method takes precedence over any other defined method to retrieve Type Metadata. If the type is a URL using the HTTPS scheme, Type Metadata MUST be retrieved using the HTTP GET method. A successful response MUST use an HTTP 200 status code and return a JSON object as defined in [Section 5.2] using the `application/json` content type. An error response MUST use the applicable HTTP status code value.<br>

If the claim `vct_metadata_uri#integrity` is present in the SD-JWT VC, its value `vct_metadata_uri#integrity` MUST be an "integrity metadata" string as defined in [Section 6].<br>

5.3.4. From a Local Cache<br>
The decision whether to cache the Type Metadata or not is left to the Wallet implementation. The absence of a hash for integrity protection does not require the Wallet to re-fetch the Type Metadata according to the Cache-Control header.<br>

5.4. Extending Type Metadata<br>
Extending types is NOT SUPPORTED.<br>

## 7. Display Metadata

7.1. Rendering Metadata<br>
The display property supports Overlay Capture Architecture (OCA), an additional rendering method (more on this in the specification: [Visualisation of Verifiable Credential with OCA]). If no OCA Bundle is present, rendering will fall back to the Credential Issuer Metadata display.<br>

The `oca` rendering method object contains the following properties:
- `uri`: REQUIRED. a URI which is either a URL that points to an OCA Bundle file with an associated application/json media type or a Data URL.
- `uri#integrity`: OPTIONAL. an "integrity metadata" string as described in [Section 6].

Below is a non-normative example of a OCA rendering method declaration inside the Type Metadata `display` property.

```
{
	"display": [
		{
      		"lang":"en",
      		"name":"example",
      		"rendering":{
				"oca":{
					"uri": "https://example.com/oca/oca-bundle.json",
          			"uri#integrity": "sha256-9cLlJNXN-TsMk-PmKjZ5t0WRL5ca_xGgX3c1VLmXfh-WRL5"
				}
			}
    	}
  	]
}
```

7.1.1. Rendering Method “simple”<br>
"Simple" rendering Is NOT SUPPORTED.<br>

7.1.2. Rendering Method “svg_templates”<br>
SVG rendering is NOT SUPPORTED.<br>

7.2. Extending Display Metadata<br>
Display Metadata extension is NOT SUPPORTED.<br>

## 8. Claim Metadata

Claim metadata is NOT SUPORTED.<br>

## 9. Security Considerations

9.6. Credential Type Extension and Issuer Authorization<br>
Issuer authorization and the challenge of credential type extension (trust chain) is specified in detail in [swiss-profile-trust].<br>

9.7. Trust in Type Metadata<br>
(???) How is trust established in Type Metadata <br>

10.4 Privacy-Preserving Retrieval of Type Metadata<br>
(???) <br>


??? in cookbook?? Implementation Considerations<br>

Business Expiry Claim<br>
The swiyu Wallet implementation supports a business expiry claim to be set in the verifiable credential.<br>

expiry_date: OPTIONAL, a date according to RFC 8943 full-date. The validity of the business expiry is up to and including the entire day. If present, it MUST be part of a disclosure.<br>

It differs from the exp claim of the SD-JWT VC the following way:

The expiry_date claim MUST be a Disclosure but the exp claim MUST NOT be part of a Disclosure. 
The holder of the swiyu wallet can still use and present the credential if the business expiry time is reached. There is only a warning shown to the holder when trying to present the digital credential. It is then up to the verifier to decide whether to accept this credential or not (e.g., Accepting a "over 18" proof for a expired e-ID). 
The digital credential cannot be shared once the exp time is reached. It is considered invalid for all participants of the trust infrastructure. 
Once the business expiry time is reached it will be displayed to the Holder as Expired / Abgelaufen / Expiré / Scaduto / Spirà in the swiyu App





