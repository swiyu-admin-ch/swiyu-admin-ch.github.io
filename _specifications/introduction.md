---
title: "Introduction"
toc: true
toc_sticky: true
excerpt: Introduction and Overview of the Swiss Profiles")
header:
  teaser: ../assets/images/specifications_interoperability-profile.jpg
---


Swiss Profiles provide a stable abstraction layer for managing versioning across our ecosystem of interdependent, versioned artefacts. Instead of dealing with each specification and its versions individually, a Swiss Profile groups them into a coherent, well-defined bundle.

Each Swiss Profile contains:

- A curated set of specifications relevant for a particular domain or integration scenario
- For every specification, one or more allowed versions
- Implementation notes and identified gaps where behaviour deviates from the underlying specs

This structure lets us define what a client or service must support in a single place, while absorbing the complexity of evolving specifications underneath. Swiss Profiles make compatibility expectations explicit, reduce integration friction, and ensure we can evolve the ecosystem without breaking dependent systems.

# Overview

As of now there are 7 Swiss Profiles with the following specifications contained in them. These profiles replace the previously published [Interoperability Profile](../archive/interoperability-profile) for the swiyu Public Beta Trust Infrastructure.

| Swiss Profile              | Specifications          |
|----------------------------|-------------------------|
| swiss-profile-trust        | Trust Protocol    <br> Non-compliance Protocol      |
| swiss-profile-anchor       | DID Core <br> DID:webvh               |
| swiss-profile-vc           | Token Status List  <br> SD-JWT <br>  SD-JWT-VC <br>  OCA                     |
| swiss-profile-issuance     | OAuth 2.0 DPoP  <br> OpenID4VCI              |
| swiss-profile-verification | OpenID4VP      <br> JAR                 |
| swiss-profile-proximity    | mDL ISO-18013-5 BLE     |
| swiss-profile-portability  | Wallet Backup Container |

# Dependencies between Swiss Profiles

While there exist no hard dependencies between Swiss Profiles (i.e. a spec from Swiss Profile X works on it's own and doesn't strictly need other specifications in Swiss Profile Y) there is still a de facto hierarchy of the Swiss Profiles: some Swiss Profiles build upon another, thus artefacts / use cases sometimes have to depend on multiple Swiss Profiles. 

_Example:
The swiss-profile-verification-proximity is aimed specifically at an artefact concerned with proximity verification, i.e. verification using direct connection via Bluetooth Low Energy.
It builds upon the regular swiss-profile-verification, which covers the more generic verification use case._

The following diagram shows how the Swiss Profiles build upon each other:

[![swiss-profiles-dependencies](../assets/images/swiss-profiles-dependencies.png)](../assets/images/swiss-profiles-dependencies.png)


# Key Words

Key words for thie swiss profiles expand on RFC 2119 "Key words for use in RFCs to Indicate Requirement Levels"

| MUST |   This word, or the terms "REQUIRED" or "SHALL", mean that the definition is an absolute requirement of the specification. |
|MUST NOT |  This phrase, or the phrase "SHALL NOT", mean that the definition is an absolute prohibition of the specification. |
| SHOULD |  This word, or the adjective "RECOMMENDED", mean that there may exist valid reasons in particular circumstances to ignore a particular item, but the full implications must be understood and carefully weighed before choosing a different course. |
|SHOULD NOT |   This phrase, or the phrase "NOT RECOMMENDED" mean that there may exist valid reasons in particular circumstances when the particular behavior is acceptable or even useful, but the full implications should be understood and the case carefully weighed before implementing any behavior described with this label. |
| MAY |  This word, or the adjective "OPTIONAL", mean that an item is truly optional.  One vendor may choose to include the item because a particular marketplace requires it or because the vendor feels that it enhances the product while another vendor may omit the same item. An implementation which does not include a particular option MUST be prepared to interoperate with another implementation which does include the option, though perhaps with reduced functionality. In the same vein an implementation which does include a particular option MUST be prepared to interoperate with another implementation which does not include the option (except, of course, for the feature the option provides.) |
| NOT SUPPORTED | This phrase mean that the functionality is not officially supported in the swiss profile, but MAY be implemented. |
