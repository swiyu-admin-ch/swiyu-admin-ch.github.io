---
title: "Swiss Profile Portability"
toc: true
toc_sticky: true
excerpt: Specifications for transferring VC's in the swiyu Trust Infrastructure
header:
  teaser: ../assets/images/swiss-profile-portability.jpg
---


<div class="notice--info">
  Version 1.0 <br>
  Status: draft <br>
  Last edited: 2026-10-27
</div>


# Introduction

This profile concerns itself with how ""Verifiable Credentials (VC)" in the swiyu Trust Infrastructure can be transferred from one Wallet to another. Components of the swiyu Trust Infrastructure can port verifiable credentials only if they satisfies the following specifications.

All underlying specifications referenced by the included standards are considered fully supported / needed unless explicitly noted otherwise.

# Specifications

This section details the implementation notes and gaps pertaining to the supported specifications.

The specifications are fully supported by this profile (and components adhering to it) except for the specific cases mentioned in the following subsections.

| Contained Specifications | Version | Link to referenced Specification |
| ---- | ---- | ---- |
| Wallet Backup Container | 1.0 | available soon |


**KEY WORDS** for this swiss profile expand on RFC 2119 "Key words for use in RFCs to Indicate Requirement Levels". They are explained in the [general introduction for the specifications](/specifications/introduction/#key-words). They are to be interpreted as such when, and only when, they appear **bold** and CAPITALIZED.


## Wallet Backup Container 

The specification is fully supported by this profile (and components adhering to it) except for the specific cases mentioned in the following subsections.

<div class="notice--warning">
The below sub-sections rely on the numbering from the original reference specification for ease of reference and comparison.
</div>

### File format

container_encryption.json **MUST** be used and contained in the wbak backup file.

wbak files in JSON data structure (wbak-*.json) **MUST NOT** be used. Wbak files have to be in an encrypted JSON data structure encoded as JWE.

### meta.json - Metadata file

Swiss Profile version indication with parameter `profile_version` in the wallet backup container JSON body is **REQUIRED**. 

``` Wallet Backup Container version
{
  "type": "WalletBackupContainerV1",
  "creation_date": "2025-01-01T15:50+00Z",
  "profile_version": "swiss-profile-portability:1.0.0"  
}
```
### wbak-* - Wallet Backup Container files

Wallets **MUST** support encrypted wback files encoded as JWE with the following header parameter:

| `**alg**` | MUST be `dir` |
| `**enc**` | MUST be `A256GCM` |

### Container Types

#### VerifiableCredentialContainerV1

In the case of batch-issued credentials with a hardware key holder binding, the `credentials` array property **SHOULD** contain only a single credential.

#### VerifiableCredentialAuthenticationContainerV1
A credential is treated as refreshable, when it has an `authentications` parameter entry in the `VerifiableCredentialAuthenticationContainerV1` and the Credential Issuer Metadata parameter `credential_refresh_disabled` is absent or false (see [swiss-profile-issuance 1.0](https://swiyu-admin-ch.github.io/specifications/swiss-profile-issuance/#1224-credential-issuer-metadata-parameters)).

{% capture notice-text %}

The ability to refresh credentials after recovery from a Wallet Backup Container SHOULD be preserved by ensuring that the Authorization Server does not rotate refresh tokens. Detection of refresh token replay can still be ensured by sender-constrained refresh tokens using DPoP (see [swiss-profile-issuance 1.0](https://swiyu-admin-ch.github.io/specifications/swiss-profile-issuance/#145-refreshing-issued-credentials))

{% endcapture %}

<div class="notice--info">
  <h3 class="no_toc">Implementation Note</h3>
  {{ notice-text | markdownify }}
</div>
