---
title: "Roadmap for the swiyu Public Beta Trust Infrastructure"
permalink: /roadmap/
toc: true
toc_sticky: true
---

## Current stage and Gaps of Public Beta

The Public Beta environment aims to function as a basis for experimentation and integration efforts conducted by the ecosystem participants from both the public and the private sector. It provides the same technology that will be used by the productive environment in 2026, but with, as of now, reduced maturity and scope. At the moment operation and support of the Public Beta Trust Infrastructure are run on a best effort basis. It is planned to gruadually develop Public Beta into an integration environment that is run in parallel and equivalent to the productive infrastructure from Go-live in 2026 onwards.  

As regards the e-ID, the Public Beta Trust Infrastructure will mimic this credential type through a Beta-ID. Beta-IDs contain the same set of attributes as the e-ID defined in Art. 15 of the BGEID (Bundesgesetz über den elektronischen Identitätsnachweis und andere elektronische Nachweise). However, Beta-ID's technical features are restricted and the legal requirements defined in Section 3 of the BGEID do not apply. 

## Roadmap with general overview on GitHub

Our [Roadmap on GitHub](https://github.com/orgs/swiyu-admin-ch/projects/1/views/7) gives a general overview of the development of the swiyu Public Beta Trust Infrastructure. It includes the closure of existing gaps, new features and the updating of the standards applied.
We invite interested parties to subscribe via [GitHub discussions](https://github.com/orgs/swiyu-admin-ch/discussions/11) or [RSS feed](https://swiyu-admin-ch.github.io/release-announcements/) to our release announcements to be informed about upcoming changes.

## Initial Supported Technical Standards

The following table provides a reference that indicates which standards are currently employed within the swiyu Public Beta Trust Infrastructure. While the Confederation aims to provide a degree of assurance and stability for integrators even at this early stage, evolution seems inevitable. Consequently, set of selected standards will be updated or extended if perspectives within the implementing organizations change. Changes will be considered, especially if they benefit privacy-protection for users, increase the security and stability of the overall system, or if standards converge to serve the purpose of fostering interoperability. We currently differentiate between support for [Public Beta](https://www.eid.admin.ch/en/public-beta-e) and the initial Go-live support.


| Aspect      | Current Hypothesis   | Public Beta Support   | Initial Go-live Support |  
| ----------- | ----------- |----------- |----------- |
| **Identifiers**       | Decentralized Identifiers (**DIDs**) v1.0 according to [W3C](https://www.w3.org/TR/did-core/) <br> DID Method: **[did:tdw/did:webvh](https://identity.foundation/trustdidweb/)**     | **SELECTED** <br> Hosted on central base registry provided by Confederation | **SELECTED** |
| **Status Mechanisms**       | [Statuslist](https://datatracker.ietf.org/doc/draft-ietf-oauth-status-list/) | **SELECTED** | **SELECTED** |
| **Trust Protocol**       | [Trust protocol based on VCs](https://swiyu-admin-ch.github.io/specifications/swiss-profile-trust/)  | **SELECTED** <br> Initial support of the "identity" trust statement by Confederation | **HIGH** <br> Additional support of issuer & verifier legitimacy (per VC schema) |
| **Communication Protocol (Issuance/Verification)**       | OID4VC/OID4VP <br> [Issuance](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0-ID1.html) <br> [Verification](https://openid.net/specs/openid-4-verifiable-presentations-1_0-ID2.html)  | **SELECTED** <br> In accordance with [Swiss Profiles](https://swiyu-admin-ch.github.io/specifications/inttroduction-profile/) | **SELECTED** |
| **Payload Encryption**       | [JWE](https://www.rfc-editor.org/rfc/rfc7516.html) as proposed by the communication protocol  | **SELECTED** | **SELECTED** |
| **VC-Format/Signature-Scheme Combination**       | [SD-JWT VC](https://datatracker.ietf.org/doc/draft-ietf-oauth-sd-jwt-vc/) & ECDSA   | **SELECTED** <br> In accordance with [Swiss profile](https://swiyu-admin-ch.github.io/specifications/introduction) | **SELECTED** |
| **Device Binding Scheme**       | **Hardware** based device binding depending on capabilities provided by [Apple](https://developer.apple.com/documentation/cryptokit/secureenclave) or [Android](https://source.android.com/docs/security/features/keystore) mobile devices <br> **Software** based device binding implemented by wallets  |  Hardware  **SELECTED** <br> Software **UNSUPPORTED**  | Hardware **SELECTED** <br> Software **SELECTED** |
| **VC appearance**       | Visualization of Verifiable Credential with [OCA](https://swiyu-admin-ch.github.io/specifications/oca-v1-0/) | **SELECTED** | **SELECTED**|

**Probability interpretation:** <br>
- **UNSUPPORTED** = No Solution provided, <br>
- **OPEN** = Options are being assessed, <br>
- **CANDIDATE** = Standard/Specification is in selection, <br>
- **HIGH** = Current hypothesis for implementation, <br>
- **SELECTED** = Chosen for system

The versions of the referenced specifications may change. In particular, the e-ID program is planning to upgrade most of the implemented specifications to newer and more mature versions until the Go-live.


