---
title: Test Collapsing Content
permalink: /test-collapse/
toc: true
toc_sticky: true
---

Multiple technical architectures, standards and approaches were considered in the development process of the swiyu Trust Infrastructure. A key decision was to follow the decentralized identity paradigm that is built around the subject as owner of their personal data. Technically, this paradigm is often implemented by providing data subjects with a digital identity wallet. In acknowledgement of the fast-paced technological ecosystem of identity wallet apps and digital credentials, the decision was made to work towards a multi-stack solution for the infrastructure. Meaning that, multiple technical specifications are going to be supported simultaneously by the swiyu Trust Infrastructure in the future. This approach allows Switzerland to benefit from technological advancements (e.g., privacy-enhancing features) as well as to ensure interoperability in cross-border use cases. 

Initially the Confederation will focus on a single technology stack to reduce complexity and ensure maximum technical interoperability within Switzerland. The technology decision that has been published on December 6th 2024 defines the current technology stack for the swiyu Trust Infrastructure. Its specifications are introduced below.


<details markdown="1">

<summary markdown="span">Collapse Code Block</summary>

# Example of the issued SD-JWT credential

```
{
  "vct": {
    "value": "betaid-sdjwt",
    "disclose": false
  },
  "_sd_alg": {
    "value": "sha-256",
    "disclose": false
  },
  "iss": {
    "value": "did:tdw:QmRSJNTEM1PkmiD6fcfAFdZERmzqVkok6xwmx9XyvgckxX:identifier-reg-a.trust-infra.swiyu-int.admin.ch:api:v1:did:5caa5372-34b5-4a47-9744-55ba8e680ed0",
    "disclose": false
  },
  "cnf": {
    "value": {
      "kty": "EC",
      "use": "sig",
      "crv": "P-256",
      "kid": "dfdc998b-6bda-4107-a5c5-5fd0162350d7",
      "x": "mzddJ3NfpDYe-pnmFuKZJJckzlZxFHRf1CcGaujZn9Q",
      "y": "yL2vrimO-xvtMDfM-e_WipfsKpNbl0wlcpbvKBX8aUY"
    },
    "disclose": false
  },
  "iat": {
    "value": 1739801909,
    "disclose": false
  },
  "status": {
    "value": {
      "status_list": {
        "uri": "https://status-reg-a.trust-infra.swiyu-int.admin.ch/api/v1/statuslist/28361336-7934-41d5-ab23-7d6c9009e6e6.jwt",
        "idx": 241,
        "type": "SwissTokenStatusList-1.0"
      }
    },
    "disclose": false
  },
  "document_number": {
    "value": "BETA-ID-P5Y700MS",
    "disclose": true
  },
   "given_name": {
    "value": "Helvetia",
    "disclose": true
  },
   "family_name": {
    "value": "National",
    "disclose": true
  },  
   "birth_date": {
    "value": "1848-09-12",
    "disclose": true
  }, 
   "age_over_16": {
    "value": "true",
    "disclose": true
  }, 
  "age_over_18": {
    "value": "true",
    "disclose": true
  },
   "age_over_65": {
    "value": "true",
    "disclose": true
  },
   "age_birth_year": {
    "value": "1848",
    "disclose": true
  },
   "birth_place": {
    "value": "Luzern",
    "disclose": true
  }, 
   "place_of_origin": {
    "value": "Altdorf UR",
    "disclose": true
  },
   "sex": {
    "value": "2",
    "disclose": true
  }, 
  "nationality": {
    "value": "CH",
    "disclose": true
  },
   "portrait": {
    "value": "iVBORw0KGgoAAAANSUhEUgAAAVYAA...",
    "disclose": true
  },  
   "additional_person_info": {
    "value": "N/A",
    "disclose": true
  }, 
   "personal_administrative_number": {
    "value": "756.3658.1881.91",
    "disclose": true
  },   
  "reference_id_type": {
    "value": "Self-Declared",
    "disclose": true
  },
   "verification_type": {
    "value": "Self-Service",
    "disclose": true
  }, 
   "issuance_date": {
    "value": "2025-02-17",
    "disclose": true
  }, 
  "issuing_country": {
    "value": "CH",
    "disclose": true
  },
  "issuing_authority": {
    "value": "Beta Credential Service BCS",
    "disclose": true
  },
  "verification_organization": {
    "value": "Beta Credential Service BCS",
    "disclose": true
  },
  "reference_id_expiry_date": {
    "value": "2030-02-17",
    "disclose": true
  },
  "expiry_date": {
    "value": "2025-05-17",
    "disclose": true
  }
}
```
</details>

<details markdown="1">

<summary markdown="span">Collapse Table</summary>

| Aspect |	Selected Technology & References for the Public Beta version currently in use |
|-------|---------------|
| Identifiers |	[W3C Decentralized Identifiers v1.0](https://www.w3.org/TR/did-core/) <br> [did:tdw/did:webvh v0.3](https://identity.foundation/didwebvh/v0.3/) (as DID Method) |
| Status Mechanisms |	[Token Status List draft 3](https://www.ietf.org/archive/id/draft-ietf-oauth-status-list-03.html) |
| Trust Protocol |	[Swiss Trust Protocol version 0.1 (based on VCs)](https://swiyu-admin-ch.github.io/specifications/trust-protocol/) |
| Communication Protocol |	[OID4VCI – draft 13 (for credential issuance)](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0-ID1.html) <br> [OID4VP – draft 20 (for credential verification)](https://openid.net/specs/openid-4-verifiable-presentations-1_0-20.html) |
| Payload Encryption	| [JWE](https://www.rfc-editor.org/rfc/rfc7516.html)[^1] (as proposed by the communication protocol) |
| VC-Format & Signature-Scheme |	[SD-JWT VC – draft 4](https://datatracker.ietf.org/doc/draft-ietf-oauth-sd-jwt-vc/04/) <br> [SD-JWT draft 10](https://datatracker.ietf.org/doc/draft-ietf-oauth-selective-disclosure-jwt/10/) <br> [ECDSA P-256](https://csrc.nist.gov/pubs/fips/186-5/final) |
| Device Binding Scheme	| **Hardware-based** device binding (depending on capabilities provided by [Android](https://source.android.com/docs/security/features/keystore) or [Apple](https://developer.apple.com/documentation/cryptokit/secureenclave) mobile devices) <br> **Software-based**[^1] device binding implemented by wallets |
| VC appearance	 | [Overlays Capture Architecture](https://swiyu-admin-ch.github.io/specifications/oca/) (for visualization of VCs)[^1]

[^1]: Use of this technology is planned, and specification/implementation is in progress

</details>


{% capture notice-text %}

Upgrades to newer versions are planned for the go-live of the productive environment.

{% endcapture %}

<div class="notice--info">
  <h4 class="no_toc">Note:</h4>
  {{ notice-text | markdownify }}
</div>
