---
title: Getting Started as Issuer in the swiyu Ecosystem
toc: true
toc_sticky: true
excerpt: Find relevant information about the VC issuance in the swiyu ecosystem
header:
  teaser: ../assets/images/cookbook_generic_issuer.jpg
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

# swiyu Generic Issuer

The swiyu Generic Issuer is a self-hosted service that enables an organisation to issue verifiable credentials over the swiyu Trust Infrastructure without implementing the underlying standards itself. It implements the technical standards defined in the [swiyu Trust Infrastructure Interoperability Profile](https://swiyu-admin-ch.github.io/specifications/) and exposes them as an API, so that each participant can concentrate on its own business process rather than on protocol conformance.

The swiyu Generic Issuer is not operated centrally. Every organisation acting as an Issuer hosts its own instance and connects it to its own Business Issuer Application. The Generic Issuer can be obtained as Open Source software through GitHub and be setup according the specific [cookbook](https://swiyu-admin-ch.github.io/cookbooks/onboarding-generic-issuer/).

## Scope

- Creation and management of credential offers, including deferred offers.
- Issuance of verifiable credentials to a wallet over OID4VCI, including batch issuance and renewal.
- Publication of issuer metadata and OpenID configuration, signed or unsigned.
- Management of credential status through status lists, including suspension, reactivation and revocation.
- Notification of the Business Issuer Application about credential state changes and issuance errors.

## Out of Scope

- The business decision to issue a credential, and the identification of the person it is issued to.
- Delivery of the credential offer or deeplink to the Holder. This is performed by the Business Issuer Application.
- User management and authentication of the Business Issuer Application's own users.
- Creation, update and deactivation of the Issuer's DID. This is performed with the DID-Toolbox.
- Registration in the Base Registry and Trust Registry, and creation of the status list resource on the Status Registry. The onboarding has to be completed before deployment.
- Multi-tenancy (one instance serves one Issuer).

# Delimitation from the Business Issuer

The swiyu Generic Issuer implements the issuance standards. The Business Issuer Application owns the business decision to issue, the identification of the person, user management, and the delivery of the credential offer to the Holder. The swiyu Generic Issuer is therefore closer to a library than to a stand-alone service and is deployed so that its management interface is reachable only from within the issuing organisation. 

# Key Features

- **Standards-based issuance:** Credentials are issued over OID4VCI in the SD-JWT VC format, following the [Swiss Profile Issuance](https://swiyu-admin-ch.github.io/specifications/swiss-profile-issuance/).
- **Two separated interfaces:** A management interface for the Business Issuer Application and a public OID4VCI interface for the wallet.
- **Credential lifecycle management:** Credential offers and issued credentials can be suspended, reactivated and revoked through status lists.
- **Deferred issuance:** Issuance can be postponed where the business process requires further processing before the credential can be released.
- **Batch issuance:** Interchangeable single-use credentials are issued in batches and renewed automatically, so that Holders cannot be correlated across verifications.
- **Key attestation:** The Issuer can require cryptographic proof that the wallet protects its keys in secure hardware at a defined security level.
- **Hardware Binding:** The Issuer can require cryptographic proof that a credential is tied to a specific device.
- **Signed metadata:** The wallet can verify that the issuer metadata it received has not been tampered with.
- **End-to-end encryption:** Credential requests and responses can be encrypted between wallet and Issuer using automatically rotated encryption keys.
- **Webhook notifications:** The Business Issuer Application is notified of credential state changes and issuance errors instead of having to poll.
- **Hardware Security Module support:** Signing keys can be held in an HSM rather than mounted into the runtime environment.

# Use Cases

The use cases are grouped by the interface plane on which they occur.

- Use cases in the Issuer Management group are performed by the Business Issuer Application over the management interface.
- Use cases in the OID4VCI group are performed by the Holder over the public interface.
- Use cases in the Outside the component boundary group are part of the issuing process but are not implemented by the Generic Issuer.

## Issuer Management

| UC | Name | Description |
|--- |--- |--- |
| UCI_S1 |	Create Status List |	Allows the Business Issuer to initialise a new status list resource, which is used to track the revocation or validity status of verifiable credentials issued by the system. Typically performed once per issuer or credential type.|
|UCI_S2 |	Retrieve Status List |	Enables the Business Issuer to fetch the current status list resource containing the up-to-date status of all verifiable credentials managed by the issuer. Essential for monitoring, auditing and verifying the validity of issued credentials. |
|UCI_C1 |	Create a generic credential offer|	Enables the Business Issuer to generate a new credential offer with custom content and properties. The offer serves as the basis for issuing a verifiable credential to a Holder and includes all information necessary for the issuance process.|
|UCI_C1a |	Create a deeplink for Credential Offer |	Generates a unique deeplink that points to the created credential offer, enabling the Holder to retrieve the offer directly. Included in UCI_C1.|
|UCI_C1b |	Store the Credential Offer in the database |	Persists the created credential offer for later retrieval and issuance. Included in UCI_C1.|
|UCI_C2|	Get the current status of an offer|	Allows the Business Issuer to retrieve the current status of a specific credential offer, such as DEFERRED, READY, ISSUED or REVOKED.|
|UCI_C3|	Update the status of an offer or VC|	Allows the Business Issuer to suspend, reactivate or revoke an existing verifiable credential. Essential for managing the credential lifecycle and supporting revocation and reinstatement.|
|UCI_P1	|Get JWT for accessing|	Obtains the token required to access the management interface where it is protected by OAuth 2.0. Optional; the management interface may also be protected at network level.|

## OID4VCI

| UC | Name | Description |
|--- |--- |--- |
|UCI_W1|	Expose OpenID .well-known endpoints|	Provides the endpoints required by the OID4VCI specification, allowing wallets to retrieve issuer configuration and credential metadata. Enables discovery of issuer capabilities, supported credential types and the endpoints needed for issuance.|
|UCI_W1a|	Expose token endpoint|	Exposes the OAuth 2.0 token endpoint used to authorise credential issuance. Included in UCI_W1.|
|UCI_M1|	Provide metadata related to VCs|	Supplies metadata about the supported verifiable credentials, such as types, schemas and overlays.|
|UCI_M1a|	Expose credential type metadata|	Exposes credential type metadata, JSON schemas and Overlays Capture Architecture (OCA) data. Included in UCI_M1.|
|UCI_I2|	Get authorization for issuing|	Allows the wallet to obtain an access token for credential issuance using the pre-authorized code contained in the credential offer.|
|UCI_I1|	Issuing Verifiable Credentials|	Handles the issuance of verifiable credentials to the Holder, including validation and packaging.|
|UCI_I1a|	Create Verifiable Credentials|	Issues a verifiable credential immediately upon request, using the provided access token and credential properties. Extends UCI_I1.|
|UCI_I1b|	Create deferred Verifiable| Credentials	Issues a verifiable credential in a deferred manner, requiring a transaction ID and access token. Extends UCI_I1.|
|UCI_I1c|	Store the Verifiable Credential|	Persists the issued verifiable credential for future reference and status tracking. Included in UCI_I1.|
|UCI_I1d|	Create Webhook - Status change|	Notifies the Business Issuer Application when the status of an offer or credential changes, or when an issuance error occurs.|
|UCI_I1e|	Renew Verifiable Credentials|	Renews a verifiable credential. A new credential offer is created but linked to the same management entity as the previous verifiable credential. Extends UCI_I1.|

## Outside the component boundary

| UC | Name | Description |
|--- |--- |--- |
|UCI_EX_1|	Display QR Code to get Credential Offer|	The Issuer displays a QR code containing the deeplink that allows the Holder to initiate the credential offer retrieval process. Performed by the Business Issuer Application.|
|UCI_EX_2|	Scan QR Code and fetch deeplink|	The Holder scans the QR code and uses the deeplink to fetch the credential offer from the issuer service. Performed by the wallet.|


# Showcases and Testing

link auf discussion

links auf testapplikationen

bei Problemen: GitHub Issues



