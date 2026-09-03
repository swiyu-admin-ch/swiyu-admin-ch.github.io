---
title: "New BCS Release in September"
categories:
  - PublicBeta
---


A new release of the Beta Credential Service (BCS) will be deployed on 16 September 2026. With this release, the [current components](https://swiyu-admin-ch.github.io/open-source-components/#version-overview) of the swiyu Trust Infrastructure will be integrated.

## BCS - Overview of Changes

-	DID Tooolbox 2.3.0 and DID Resolver 2.9.0 are integrated.
-	Current 4.x versions of the swiyu Generic Issuer and swiyu Generic Verifier are integrated.
- DPoP is set to "mandatory" in the swiyu-issuer configuration.
- did:webvh: is used, requiring a new DID (see below).
- The schema for the issuance URL for Beta-IDs is changed from "swiyu" to “openid-credential-offer”.
-	The schema for the verification URL for Beta-IDs is changed from "swiyu-verify" to “openid4vp”.

## Action required

We will use the following new DID on the Sandbox environment:

swiyu Sandbox BCS: did:webvh:QmdPxnNc9MzGYZ6qcHuvi8YpDVYWW7mmefnCTPcKapNEL5:identifier-reg.trust-infra.swiyu-int.admin.ch:api:v1:did:5f8a3c95-1772-4ebf-ada0-c88bafb258e1

If you have built your own Beta-ID verifier, then you will have to add the new DID to the list of accepted VCs in the verifier configuration in order to be able to verify newly issued Beta-IDs. 

You'll find more details about the different steps in our Change Dossiers:

- [Generic Issuer](https://swiyu-admin-ch.github.io/change-dossiers/CD-002-Issuer-Security-Enforcements/)
- [Generic Verifier](https://swiyu-admin-ch.github.io/change-dossiers/CD-004-Verifier-Security-Enforcements/)
- [DPoP Enforcement](https://swiyu-admin-ch.github.io/change-dossiers/CD-005-DPoP-Enforcement/)




