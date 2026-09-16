---
title: Getting Started as an Issuer in the swiyu Ecosystem
toc: true
toc_sticky: true
excerpt: Find relevant information for Issuers who want to use the generic components
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

## Delimitation from the Business Issuer

The swiyu Generic Issuer implements the issuance standards. The Business Issuer Application owns the business decision to issue, the identification of the person, user management, and the delivery of the credential offer to the Holder. The swiyu Generic Issuer is therefore closer to a library than to a stand-alone service and is deployed so that its management interface is reachable only from within the issuing organisation. 

# Key Features

The features are set mostly by the [Swiss Profile Issuance](https://swiyu-admin-ch.github.io/specifications/swiss-profile-issuance/) and the [Swiss Profile VC](https://swiyu-admin-ch.github.io/specifications/swiss-profile-vc/)

- **Standards-based issuance:** Credentials are issued over OID4VCI in the SD-JWT VC format.
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
| UCI_S1 |	Create Status List |	Allows the Business Issuer to initialize a new status list resource, which is used to track the revocation or validity status of verifiable credentials issued by the system. Typically performed once per issuer or credential type.|
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

# Business Rules
## Protocol and Format

| Name | Rule |
|--- |--- |
|Mandated issuance flow	|Credentials are issued using the Pre-Authorized Code Flow. The Swiss Profile requires implementers to support this flow, and the Authorization Code Flow is not implemented by swiyu components.|
|Mandated credential format|	Credentials are issued in the SD-JWT VC format. The current format identifier is `dc+sd-jwt`. `vc+sd-jwt` is deprecated and supported temporarily for compatibility with earlier drafts.|
|Issuer identification by DID|	The Issuer identifies itself by a Decentralized Identifier. The public keys used to verify issued credentials and signed metadata are published in the corresponding DID document on the Base Registry.|
|Signing algorithm	|Issuers, wallets and verifiers must support the key type P-256 with the ES256 algorithm for signing and signature validation. The configured signing algorithm must match the configured signing key.|

## Credential Offer and Issuance

| Name | Rule |
|--- |--- |
|Offer must reference a supported configuration	|A credential offer must reference a credential configuration that exists in the published issuer metadata. If it does not, the credential request will fail later in the process.|
|Cancellation window|	A credential offer can be cancelled at any time as long as the credential has not been issued.|
|	Offer expiry|	A credential offer expires if it is not collected within its validity period. Validity is controlled per offer.|
|	Release of deferred offers|	In the deferred flow, the credential is only released once the Business Issuer Application has set the offer to READY. A deferred offer expires if it is not released within the deferred offer validity period.|
|	Validity rounding for unlinkability|	The validity dates of a credential are rounded — the start date down and the end date up to the day — so that the exact issuance time cannot be used to distinguish Holders.|
|	Renewal keeps the management entity|	Renewing a credential creates a new credential offer that remains linked to the management entity of the previous credential.|

## Status and Revocation

| Name | Rule |
|--- |--- |
|Status list precedes issuance|	The status list resource must exist on the Status Registry before it is registered on the Generic Issuer, and it must be registered before credentials with a status can be issued.|
|	Credentials without status cannot be revoked|	It is possible to issue credentials without a status. Such credentials can never be revoked or suspended.|
|Status transitions	|An issued credential can be suspended and reactivated any number of times. Revocation is permanent and terminal.|
|	Whole-batch revocation|	Where a credential was issued as part of a batch, revoking any one credential of that batch revokes the entire batch.|
|	No partial batches|	If the status list no longer has the number of free slots required for a full batch, an error is returned and no partial batch is created.|

## Credential Type

| Name | Rule |
|--- |--- |
|Stability of the credential type	|The `vct` identifies the credential type from a business point of view and remains stable. Adding or removing an attribute, or changing metadata or styling, does not lead to a new `vct`. Only a complete business change does.|
|Trust is bound to the credential type only|	Only the `vct` carries trust in the ecosystem. The values of `vct_version`, `vct_subtype` and `vct_subtype_version` are set at the discretion of the Issuer, and no component may base a trust decision on them.|
|Disclosure of type claims	|The `vct` claim must not be selectively disclosable. The `vct_version`, `vct_subtype` and `vct_subtype_version` claims must be selective disclosures, so that the Holder decides whether to share them.|
|	Freedom of the Issuer	|Every Issuer is free to choose the value it places in the `vct`, whether or not it matches a published schema. Verifiers must therefore know which credential type they require, which claims to request, and which Issuers they trust.|

## Security and Trust

| Name | Rule |
|--- |--- |
|Management interface is internal	|The management interface is intended exclusively for the Business Issuer Application and must be deployed so that it is not reachable from outside the issuing organisation.|
|Key attestation is optional but always validated	|The Issuer may require the wallet to prove that its keys are held in secure hardware at a given security level. Where a list of trusted attestation providers is configured, only those providers are accepted; where no list is configured, attestations are accepted from any provider. The integrity and signature of an attestation are validated in every case.|
|Consequence of the highest key storage level|	Credentials issued with a key storage requirement of `iso_18045_high` are bound to the device's secure element and cannot be restored from a backup.|
|	One instance, one Issuer|	Multi-tenancy is not supported. Each Issuer operates its own instance of the Generic Issuer.|

## Notification and Data

| Name | Rule |
|--- |--- |
|At-least-once delivery of notifications	|Delivery of webhook events is retried until successful, guaranteeing at-least-once delivery. Failed deliveries create error logs and are retried in the next interval.|
|	Handling of undeliverable notifications	|Handling of events that cannot ultimately be delivered is the responsibility of the Business Issuer Application.|
|	Offer data is retained only for the duration of the process	|Offer data is kept only while the issuance process is in progress. It is removed once the result has been fetched by the Business Issuer Application, or once the offer expiration timestamp has been reached.|

# Setup your instance

We provide a [cookbook](https://swiyu-admin-ch.github.io/cookbooks/onboarding-generic-issuer/) with step-by-step instructions for the deployment of the swiyu Generic Issuer. The complete architecture documentation and detailed issuance flows can be found on [GitHub](https://github.com/swiyu-admin-ch/swiyu-issuer/tree/main/docs).

# Showcases, Testing and Technical Issues

You'll find existing showcases in our [GitHub discussion forum](https://github.com/orgs/swiyu-admin-ch/discussions/categories/show-and-tell). You are also welcome to present your use case there.

We provide two test applications to validate the behaviour of your instances during development and integration phases:
- [A very simplistic wallet implementation, usable in end 2 end tests or testing of deployments](https://github.com/swiyu-admin-ch/swiyu-generic-application-test)
- [A wallet simulation to test credential issuance and verification](https://github.com/swiyu-admin-ch/swiyu-generic-test-wallet)

Should any problems arise whilst integrating the generic components, you can report them as a [GitHub issue](https://github.com/swiyu-admin-ch/swiyu-issuer/issues).



