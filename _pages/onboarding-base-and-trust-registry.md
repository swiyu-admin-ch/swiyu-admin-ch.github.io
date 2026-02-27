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

# 1. Title

## 1.1. Title

# 2. Title

## 2.1. Title

# 3. Proof of Possession creation

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
