---
title: Implementation Considerations for the swyiu Components
toc: true
toc_sticky: true
excerpt: Notable Considerations for using the Components of the swiyu Trust Infrastructure
header:
  teaser: ../assets/images/cookbook_beta_eid.jpg
---

{% capture notice-text %}

So sieht der Notice-Text aus (Überschrift siehe h4 unten)

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Public Beta</h4>
  {{ notice-text | markdownify }}
</div>


# Introduction

This page lists implementation details that should be considered when using or interacting with the swiyu components.

## Titel 1.1


# swiyu Wallet

## Attestations

**Key Attestation**

**Client Attestation**

## Issuing into swiyu Wallet

**[Credential Response](https://swiyu-admin-ch.github.io/specifications/swiss-profile-issuance/#83-credential-response):** 
* Generally issuers are recommended to fit the size of issued VCs to their use case and to keep them as small as possible. The same goes for the batch payload limit.
* The max payload limit SUPPORTED by the swiyu Wallet is 20MB (measured decompressed but potentially still encrypted payload).

## Verification of VCs stored in swiyu Wallet

**[Authorization Response Size](https://confluence.bit.admin.ch/spaces/EIDTEAM/pages/1277151843/swiss-profile-verification+1.0#swissprofileverification1.0-AuthorizationResponseSize)**
* Generally verifiers are recommended to tailor the size of accepted presentations to their use case and to keep them small enough to prevent the risk of overloading systems/DoS.
* The recommended supported authorization response (aka presentation) size is the current max payload limit of accepted VCs (see Issuing into swiyu Wallet - Credential Response) plus one MB.
* In order to be guaranteed to work with VCs presented by the swiyu Wallet a verifier needs to support an authorization response size of 21MB.

## Credential status handling
The swiyu wallet handles the different status of VCs as follows:




# swiyu Generic Issuer

# swyiu Generic Verifier

# swiyu Check

## Attestations

**Verifier Attestation**


# swiyu Base Registry

## Status Registry

In addition to conformity checks documented in the standard, the registry performs additional checks on upload of a Status List:

* Size Limits: The Status List Token size MUST be greater than 200 bytes and MUST NOT exceed 200 KB. The decompressed Byte Array also MUST NOT exceed 200KB (~100'000 entries when using 2 bits per status). This ensures the registry remains performant while preventing the upload of empty or malformed headers.
* Cryptographic Integrity: The document MUST include a valid digital signature. Submissions with invalid, expired, or unsupported signature formats MUST be rejected.

Additional checks to the content of the Status List Token are performed

|Claim	| Requirement Type | Validation Logic
| -- | -- | -- |
| kid (Key Identifier) |	Initial Upload	| MUST match a Decentralized Identifier (DID) currently authorized and assigned to the submitting swiyu business partner.
| kid (Key Identifier) | Subsequent Updates |	MUST be signed by the same entity as the previously recorded version of the Status list. See: swiss-profile-anchor 1.0#JWTValidationwithcryptographickeysfromDIDs
| iat (Issued At) |	Freshness Check |	MUST be greater than T - 24 hours (where T represents the current system time). Documents older than 24 hours cannot be uploaded.
| iat (Issued At) |	Freshness Check |	MUST be greater than the iat of the last version of the status list.
| exp (Expiration) |	Validity Window |	MUST be present and MUST be greater than the current system time (T).


# swiyu Trust Registry

## Trust Roots

## Trust statement details
