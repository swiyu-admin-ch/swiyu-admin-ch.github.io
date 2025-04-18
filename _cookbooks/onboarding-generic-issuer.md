---
title: Getting started with the swiyu Generic Issuer
toc: true
toc_sticky: true
excerpt: Learn how to deploy the swiyu Generic Issuer Management Service
header:
  teaser: ../assets/images/cookbook_generic_issuer.jpg
---

{% capture notice-text %}

Please be advised that the current system and its operations are provided on a best-effort basis and will continue to evolve over time. The security of the system and its overall maturity remain under development.

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Public Beta</h4>
  {{ notice-text | markdownify }}
</div>

This software is a web server implementing the technical standards as specified in the ["Swiss Profile"](https://swiyu-admin-ch.github.io/specifications/interoperability-profile/). Together with the other generic components provided, this software forms a collection of APIs allowing issuance and verification of verifiable credentials without the need of reimplementing the standards.

[![ecosystem components](../../assets/images/components.png)](../../assets/images/components.png)

The **swiyu Generic Issuer Management Service** is the interface to trigger a credential offering. It should be only accessible from the issuers internal organization.

The **swiyu Generic Issuer OID4VCI Service** interacts with the wallets directly and must be publicly available.

As with all the generic issuance & verification services it is expected that every issuer and verifier hosts their own instance of the service.

The swiyu Generic Issuer Management Service is linked to the issuer oid4vci services through a database, allowing to scale the oid4vci service independently from the management service.

[![issuer flowchart](../../assets/images/cookbook_generic_issuer_model.png)](../../assets/images/cookbook_generic_issuer_model.png)

# Deployment instructions

> Please make sure that you did the following before starting the deployment:
>
> - Registered yourself on the swiyu Trust Infrastructure portal
> - Registered yourself on the api self service portal
> - Generated the signing keys file with the didtoolbox.jar
> - Generated a DID which is registered on the identifier registry
>
> The required steps are explained in the [Base- and Trust Registry Cookbook](https://swiyu-admin-ch.github.io/cookbooks/onboarding-base-and-trust-registry/)

## Set the environment variables

A sample compose file for an entire setup of both components and a database can be found in [sample.compose.yml](https://github.com/swiyu-admin-ch/eidch-issuer-agent-management/blob/main/sample.compose.yml) file. You will need to configure a list of environment variables in the `.env` file.

### Issuer Agent Management

|---
| Name | Description | Example
| --- | --- |---
|SPRING_APPLICATION_NAME|Name of your application|
|ISSUER_ID|The DID you created in the [onboarding process](https://swiyu-admin-ch.github.io/cookbooks/onboarding-base-and-trust-registry/#create-a-did-or-create-the-did-log-you-need-to-continue)| did:tdw:QmejrSkusQgeM6FfA23L6NPoLy3N8aaiV6X5Ysvb47WSj8:identifier-reg.trust-infra.swiyu-int.admin.ch:api:v1:did:ff8eb859-6996-4e51-a976-be1ca584c124 |
| EXTERNAL_URL | URL of the issuer-agent-oid4vci service | |
|DID_STATUS_LIST_VERIFICATION_METHOD|ISSUER_ID + Verification Method, which can be taken from the [onboarding process](https://swiyu-admin-ch.github.io/cookbooks/onboarding-base-and-trust-registry/#create-a-did-or-create-the-did-log-you-need-to-continue)|did:tdw:QmejrSkusQgeM6FfA23L6NPoLy3N8aaiV6X5Ysvb47WSj8:identifier-reg.trust-infra.swiyu-int.admin.ch:api:v1:did:ff8eb859-6996-4e51-a976-be1ca584c124#assert-key-01|
|STATUS_LIST_KEY|EC Private key can be taken from [onboarding process](https://swiyu-admin-ch.github.io/cookbooks/onboarding-base-and-trust-registry/#create-a-did-or-create-the-did-log-you-need-to-continue) and must match the used DID status verification method|
|SWIYU_PARTNER_ID|[swiyu Trust Infrastructure business partner ID](https://swiyu-admin-ch.github.io/cookbooks/onboarding-base-and-trust-registry/#business-partner-registration)|d33fab52-1657-4240-9189-97c33b949739|
|SWIYU_STATUS_REGISTRY_CUSTOMER_KEY|[Status Registry API Key](https://swiyu-admin-ch.github.io/cookbooks/onboarding-base-and-trust-registry/#get-api-keys-to-access-swiyu-apis)||
|SWIYU_STATUS_REGISTRY_CUSTOMER_SECRET|[Status Registry API Secret](https://swiyu-admin-ch.github.io/cookbooks/onboarding-base-and-trust-registry/#get-api-keys-to-access-swiyu-apis)|
|SWIYU_STATUS_REGISTRY_ACCESS_TOKEN|[Status Registry API ACCESS Token](https://swiyu-admin-ch.github.io/cookbooks/onboarding-base-and-trust-registry/#get-api-keys-to-access-swiyu-apis)|
|SWIYU_STATUS_REGISTRY_BOOTSTRAP_REFRESH_TOKEN|[Status Registry API Refresh Token](https://swiyu-admin-ch.github.io/cookbooks/onboarding-base-and-trust-registry/#get-api-keys-to-access-swiyu-apis)|
|SWIYU_STATUS_REGISTRY_TOKEN_URL|[OAuth Refresh URL](https://swiyu-admin-ch.github.io/cookbooks/onboarding-base-and-trust-registry/#authenticate-with-oauth2)|https://keymanager-prd.api.admin.ch/keycloak/realms/APIGW/protocol/openid-connect/token|
|SWIYU_STATUS_REGISTRY_API_URL|[Status Registry Base URL](https://swiyu-admin-ch.github.io/cookbooks/onboarding-base-and-trust-registry/#base-urls)|https://status-reg-api.trust-infra.swiyu-int.admin.ch|

### Issuer Agent OID4VCI

| Name                          | Description                                                                          | Example                                                                                                                                                            |
| ----------------------------- | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| EXTERNAL_URL                  | URL of the issuer-agent-oid4vci service                                              |                                                                                                                                                                    |
| ISSUER_ID                     | The same ISSUER_ID you used in the issuer-agent-management                           | did:tdw:QmejrSkusQgeM6FfA23L6NPoLy3N8aaiV6X5Ysvb47WSj8:identifier-reg.trust-infra.swiyu-int.admin.ch:api:v1:did:ff8eb859-6996-4e51-a976-be1ca584c124               |
| DID_SDJWT_VERIFICATION_METHOD | The same Verification Method, you used in the issuer-agent-management                | did:tdw:QmejrSkusQgeM6FfA23L6NPoLy3N8aaiV6X5Ysvb47WSj8:identifier-reg.trust-infra.swiyu-int.admin.ch:api:v1:did:ff8eb859-6996-4e51-a976-be1ca584c124#assert-key-02 |
| SDJWT_KEY                     | EC Private key used to sign credentials must match the DID sdjwt verification method |                                                                                                                                                                    |

<div class="notice--warning">
  ⚙️ The generated pem .didtoolbox/assert-key-01 fille will be referenced as "assert-key-01"
</div>
Please be aware that the the issuer-agent-oid4vci needs to be accessible (configured in EXTERNAL_URL) so that a wallet can communicate with it.

The provided images can be used with arm based processors, but they are not optimized. For further information, please consult the [Development instructions section](#development-instructions).

The latest images are available here:

- [issuer-agent-oid4vci](https://github.com/orgs/swiyu-admin-ch/packages/container/package/eidch-issuer-agent-oid4vci)
- [issuer-agent-management](https://github.com/orgs/swiyu-admin-ch/packages/container/package/eidch-issuer-agent-management)

## Create a verifiable credential schema

In order to support your use case you need to adapt the so-called issuer_metadata (see [sample.compose.yml](https://github.com/swiyu-admin-ch/eidch-issuer-agent-management/blob/main/sample.compose.yml#L85)).
Those metadata define the appearance of the credential in the wallet and defines what kind of credential formats are supported.
For further information consult the [VC visual presentation cookbook](https://swiyu-admin-ch.github.io/cookbooks/vc-visual-presentation/).

## Initialize the status list

Once the issuer-agent-management, issuer-agent-oid4vci and postgres instance are up and running you need to initialize the status list of your issuer so that you can issue credentials.

**Request to create and initialize a status list slot**

The following request needs to be run on your issuer-agent-management instance (example for the sample environment):

<div class="notice--warning">
  The maximum file size of the status list is currently 200kB. (Subject to evaluation and might change after public beta).
</div>

```bash
curl -X POST http://localhost:8080/api/v1/status-list \
  -H "accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{
  "type": "TOKEN_STATUS_LIST",
  "maxLength": 100000,
  "config": {
    "bits": 2
  }
}'
```

This results in a response like:

<div class="notice--warning">
  ⚙️ Please store the "statusRegistryUrl" as it is required in the Issue Credential call.
</div>

```json
{
  "id": "EXAMPLE_ENTRY_UUID",
  "statusRegistryUrl": "https://status-reg.trust-infra.swiyu-int.admin.ch/api/v1/statuslist/EXAMPLE_STATUS_LIST_ID.jwt",
  "type": "TOKEN_STATUS_LIST",
  "maxListEntries": 100000,
  "remainingListEntries": 100000,
  "nextFreeIndex": 0,
  "version": "1.0",
  "config": {
    "bits": 2
  }
}
```

## Issue credential

You are now ready to issue credentials by using the issuer-agent-management API to create a credential offer for a holder. Here is an example of a request body for the offer creation (in the sample environment):

<div class="notice--warning">
  ⚙️ Please update the statusRegistryUrl with your newly created statusRegistryUrl from the response above.
</div>

```bash
curl -X POST http://localhost:8080/api/v1/credentials \
  -H "accept: */*" \
  -H "Content-Type: application/json" \
  -d '{
  "metadata_credential_supported_id": [
    "my-test-vc"
  ],
  "credential_subject_data": {
    "firstName": "Test FirstName",
    "lastName": "Test LastName",
    "birthDate": "01.01.2025"
  },
  "offer_validity_seconds": 86400,
  "credential_valid_until": "2030-01-01T19:23:24Z",
  "credential_valid_from": "2025-01-01T18:23:24Z",
  "status_lists": [
    "statusRegistryUrl"
  ]
}'
```

<div class="notice--warning">
  ⚙️ Please store the id of the response as the value is required in the "Update Status" call referenced as "$CREDENTIAL_ID".
</div>

To check the result, create a qr code from the resulting offer_deeplink, which then can be scanned with the swiyu wallet.

## Update status

A credential can have one of the following status: `OFFERED`, `CANCELLED`, `IN_PROGRESS`, `ISSUED`, `SUSPENDED`, `REVOKED`, `EXPIRED`.
Using the Issuer Management service the status can be updated

<div class="notice--warning">
  ⚙️ Please update the credentialID below with the correct id received from the issue credential call.
</div>

```bash
curl -X PATCH http://localhost:8080/api/v1/credentials/{credentialID}/status?credentialStatus=ISSUED
```

# Development instructions

Instructions for the development of the swiyu Generic Issuer can be found in the [GitHub repository](https://github.com/swiyu-admin-ch/eidch-issuer-agent-management?tab=readme-ov-file#development).

## Create Images for ARM based processors

In order to optimize the image for arm based systems, you first have to check out the [issuer-agent-management](https://github.com/swiyu-admin-ch/eidch-issuer-agent-management) and [issuer-agent-oid4vci](https://github.com/swiyu-admin-ch/eidch-issuer-agent-oid4vci) repositories.

To create an image you to run the following command in both repositories to create local images of the services:

```bash
./mvnw install:install-file -Dfile=lib/primusX-java11-2.4.4.jar -DgroupId=com.securosys.primus -DartifactId=jce -Dversion=2.4.4 -Dpackaging=jar spring-boot:build-image
```

# Your Feedback?

We would be pleased if you spend about 3 additional minutes and give us feedback on the swiyu Public Beta Trust Infrastructure and your onboarding process! With Public Beta, we want to give ecosystem stakeholders the opportunity to gain initial experience and build their own use cases on the trust infrastructure of the future e-ID. Your [feedback](https://findmind.ch/c/feedback_publicbeta_infr_en) will help us to further develop and improve the touchpoints, and we greatly appreciate your support.

