---
title: "Roadmap to Swiss Profiles V1.0"
categories:
  - PublicBeta
published: false
---
The information is also available in German on [GitHub]().

We would like to give an outlook to the upcoming changes related to the migration to the new Swiss Profiles. All details are based on current plans and are subject to change. Updates will be announced on this channel as far in advance as possible.

## Swiss Profile Trust and Trust Protocol
With the [Swiss Profile Trust V1.0](https://swiyu-admin-ch.github.io/specifications/swiss-profile-trust/) we introduce [Trust Artefacts](https://swiyu-admin-ch.github.io/introduction#trust-in-the-swiyu-ecosystem) for different use cases.

- The corresponding versions of the swiyu-issuer and swiyu-verifier should be available by 26.05.2026.
- The corresponding wallet version should be available by 09.06.2026 --> was ist hier die Empfehlung?

All related relevant issues are referenced in this [roadmap feature](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/14).

## Swiss Profile Anchor
Actors within the swiyu ecosystem will have to re-onboard with the DID method DID:webvh with JSON as described in the [Swiss Profile Anchor V1.0](https://swiyu-admin-ch.github.io/specifications/swiss-profile-anchor/).
- All newly created DID documents must contain JSON claim ["profile version"](https://github.com/swiyu-admin-ch/didtoolbox-java/issues/80).
- With the release of the new Onboarding Flow, old DIDs can no longer be created (estimated for end of June 2026).
- Old DID's can no longer be updated (estimated for October 2026)

All the relevant steps for the migration are referenced in this [roadmap feature](https://github.com/swiyu-admin-ch/didresolver/issues/37). 

## Swiss Profile Issuance
The [Swiss Profile Issuance V1.0](https://swiyu-admin-ch.github.io/specifications/swiss-profile-issuance/) defines the capabilities required to issue Verifiable Credentials to a holder's wallet supporting the OID4VCI V1.0 standard. Relevant changes include: 
- The credential changes from vc+sd-jwt to dc+sd-jwt
- The enforcement of the security requirements (Payload Encription, Signed Metadata, DPoP)

All the relevant steps for the migration are referenced in this [roadmap feature](https://github.com/swiyu-admin-ch/swiyu-admin-ch.github.io/issues/11)

## Swiss Profile Verification
The [Swiss Profile Verification V1.0](https://swiyu-admin-ch.github.io/specifications/swiss-profile-verification/) concerns itself with how a wallet is presenting VCs to a verifier.
- Expand/Migrate, welche der Verifier bereits drin hat:
- Enforce DCQL in iOS and Android wallet (Wegfall DIF Presentation Exchange)
  -  Für BCS: der Parameter "vct_values" muss dabei den bisherigen und den neuen Wert des vct-Claims enthalten ( "betaid-sdjwt" und "urn:vct:ch.admin.bcs.betaid")
   
- Enforce Payload Encryption in iOS and Android wallet

All the relevant steps for the migration are referenced in this [roadmap feature](https://github.com/swiyu-admin-ch/swiyu-admin-ch.github.io/issues/10)

## Swiss Profile VC -> 23.6.
Intro: & VC Migration 

https://swiyu-admin-ch.github.io/specifications/swiss-profile-vc/

- Dokumentation ergänzen für VC Migration

## Trennung Public Beta and Production

As the governance measures for the Public Beta differ from those for the future production environment, a dedicated ‘sandbox’ wallet for the Public Beta environment is expected to be available from June 2026.
