---
title: Onboarding the swiyu Base & Trust Registry
permalink: /onboarding/
toc: true
toc_sticky: true
excerpt: Detailed steps for the onboarding to the swiyu Trust Infrastructure
header:
  teaser: ../../assets/images/cookbook_base_trust_registry.jpg
---

{% capture notice-text %}

Please be advised that the current system and its operations are provided on a best-effort basis and will continue to evolve over time. The security of the system and its overall maturity remain under development.

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Public Beta</h4>
  {{ notice-text | markdownify }}
</div>

# 1. Business Partner creation

## 1.1. Title

# 2. Subscribe to Swiyu Trust Infrastructure APIs

Go to the API [self-service portal](https://selfservice.api.admin.ch/api-selfservice/apis) to subscribe to the swiyu Trust Infrastructure APIs.

## 2.1. Select your Business Partner

If you are registered with multiple business partners, click the business partner ID in the top-right corner of the portal to select the one you want to subscribe with.

[![API self-service list of APIs](../../assets/images/api_selfservice.png)](../../assets/images/api_selfservice.png)

## 2.2. Subscribe to the APIs

The swiyu Trust Infrastructure consists of three APIs. Subscribe your business partner to each of them:

**swiyucorebusiness_identifier:** Use this API to manage your public key material on the Base Registry.

**swiyucorebusiness_status:** Use this API to manage your [credential status lists](https://swiyu-admin-ch.github.io/specifications/interoperability-profile/#credential-status).

**swiyucorebusiness_trust:** Use this API to manage your organisation's trust verification submissions.

For each API, select it and press **Subscribe**. You will be prompted to create a new application or select an existing one.

[![create or select an application](../../assets/images/create_select_application.png)](../../assets/images/create_select_application.png)

[![create application](../../assets/images/create_application.png)](../../assets/images/create_application.png)

{% capture subscription-hint %}

<p> ⚙️ One application and its token set grants access to all APIs it is subscribed to. However, the application must be individually subscribed to each API.</p>
<p> ⚙️ We suggest creating separate applications for each service you are running — e.g. one for your issuer service and one for your verifier service.</p>
<p> ⚙️ When subscribing an existing application to an additional API, you will need to refresh its tokens so they include the new subscription scope.</p>

{% endcapture %}

<div class="notice--warning">
  <h4 class="no_toc">Note:</h4>
  {{ subscription-hint | markdownify }}
</div>

## 2.3. Save Your Tokens

After subscribing, copy and securely store the access and refresh tokens shown for your application.

[![access tokens and customer key](../../assets/images/access_token.png)](../../assets/images/access_token.png)

{% capture token-notice %}

<p> ⚙️ The output of the application creation will be referenced as: <br>
SWIYU_IDENTIFIER_REGISTRY_CUSTOMER_KEY <br>
SWIYU_IDENTIFIER_REGISTRY_CUSTOMER_SECRET <br>
SWIYU_IDENTIFIER_REGISTRY_BOOTSTRAP_REFRESH_TOKEN <br>
SWIYU_IDENTIFIER_REGISTRY_ACCESS_TOKEN <br>
<hr>
SWIYU_STATUS_REGISTRY_CUSTOMER_KEY <br>
SWIYU_STATUS_REGISTRY_CUSTOMER_SECRET <br>
SWIYU_STATUS_REGISTRY_BOOTSTRAP_REFRESH_TOKEN <br>
SWIYU_STATUS_REGISTRY_ACCESS_TOKEN <br>
<hr>
SWIYU_TRUST_REGISTRY_CUSTOMER_KEY <br>
SWIYU_TRUST_REGISTRY_CUSTOMER_SECRET <br>
SWIYU_TRUST_REGISTRY_BOOTSTRAP_REFRESH_TOKEN <br>
SWIYU_TRUST_REGISTRY_ACCESS_TOKEN <br>
</p>
Safely store your keys, secrets, and tokens — this is the only time they are shown to you. It is possible to create new ones if necessary.<br>
The ACCESS_TOKEN expires after 24 hours and can be refreshed using the REFRESH_TOKEN. The REFRESH_TOKEN is valid for 168 hours. You can always create new tokens if you lose them or both expire.

{% endcapture %}

<div class="notice--warning">
  <h4 class="no_toc">Important:</h4>
  {{ token-notice | markdownify }}
</div>

## 2.4. API Documentation

Interactive API reference documentation is available for each of the three APIs:

- [swiyucorebusiness_identifier API reference](/api-docs/identifier/)
- [swiyucorebusiness_status API reference](/api-docs/status/)
- [swiyucorebusiness_trust API reference](/api-docs/trust/)

# 3. Create your first DID

Creating a DID involves three steps: reserving a DID space on the Base Registry, generating the DID log locally with the DID Toolbox, and uploading the log to your reserved space.

## 3.1. Reserve a DID Space

Call the **swiyucorebusiness_identifier** API to create a new identifier entry for your business partner. The response contains the `identifierRegistryUrl` — the URL your DID will be published at — and the `id` you will need to upload the DID log in the next step.

```sh
# Parameter
curl -X POST \
  "https://swiyu-core-business-service-d.apps.p-szb-ros-shrd-npr-01.cloud.admin.ch/api/v1/identifier/business-entities/$PARTNER_ID/identifier-entries/" \
  -H "Authorization: Bearer $SWIYU_IDENTIFIER_REGISTRY_ACCESS_TOKEN"

# Example response
{
  "id": "18fa7c77-9dd1-4e20-a147-fb1bec146085",
  "identifierRegistryUrl": "https://identifier-reg.trust-infra.swiyu.admin.ch/api/v1/did/18fa7c77-9dd1-4e20-a147-fb1bec146085",
  "status": "NOT_INITIALIZED",
  ...
}
```

<div class="notice--warning">
  Save the <code>id</code> and <code>identifierRegistryUrl</code> from the response — they are referenced below as <code>IDENTIFIER_REGISTRY_ENTRY_ID</code> and <code>IDENTIFIER_REGISTRY_URL</code>.
</div>

## 3.2. Generate the DID Log

Use the [DID Toolbox](https://github.com/swiyu-admin-ch/didtoolbox-java/releases/latest) to generate a DID log for your reserved space. Pass the `identifierRegistryUrl` from the previous step as the `--identifier-registry-url` parameter.

When no key material is supplied, the DID Toolbox automatically generates Ed25519 key pairs and saves them as PEM files in a `.didtoolbox/` directory relative to your working directory. The DID log is written to stdout.

```sh
# Parameter
java -jar didtoolbox.jar create \
  --identifier-registry-url $IDENTIFIER_REGISTRY_URL \
  > did.jsonl

# Example
java -jar didtoolbox.jar create \
  --identifier-registry-url "https://identifier-reg.trust-infra.swiyu.admin.ch/api/v1/did/18fa7c77-9dd1-4e20-a147-fb1bec146085" \
  > did.jsonl
```

{% capture did-toolbox-hint %}

<p> ⚙️ The generated key files in <code>.didtoolbox/</code> are required for subsequent operations such as updating your DID or creating a Proof of Possession. Store them securely.</p>
<p> ⚙️ If you already have existing Ed25519 key pairs, supply them with <code>--signing-key-file</code> and <code>--verifying-key-files</code>. See the <a href="https://github.com/swiyu-admin-ch/didtoolbox-java">DID Toolbox documentation</a> for advanced key management options including Java KeyStore (PKCS12) and Securosys Primus HSM support.</p>

{% endcapture %}

<div class="notice--warning">
  <h4 class="no_toc">Note:</h4>
  {{ did-toolbox-hint | markdownify }}
</div>

## 3.3. Upload the DID Log

Upload the generated `did.jsonl` to your reserved DID space using the `PUT` endpoint. Use the `IDENTIFIER_REGISTRY_ENTRY_ID` from step 3.1.

```sh
# Parameter
curl -X PUT \
  "https://swiyu-core-business-service-d.apps.p-szb-ros-shrd-npr-01.cloud.admin.ch/api/v1/identifier/business-entities/$PARTNER_ID/identifier-entries/$IDENTIFIER_REGISTRY_ENTRY_ID" \
  -H "Authorization: Bearer $SWIYU_IDENTIFIER_REGISTRY_ACCESS_TOKEN" \
  -H "Content-Type: application/jsonl+json" \
  --data-binary @did.jsonl

# Example
curl -X PUT \
  "https://swiyu-core-business-service-d.apps.p-szb-ros-shrd-npr-01.cloud.admin.ch/api/v1/identifier/business-entities/8432e1f3-8119-4fb9-a879-190ab2cb9deb/identifier-entries/18fa7c77-9dd1-4e20-a147-fb1bec146085" \
  -H "Authorization: Bearer $SWIYU_IDENTIFIER_REGISTRY_ACCESS_TOKEN" \
  -H "Content-Type: application/jsonl+json" \
  --data-binary @did.jsonl
```

A `200 OK` response confirms your DID is now published on the Base Registry and resolvable at the `identifierRegistryUrl`.

# 4. Proof of Possession creation

The proof of possession (PoP) is a testament that its creator is in possession of something.
In the context of the trust onboarding, this PoP takes the form of a [JSON Web Token (JWT)](https://www.jwt.io/introduction#what-is-json-web-token).
Such a PoP can be created with the [DID Toolbox](https://github.com/swiyu-admin-ch/didtoolbox-java/releases/latest).
Prerequisites for generating a PoP are:

* A valid DID log containing at least 1 public key.
* The corresponding private key for said public key.
* Possession in form of a string, referred to as nonce.

<div class="notice--warning">
  The generated PoP is only valid within the next 24 hours.
</div>

```sh
# Parameter
java -jar didtoolbox.jar create-pop -d $DID_LOG_PATH -k $ID_OF_PUBLIC_KEY -s $PRIVATE_KEY_PEM_FILE_PATH -n $NONCE

# Example
java -jar didtoolbox.jar create-pop -d did.jsonl -k "did:webvh:QmfNchmAvY4EJ7WrxaiWRyrspV9B8dSRzUgcs4CWUggiBD:example.com#assert-key-01" -s .didtoolbox/assert-key-01 -n "99A2BF79-3575-4824-87A5-8F66E6E8C2C7"
```

<div class="notice--warning">
  The generated PoP is used in the next step and will be further referenced as POP_JWT.
</div>
