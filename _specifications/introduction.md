---
title: "Introduction"
excerpt: Introduction and Overview of the Swiss Profiles
header:
  teaser: ../assets/images/swiss-profile-introduction.jpg
toc: true
toc_sticky: true
---


Swiss Profiles provide a stable abstraction layer for managing versioning across our ecosystem of interdependent, versioned artefacts. Instead of dealing with each specification and its versions individually, a Swiss Profile groups them into a coherent, well-defined bundle.

Each Swiss Profile contains:

- A curated set of specifications relevant for a particular domain or integration scenario
- For every specification, one or more allowed versions
- Implementation notes and identified gaps where behaviour deviates from the underlying specs

This structure defines what a client or service must support in a single place, while absorbing the complexity of evolving specifications underneath. Swiss Profiles make compatibility expectations explicit, reduce integration friction, and ensure we can evolve the ecosystem without breaking dependent systems.

# Overview

As of now there are 7 Swiss Profiles with the following specifications contained in them. These profiles replace the previously published [Interoperability Profile](/archive/interoperability-profile) for the swiyu Public Beta Trust Infrastructure.

| Swiss Profile              | Specifications          |
|----------------------------|-------------------------|
| [swiss-profile-trust](../swiss-profile-trust/)        | Trust Protocol    <br> Non-compliance Protocol      |
| [swiss-profile-anchor](../swiss-profile-anchor/)       | DID Core <br> DID:webvh               |
| [swiss-profile-vc](../swiss-profile-vc/)           | Token Status List  <br> SD-JWT <br>  SD-JWT-VC <br>  OCA                     |
| [swiss-profile-issuance](../swiss-profile-issuance/)     | OAuth 2.0 DPoP  <br> OpenID4VCI              |
| [swiss-profile-verification](../swiss-profile-verification/) | OpenID4VP      <br> JAR                 |
| swiss-profile-proximity   | mDL ISO-18013-5 BLE     |
| swiss-profile-portability  | Wallet Backup Container |

# Scope

| Component |	Description |swiss-profile-trust |swiss-profile-anchor |	swiss-profile-vc	| swiss-profile-issuance |	swiss-profile-verification |	swiss-profile-verification-proximity |	swiss-profile-portability |
|---|---|---|---|---|---|---|---|---|
|Base Registry	| The central base registry provided in the swiyu trust infrastructure.           	                          |   | X |   |   |   |   |   |  
| DID Toolbox / Resolver	| The published DID helper libraries or resolving and working with DIDs.	                          |   | X |   |   |   |   |   |
| Status Registry |	The central status registry as provided in the swiyu trust infrastructure.	                              |   | X | X |   |   |   |   |
| Trust Registry <br> (w/o Trust Issuer, onboarding) | The central trust registry as provided in the swiyu trust infrastructure. <br> Excludes the trust issuer and trust management systems, as well as the onboarding of participants. | X |   | X |   |   |   |   |
|Issuer / Generic Issuer |	A custom issuer implementation, or the generic issuer component, or a custom issuer based on the generic issuer component. |   | X | X | X |   |   |   |
|Verifier / Generic Verifier |	A custom verifier implementation, or the generic verifier component, or a custom verifier based on the generic issuer component. | X | X | X |   | X |   |   |
|Wallet	| The swiyu wallet app                                                                                                | X | X | X | X | X | X | X |
| Proximity Verifier /Check App |	A proximity verifier, i.e. a mobile app verifier relying on device engagement via Bluetooth. | X | X | X |   | X | X |    |
|VC |	A verifiable credential issued in the swiyu ecosystem.	                                                                 |   | X | X |   |   |   |    |

# Dependencies between Swiss Profiles

While there exist no hard dependencies between Swiss Profiles (i.e. a spec from Swiss Profile X works on it's own and doesn't strictly need other specifications in Swiss Profile Y) there is still a de facto hierarchy of the Swiss Profiles: some Swiss Profiles build upon another, thus artefacts / use cases sometimes have to depend on multiple Swiss Profiles. <br>

_Example:
The swiss-profile-verification-proximity is aimed specifically at an artefact concerned with proximity verification, i.e. verification using direct connection via Bluetooth Low Energy.
It builds upon the regular swiss-profile-verification, which covers the more generic verification use case._

The following diagram shows how the Swiss Profiles build upon each other:

[![swiss-profiles-dependencies](/assets/images/swiss-profiles-dependencies.png)](/assets/images/swiss-profiles-dependencies.png)

# Versioning

With the indication of the Swiss Profile version, participants can detect which exact version is currently used and are therefore able to support multiple versions even if there are breaking changes between these versions.

## Principles

**Versioning is mandatory**

Adding the versioning indication as mentioned is **REQUIRED**. There are some cases where this is not (yet) enforced to cope with legacy entities during a transitional period (e.g. old DID logs pre-existing the definition of this versioning indication).

**Versioning Attribute**

Wherever possible, the version is indicated in the various data structures of the specifications within the attribute/field name `profile_version`.
- In JWTs the `profile_version` versioning attribute goes into the header of the JWT.
- In regular JSONs the `profile_version` versioning attribute goes into the regular JSON body.

**Versioning Entities vs References**

We sometimes have (versioned) entities which refer to other versioned entities. E.g. entity Foo, a JWT, contains a reference to entity Bar, a JSON.

The following principles apply:
- Entities **MUST** have a versioning indication. (in the example above: versioning attribute in entity Bar).
- Reference **CAN** get a versioning indication, this should only be done if there are good reasons for it (e.g. additionally adding the version of Bar next to the reference to Bar in Foo).

## Pattern

The pattern of the used Swiss Profile versions is:

```
swiss-profile-{type}:{profileVersion}
```
Where `{profileVersion}` follows the pattern of [Semantic Versioning](https://semver.org/). In summary our versions follow the schema MAJOR.MINOR.PATCH, where:

- MAJOR version for breaking changes, i.e. incompatible changes to any interface
- MINOR version for backwards compatible changes, e.g. adding functionality
- PATCH version for backward compatible bug fixes

Example:

```
swiss-profile-issuance:1.0.0
```
## Overview

The following diagram shows an overview of the various versioned entities in the swiyu ecosystem and how they relate among each other, as well as to third party standards specifications.

[![swiyu-ecosystem-versioning](/assets/images/swiyu-ecosystem-versioning.png)](/assets/images/swiyu-ecosystem-versioning.png)

## Versioning Indications

| Specification | Entity/Interface | Versioning Indication |
|---|---|---|
|Trust Protocol | JWT Statement | [Trust Statement version](../trust-protocol-v2-0/#statements) |
|DID:webvh | DID Log | [DID Log Entry version](../swiss-profile-anchor/#did-log-entry-version) |
|Token Status List | Status List Token | [Status List Token JWT version](../swiss-profile-vc/#5-status-list-token)  |
| SD-JWT/SD-JWT-VC | VC | [SD-JWT VC version](../specifications/swiss-profile-vc/#321-jose-header)     |
| SD-JWT/SD-JWT-VC | VCT | [VCT version](../specifications/swiss-profile-vc/#5-sd-jwt-vc-type-metadata)     |
| OCA | OCA | [OCA Bundle JSON version](../specifications/swiss-profile-vc/#oca-bundle-as-json-file) |
| OAuth 2.0 DPoP | DPoP | [DPoP JWT version](../swiss-profile-issuance/#42-dpop-proof-jwt-syntax) |
| OID4VCI | Issuer Meta Data | In case of _signed_ meta data: [Credential Issuer Metadata JWT version](../swiss-profile-issuance/#1223-signed-metadata) <br> In case of _unsigned_ meta data: [Credential Issuer Metadata](../swiss-profile-issuance/#1224-credential-issuer-metadata-parameters) |
| Key Attestation | Key Attestation | [Key Attestation JWT version](../swiss-profile-issuance/#d1-key-attestation-in-jwt-format) |
| OID4VP | Verification Request Object | [JAR version](../swiss-profile-verification/#5-authorization-request) |
| mDL ISO-18013-5 BLE | Verifier Attestation | [Verifier Attestation JWT] |


# Key Words

Key words for thie swiss profiles expand on [RFC 2119 "Key words for use in RFCs to Indicate Requirement Levels"](https://datatracker.ietf.org/doc/html/rfc2119). They are to be interpreted as such when, and only when, they appear **bold** and CAPITALIZED.

| **MUST** |   This word, or the terms "**REQUIRED**" or "**SHALL**", mean that the definition is an absolute requirement of the specification. |
| **MUST NOT** |  This phrase, or the phrase "**SHALL NOT**", mean that the definition is an absolute prohibition of the specification. |
| **SHOULD** |  This word, or the adjective "**RECOMMENDED**", mean that there may exist valid reasons in particular circumstances to ignore a particular item, but the full implications must be understood and carefully weighed before choosing a different course. |
| **SHOULD NOT** |   This phrase, or the phrase "**NOT RECOMMENDED**" mean that there may exist valid reasons in particular circumstances when the particular behavior is acceptable or even useful, but the full implications should be understood and the case carefully weighed before implementing any behavior described with this label. |
| **MAY** |  This word, or the adjective "**OPTIONAL**", mean that an item is truly optional.  One vendor may choose to include the item because a particular marketplace requires it or because the vendor feels that it enhances the product while another vendor may omit the same item. An implementation which does not include a particular option MUST be prepared to interoperate with another implementation which does include the option, though perhaps with reduced functionality. In the same vein an implementation which does include a particular option MUST be prepared to interoperate with another implementation which does not include the option (except, of course, for the feature the option provides.) |
| **NOT SUPPORTED** | This phrase mean that the functionality is not officially supported in the swiss profile, but MAY be implemented. |
