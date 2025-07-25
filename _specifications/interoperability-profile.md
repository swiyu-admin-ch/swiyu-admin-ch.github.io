---
title: "swiyu Trust Infrastructure: Interoperability profile"
toc: true
toc_sticky: true
excerpt: Technical profile of the swiyu Public Beta Trust Infrastructure ("Swiss Profile")
header:
  teaser: ../assets/images/specifications_interoperability-profile.jpg
---

**NOTE** <br/> This profile focuses on the Public Beta release and is not complete. It reflects the current state of implementation and will evolve in the future to fullfil the requirements of the swiyu Trust Infrastructure.
{: .notice--info}

## Introduction
This document defines a set of requirements based on new or existing technical specifications and aims to enable interoperability between issuers, wallets and verifiers of credentials in the swiyu Public Beta Trust Infrastructure. It is intended as an interoperability profile that can be used by implementers. As such it shows how the referenced specifications can, and sometimes have to be, implemented.

### Target Audience/Usage
The target audience of the document are early adopters who want to use the swiyu Public Beta Trust Infrastructure to:
- experience the Confederations infrastructure and assess how it works
- experiment with their use cases 
- test the integration of their products and systems 
- conduct experiences with regard to interoperability across sectors as well as international interoperability 
- get ready for the productive environment in 2026 

## Scope
The following specifications are in scope of this "Swiss Profile":

- Issuer & Verifier identification (DID:TDW, respectively the renamed method DID:WEBVH) 
- Protocol for issuance of the Verifiable Credentials (OID4VCI)
- Protocol for online presentation of Verifiable Credentials (OID4VP)
- Credential Format (SD-JWT VC)
- Credential Status (Token Status List)
- Cryptographic Device Binding
- Trust Protocol
- Crypto Suites

The following assumptions apply:

- Issuers and verifiers cannot pre-discover the capabilities of wallets.
- Mechanisms that enables wallets to discover the capabilities of issuers and verifiers.
- Mechanisms that enables issuers and verifiers to discover the capabilities of each other exist.

### Out of Scope
The following items are currently out of scope but might be added in future versions:

- Protocol for presentation of Verifiable Credentials for offline use-cases, e.g. using BLE

### Standard Requirements
The following table defines which specification must be supported by an actor (issuer, verifier, wallet) in order to comply with this profile.

| Specification     | Issuer   | Wallet   | Verifier |
|-------------------|----------|----------|----------|
| OID4VP            | **MAY**  | **MUST** | **MUST** |
| OID4VCI           | **MUST** | **MUST** | **MAY**  |
| DID:TDW/DID:WEBVH | **MUST** | **MUST** | **MUST** |
| SD-JWT VC profile | **MUST** | **MUST** | **MUST** |
| Status List       | **MUST** | **MUST** | **MUST** |
| Trust Protocol    | **MAY**  | **MUST** | **MAY** |

## Issuer & Verifier Identification
Issuers and verifiers use [DID:TDW](https://identity.foundation/trustdidweb/) version 0.3 as identifiers.

### DID:TDW/DID:WEBVH
Implementations of this profile:

- **MUST** set `portable` to `false` in the first DID log entry.
- **MUST** set `method` to `did:tdw:0.3` in the first DID log entry.

#### DID Document Format

The following specification defines the requirements of the to DID Document.

| Property           | Description                                                                                 |
|--------------------| --------------------------------------------------------------------------------------------|
| @context           | **MUST** contain `https://www.w3.org/ns/did/v1` and `https://w3id.org/security/jwk/v1`      |
| id                 | **MUST** contain the DID of the DID document                                                |
| verificationMethod | **MUST** contain at least one public key from type `PublicKeyJwk`                           |
| alsoKnownAS        | **MUST NOT** be used                                                                        |
| controller         | **MUST NOT** be used                                                                        |
| service            | **MUST NOT** be used                                                                        |


{% capture notice-text %}
Issuer and Verifier have the possibility to add metatada to their DIDs with:
- Self-attestated metadata with OpenID4VCI Server Metadata
- Self-attestated metadata with OpenID4VP Authorization request
- Validated metadata with the Trust Statement in chapter Trust Protocol
{% endcapture %}

<div class="notice--info">
  <h4 class="no_toc">NOTE</h4>
  {{ notice-text | markdownify }}
</div>

## OpenID for Verifiable Credential Issuance
Implementations of this profile:

- **MUST** support the pre-auth code flow.
- **MUST** support protocol extensions for the SD-JWT VC credential format profile as defined in Section [SD-JWT VC](#sd-jwt-vc).

This chapter maps to OpenID4VCI draft 13

### Credential Offer
- The Grant Type `urn:ietf:params:oauth:grant-type:pre-authorized_code` **MUST** be supported as defined in Section 4.1.1 in [OpenID4VCI](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0-ID1.html).
- As a way to invoke the wallet, the custom URL scheme `openid-credential-offer://` **MUST** be supported.

Both sending credential offer same-device and cross-device are supported.

### Credential Issuer Metadata
- `credential_issuer` **MAY** be defined
- `display` **MAY** contain the following objects
    - `name` **MAY** be the self-attested name of the issuer
    - `logo` **MAY** contain the self-attested logo of the issuer.
        - `uri` **MUST** be a DATA URL with mime-type `image/png` or `image/jpg`
        - `alt_text` **MAY** be a text that describes the logo
    - `locale` **MAY** be the locale of the self-attested issuer metadata
- `credential_configurations_supported` **MUST** contain
    - `format` **MUST** be `vc+sd-jwt`
    - `cryptographic_binding_methods_supported` **MUST** be `jwk`
    - `credential_signing_alg_values_supported` **MUST** be
        - `ES256`
    - `proof_types_supported` **MAY** be defined
        -  **MUST** contain `jwt`.
        - `proof_signing_alg_values_supported` **MUST** contain at least `ES256`
    - `display` **MAY** be defined, and when defined **MUST** at least contain one of the following object
        - `name` **MUST** be the self-attested name of the credential
        - `logo` **MAY** contain the self-attested logo of the credential.
            - `uri` **MUST** be a DATA URL with mime-type `image/png` or `image/jpg`
            - `alt_text` **MAY** be a text that describes the logo
        - `locale` **MAY** be the locale of the self-attested credetial metadata
        - `description` **MAY** be defined
        - `background_color` **MAY** be defined

### Credential Endpoint
#### Credential Request

- `format` **MUST** be `vc+sd-jwt`
- `proof` **MAY** be defined, and when defined **MUST** contain:
    - `proof_type` **MUST** be `jwt` 

#### JWT Proof Type

The JOSE header **MUST** contain following values:
- `alg` **MUST** be `ES256`
- `kid` **MUST** be JWK encoded as a DID:JWK

The JWT body **MUST** contain following values:
- `nonce` **MUST** be defined, if cryptographic device binding is requested.
 
#### Credential Response

- `credential` **MUST** be defined

##### Credential Error Response

If the wallet was sending a signed nonce on their proof, the following value **MUST** be added:
- `c_nonce` **MUST** be defined

### Token Endpoint

#### Token Request

- `grant_type` **MUST** be `urn:ietf:params:oauth:grant-type:pre-authorized_code`

#### Token Response

- `c_nonce` **MUST** be defined, if cryptographic device binding is requested.

## OpenID for Verifiable Presentations

This chapter maps to OpenID4VP draft 20

- MUST support protocol extensions for SD-JWT VC format profile as defined in this specification Section [SD-JWT VC](#sd-jwt-vc).

### Authorization Request

- Authorization Request **MUST** be sent using the request_uri parameter as defined in JWT-Secured Authorization Request (JAR) [RFC9101].
- `response_type` **MUST** be `vp_token`.
- `response_mode` **MUST** be `direct_post`
- `response_uri` **MUST** be defined
- `client_id` **MAY** be set if Verifier authentication is requested.
- `client_id_scheme`, if used with a DID, **MUST** be `did`.
- `client_metadata` **MAY** contain
    - `client_name` **MAY** be defined
    - `logo_uri` **MAY** be defined but **MUST** be a data URL.
- `nonce` **MUST** be defined, if cryptographic device binding is requested.
- `presentation_definition` **MUST** be defined
- The following features from the DIF Presentation Exchange v2.1.1 **MUST** be supported.
    - `presentation_definition` **MUST** contain
        - `id` **MUST** be defined 
        - `input_descriptors` **MUST** contain at least one object with:
            - `id` **MUST** be defined
            - `name` **MAY** be defined
            - `purpose` **MAY** be defined
            - `format` **MAY** be defined, when defined **MUST** be `vc+sd-jwt`.
            - `constraints` **MAY** be defined, when defined **MUST** contain object `fields` with the following properties
                - `path` **MUST** be defined
                - `filter` **MAY** be defined to be used with the `vct` claim from the SD-JWT VC profile

### Authorization Response

- `vp_token` **MUST** be defined
- `presentation_submission` **MUST** be defined.
- The following features from the DIF Presentation Exchange v2.1.1 **MUST** be supported.
    - `presentation_submission` **MUST** contain:
        - `id` **MUST** be defined
        - `definition_id` **MUST** be defined
        - `descriptor_map` **MUST** be defined and **MUST** contain:
            - `id` **MUST** be defined
            - `format` **MUST** be `vc+sd-jwt`
            - `path` **MUST** be defined
 
## Credential Formats

### SD-JWT VC
As credential format, SD-JWT VCs as defined in [ietf-oauth-sd-jwt-vc](https://datatracker.ietf.org/doc/draft-ietf-oauth-sd-jwt-vc/) **MUST** be supported.

In addition, this profile defines the following additional requirements.

Compact serialization **MUST** be supported as defined in [ietf-oauth-selective-disclosure-jwt](https://datatracker.ietf.org/doc/draft-ietf-oauth-selective-disclosure-jwt/). 
The following JWT Claims **MUST** be supported content

| Claim  | SD-JWT     |
| -------| -----------|
| vct    | **MUST**   |
| iss    | **MUST**   |
| iat    | **SHOULD** |
| exp    | **SHOULD** |
| status | **SHOULD** |
| sub    | **MAY**    |
| cnf    | **MAY**    |

- The Issuer **MUST NOT** make any of the JWT Claims in the table above to be selectively disclosable, so that they are always present in the SD-JWT-VC presented by the wallet.
- It is at the discretion of the issuer whether to use `exp`, `iat` claims and/or a `status` claim to express the validity period of an SD-JWT-VC. The wallet and the verifier **MUST** support those mechanisms.
- The `vct` claim **MUST** be defined and is treated as an unresolvable string.
- The `iss` claim **MUST** be a DID. The `iss` value is used to obtain Issuer's signing key as defined in section [Issuer identification and key resolution](#sd-jwt-did-resolution).
- The `sub` claim **MAY** be used, if there is a requirement to provide the subject's identifier assigned and maintained by the issuer.
- When the issuer decides to use device binding, the `cnf` claim [RFC7800] **MUST** conform to the definition given in [Device Binding Chapter](#device-binding).

<a id="sd-jwt-did-resolution"></a>

#### Issuer Identification and Key Resolution to validate an Issued Credential
- The key used to validate the issuer's signature on the SD-JWT VC **MUST** be obtained by resolving the DID with key reference from the JOSE header `kid` parameter.

<a id="device-binding"></a>

##### Cryptographic Device Binding between Wallet and Verifier

- For cryptographic device binding, a KB-JWT, as defined in [I-D.ietf-oauth-sd-jwt-vc](https://www.ietf.org/archive/id/draft-ietf-oauth-selective-disclosure-jwt-12.html#name-key-binding-jwt), **MUST** be present when presenting an SD-JWT VC.

**WARNING** Issuers can issue low assurance VCs without device binding but they can become vulnerable to replay attacks. 
{: .notice--warning}

#### OpenID4VC Credential Format Profile
This section specifies how SD-JWT VCs as defined in [I-D.ietf-oauth-sd-jwt-vc](https://datatracker.ietf.org/doc/draft-ietf-oauth-sd-jwt-vc/) are used in conjunction with the OpenID4VC specifications.

##### Format Identifier
The credential format identifier is `vc+sd-jwt`. This format identifier is used in issuance and presentation requests.

<a id="sd-jwt-cred-def"></a>

##### Credential Issuer Metadata
The following additional credential issuer metadata are defined for this credential format to be used in addition to those defined in Section 10.2 of [OpenID4VCI](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html#name-credential-issuer-metadata).

- `credential_configuations_supported` **MUST** contain
    - `vct` **MUST** be defined.
    - `claims` **MAY** contain objects with the following properties
        - `value_type` **MAY** be defined
        - `display` **MAY** be defined for each credential claim
            - `name` **MAY** be the localized credential claim name
            - `locale` **MAY** be the credential claim name locale
        - `order` **MAY** be an array with the credential claim in the order of display

## Credential Status
An issuer **MAY** at their discretion add a status entry to their verifiable credential.

The credential status specification to use depends on the credential format as follow:

| Credential format | Specification         |
| ------------------| ----------------------|
| SD-JWT VC         | [Token Status List](https://datatracker.ietf.org/doc/draft-ietf-oauth-status-list/) <br/> JSON format only    |

## Trust Protocol
- Wallets **MUST** support the SD-JWT VC representation of the [Trust Protocol based on VCs](https://swiyu-admin-ch.github.io/specifications/trust-protocol/).
- Trust Statements **MUST** be defined as follows:
    - `kid` from the JOSE header **MUST** be an absolute `did:tdw` with a key reference.
    - `iss` and `sub` from the JWT body **MUST** be a `did:tdw`.
- The Trust Statement `TrustStatementMetadataV1` **MUST** be supported.
- Issuers and verifiers **MAY** support the Trust Protocol for their own needs.

This chapter maps to [Trust Protocol based on VCs V0.1](https://swiyu-admin-ch.github.io/specifications/trust-protocol/)

## Crypto Suites
Issuers, wallets and verifiers **MUST** support P-256 (secp256r1) as a key type with `ES256` JWT algorithm for signing and signature validation whenever this profiles requires to do so.

SHA256 **MUST** be supported by all the entities as the hash algorithm to generate and validate digests.

**NOTE** <br/> When using this profile with other cryptosuites, it is recommended to be explicit about which entity is required to support which curve for signing and/or signature validation
{: .notice--info}

## Privacy Considerations
In the current profile,  sections SD-JWT VC, credential status and device binding contain no protection against user correlation.
Measures to address this challenge are envisioned for a later release, for example, with solutions like [batch-issuance](https://github.com/swiyu-admin-ch/swiyu-issuer/issues/5).


## References

- [**DID:TDW/DID:WEBVH**](https://identity.foundation/trustdidweb/)
- [**OpenID4VCI**](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html)
- [**OpenID4VP**](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html)
- [**Trust Protocol based on VCs**](https://swiyu-admin-ch.github.io/specifications/trust-protocol/)
- [**SD-JWT**](https://datatracker.ietf.org/doc/draft-ietf-oauth-selective-disclosure-jwt/)
- [**SD-JWT VC**](https://datatracker.ietf.org/doc/draft-ietf-oauth-sd-jwt-vc/)
- [**Token Status List**](https://datatracker.ietf.org/doc/draft-ietf-oauth-status-list/)
