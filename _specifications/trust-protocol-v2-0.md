---
title: "Trust Protocol 2.0"
toc: true
toc_sticky: true
excerpt: Trust Protocol Specification for the swiyu Trust Infrastructure")
header:
  teaser: ../assets/images/specifications_interoperability-profile.jpg
---

# Abstract

This document defines the publicly consumable technical specification of the trust protocol, is based on JWTs and was created for the Swiss trust infrastructure. The aim is to provide a straight-forward solution allowing a governing body (trust issuer) to confirm the identity of issuers and verifiers, as well as propagating further claims about the legitimacy of the actors actions (e.g., issuance and verification of a specific credential type).

The trust protocol is based on JWTs, and on the flows defined in [swiss-profile-issuance 1.0] and [swiss-profile-verification 1.0].

JWTs are signed by a root trust anchor to authenticate the corresponding statement.

In the context of the trust protocol, those JWTs are referred to as statements, and are further split in:

- Trust Statement:
  Statements issued by a trust root anchor of type "Trust statement issuer". 
  Those statements do require a manual verification process by a governing body and are issued to a specific actors identifier.
- Trust List Statement:
  Statements issued by a trust root anchor of type "Trust statement issuer" which apply to multiple subjects.
  Those statements are actively managed by a governing body.
- Public Statement:
  Statements issued by a trust root anchor of type "Public transparency statement issuer".
  Those statements do not require a manual verification process in most cases and are issued to a specific actors identifier.

-> Conventions and Terminology
-> Roles/Actors


## Trust markers

Each issuer and verifier in the swiyu ecosystem can be provided with various Statements by the governing actor, identified in the [active swiss-profile-trust].
Those statements can be resolved to trust markers to assess the trust relationship between the different actors in an ongoing interaction

Every actor in the ecosystem SHOULD validate the trust relationship with the party they interact with.
Note: The trust relationship may also be established by other means, for example out of band. 

The [active swiss-profile-trust] does further define which trust markers are required for a trusted relationship in the swiyu ecosystem.



The following trust markers are described in this protocol:

### Verified Identity Trust Marker (viTM)
The presence of this marker indicates that the identity of the actor is validated by the governing actor.

### Compliant Actor Trust Marker (caTM)
The presence of this marker indicates that the actor was not identified as a bad actor in the ecosystem.

###Transparent Verification Trust Marker (tvTM)
The presence of this marker indicates that the ongoing verification request is publicly transparent and can be reviewed by 3rd party actors.
This does not mean the individual verification - neither what data is requested, nor what data is exposed to the verifier - is publicly available, only that the verifier made the type of verifications they are performing public for review.

### Governed use case Trust Marker (gucTM)
The presence of this marker indicates that the issuance or verification is identified to be protected by an governing actor. A valid authorization needs to be presented to continue processing such use cases.

#### Protected issuance 

The swiyu ecosystem defines certain VC Types as protected and requires special authorization by issuers to be able to issue VCs of those types.

A VC Type is protected if and only if its "vct" claim is listed in the "vct_values" claim of an active Protected Issuance Trust List Statement.

Issuers who issue such a VC MUST have a Protected Issuance Authorization Trust Statement.

#### Protected verification 

The swiyu ecosystem defines certain fields in any VC as protected and requires special authorization for verifiers to be able to request those fields during verifications.

Those fields are defined in the currently [active swiss-profile-trust] and are simple strings which match fully any claim in any VC with the same key value.

For example, the protected field personal_administrative_number (containing the "AHV Nummer") as shown in the [examples](todo) requires a Protected Verification Authorization Trust Statement for verifiers to be able to request it during verification.

### Governed use case authorization Trust Marker (gucaTM)

The presence of this marker indicates that the issuer or verifier does have authorization by the governing actor to process this use case.

## Trust Flows
Each trust flow is bound to an interaction between two actors. The flow indicates how an actor to resolve the trust markers to establish trust relationship. Adherence to the trust protocol enhances the privacy for the holder.

All actors MUST validate the received Statements, see Statement provisioning, before they act upon the data provided by those statements.
If a statement is not valid the trust marker evaluated CANNOT be set for the trust relationship.

### Issuance
#### Issuer View

To allow the wallet to mark the trust relationship to the issuer with the Verified Identity Trust Mark trust marker the following needs to be provided by the issuer:

- The issuer MUST provide his Identity Trust Statement in the issuer metadata, as described in Statement provisioning>Issuer>Issuer Metadata.
  
An additonal trust statement must be provided if the Issuer offers credentials which are part of the Protected Issuance Trust List Statement. To allow the wallet to mark the trust relationship to the issuer with the Governed use case authorization Trust Marker trust marker the following needs to be provided by the issuer:
- The issuer MUST provide, for each protected VC Type to be issued, the Protected Issuance Authorization Trust Statement in the issuer metadata, as described in Statement provisioning>Issuer>Issuer Metadata.

#### Wallet view
The wallet SHOULD read the Identity Trust Statement and Protected Issuance Authorization Trust Statement from the issuers metadata.

To process this flow the wallet needs a Protected Issuance Trust List Statement, the currently active Protected Issuance Trust List Statement SHOULD be fetched via Retrieving Protected Issuance Trust List Statements.
To process this flow the actor needs a Non-Compliance Trust List Statement, the currently active Non-Compliance Trust List Statement SHOULD be fetched via Retrieving Non-Compliance Trust List Statements.

The wallet MUST make sure the received VCs VC Type matches the validated VC Type during the issuance trust process.

The wallet SHOULD mark the trust relationship to the issuer with the following trust marks if the necessary validations are done.
When performing the necessary validations the wallet MUST perform all steps as in the table below.


| Trust Mark              | Necessary Validations   |
|--------------------- |------------------- |
| Verified Identity Trust Mark	| 1. Make sure the issuer provides a valid Identity Trust Statement in his issuer metadata. 2. Validate that the DID, resolved from the "kid" header claim of the issuers signed issuer metadata, matches the "sub" claim of the Identity Trust Statement. |
| Governed use case Trust Mark	| 1. Act upon a Protected Issuance Trust List Statement which is valid at the time of the trust process. 2. Make sure that the "vct" claim of the offered VC is listed in the "vct_values" of the Protected Issuance Trust List Statement. |
| Governed use case authorization Trust Mark	| 1. Validate that the trust relationship is already marked with the Governed use case Trust Mark. 2. Act upon a Protected Issuance Trust List Statement which is valid at the time of the trust process. 3. Make sure the issuer provides a valid Protected Issuance Authorization Trust Statement in his issuer metadata. 4. Validate that the DID, resolved from the "kid" header claim of the issuers signed issuer metadata, is equal to the "sub" claim of the Protected Issuance Authorization Trust Statement. 5. Make sure that the "can_issue.vct" claim of the Protected Issuance Authorization Trust Statement is equal to the VC Type of the offered credential. |
| Compliant actor Trust Mark	| 1. Act upon a Non-Compliance Trust List Statement which is valid at the time of the trust process. 2. validate that the DID, resolved from the "kid" header claim of the issuers signed issuer metadata, is not listed in any Non-Compliant Actor Objects "actor" claim of the root "non_compliant_actors" claim.|


The following diagram shows how the wallet could resolve trust markers:

-> image holder-issuer

### Verification

To allow the wallet to mark the trust relationship to the verifier with the Verified Identity Trust Mark trust marker the following needs to be provided by the verifier:
- The verifier MUST provide his Identity Trust Statement to the wallet as described in Statement provisioning>Verifier>JWT-Secured Authorization Request (Request Object).

To allow the wallet to mark the trust relationship to the verifier with the Governed use case authorization Trust Mark trust marker the following needs to be provided by the verifier:
- The verifier MUST provide the relevant Verification Query Public Statement to the wallet, as described in Statement provisioning>Verifier>JWT-Secured Authorization Request (Request Object).
- The verifier MUST link to the "scope" claim of the Verification Query Public Statement via the scope parameter, as defined in section 5.5 of [OpenID4VP].

To allow the wallet to mark the trust relationship to the verifier with the Governed use case authorization Trust Marker trust marker the following needs to be provided by the verifier:
- The verifier MUST provide for each protected VC Type to be verified a matching Protected Verification Authorization Trust Statements as described in Statement provisioning>Verifier>JWT-Secured Authorization Request (Request Object).


#### Wallet view

The wallet MUST NOT send any data which is not explicitly requested by the verifier or data technically required to perform the verification, to the verifier.

The wallet MUST get consent of the user before sharing data with the verifier.

The wallet SHOULD read the Identity Trust Statement and Protected Verification Authorization Trust Statement of the verifier from the JWT-Secured Authorization Request (Request Object).

The wallet MUST NOT send the values of any protected fields to the verifier, if the trust relationship to the verifier is not marked with the Governed use case authorization Trust Marker.

To process this flow the actor needs an Non-Compliance Trust List Statement, the currently active Non-Compliance Trust List Statement SHOULD be fetched via Retrieving Non-Compliance Trust List Statements.



The wallet SHOULD mark the trust relationship to the verifier with the following trust marks if the necessary validations are done.

When performing the necessary validations the wallet MUST perform all steps as in the table below.

| Trust Mark              | Necessary Validations          |
|---------------------------- |------------------------- |
| Verified Identity Trust Mark	| 1. Validate that the provided attestations do contain exactly one Identity Trust Statement. 2. Validate that the "client_id" claim of the verifiers JWT-Secured Authorization Request matches the "sub" claim of the Identity Trust Statement. If the "client_id" contains the prefix "decentralized_identifier:" it MUST be removed before the comparison. |
| Transparent verification Trust Mark	| 1. Validate that the provided attestations contain exactly one Verification Query Public Statement. 2. Validate that the presentation request contains a "scope" parameter, as defined in section 5.5 of [OpenID4VP]. 3. Validate that the "scope" claim of the Verification Query Public Statement is contained in the presentation request "scope" claim. |
| Governed use case Trust Mark | 1. Identify at least one protected field in the presentation, as defined in Protected verification. |
| Governed use case authorization Trust Mark	| 1. Validate that the trust relationship is already marked with the Governed use case Trust Mark. 2. Identify each protected field in the presentation, as defined in Protected verification. 3. Protected fields MUST be matched against all claims which are send from the wallet to the verifier. 4. For each protected field the wallet MUST adhere to the following process:  a. Make sure the protected field is listed in the "authorized_fields" claim of a Protected Verification Authorization Trust Statement.   b. Validate that the "client_id" claim of the verifiers JWT-Secured Authorization Request matches the "sub" claim of the Protected Verification Authorization Trust Statement. If the "client_id" contains the prefix "decentralized_identifier:" it MUST be removed before the comparison. |
| Compliant actor Trust Mark | 1. Aact upon a Non-Compliance Trust List Statement which is valid at the time of the trust process. 2. Validate that the "client_id" claim of the verifiers JWT-Secured Authorization Request is not listed in any Non-Compliant Actor Objects "actor" claim of the root "non_compliant_actors" claim.  If the "client_id" contains the prefix "decentralized_identifier:" it MUST be removed before the comparison. |

The following diagram shows how the wallet could resolve trust markers:

-> image trust holder-verifier

#### Verifier view

The verifier MUST NOT make any requests, or notify by any other means, the issuer about the individual verification.

To process this flow the wallet needs an Protected Issuance Trust List Statement, the currently active Protected Issuance Trust List Statement SHOULD be fetched via Retrieving Protected Issuance Trust List Statements.

The verifier SHOULD mark the trust relationship to the issuer with the following trust marks if the necessary validations are done.

When performing the necessary validations the verifier MUST process trust marks for each presented VC and perform all steps as in the table below.

| Trust Mark                 | Necessary Validations   |
|----------------------------|-------------------------|
| Verified Identity Trust Mark	| 1. Validate that a trust registry provides, through the process described in Retrieving Identity Trust Statements, an Identity Trust Statement for the issuers identifier of the VC. Note: The process to resolve the VC issuers identifier is defined in the [swiss-profile-vc 1.0]. |
| Governed use case Trust Mark	| 1. Act upon a Protected Issuance Trust List Statement which is valid at the time of the trust process. 2. Make sure that the "vct" claim of the VC is listed in the "vct_values" of the Protected Issuance Trust List Statement |
| Governed use case authorization Trust Mark	| 1. Validate that the trust relationship is already marked with the Verified Identity Trust Mark. 2. Validate that the trust relationship is already marked with the Governed use case Trust Mark. 3. Fetch the issuers Protected Issuance Authorization Trust Statement from the currently [active trust registry] via Retrieving Protected Issuance Authorization Trust Statements. 4. Validate that the "sub" claim of the issuers Protected Issuance Authorization Trust Statement matches the "sub" claim of the Identity Trust Statement. 5. Mmake sure that the "can_issue.vct" claim of the Protected Issuance Authorization Trust Statement is equal to the VC Type of the VC. |

The following diagram shows how the wallet could resolve trust markers:

-> image verifier-issuer


## Statement provisioning
Issuer and verifier MUST provide identification and permission statements via their respective provisioning channels to the wallet.

Issuer and verifier MUST provide identification as soon as possible in their respective flows.

Issuer and verifier SHOULD make sure the provided data is up to date.

### Issuer
#### Issuer Metadata 

The issuer metadata are provided as signed metadata as defined in the [swiss-profile-issuance 1.0]. The trust statements are included in the signed metadata. The trust statements included in the signed metadata provide a cryptographic chain of trust, with which proves that the metadata was created by the issuer without outside call beyond the trust statement revocation status list.

The issuer MUST provide the Identity Trust Statement in the issuer metadata in the claim "credential_issuer_identity_trust_statement".

The issuer MUST provide, for each protected VC Type to be issued, a "protected_issuance_authorization_trust_statement" claim below the respective credential key in the "credential_configurations_supported" claim, as defined in 12.2.4. of [OpenID4VCI] containing the serialized Protected Issuance Authorization Trust Statement.

-> Example: Credential Issuer Metadata with Trust Statements


### Verifier

JWT-Secured Authorization Request (Request Object)
The verifier MUST add his Identity Trust Statement, the relevant Verification Query Public Statement for this verification and if needed the relevant Protected Verification Authorization Trust Statement as attestations to the "verifier_info" claim in the JWT-Secured Authorization Request as defined in [OpenID4VP].

Each of those attestations MUST have the "format" claim "jwt".

Each of those attestations MUST NOT utilize the "credential_ids" claim.

-> Example: Request Object with Trust Statements

### Trust Registry

A trust registry, identified in a [swiss-profile-trust], provides statements to the public.

For examples please use the following OpenAPI Specification: Trust Protocol 2.0 Trust Registry.yaml

A trust registry MUST provide the following HTTP REST endpoints:

#### Retrieving Identity Trust Statements

| Path                       | Method                  | Description             |
|----------------------------|-------------------------|-------------------------|
| /api/v2/identity-trust-statement/	 | GET | MUST return a List Response Object, The content objects are serialized Identity Trust Statements. MUST support the following parameters:
<table>
    <tr>
        <td>Name</td>
        <td>Type</td>
        <td>Default</td>
        <td>Description</td>
    </tr>
    <tr>
        <td>filterActive</td>
        <td>Query</td>
        <td>true</td>
        <td>MUST be a boolean. Indicates that the trust registry only returns trust statements it deems active. Implementation Note: The client still needs to validate the statements and cannot assume that all statements returned are indeed active.</td>
    </tr>
    <tr>
        <td>page</td>
        <td>Query</td>
        <td>0</td>
        <td>MUST be an integer. The zero-based page index (0..N) to retrive.</td>
    </tr>
    <tr>
        <td>size</td>
        <td>Query</td>
        <td>20</td>
        <td>MUST be an integer. The requested size of the page to be returned. actual returned size may differ.</td>
    </tr>
    <tr>
        <td>sub</td>
        <td>Query</td>
        <td>No default</td>
        <td>If provided MUST be a string. The trust registry returns only statements where the sub claim matches exactly.</td>
    </tr>
</table> |


| /api/v2/identity-trust-statement/{identifier} | GET | MUST return a serialized Identity Trust Statement. <br>

MUST support the following parameters:


| Name                       | Type         | Default          | Description             |
|----------------------------|--------------|------------------|-------------------------|
| identifier |	Path	| No default |	URL encoded identifier of the actor in a format defined in the [swiss-profile-anchor 1.0] |


Retrieving Verification Query Public Statements
/api/v2/verification-query-public-statement/	GET	
MUST return a List Response Object, The content objects are serialized Verification Query Public Statements.

MUST support the following parameters:

sub	Query	No default	If provided MUST be a string. The trust registry returns only statements where the sub claim matches exactly.
filterActive	Query	true	MUST be a boolean. Indicates that the trust registry only returns trust statements it deems active.
Implementation Note: The client still needs to validate the statements and cannot assume that all statements returned are indeed active.
page	Query	0	MUST be an integer. The zero-based page index (0..N) to retrive.
size	Query	20	MUST be an integer. The requested size of the page to be returned. Actual returned size may differ.
/api/v2/verification-query-public-statement/{jti}

GET	
MUST return a serialized Verification Query Public Statement.

MUST support the following parameters:

jti	Path	No default	MUST be a UUIDv4, see [RFC 9562], of the Verification Query Public Statement to return.
Retrieving Protected Verification Authorization Trust Statements
/api/v2/protected-verification-authorization-trust-statement/	GET	
MUST return a List Response Object, The content objects are serialized Protected Verification Authorization Trust Statements.

MUST support the following parameters:

sub	Query	No default	If provided MUST be a string. The trust registry returns only statements where the sub claim matches exactly.
filterActive	Query	true	MUST be a boolean. Indicates that the trust registry only returns trust statements it deems active.
Implementation Note: The client still needs to validate the statements and cannot assume that all statements returned are indeed active.
page	Query	0	MUST be an integer. The zero-based page index (0..N) to retrive.
size	Query	20	MUST be an integer. The requested size of the page to be returned. Actual returned size may differ.
/api/v2/protected-verification-authorization-trust-statement/{jti}

GET	
MUST return a serialized Protected Verification Authorization Trust Statement.

MUST support the following parameters:

jti	Path	No default	MUST be a UUIDv4, see [RFC 9562], of the Protected Verification Authorization Trust Statement to return.
Retrieving Protected Issuance Authorization Trust Statements  
/api/v2/protected-issuance-authorization-trust-statement/	GET	
MUST return a List Response Object, The content objects are serialized Protected Issuance Authorization Trust Statements.

MUST support the following parameters:

sub	Query	No default	If provided MUST be a string. The trust registry returns only statements where the sub claim matches exactly.
filterActive	Query	true	MUST be a boolean. Indicates that the trust registry only returns trust statements it deems active.
Implementation Note: The client still needs to validate the statements and cannot assume that all statements returned are indeed active.
page	Query	0	MUST be an integer. The zero-based page index (0..N) to retrive.
size	Query	20	MUST be an integer. The requested size of the page to be returned. Actual returned size may differ.
/api/v2/protected-issuance-authorization-trust-statement/{jti}

GET	
MUST return a serialized Protected Issuance Authorization Trust Statement.

MUST support the following parameters:

jti	Path	No default	MUST be a UUIDv4, see [RFC 9562], of the Protected Issuance Authorization Trust Statement to return.
Retrieving Protected Issuance Trust List Statements
/api/v2/protected-issuance-trust-list-statement/	GET	
MUST return a List Response Object, The content objects are serialized Protected Issuance Trust List Statements.

MUST support the following parameters:

filterActive	Query	true	MUST be a boolean. Indicates that the trust registry only returns trust statements it deems active.
Implementation Note: The client still needs to validate the statements and cannot assume that all statements returned are indeed active.
page	Query	0	MUST be an integer. The zero-based page index (0..N) to retrive.
size	Query	20	MUST be an integer. The requested size of the page to be returned. Actual returned size may differ.
/api/v2/protected-issuance-trust-list-statement/{jti}

GET	
MUST return are serialized Protected Issuance Trust List Statement

MUST support the following parameters:

jti	Path	No default	MUST be a UUIDv4, see [RFC 9562], of the Protected Issuance Trust List Statement to return.
/api/v2/protected-issuance-trust-list

GET	
MUST return are serialized Protected Issuance Trust List Statement

#### Retrieving Non-Compliance Trust List Statements

/api/v2/non-compliance-trust-list	GET	
MUST return are serialized Non-Compliance Trust List Statement.

Shared object definitions
List Response Object 




content

required

MUST be an array of objects. Objects are defined by the context of the endpoint utilizing the List Response Object.

page

required

MUST be an object. Fields detailed below

page.size

required

MUST be an integer depicting the size of the current page

page.number

required

MUST be an integer depicting the page number.

page.totalPages

required

MUST be an integer depicting the total count of pages

page.totalElements

required

MUST be an integer depicting the total count of elements over all pages



Example
Statements
Representations
Statements MUST utilize the JWT format detailed below.

JWT Format
Statements MUST be valid in accordance to [RFC 7519].

If a statement needs to be serialized the JWS Compact Serialization MUST be used.





typ	
Header

required

MUST be a string.
Implementation Note: The specific statements define the typ string.

alg	
Header

required

MUST be a cryptographic identifier string defined in the [swiss-profile-trust 1.0]

kid	
Header

required

MUST be an identifier which can be resolved to a specific cryptographic key as defined in the [swiss-profile-anchor 1.0].
Implementation Note: The specific statements define the type of the issuer, which are further defined in a [swiss-profile-trust].

profile_version	
Header

required

MUST be a string identifying the trust protocol version to process the statement.
MUST start with "swiss-profile-trust:" and afterward MUST contain a version string following the [Semantic Versioning] standard.

iat	
Payload

required

Issuance time, MUST be in accordance to [RFC 7519]

exp	
Payload

required

Expiry of validity time, MUST be in accordance to [RFC 7519]

To identify to which trust protocol a given statement belongs and how to process it the claims "profile_version" and "typ" MUST be evaluated.
The "profile_version" claim identifies the Trust Protocol version to utilize and the "typ" claim identifies the relevant statement of that trust protocol version.

Localization  
Certain claims of the statements need localization support.
To provide the localizated version of a string the following format is used:

"<claim name>#<language_tag>": "<localized value>"

language_tag MUST be a string in accordance to [BCP 47]

An application displaying a localized claim SHOULD display the localized value instead of the non localized value in accordance with the users preferences.
If a claim is provided in a localized version it SHOULD also provide the locale of the default value.

Example
Statement types
Identity Trust Statement (idTS)
This trust statement is provided by issuers and verifiers to link real-world identities to their cryptographic counterparts.

The trust statements contains the following fields:





typ

Header

required

MUST be "swiyu-identity-trust-statement+jwt"

kid

Header

required

This statement MUST be issued by an trust statement issuer identified in a [swiss-profile-trust].

status

Payload

required

MUST adhere to the status list revocation entry in a format defined by the [swiss-profile-vc 1.0]

 A statement MUST further be considered invalid when:

status cannot be resolved
status resolves does not resolve to valid

the resolved status list is issued by a different identifier than the statement;
Implementation Note: A different key to the one used for the VC from the issuer's identity is still acceptable.

sub

Payload

required

MUST be an identifier of the actor in a format defined in the [swiss-profile-anchor 1.0]

entity_name

Payload

required

MUST be a human readable string identifying the actor in the real world
MAY be localized

is_state_actor

Payload

required

MUST be a boolean (true/false) value. Indicates that the subject is considered a government approved state actor.

registry_ids

Payload

optional

MUST be an array of Registry ID Objects.

Registry ID Object




type

required

MUST be a string defining the type of the registry identifier.
We provide a non exhaustive list of well known types and corresponding information blow.

value 

required

MUST be a string. Further requirements of the identifier might apply depending on the type of identifier.

Well known registry IDs 






UID

123456789

Unternehmens-Identifikationsnummer

Federal Statistical Office

FAQ

Example Identity Trust Statement
Verification Query Public Statement (vqPS)
This statement is provided by verifiers to provide public transparency on their intended verification scope.





typ

Header

required

MUST be "swiyu-verification-query-public-statement+jwt"

kid

Header

required

This statement MUST be issued by a public transparency statement issuer identified in a [swiss-profile-trust].

sub

Payload

required

MUST be an identifier of the verifier in a format defined in the [swiss-profile-anchor 1.0]

jti

Payload

required

MUST be a UUIDv4, see [RFC 9562], provided by the statement issuer to facilitate easier matching in cross reference documents like the verifiers metadata.

purpose_name

Payload

required

MUST be a human readable string defining the purpose of this verification
MUST not contain more than 40 characters.
MAY be localized

purpose_description

Payload

required

MUST be a human readable string defining the purpose of this verification
MUST not contain more than 1000 characters.
MAY be localized

request

Payload

required

MUST be an Verification Request Object.

Verification Request Object 




type

required

MUST be the string "DCQL"

scope

required

MUST be a string in accordance to the "scope" parameter defined in [OpenID4VP].

query

required

If the type "DCQL" is chosen MUST be complying to restrictions of Verification Type: DCQL



Verification Type: DCQL

A query of type "DCQL" must comply with [OpenID4VP] and MUST contain for each Credential Query a "meta" field with an object containing at least the field "vct_values" with an non empty array.

Example DCQL Query

Example Verification Query Public Statement
Protected Verification Authorization Trust Statement (pvaTS)
This statement is provided by verifiers to provide authorization to request protected claims in a presentation from the holder





typ

Header

required

MUST be "swiyu-protected-verification-authorization-trust-statement+jwt"

kid

Header

required

This statement MUST be issued by an trust statement issuer identified in a [swiss-profile-trust].

status

Payload

required

MUST adhere to the status list revocation entry in a format defined by the [swiss-profile-vc 1.0]

 A statement MUST further be considered invalid when:

status cannot be resolved
status resolves does not resolve to valid

the resolved status list is issued by a different identifier than the statement;
Implementation Note: A different key to the one used for the VC from the issuer's identity is still acceptable.

sub

Payload

required

MUST be an identifier of the verifier in a format defined in the [swiss-profile-anchor 1.0]

jti

Payload

required

MUST be a UUIDv4, see [RFC 9562]. Identifies the protected claim trust statement

authorized_fields

Payload

required

MUST be a non-empty array of strings that specify the name of a field which is authorized to be verified.

A Protected Verification Authorization Trust Statement provides authorization to the verifier identified in the "sub" claim if the protected field is listed in the "authorized_fields" claim.

Example Protected Verification Authorization Trust Statement


Protected Issuance Authorization Trust Statement (piaTS)
This statement is provided by issuers as proof of state authorization to issue protected VCs .




typ

Header

required

MUST be "swiyu-protected-issuance-authorization-trust-statement+jwt"

kid

Header

required

This statement MUST be issued by an trust statement issuer identified in a [swiss-profile-trust].

status

Payload

required

MUST adhere to the status list revocation entry in a format defined by the [swiss-profile-vc 1.0]

 A statement MUST further be considered invalid when:

status cannot be resolved
status resolves does not resolve to valid

the resolved status list is issued by a different identifier than the statement;
Implementation Note: A different key to the one used for the VC from the issuer's identity is still acceptable.

sub

Payload

required

MUST be an identifier of the issuer in a format defined in the [swiss-profile-anchor 1.0]

jti

Payload

required

MUST be a UUIDv4, see [RFC 9562]. Identifies the protected claim trust statement

can_issue

Payload

required

MUST be a Protected Issuance Authorization Object

Protected Issuance Authorization Object

Defines the scope and descriptive details of the authorization.




vct

required

MUST be a String designating the type of the Credential, as defined for claim `vct` in [SD-JWT VC]

vct_name

required

MUST be a human readable string defining the name of the credential to be issued.
MUST not contain more than 40 characters.
MAY be localized

reason

optional

MUST be a human readable string defining reason of why the subject is permitted to issue this credential.
MUST not contain more than 1000 characters.
MAY be localized

Example Protected Issuance Authorization Trust Statement
Protected Issuance Trust List Statement (piTLS)
Information for actors which VCTs can be issued only by authorized issuers.





typ

Header

required

MUST be "swiyu-protected-issuance-trust-list-statement+jwt"

kid

Header

required

This statement MUST be issued by an trust statement issuer identified in a [swiss-profile-trust].

status

Payload

required

MUST adhere to the status list revocation entry in a format defined by the [swiss-profile-vc 1.0]

 A statement MUST further be considered invalid when:

status cannot be resolved
status resolves does not resolve to valid

the resolved status list is issued by a different identifier than the statement;
Implementation Note: A different key to the one used for the VC from the issuer's identity is still acceptable.

jti

Payload

required

MUST be a UUIDv4, see [RFC 9562]. Identifies the protected claim trust statement

vct_values

Payload

required

MUST be an array of strings that MUST be valid type identifiers as defined in [SD-JWT VC]

Example Protected Issuance Trust List Statement
Non-Compliance Trust List Statement (ncTLS)
This statement is provided by a trust registry, identified in a [swiss-profile-trust], as a means to warn actors of known bad actors in the ecosystem.






typ

Header

required

MUST be "swiyu-non-compliance-trust-list-statement+jwt"

kid

Header

required

This statement MUST be issued by an trust statement issuer identified in a [swiss-profile-trust].

status

Payload

required

MUST adhere to the status list revocation entry in a format defined by the [swiss-profile-vc 1.0]

 A statement MUST further be considered invalid when:

status cannot be resolved
status resolves does not resolve to valid

the resolved status list is issued by a different identifier than the statement;
Implementation Note: A different key to the one used for the VC from the issuer's identity is still acceptable.

non_compliant_actors

Payload

required

MUST be an array of Non-Compliant Actor Objects

Non-Compliant Actor Object

Defines the scope of the state authorization.




actor

required

MUST be an identifier of the bad actor in a format defined in the [swiss-profile-anchor 1.0]

flagged_at

required

MUST be a [RFC 3339] compliant String

reason

required

MUST be a human readable String with a description of why this actor was deemed a bad actor.
MAY be localized (Frage)  

Example Non-Compliance Trust List Statement
