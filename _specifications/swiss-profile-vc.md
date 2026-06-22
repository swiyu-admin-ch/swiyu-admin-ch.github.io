---
title: "Swiss Profile for Verifiable Credentials"
toc: true
toc_sticky: true
excerpt: Specifications for Token Status List, SD-JWT, SD-JWT-VC, and OCA
header:
  teaser: ../assets/images/swiss-profile-vc.jpg
---

<div class="notice--info">
  Version 1.0 <br>
  Status: draft - technically complete, but might to be reformulated
</div>

# Introduction

This profile concerns itself with how a **Verifiable Credential (VC)** in the swiyu Trust Infrastructure is structured and visualized as well as how information on their validity/revocation state is provided. Components of the swiyu Trust Infrastructure can use verifiable credentials only if they satisfy the following specifications.

## Cryptography
To decrease complexity, initially the cryptographic options are limited to following algorithms.
- JWS algorithm **MUST** use ES256.
- Hash function **MUST** be sha-256
- Encryption **MUST** use ECDH-ES with P-256 Keys with A128GCM algorithm.

If using encryption is possible, it MUST be used.

## Specifications

All underlying specifications referenced by the included standards are considered fully supported / needed unless explicitly noted otherwise.

| Contained Specifications | Version | Link to referenced Specification |
| ---- | ---- | ---- |
| Token Status List (TSL) | Standards Track (Draft 20) | [Token Status List (TSL) - Standards Track](https://www.ietf.org/archive/id/draft-ietf-oauth-status-list-20.html)) |
| SD-JWT | RFC-9901 | [RFC 9901: Selective Disclosure for JSON Web Tokens](https://www.rfc-editor.org/rfc/rfc9901.html) |
| SD-JWT-VC | Standards Track (Draft 15) | [SD-JWT-based Verifiable Digital Credentials (SD-JWT VC) - Standards Track](https://www.ietf.org/archive/id/draft-ietf-oauth-sd-jwt-vc-15.html) |
| Visualisation of Verifiable Credentials with OCA | 1.0 | [Visualisation of Verifiable Credentials with OCA](../oca-v1-0/) |

**KEY WORDS** for this swiss profile expand on RFC 2119 "Key words for use in RFCs to Indicate Requirement Levels". They are explained in the [general introduction for the specifications](https://swiyu-admin-ch.github.io/specifications/introduction/#key-words). They are to be interpreted as such when, and only when, they appear **bold** and CAPITALIZED.


# Token Status List (TSL) Draft 20

The specification is fully supported by this profile (and components adhering to it) except for the specific cases mentioned in the following subsections. <br>

<div class="notice--warning">
The subsections rely on the numbering from the original reference specification for ease of reference and comparison.
</div>

## 1. Introduction
In the swiyu Trust Infrastructure the roles of Issuer and Status Issuer are fulfilled by the same entity. The Base Registry, provided by FOITT, acts as the Status Provider.

## 4. Status List
### 4.2. Status List in JSON Format
`aggreation_uri` is **NOT SUPPORTED**

### 4.3. Status List in CBOR Format
Status List in CBOR Format is NOT **SUPPORTED**

## 5. Status List Token
### 5.1. Status List Token in JWT Format
In addition to the already specified claims the JWT Claims Set **MUST** contain:
- `exp`: **REQUIRED**. As generally defined in [RFC7519](https://www.ietf.org/archive/id/draft-ietf-oauth-status-list-14.html#RFC7519). The `exp` (expiration time) **MUST** be set and can be any time in the future.

The JWT header of the Status List Token **MUST** contain: 
- `kid`: **REQUIRED**. Must be an absolute `kid` as specified in [swiss-profile-anchor](../swiss-profile-anchor/#JWTValidationwithcryptographickeysfromDIDs).

The Status List Token **MUST** be signed by the same entity as the Referenced Token inside the SD-JWT VC but can use a different key.<br>

Swiss Profile version indication with parameter `profile_version` in Status List Token JWT header is **REQUIRED**.<br>

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

### 5.2. Status List Token in CWT Format
Status List Token in CWT Format is **NOT SUPPORTED**.<br>

## 6. Referenced Token

### 6.3. Referenced Token in COSE
References Token in COSE is NOT **SUPPORTED**.

## 7. Status Types

### 7.1. Status Types Values
Accepted Status Types include only 0x00 - "VALID", 0x01 - "INVALID", and 0x02 - "SUSPENDED".<br>
All other Status Types are technically valid and shown as "UNKNOWN" in the swiyu Wallet.<br>

## 8. Verification and Processing

Only "application/statuslist+jwt" for Status List Token in JWT format is supported.<br>

### 8.4. Historical resolution
Historical resolution is **NOT SUPPORTED**.

## 9. Status List Aggregation

Status List Aggregation is **NOT SUPPORTED**.

## 10. X.509 Certificate Extended Key Usage Extension

X.509 Certificate Extended Key Usage Extension is **NOT SUPPORTED**.

## 11. Security Considerations

11.3. Key Resolution and Trust Management<br>
As specified above, the Status List Token **MUST** be signed by the same entity as the Referenced Token inside the SD-JWT VC. Issuers **MAY** use a different key for the signature. See [swiss-profile-anchor](/specifications/swiss-profile-anchor/#JWTValidationwithcryptographickeysfromDIDs) for more detail.<br>

## 12. Privacy Considerations

### 12.1. Observability of Issuers
To prevent observability of Issuers, the Status Provider **MUST** be the registry provided by FOITT. Participants **MAY** reject resolution if the URI inside the Reference Token points to another endpoint. 

### 12.2. Issuer Tracking of Reference Tokens
This risk is completely eliminated by forcing the Status Provider to be the registry and therefore different from the Issuer. 

### 12.6. External Status Provider for Privacy
Status Issuer and Status Provider are forced to be different entities as the Status Provider **MUST** be the registry provided by FOITT.

### 12.8. Status Types
The decision whether use of the supported Status Type "SUSPENDED" is at the discretion of the Issuer. Information published to the Status List is considered to be public.

## 13. Implementation Considerations

In addition to conformity checks documented in the standard, the registry performs additional checks on upload of a Status List:

- **Size Limits**: The Status List Token size **MUST** be greater than **200 bytes** and **MUST NOT** exceed **200 KB**. The decompressed Byte Array also **MUST NOT** exceed **200KB** (~100'000 entries when using 2 bits per status). This ensures the registry remains performant while preventing the upload of empty or malformed headers.
- **Cryptographic Integrity**: The document **MUST** include a **valid digital signature**. Submissions with invalid, expired, or unsupported signature formats **MUST** be rejected.<br>

Additional checks to the content of the Status List Token are performed:

| Claim |	Requirement Type |	Validation Logic |
|-----|-----|-----|
| `kid` (Key Identifier) |	Initial Upload |	**MUST** match a Decentralized Identifier (DID) currently authorized and assigned to the submitting swiyu business partner. |
| `kid` (Key Identifier) | Subsequent Updates |	**MUST** be identical to the iss value of the previously recorded version of the Status List. See [swiss-profile-anchor](/specifications/swiss-profile-anchor/#JWTValidationwithcryptographickeysfromDIDs). |
| `iat` (Issued At) |	Freshness Check |	**MUST** be greater than T - 24 hours (where T represents the current system time). Documents older than 24 hours cannot be uploaded. |
| `exp` (Expiration) |	Validity Window |	**MUST** be present and **MUST** be greater than the current system time (T). |

# RFC 9901: Selective Disclosure for JSON Web Tokens

The specification is fully supported by this profile (and components adhering to it) except for the specific cases mentioned in the following subsections. <br>

<div class="notice--warning">
The below sub-sections rely on the numbering from the original reference specification for ease of reference and comparison.
</div>

## 4. SD-JWT and SD-JWT+KB Data Formats

### 4.1. Issuer-Signed JWT
The payload **MUST NOT** contain one or more permanently disclosed claims.<br>

#### 4.1.1. Hash Function Claim
When used, the _sd_alg claim **MUST** be sha-256. Any other hash algorithm is **NOT SUPPORTED**.

#### 4.1.2. Key Binding
The cnf claim with the jwk confirmation method **MUST** be used if the Issuer wants to enable Key Binding in the SD-JWT.<br>
Multiple bound keys in the same SD-JWT are **NOT SUPPORTED**.<br>

### 4.2. Disclosures
#### 4.2.2 Disclosures for Array Elements
Disclosures for array elements **MUST** be supported and **SHOULD** be used when dealing with selectively disclosable arrays.

#### 4.2.5. Decoy Digests
Decoy Digests are **NOT SUPPORTED**.

#### 4.2.6. Recursive Disclosures
Recursive Disclosures **MUST** be supported and **SHOULD** be used when dealing with nested selectively disclosable objects.

### 4.3. Key Binding JWT
JWT payload:
- aud: **REQUIRED**. The aud claim **MUST** be client_id that was sent in the JAR of the verifier (see [swiss-profile-verification 1.0](../swiss-profile-verification/)). Please respect the security considerations in the implementation: [Validation of aud claim in Key Binding JWT](#validation-of-aud-claim-in-key-binding-jwt).
  
## 6 Considerations on Nested Data in SD-JWTs

### 6.1 Example: Flat SD-JWT
Flat SD-JWT **MUST** be supported.

### 6.3 Example: Structured SD-JWT
Structured SD-JWT is **NOT SUPPORTED**.

### 6.3 Example: SD-JWT with Recursive Disclosures
Recursive SD-JWT disclosures **MUST** be supported and **SHOULD** be preferred.

## 8. JWS JSON Serialization

JWS JSON Serialization is **NOT SUPPORTED**.

## 9. Security Considerations

### 9.11. Explicit Typing
As specified in [chapter 3.1](https://www.ietf.org/archive/id/draft-ietf-oauth-sd-jwt-vc-13.html#name-media-type) of the SD-JWT-VC standard, the media type **MUST** be `application/dc+sd-jwt`.

### Validation of aud claim in Key Binding JWT
The wallet **MUST** verify that the client_id belongs to the verifier to prevent identity fraud attacks. This **SHOULD** be done by checking that the client_id refers to the same entity that signed the JWT Secured Authorization Requests (JAR) as outlined in [swiss-profile-anchor](../swiss-profile-anchor/#JWTValidationwithcryptographickeysfromDIDs).<br> 
Only after a successful verification **SHOULD** the wallet include this client_id into the aud claim of the Key Binding JWT. <br>

The verifier **MUST** ensure that the Key Binding JWT received during a presentation is intended for this verifier by checking the aud claim specified by the wallet.<br>

# SD-JWT-based Verifiable Credentials (SD-JWT VC)

<div class="notice--warning">
The below sub-sections rely on the numbering from the original reference specification for ease of reference and comparison.
</div>

## 3. Verifiable Digital Credentials based on SD-JWT
### 3.2. Data Format
#### 3.2.1. JOSE Header

Swiss Profile version indication with parameter `profile_version` in SD-JWT-VC header is **REQUIRED**.<br>

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

#### 3.2.2. JWT Claims Set
##### 3.2.2.2  Registered JWT Claims
The following additional JWT claims are used within the SD-JWT component of the SD-JWT VC and **MUST NOT** be included in Disclosures, i.e., cannot be selectively disclosed:
- `vct_metadata_uri`: **OPTIONAL**. URI pointing towards where the VC Type Metadata can be fetched. Takes precedence over `vct` claim Type Metadata resolution.
- `vct_metadata_uri#integrity`: **OPTIONAL**. SRI integrity hash for the resources loaded from the `vct_metadata_uri`.
- `iat`: **OPTIONAL**. Meaning as specified in the standard. Contrary to the standard, this claim, if present, **MUST NOT** be set as a disclosure.

  
The following registered JWT claims **MUST** be included in Disclosures:
- `sub`: **OPTIONAL**. Meaning as specified in the standard. Contrary to the standard, this claim, if present, MUST be set as a disclosure.
- `aud`: **OPTIONAL**. Meaning as specified in the standard. 
- `jti`: **OPTIONAL**. Meaning as specified in the standard. 

Additionally, if present for some use-cases, the following (business) claims **MUST** be included in disclosures
- `vct_version`: **OPTIONAL**. value is version (semver) of the `vct`.
- `vct_subtype`: **OPTIONAL**. value that can describe an adaption (more specific context) of the `vct`, that defines another standard that can be used by issuers, referenced in the standardization.
- `vct_subtype_version`: **OPTIONAL**. value is version (semver) of the `vct_subtype`.
- `expiry_date`: **OPTIONAL**. a date according to [RFC 8943] full-date. The validity of the business expiry is up to and including the entire day.

Business expiry date differs from the exp claim of the SD-JWT VC the following way:
- The `expiry_date` claim **MUST** be a Disclosure but the `exp` claim **MUST NOT** be part of a Disclosure. 
- The holder of the swiyu wallet can still use and present the credential if the `expiry_date` time is reached. There is only a warning shown to the holder when trying to present the digital credential. It is then up to the verifier to decide whether to accept this credential or not (e.g., Accepting a "over 18" proof for a expired e-ID). 
- The digital credential cannot be shared once the `exp` time is reached. It is considered invalid for all participants of the trust infrastructure. 
- Once the business expiry (`expiry_date`) time is reached it will be displayed to the Holder as "Expired / Abgelaufen / Expiré / Scaduto / Spirà" in the swiyu App

##### 3.2.2.3 Public and Private JWT claims
The only binary data claims supported are: 
- `data:image/png;base64,`
- `data:image/jpeg;base64,`

##### 3.2.2.4. SD-JWT VC without Selectively Disclosable Claims
An SD-JWT VC **MUST** only have selectively disclosable claims, apart form the claims listed in [3.2.2.2 Registered JWT Claims](#3222--registered-jwt-claims). Other non-selectively dislosable claims **MUST NOT** be supported and **MUST** be rejected.

### 3.5. Issuer Signature Mechanisms
The Issuer Signature mechanism is described in [swiss-profile-anchor](../swiss-profile-anchor/).

## 4. JWT VC Issuer Metadata

JWT VC Issuer Metadata is **NOT SUPPORTED**.

## 5. SD-JWT VC Type Metadata

Usage of SD-JWT VC Type Metadata is **RECOMMENDED**.<br>

Swiss Profile version indication with parameter `profile_version` in VCT body is **REQUIRED**.

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

### 5.2. Type Metadata Format
Property extends and extends#integrity are **NOT SUPPORTED**.

The additional new properties are defined:
- `schema_uri`: **OPTIONAL**. a URI pointing to a JSON Schema describing the vct and its claims. If provided, Wallet **MAY** perform JSON Schema validation against the issued verifiable credential.
  
Additionally, `schema_uri#integrity` **MAY** be present as defined in [Section 6](https://www.ietf.org/archive/id/draft-ietf-oauth-sd-jwt-vc-15.html#document-integrity).<br>

### 5.3. Retrieving Type Metadata
#### 5.3.2. From a Registry
Registry retrieval is **NOT SUPPORTED**.

#### 5.3.3. Using a Defined Retrieval Method
A Consumer **MAY** use claim `vct_metadata_uri` to retrieve Type Metadata for a SD-JWT VC type. If `vct_metadata_uri` is present in the SD-JWT VC on root level (same level like claim `vct`), this method takes precedence over any other defined method to retrieve Type Metadata. If the type is a URL using the HTTPS scheme, Type Metadata **MUST** be retrieved using the HTTP GET method. A successful response **MUST** use an HTTP 200 status code and return a JSON object as defined in [Section 5.2](https://www.ietf.org/archive/id/draft-ietf-oauth-sd-jwt-vc-15.html#name-type-metadata-format) using the `application/json` content type. An error response **MUST** use the applicable HTTP status code value.<br>

If the claim `vct_metadata_uri#integrity` is present in the SD-JWT VC, its value `vct_metadata_uri#integrity` **MUST** be an "integrity metadata" string as defined in [Section 6](https://www.ietf.org/archive/id/draft-ietf-oauth-sd-jwt-vc-15.html#document-integrity).<br>

#### 5.3.4. From a Local Cache
The decision whether to cache the Type Metadata or not is left to the Wallet implementation. The absence of a hash for integrity protection does not require the Wallet to re-fetch the Type Metadata according to the Cache-Control header.

### 5.4. Extending Type Metadata
Extending types is NOT **SUPPORTED**.

## 7. Display Metadata

### 7.1. Rendering Metadata
The `display` property supports Overlay Capture Architecture (OCA), an additional rendering method (more on this in the specification: [Visualisation of Verifiable Credential with OCA](../oca-v1-0/). If no OCA Bundle is present, rendering will fall back to the Credential Issuer Metadata display.<br>

The `oca` rendering method object contains the following properties:
- `uri`: **REQUIRED**. a URI which is either a URL that points to an OCA Bundle file with an associated application/json media type or a Data URL.
- `uri#integrity`: **OPTIONAL**. an "integrity metadata" string as described in [Section 6](https://www.ietf.org/archive/id/draft-ietf-oauth-sd-jwt-vc-15.html#document-integrity).

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

#### 7.1.1. Rendering Method “simple”
"Simple" rendering is **NOT SUPPORTED**.

#### 7.1.2. Rendering Method “svg_templates”
SVG rendering is **NOT SUPPORTED**.

### 7.2. Extending Display Metadata
Display Metadata extension is **NOT SUPPORTED**.

## 8. Claim Metadata

Claim metadata is **NOT SUPORTED**.

## 9. Security Considerations

### 9.6. Credential Type Extension and Issuer Authorization
Issuer authorization and the challenge of credential type extension (trust chain) is specified in detail in [swiss-profile-trust](../swiss-profile-trust/).


## Implementation Considerations

### Privacy-Preserving Retrieval of VCT Metadata

Wallets **SHOULD** prefer methods for retrieving VCT Metadata that do not leak information about the usage of a credential to third parties. Wallets **SHOULD** retrieve VCT Metadata (Type Metadata, JSON Schema or OCA Bundle) only at the time of VC issuance and store the necessary metadata in a local cache.

# Credential Visualisation

Wallets **MUST** support the following methods to visualise credential on their display in the order of support priority

1. Overlays Capture Architecture (OCA) in [Visualisation of Verifiable Credential with OCA](/oca-v1-0/)
2. Credential Issuer Metadata in [OID4VCI](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html#name-credential-issuer-metadata)


Supported requirements for OID4VCI Credential Issuer Metadata can be found in [swiss-profile-issuance](../swiss-profile-issuance/).

Any invalid OCA object (Capture Base or Overlay) will invalidate the entire OCA Bundle. If no valid OCA Bundle is available, the Wallet will visualise the credential based on default values. If usage of OCA is indicated by the Issuer providing an OCA Bundle in VC Type Metadata, no fallback to Credential Issuer Metadata is made for unavailable visualisation metadata (e.g. an Overlay in the OCA Bundle is invalid). Credential Issuer Metadata is only considered in the case no OCA Bundle at all is provided.

## Visualisation of Verifiable Credential with OCA
### OCA Bundle as JSON file
Swiss Profile version indication with parameter `profile_version` in OCA Bundle JSON body is **REQUIRED**.

```
{
  "profile_version": "swiss-profile-vc:1.0.0",
  "capture_bases":[],
  "overlays":[]
}
```

### OCA Object Types
#### Capture Base
OCA object [Capture Base 1.0](https://oca.colossi.network/specification/v1.0.1.html#capture-base) **MUST** be supported.

**Attributes**<br>
Attributes `classification` and `flagged_attributes` are **NOT SUPPORTED**.

The following attribute types **MUST** be supported:

- `Text` - including Data URL with mime-type `image/png` and `image/jpeg`
- `Numeric`
- `Boolean`
- `DateTime` - ISO 8601 and Epoch Time
- `Reference`
- `Binary` - mime-type `image/png` and `image/jpeg`
- `Array[Text]` - excluding Data URL
- `Array[Numeric]`
- `Array[Boolean]`
- `Array[DateTime]`
- `Array[Reference]`
- `Array[Binary]`
  
Image binary attributes (attribute type `Binary`) **MUST** have declared encoding `base64` in the Character Encoding Overlay and the respective mime-type `image/png` and `image/jpeg` in the Format Overlay. Any other binary mime-type **MUST NOT** be supported.

#### Overlays

The following OCA Overlay objects **MUST** be supported:

- [Character Encoding Overlay 1.0](https://oca.colossi.network/specification/v1.0.1.html#character-encoding-overlay)
- [Format Overlay 1.0](https://oca.colossi.network/specification/v1.0.1.html#format-overlay)
- [Standard Overlay 1.0](https://oca.colossi.network/specification/v1.0.1.html#standard-overlay)
- [Meta Overlay 1.0](https://oca.colossi.network/specification/v1.0.1.html#meta-overlay)
- [Entry Overlay 1.0](https://oca.colossi.network/specification/v1.0.1.html#entry-overlay)
- [Entry Code Overlay 1.0](https://oca.colossi.network/specification/v1.0.1.html#entry-code-overlay)
- [Sensitive Overlay 1.0](https://oca.colossi.network/specification/v1.0.1.html#sensitive-overlay)
- [Label Overlay 1.1](https://swiyu-admin-ch.github.io/specifications/oca-v1-0/#label-overlay-update)
- [Data Source Mapping Overlay 2.0](https://swiyu-admin-ch.github.io/specifications/oca-v1-0/#data-source-mapping-overlay)
- [Order Overlay 1.0](https://swiyu-admin-ch.github.io/specifications/oca-v1-0/#order-overlay)
- [Branding Overlay 1.1](https://swiyu-admin-ch.github.io/specifications/oca-v1-0/#aries-branding-overlay-update)

Code Tables in Entry & Entry Code Overlay 1.0 **MUST NOT** be supported.

Wallets **SHOULD** use the Branding Overlay 1.1 with attribute `theme` set to `"dark"` to display branding information when running in dark mode.

We provide a [cookbook](/cookbooks/vc-visual-presentation-oca/) which provides more details about how to implement OCA according to the Swiss Profiles.
