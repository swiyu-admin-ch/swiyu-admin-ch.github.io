---
title: "Roadmap to Swiss Profiles V1.0"
categories:
  - PublicBeta
published: false
---
The information is also available in German on [GitHub]().

We would like to give an outlook to the upcoming changes related to the migration to the new Swiss Profiles. All details are based on current plans and are subject to change.

## Swiss Profile Trust and Trust Protocol
With the [Swiss Profile Trust V1.0](https://swiyu-admin-ch.github.io/specifications/swiss-profile-trust/) we introduce [Trust Artefacts](https://swiyu-admin-ch.github.io/introduction#trust-in-the-swiyu-ecosystem) for different use cases.

- The corresponding versions of the swiyu-issuer and swiyu-verifier should be available by 26.05.2026.
- The corresponding wallet version should be available by 09.06.2026 --> was ist hier die Empfehlung?

All the relevant steps will be outlined in this [roadmap feature](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/14)

## Swiss Profile Anchor
Actors within the swiyu ecosystem will have to re-onboard with the DID method DID:webvh with JSON as described in the [Swiss Profile Anchor V1.0](https://swiyu-admin-ch.github.io/specifications/swiss-profile-anchor/).
- All newly created DID documents must contain JSON claim ["profile version"](https://github.com/swiyu-admin-ch/didtoolbox-java/issues/80).
- With the release of the new Onboarding Flow, old DIDs can no longer be created (estimated for end of June 2026)
- Old DID's can no longer be updated (estimated for October 2026)

All the relevant steps will be outlined in this [roadmap feature](https://github.com/swiyu-admin-ch/didresolver/issues/37). 


## Swiss Profile VC -> 23.6.
Intro: & VC Migration 

https://swiyu-admin-ch.github.io/specifications/swiss-profile-vc/

- Dokumentation ergänzen für VC Migration

## Swiss Profile Issuance
- The credential format will change from vc+sd-jwt to dc+sd-jwt (state?)
- Enforcement of the security requirements (Payload Encription, Signed Metadata, DPoP) wann?

All the relevant steps will be outlined in this [roadmap feature](https://github.com/swiyu-admin-ch/swiyu-admin-ch.github.io/issues/11)

## Swiss Profile Verification
- Expand/Migrate, welche der Verifier bereits drin hat:
- Enforce DCQL in iOS and Android wallet (Wegfall DIF Presentation Exchange)
  -  Für BCS: der Parameter "vct_values" muss dabei den bisherigen und den neuen Wert des vct-Claims enthalten ( "betaid-sdjwt" und "urn:vct:ch.admin.bcs.betaid")
   
- Enforce Payload Encryption in iOS and Android wallet

All the relevant steps will be outlined in this [roadmap feature](https://github.com/swiyu-admin-ch/swiyu-admin-ch.github.io/issues/10)


## Trennung Public Beta and Production

Da sich die Governance Massnahmen für Public Beta und die künftige Produktionsumgebung unterscheiden, wird voraussichtlich ab Juni 2026 eine eigene "Sandbox" Wallet für die Public Beta Umgebung zur Verfügung stehen. 
