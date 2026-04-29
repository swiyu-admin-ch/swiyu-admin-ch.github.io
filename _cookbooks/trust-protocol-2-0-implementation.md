---
title: Trust Protocol Implementation Examples
toc: true
toc_sticky: true
excerpt: Examples on how to implement the swiyu Trust Protocol
header:
  teaser: ../assets/images/cookbook_beta_eid.jpg
---

{% capture notice-text %}

For a general introduction on Trust ... trust-profile and trust protocol



{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Public Beta</h4>
  {{ notice-text | markdownify }}
</div>

# Trust Protocol 2.0

## gucTM - protected verification

The following non-normative example shows a SD-JWT example VC with a protected field at the root node.

```
{
    "typ": "vc+sd-jwt",
    "alg": "ES256",
    "kid": "did:example:issuer#key-1",
}
.
{
  "iat": 1690360968,
  "exp": 1753432968, 
  "personal_administrative_number": "756.1234.5678.90"
}
.
<SIGNATURE>

```

The following non-normative example shows a SD-JWT example VC with a protected field at a child node.
```
{
    "typ": "vc+sd-jwt",
    "alg": "ES256",
    "kid": "did:example:issuer#key-1",
}
.
{
  "iat": 1690360968,
  "exp": 1753432968,
  "some_parent": {
    "personal_administrative_number": "756.1234.5678.90"
  }, 
}
.
<SIGNATURE>


The following non-normative example shows a SD-JWT example VC with no protected field.

{
    "typ": "vc+sd-jwt",
    "alg": "ES256",
    "kid": "did:example:issuer#key-1",
}
.
{
  "iat": 1690360968,
  "exp": 1753432968,
  "personal": {
    "administrative": {
      "number": "1234ABC"
    }
  }
}
.
<SIGNATURE>
```

## Issuer Metadata

The following is a non-normative example of an abbreviated credential issuer metadata extended with a Identity Trust Statement and a Protected Issuance Authorization Trust Statement.
```
{
  "kid": "did:tdw:QmZytPjpzRh6PmxgLtQYKaZckQ8T4WLhvMaHWLaTBdquqq:identifier-reg.trust-infra.swiyu-int.admin.ch:api:v1:did:95bafa40-c4a1-4db9-b035-84b556f8e94c#assert-key-01",
  "typ": "openidvci-issuer-metadata+jwt",
  "alg": "ES256"
}
.
{
  "credential_issuer": "https://chasseral-r.infra.swiyu.admin.ch/issuer02",
  "credential_issuer_identity_trust_statement": "eyJ0eXAiOiJzd2l5dS1pZGVudGl0eS10cnVzdC1zdGF0ZW1lbnQrand0IiwiYWxnIjoiRVMyNTYiLCJraWQiOiJmMzhiYTE0NGM4YzlhZTQwYWE1MTg4OTc3OWQ5Mzk4NCIsInByb2ZpbGVfdmVyc2lvbiI6InN3aXNzLXByb2ZpbGUtdHJ1c3Q6MS4wLjAifQ.eyJzdWIiOiJkaWQ6ZXhhbXBsZTpzdWJqZWN0IiwiaWF0IjoxNjkwMzYwOTY4LCJleHAiOjE3NTM0MzI5NjgsInN0YXR1cyI6eyJzdGF0dXNfbGlzdCI6eyJpZHgiOjAsInVyaSI6Imh0dHBzOi8vZXhhbXBsZS5jb20vc3RhdHVzbGlzdHMvMSJ9fSwiZW50aXR5TmFtZSI6IkpvaG4gU21pdGgncyBTbWl0aGVyeSIsImVudGl0eU5hbWUjZGUiOiJKb2huIFNtaXRoJ3MgU2NobWlkZXJlaSIsImVudGl0eU5hbWUjZGUtQ0giOiJKb2huIFNtaXRoJ3MgU2NobWlkZXJlaSIsImlzU3RhdGVBY3RvciI6ZmFsc2UsInJlZ2lzdHJ5SWRzIjpbeyJ0eXBlIjoiVUlEIiwidmFsdWUiOiJDSEUtMDAwLjAwMC4wMDAifSx7InR5cGUiOiJMRUkiLCJ2YWx1ZSI6IjBBMUIyQzNENEU1RjZHN0g4SjlJIn1dfQ.kVk0ovqKHR-6Q5g8H6tUjE-euaADAxZQQUcufd_IgPYzNhzQ10xOVpR00Lp0ydeQGd_B-Vaz3Wo1NAGs8O904g",
  "credential_endpoint": "https://chasseral-r.infra.swiyu.admin.ch/issuer02/oid4vci/api/credential",
  "nonce_endpoint": "https://chasseral-r.infra.swiyu.admin.ch/issuer02/oid4vci/api/nonce",
  "credential_configurations_supported": {
    "chasseral-vc": {
      "format": "vc+sd-jwt",
      "vct": "chasseral-vc",
      "protected_issuance_authorization_trust_statement": "eyJ0eXAiOiJzd2l5dS1pc3N1YW5jZS10cnVzdC1zdGF0ZW1lbnQrand0IiwiYWxnIjoiRVMyNTYiLCJraWQiOiJkaWQ6ZXhhbXBsZTp0cnVzdC1pc3N1ZXIja2V5LTEiLCJwcm9maWxlX3ZlcnNpb24iOiJzd2lzcy1wcm9maWxlLXRydXN0OjEuMC4wIn0.eyJpc3MiOiJkaWQ6ZXhhbXBsZTppc3N1ZXIiLCJzdWIiOiJkaWQ6ZXhhbXBsZTpzdWJqZWN0IiwiaWF0IjoxNjkwMzYwOTY4LCJuYmYiOjE3MjE4OTY5NjgsImV4cCI6MTc1MzQzMjk2OCwic3RhdHVzIjp7InN0YXR1c19saXN0Ijp7ImlkeCI6MCwidXJpIjoiaHR0cHM6Ly9leGFtcGxlLmNvbS9zdGF0dXNsaXN0cy8xIn19LCJwZXJtaXNzaW9ucyI6W3sidmN0IjoidXJuOmNoLmFkbWluLmZlZHBvbC5laWQifV19.PXOWjGHy6jlH-bToW0J3SvIeR2twv7914E21obwAE_zLIP-0TwyukzJ1kce3IXAOasSD6UwF6TqRCkuKFam8yA"
      ...
    }
  }
  ...
}
.
<signature>
```

## JWT-Secured Authorization Request 
```
 {
  "response_uri": "https://bcs.admin.ch/bcs-web/verifier-agent/oid4vp/api/request-object/af86e2ae-74f0-4dd2-86f3-91dc4cfbe028/response-data",
  "client_id_scheme": "did",
  "response_type": "vp_token",
  "scope": "BetaID_Credential",
  "nonce": "0zC0cR7XjqX8aUMhy/rRSC/FrojAeW0b",
  "client_id": "did:tdw:QmPEZPhDFR4nEYSFK5bMnvECqdpf1tPTPJuWs9QrMjCumw:identifier-reg.trust-infra.swiyu-int.admin.ch:api:v1:did:9a5559f0-b81c-4368-a170-e7b4ae424527",
  "verifier_info": [
     {
      "format": "jwt",
      "data": "ey...IQ" // idTS
    } ,
     {
      "format": "jwt",
      "data": "ey...IQ", //  vqPS
    } ,
     {
      "format": "jwt",
      "data": "ey...IQ", //  pvaTS
    }
  ],
  ...
}
```

## Trust Registry: List Response Object

The following is a non-normative example of a List Response Object.
```
{
  "content": [
    {...}
  ],
  "page": {
    "size": 5,
    "number": 1,
    "totalPages": 20,
    "totalElements": 100,
  }
}
```

## Localization

The following is a non-normative example of a localized claim "name".
```
{
  "name": "John Smith's Schmiderei",
  "name#en": "John Smith's Smithery",
  "name#de-CH": "John Smith's Schmiderei",
  "name#it-CH": "La fabbrica di John Smith",
  "name#fr-CH": "La forge de John Smith"
}
```
## Identity Trust Statement

The following is a non-normative example of a Identity Trust Statement.
```
 {
    "typ": "swiyu-identity-trust-statement+jwt",
    "alg": "ES256",
    "kid": "did:example:trust-issuer#key-1",
	"profile_version": "swiss-profile-trust:1.0.0"
}
.
{
    "sub": "did:example:actor",
    "iat": 1690360968,
    "exp": 1753432968,
    "status":  {
        "status_list": {
          "idx": 0,
          "uri": "https://example.com/statuslists/1"
        }
    },
    "entity_name": "John Smith's Smithery",
    "entity_name#de": "John Smith's Schmiderei",
    "entity_name#de-CH": "John Smith's Schmiderei",
    "is_state_actor": false,
    "registry_ids": [
      {
        "type": "UID",
        "value": "CHE-000.000.000"
      },
      {
        "type": "LEI",
        "value": "0A1B2C3D4E5F6G7H8J9I"
      }
    ]
}
.
<SIGNATURE>
```

## Verification Type: DCQL

The following is a non-normative example of a trust process compliant DCQL query.
```
{
  "credentials": [
    {
      "id": "my_credential",
      "format": "dc+sd-jwt",
      "meta": {
        "vct_values": [ "https://credentials.example.com/identity_credential" ]
      },
      "claims": [
          {"path": ["last_name"]},
          {"path": ["first_name"]},
          {"path": ["address", "street_address"]}
      ]
    }
  ]
}
```
## Verification Query Public Statement

The following is a non-normative example of a Verification Query Public Statement.
```
{
    "typ": "swiyu-verification-query-public-statement+jwt",
    "alg": "ES256",
    "kid": "did:example:verification-statment-issuer#key-1",
	"profile_version": "swiss-profile-trust:1.0.0"
}
.
{
   "jti": "07f289d5-8b1f-4604-bf72-53bdcb71ee05",
   "sub":"did:example:verifier",
   "iat":1690360968,
   "exp":1753432968,
   "purpose_name":"beispiel abfrage", 
   "purpose_name#de-ch":"beispiel abfrage",  
   "purpose_description":"frage ab zum beispiel",  
   "purpose_description#de-ch":"frage ab zum beispiel", 
   "request": {
      "type":"DCQL",
      "scope": "com.example.identityCardCredential_presentation",
      "query":{
         "credentials":[
            {
               "id":"my_credential",
               "format":"dc+sd-jwt",
               "meta":{
                  "vct_values":[
                     "https://credentials.example.com/identity_credential"
                  ]
               },
               "claims":[
                  {
                     "path":[
                        "last_name"
                     ]
                  }
               ]
            }
         ]
      }
   }
}
.
<SIGNATURE>
```

## Protected Verification Authorization Trust Statement

The following is a non-normative example of a Protected Verification Authorization Trust Statement.
```
{
    "typ": "swiyu-protected-verification-authorization-trust-statement+jwt",
    "alg": "ES256",
    "kid": "did:example:trust-issuer#key-1",
	"profile_version": "swiss-profile-trust:1.0.0"
}
.
{
  "jti": "07f289d5-8b1f-4604-bf72-53bdcb71ee05",
  "sub": "did:example:verifier",
  "iat": 1690360968,
  "exp": 1753432968,
  "status": {
    "status_list": {
      "idx": 0,
      "uri": "https://example.com/statuslists/1"
    }
  },
  "authorized_fields": [
    "personal_administrative_number"
  ]
}
.
<SIGNATURE>
```
## Protected Issuance Authorization Trust Statement

The following is a non-normative example of a Protected Issuance Authorization Trust Statement.
```
{
    "typ": "swiyu-protected-issuance-authorization-trust-statement+jwt",
    "alg": "ES256",
    "kid": "did:example:trust-issuer#key-1",
	"profile_version": "swiss-profile-trust:1.0.0"
}
.
{
  "jti": "07f289d5-8b1f-4604-bf72-53bdcb71ee05", 
  "sub": "did:example:issuer",
  "iat": 1690360968,
  "exp": 1753432968,
  "status": {
    "status_list": {
      "idx": 0,
      "uri": "https://example.com/statuslists/1"
    }
  },
  "can_issue": {
    "vct": "urn:ch.admin.fedpol.betaid",
    "vct_name": "Beta credential",
    "reason": "This issuer is eglible to issue Beta credentials due to AwG Art.6b"
  }
}
.
<SIGNATURE>
```
## Protected Issuance Trust List Statement (piTLS)
```
{
    "typ": "swiyu-protected-issuance-trust-list-statement+jwt",
    "alg": "ES256",
    "kid": "did:example:trust-issuer#key-1",
	"profile_version": "swiss-profile-trust:1.0.0"
}
.
{
  "jti": "07f289d5-8b1f-4604-bf72-53bdcb71ee05",
  "iat": 1690360968,
  "exp": 1753432968,
  "status": {
    "status_list": {
      "idx": 0,
      "uri": "https://example.com/statuslists/1"
    }
  },
  "vct_values": [
    "urn:ch.admin.fedpol.eid"
  ]
}
.
<SIGNATURE>
```
## Non-Compliance Trust List Statement
```
{
    "typ": "swiyu-non-compliance-trust-list-statement+jwt",
    "alg": "ES256",
    "kid": "did:example:trust-issuer#key-1",
	"profile_version": "swiss-profile-trust:1.0.0"
}
.
{
  "iat": 1690360968,
  "exp": 1753432968,
  "status": {
    "status_list": {
      "idx": 0,
      "uri": "https://example.com/statuslists/1"
    }
  },
  "non_compliant_actors": [
    {
      "actor": "did:example:badActor",
      "flagged_at": "2026-02-25T07:07:35Z",
      "reason": "The issuer is not who they claim to be (DE)",
      "reason#de": "The issuer is not who they claim to be (DE)",
      "reason#en": "The issuer is not who they claim to be (EN)",
      "reason#fr-CH": "The issuer is not who they claim to be (FR)",
      "reason#it-CH": "The issuer is not who they claim to be (IT)",
      "reason#rm-CH": "The issuer is not who they claim to be (RM)"
    },
    {
      "actor": "did:example:badActor2",
      "flagged_at": "2025-01-13T07:13:00Z",
      "reason": "The verifier is not who they claim to be (DE)",
      "reason#de": "The verifier is not who they claim to be (DE)",
      "reason#en": "The verifier is not who they claim to be (EN)",
      "reason#fr-CH": "The verifier is not who they claim to be (FR)",
      "reason#it-CH": "The verifier is not who they claim to be (IT)",
      "reason#rm-CH": "The verifier is not who they claim to be (RM)"
    }
  ]
}
.
<SIGNATURE>
```
