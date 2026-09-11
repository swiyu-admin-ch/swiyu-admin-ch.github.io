---
title: Getting Started as Verifier in the swiyu Ecosystem
toc: true
toc_sticky: true
excerpt: Find relevant information about the VC verification in the swiyu ecosystem
header:
  teaser: ../assets/images/cookbook_generic_verifier.jpg
---

{% capture notice-text %}

Please be advised that the swiyu Sandbox and its operations are provided on a best-effort basis and will continue to evolve over time. The security of the system and its overall maturity remain under development.

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Sandbox</h4>
  {{ notice-text | markdownify }}
</div>

#	Onboarding

Before you can issue a credential into the swiyu (Sandbox) Wallet, you need to [onboard](https://swiyu-admin-ch.github.io/cookbooks/onboarding-base-and-trust-registry/) to the swiyu registry. It is recommended to first read the [introduction to the swiyu Trust Infrastructure](https://swiyu-admin-ch.github.io/introduction/) to get an overview of the different roles, components and trust artefacts.

# swiyu Generic Verifier

The swiyu Generic Verifier is a self-hosted service that enables an organisation to verify verifiable credentials over the swiyu Trust Infrastructure without implementing the underlying standards itself. It implements the technical standards defined in the [swiyu Trust Infrastructure Interoperability Profile](https://swiyu-admin-ch.github.io/specifications/) and exposes them as an API, so that each participant can concentrate on its own business process rather than on protocol conformance.

The Generic Verifier is not operated centrally. Every organisation acting as a Verifier hosts its own instance and connects it to its own Business Verifier Application. The Generic Verifier can be obtained through GitHub and be setup according the specific [cookbook](https://swiyu-admin-ch.github.io/cookbooks/onboarding-generic-verifier/).

## Scope

- Creation and lifecycle of a verification request on behalf of a Business Verifier Application, including the deeplink used to reach the wallet.
- Execution of the OID4VP exchange with the wallet, including the request object and the receipt of the Verifiable Presentation.
- Verification of the presentation: integrity and authenticity, cryptographic device binding, conformance of the presented claims with the query, and the credential format.
- Check of the credential status against the Status Registry.
- Validation of the Issuer through the Base Registry and the Trust Registry, and evaluation of the trust markers.
- Registration of the verification query as a public statement and its embedding in the request, so that the declared purpose is provable to the Holder.
- Provision of the verification result to the Business Verifier Application, by retrieval or by webhook notification.
- Retention and deletion of verification data for the duration of the verification process.

## Out of Scope

- The Business Verifier Application – the business decision to verify, the definition of the required attributes and the declared purpose, user and session management, the display of the QR code or link, and the use made of the result.
- The wallet – credential storage, credential selection, and the consent given by the Holder.
- The Trust Infrastructure registries – Base Registry, Status Registry, Trust Registry and the vqPS Signing Service are consumed by the Generic Verifier, not provided by it.
- Issuance – covered by the Generic Issuer and its own business documentation.
- Management of the Verifier’s own decentralised identifier – creation, update and deactivation of DIDs are performed with the DID-Toolbox, and the DID log is published to the swiyu Identifier Registry by the organisation itself.
- The federal verification application under Art. 9 BGEID – the swiyu Check App is a separate product.
- Operation of the component – each organisation hosts, configures and operates its own instance.

# Kex Features

- **Standards-based verification:** Presentations are verified over OID4VP in the SD-JWT VC format, following the [Swiss Profile Verification](https://swiyu-admin-ch.github.io/specifications/swiss-profile-verification/).
- **Two separated interfaces:**A management interface for the Business Verifier Application and a public OID4VP interface for the wallet; the two services exchange no data directly.
- **Selective disclosure by query:** The verification query names only the claims actually required, so the Holder discloses nothing beyond them.
- **Flexible presentation queries:** Queries can be expressed as a Presentation Definition or as a DCQL query, the latter allowing alternative claim sets and credential type versions to be offered within a single request.
- **Credential type tolerance:** A verification configuration remains valid when an Issuer adds or removes attributes of a credential type; only a genuine business change to the type requires the Verifier to reconfigure.
- **Credential status check:** Validity and revocation of the presented credential are checked against the Status Registry of the Trust Infrastructure.
- **Issuer validation through the Trust Registry:** The identity and the authorisation of the Issuer are established from trust statements and evaluated as trust markers before the presented data is accepted.
- **Declared verification purpose:** The verification query is registered with the Trust Management System and its signed public statement is embedded in the request, so that the Holder receives cryptographic proof of the declared purpose before any data is shared.
- **Webhook notifications:** The Business Verifier Application is notified as soon as a verification result is available instead of having to poll.
- **End-to-end encryption:** Encryption keys are bound to an individual verification request, so that each verification is protected by its own ephemeral key.
- **Minimal data retention:** Verification data is deleted as soon as the Business Verifier has retrieved the result, and at the latest 15 minutes after an unfinished process.
- **Extended non-repudiation:** The complete Verifiable Presentation can be retrieved on demand where later audits require more than the extracted attributes.
- **Hardware Security Module support:** Signing keys can be held in an HSM rather than mounted into the runtime environment.

# Use Cases

The use cases of the Generic Verifier fall into three groups, which follow the segregation of the component into two interface planes:

- Entry use cases (UCV_E) – how a verification reaches the Holder in the first place.
- Management use cases (UCV_M) – triggered by the Business Verifier Application through the management interface.
- Verification use cases (UCV_O) – triggered by the wallet over the OID4VP interface, and the checks the Generic Verifier performs in response.

A single verification runs through all three groups: the Business Verifier Application initiates the process and receives a deeplink, the Holder enters the process through a QR code or link, and the OID4VP exchange then takes place directly between the wallet and the Generic Verifier.

## Entry Use Cases

| UC | Name | Description |
|--- |--- |--- |
|UCV_E1|	Display QR Code for Verification|	The Verifier displays a QR code containing a request URI. The QR code acts as a deeplink to the verification request and allows the Holder to start the verification by scanning it.|
UCV_E2|	Scan QR Code and Fetch Deeplink|	The Holder scans the QR code presented by the Verifier. The wallet retrieves the deeplink, which contains the information needed to continue with the verification.|

How the QR code or link reaches the Holder – on a website, at a counter, in an application form – is the responsibility of the Business Verifier Application and is not part of the Generic Verifier.

## Management Use Cases

 UC | Name | Description |
|--- |--- |--- |
|UCV_M1|	Initiate Verification Process|	The Business Verifier initiates a new verification process, defining the data it wishes to obtain from the Holder.|
|UCV_M1a|	Create Verification Management Entry|	An entry is created in the verification management to track the verification process and its state.|
|UCV_M1b|	Provide Deeplink for QR Code|	The verification management returns a deeplink that can be embedded in a QR code and that links to the verification request.|
|UCV_M1c|	Register vqPS on-the-fly|	An unknown or expiring verification query is registered automatically with the Trust Management System while the verification request is being created. The resulting signed Verification Query Public Statement (vqPS) and its scope are persisted, so that the declared purpose of the verification is publicly transparent.|
|UCV_M3|	Retrieve Verification Result|	The Business Verifier retrieves the result of the verification process, in particular where no webhook callback is used.|
|UCV_M4	|Retrieve Full Verifiable Presentation|	The Business Verifier retrieves the entire Verifiable Presentation on demand instead of only the extracted attributes. This serves use cases that require extended, cryptographically provable non-repudiation for later audits.|

## Verification Use Cases

 UC | Name | Description |
|--- |--- |--- |
|UCV_O1|	Request Verification Object|	The wallet fetches the request object from the Generic Verifier in order to obtain the Business Verifier's query and the information on how the response is to be transmitted.|
|UCV_O1a|	Create Signed Request Object|	The Generic Verifier creates a signed request object, ensuring the integrity and authenticity of the verification request data.|
|UCV_O1b|	Create Unsigned Request Object|	The Generic Verifier creates an unsigned request object, for scenarios in which signing is not required or for testing purposes.|
|UCV_O1c|	Embed Trust Statements in verifier_info|	The active Verification Query Public Statement is embedded as a JWT into the verifier_info claim of the authorization request. The wallet thereby receives cryptographic proof of the declared purpose of the verification before any data is shared.|
|UCV_O2|	Submit Verification Presentation|	The wallet submits the verification presentation, containing the credentials and proofs required for the verification, or rejects the verification.|
|UCV_O2a|	Verify Presentation Submission and SD-JWT Credential|	The Generic Verifier checks the submitted presentation and validates the SD-JWT credential against the requirements of the verification request.|
|UCV_O2b|	Validate Issuer via Trust Registry (TP2 Verifier-View)|	As part of the token verification, the Generic Verifier contacts the Trust Registry to validate the identity and the authorisation of the Issuer of the credential. The trust statements are retrieved and the trust markers are evaluated.|
|UCV_O2c|	Check VC Status in Registry|	The Generic Verifier checks the status of the presented credential in the Status Registry to confirm its validity and revocation status.|
|UCV_O2d|	Store Verification Result|	The Generic Verifier stores the result of the verification process, so that it can be retrieved by the Business Verifier.|
|UCV_O2e|	Trigger Webhook Callback|	After the verification, the Generic Verifier notifies the Business Verifier Application that a result is available.|

# Business Rules

# Setup your instance

# Showcases and Testing

link auf discussion https://github.com/orgs/swiyu-admin-ch/discussions/categories/show-and-tell

links auf testapplikationen

https://github.com/swiyu-admin-ch/swiyu-generic-application-test
https://github.com/swiyu-admin-ch/swiyu-generic-test-wallet

bei Problemen: GitHub Issues https://github.com/swiyu-admin-ch/swiyu-verifier
