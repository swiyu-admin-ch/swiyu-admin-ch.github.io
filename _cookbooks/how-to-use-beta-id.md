---
title: How to use Beta-ID for my business
toc: true
toc_sticky: true
excerpt: Learn how to use the Beta-ID and about the credential details
header:
  teaser: ../assets/images/cookbook_beta_eid.jpg
---

{% capture notice-text %}

Please be advised that the current system and its operations are provided on a best-effort basis and will continue to evolve over time. The security of the system and its overall maturity remain under development.

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Public Beta</h4>
  {{ notice-text | markdownify }}
</div>

## In brief

**What is the Beta-ID?**

The Beta-ID is a pseudo-identity credential that was created for test purposes within the Public Beta environment, holding the same identity attributes as the coming e-ID. 

**Is the Beta-ID an official proof of identification?**

No, the Beta-ID is not a proof of identification.

**Who can obtain a Beta-ID?**

The service for obtaining a Beta-ID is open to anyone who is interested.

**How to obtain a Beta-ID?**

Anyone can create a Beta-ID on the [Beta Credential Service](https://www.bcs.admin.ch/bcs-web).
It can also get verified and revoked directly from the platform. 

**What information can be stored in the Beta-ID?**

You can choose the values in the Beta-ID request form yourself. Avoid entering your real personal data if possible.

**What happens to the data after the Beta-ID has been issued?**

After it has been issued, all data on the Beta Credential Service server except for the Beta-ID number will be deleted. The number is needed for the revocation.
The rest of the Beta-ID data will solely be found in the wallet on which it has been issued to. 

## The Beta-ID credential in Detail

The Beta-ID is a blueprint of the coming e-ID credential. All attribute definitions are equal to the e-ID credential.

The complete credential schema and the precise concepts behind the attributes will be published on the [interoperability platform I14Y](https://www.i14y.admin.ch/de/catalog/all) of the Confederation.

<details markdown="1">
<summary markdown="span">Example of the issued SD-JWT credential</summary>

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

## Use cases for the Beta-ID

Every verifier having a system following the [standards of the swiyu ecosystem](https://swiyu-admin-ch.github.io/specifications/interoperability-profile/) is able to verify Beta-IDs.
As the data in Beta-ID is only self-declared, the Beta-ID is an easy-to-create credential to test diverse use cases which need some kind of identity or person information.

The Beta-ID can be used to build and test use cases that will in the future rely upon the verification of the official e-ID. Here are some examples:

- There will be e-governmental systems working with the social security number (AHV/AVS), so these systems can start integrating the necessary elements to connect with their business applications.
- There will be private companies having a need to do identification routines (e.g. KYC or before issuing another credential), asking for given_name, family_name, birth_date and birth_place.
- There will be vendors having a need to check for age restrictions with age_over_18.
- There might be services just wanting to know that there is a "real person" behind a request, asking just for the expiry_date.
- There may be plenty of other use cases to cover.

That's it? With the Beta-ID yes, but the [swiyu Trust Infrastructure](https://swiyu-admin-ch.github.io/open-source-components/) is also there to be used by other issuers and verifiers!

## Left outs
- OCA metadata for VC styling and value localization is not provided yet.

## Useful hints
- When target systems of verifiers use the social security number, be aware to set a number that validates the pattern starting with 756. and ending with the correct check digit ([EAN-13 norm](https://en.wikipedia.org/wiki/International_Article_Number)).
- Portrait images are resized and cropped to the same output size.
- The image "blob" may be a good place for hiding malicious code. But also the firstname or lastname are. The beta credential service does not care about the integrity of the data. So for every holder and verifier application: the data has to be considered as "untrusted user input". Thanks to this it is possible to check also the robustness of your holder or verifier solution!
- A revocation cannot be reverted. This is a governance decision, not a technical issue.

## What should not be done?

Well,

- don't take it as an official and valid identity credential for your productive business cases.
- don't rely on the document_number. Also with the e-ID the document number is not a persistent identifier for the person and the value will change with each new Beta-ID for that person. The Beta-ID as the e-ID does not contain a persistent identifier for usage in private sector use cases. Who ever needs such a persistent identifier: become an issuer and issue a credential with such an identifier yourself!
- no need to reinvent the wheel: there are several open source components and libraries for issuers, verifiers and wallets available.
- don't upload illegal picture materials and avoid using your personal data and picture if not necessarily needed. Please be aware that the verifier solutions where you share your data may not be as secure as productive environments, as they are often test or development systems.
