---
title: "Roadmap to Swiss Profiles V1.0"
categories:
  - PublicBeta
---

We would like to give an outlook to the upcoming changes related to the migration to the new Swiss Profiles. All details are based on current plans and are subject to change. Updates with more precise release dates will be announced on this channel as far in advance as possible.

## Swiss Profile Trust and Trust Protocol

With the [Swiss Profile Trust V1.0](https://swiyu-admin-ch.github.io/specifications/swiss-profile-trust/) we introduce [Trust Artefacts](https://swiyu-admin-ch.github.io/introduction#trust-in-the-swiyu-ecosystem) for different use cases.

- The corresponding versions of the swiyu-issuer and swiyu-verifier should be available by end of May 2026
- The corresponding "Sandbox" wallet version (see below) should be available by beginning of June 2026 

All related relevant issues are referenced in this [roadmap feature](https://github.com/swiyu-admin-ch/eidch-ios-wallet/issues/14).

## Swiss Profile Anchor

Actors within the swiyu ecosystem will have to re-onboard with the DID method DID:webvh with JSON as described in the [Swiss Profile Anchor V1.0](https://swiyu-admin-ch.github.io/specifications/swiss-profile-anchor/).
- All newly created DID documents must contain JSON claim ["profile version"](https://github.com/swiyu-admin-ch/didtoolbox-java/issues/80).
- With the release of the new Onboarding Flow, old DIDs can no longer be created (estimated for end of June 2026).
- Old DID's can no longer be updated (estimated for end of October 2026)

All the relevant steps for the migration are referenced in this [roadmap feature](https://github.com/swiyu-admin-ch/didresolver/issues/37). 

## Swiss Profile Issuance

The [Swiss Profile Issuance V1.0](https://swiyu-admin-ch.github.io/specifications/swiss-profile-issuance/) defines the capabilities required to issue Verifiable Credentials to a holder's wallet supporting the OID4VCI V1.0 standard. Relevant changes include: 
- The credential changes from vc+sd-jwt to dc+sd-jwt
- The enforcement of the security requirements (Payload Encription, Signed Metadata, DPoP)

All the relevant steps for the migration are referenced in this [roadmap feature](https://github.com/swiyu-admin-ch/swiyu-admin-ch.github.io/issues/11).

## Swiss Profile Verification

The [Swiss Profile Verification V1.0](https://swiyu-admin-ch.github.io/specifications/swiss-profile-verification/) concerns itself with how a wallet is presenting VCs to a verifier. Upcoming "contract"-steps are:
- Support Client ID Prefixes & Remove 'client_id_scheme'
- Enforce DCQL in iOS and Android wallet (DIF Presentation Exchange is no longer supported)
  -  For interactions with the BCS: the parameter "vct_values" must contain the old and new values of the vct-claims ("betaid-sdjwt" und "urn:vct:ch.admin.bcs.betaid")
- Enforce Payload Encryption and Signed Metadata in iOS and Android wallet

All the relevant steps for the migration are referenced in this [roadmap feature](https://github.com/swiyu-admin-ch/swiyu-admin-ch.github.io/issues/10).

## Wallets: Separation of Public Beta/Sandbox and Production

As the governance measures for the Public Beta differ from those for the future production environment, a dedicated ‘sandbox’ wallet for the Public Beta environment is expected to be available from the beginning of June 2026.

## Swiss Profile VC

The new generic issuer and generic verifier for the [Swiss Profile VC 1.0](https://swiyu-admin-ch.github.io/specifications/swiss-profile-vc/) should be available by the end of June 2026. The respective wallet version should be released by September 2026. Together with the new components we will adjust our documentation and provide guidance for the VC migration.

# Roadmap, Status Board and Release Notes

Our [roadmap](https://github.com/orgs/swiyu-admin-ch/projects/1) shows a high-level overview of the upcoming features. The [status board](https://github.com/orgs/swiyu-admin-ch/projects/2) provides a more detailed overview of which tasks are still in the backlog, which are currently being worked on, and which are ready for rollout. In the release notes (in this channel) you'll find the concrete [EMC-steps](https://github.com/swiyu-admin-ch/community/blob/main/tech-concepts/expand-migrate-contract-pattern.md) and links to migration guides.

We will provide a component-related view for the migration for issuers and verifiers in the next [participation meeting](https://www.eid.admin.ch/en/partizipation-e) on 4 June 2026.

