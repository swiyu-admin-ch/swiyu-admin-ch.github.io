[![W3C](https://www.w3.org/StyleSheets/TR/2021/logos/W3C)](https://www.w3.org/)

# Digital Credentials

[W3C Working Draft](https://www.w3.org/standards/types#WD) 04 September 2026

More details about this document

This version:
:   <https://www.w3.org/TR/2026/WD-digital-credentials-20260904/>

Latest published version:
:   <https://www.w3.org/TR/digital-credentials/>

Latest editor's draft:
:   <https://w3c-fedid.github.io/digital-credentials/>

History:
:   <https://www.w3.org/standards/history/digital-credentials/>
:   [Commit history](https://github.com/w3c-fedid/digital-credentials/commits/)

Editors:
:   Marcos Caceres ([Apple Inc.](https://apple.com))
:   Tim Cappalli ([Okta](https://okta.com))
:   Mohamed Amir Yosef ([Google Inc.](https://google.com))

Former editor:
:   Sam Goto ([Google Inc.](https://google.com)) - Until 02 May 2025

Feedback:
:   [GitHub w3c-fedid/digital-credentials](https://github.com/w3c-fedid/digital-credentials/)
    ([pull requests](https://github.com/w3c-fedid/digital-credentials/pulls/),
    [new issue](https://github.com/w3c-fedid/digital-credentials/issues/new/choose),
    [open issues](https://github.com/w3c-fedid/digital-credentials/issues/))

[Copyright](https://www.w3.org/policies/#copyright)
©
2026
[World Wide Web Consortium](https://www.w3.org/).
W3C®
[liability](https://www.w3.org/policies/#Legal_Disclaimer),
[trademark](https://www.w3.org/policies/#W3C_Trademarks) and
[permissive document license](https://www.w3.org/copyright/software-license-2023/ "W3C Software and Document Notice and License") rules apply.

---

## Abstract

This document specifies an API enabling [user agents](https://infra.spec.whatwg.org/#user-agent) to mediate the
[presentation](#dfn-presentation-request) and [issuance](#dfn-issuance-request) of [digital credentials](#dfn-digital-credential), such as a
driver's license, government-issued identification card, or
[other types of digital credential](#dfn-credential-type-examples). The API
builds on [Credential Management Level 1](https://www.w3.org/TR/credential-management-1/) and is designed to be agnostic to
credential formats.

## Status of This Document

*This section describes the status of this
document at the time of its publication. A list of current W3C
publications and the latest revision of this technical report can be found
in the
[W3C standards and drafts index](https://www.w3.org/TR/).*

This document was published by the [Federated Identity Working Group](https://www.w3.org/groups/wg/fedid) as
a Working Draft using the
[Recommendation
track](https://www.w3.org/policies/process/20250818/#recs-and-notes).

Publication as
a Working Draft does not imply endorsement
by W3C and its Members.

This is a draft document and may be updated, replaced, or obsoleted by other
documents at any time. It is inappropriate to cite this document as other
than a work in progress.

This document was produced by a group
operating under the
[W3C Patent
Policy](https://www.w3.org/policies/patent-policy/).
W3C maintains a
[public list of any patent disclosures](https://www.w3.org/groups/wg/fedid/ipr)
made in connection with the deliverables of
the group; that page also includes
instructions for disclosing a patent. An individual who has actual
knowledge of a patent that the individual believes contains
[Essential Claim(s)](https://www.w3.org/policies/patent-policy/#def-essential)
must disclose the information in accordance with
[section 6 of the W3C Patent Policy](https://www.w3.org/policies/patent-policy/#sec-Disclosure).

This document is governed by the
[18 August 2025 W3C Process Document](https://www.w3.org/policies/process/20250818/).

## Table of Contents

1. [Abstract](#abstract)
2. [Status of This Document](#sotd)
3. [1.
   Introduction](#introduction)
4. [2.
   Examples of usage](#examples-of-usage)
   1. [2.1
      Feature Detection](#feature-detection)
   2. [2.2
      Checking if protocol is allowed](#checking-if-protocol-is-allowed)
   3. [2.3
      Requesting a digital credential](#requesting-a-digital-credential)
   4. [2.4
      Issuing a digital credential](#issuing-a-digital-credential)
   5. [2.5
      Requesting a digital credential across origins](#requesting-a-digital-credential-across-origins)
   6. [2.6
      Issuing a digital credential across origins](#issuing-a-digital-credential-across-origins)
5. [3.
   Scope](#scope)
6. [4.
   Terminology](#terminology)
7. [5.
   Protocols](#protocols)
   1. [5.1
      Convert request protocol](#convert-request-protocol)
8. [6.
   Credential Request Coordinator](#credential-request-coordinator)
   1. [6.1
      Interaction states](#interaction-states)
   2. [6.2
      Prepare credential requests](#prepare-credential-requests)
   3. [6.3
      Filter credential requests](#filter-credential-requests)
   4. [6.4
      Validate credential requests](#validate-credential-requests)
   5. [6.5
      Abort the credential request](#abort-the-credential-request)
   6. [6.6
      Reject the credential request](#reject-the-credential-request)
   7. [6.7
      Initiate the credential request](#initiate-the-credential-request)
9. [7.
   The Digital Credentials API](#DC-API)
   1. [7.1
      Extensions to `CredentialRequestOptions` dictionary](#extensions-to-credentialrequestoptions-dictionary)
      1. [7.1.1
         The `digital` member](#the-digital-member)
   2. [7.2
      The `DigitalCredentialRequestOptions` dictionary](#the-digitalcredentialrequestoptions-dictionary)
      1. [7.2.1
         The `requests` member](#the-requests-member)
   3. [7.3
      The `DigitalCredentialGetRequest` dictionary](#the-digitalcredentialgetrequest-dictionary)
      1. [7.3.1
         The `protocol` member](#the-protocol-member)
      2. [7.3.2
         The `data` member](#the-data-member)
   4. [7.4
      Extensions to `CredentialCreationOptions` dictionary](#extensions-to-credentialcreationoptions-dictionary)
      1. [7.4.1
         The `digital` member](#the-digital-member-0)
   5. [7.5
      The `DigitalCredentialCreationOptions` dictionary](#the-digitalcredentialcreationoptions-dictionary)
      1. [7.5.1
         The `requests` member](#the-requests-member-0)
   6. [7.6
      The `DigitalCredentialCreateRequest` dictionary](#the-digitalcredentialcreaterequest-dictionary)
      1. [7.6.1
         The `protocol` member](#the-protocol-member-0)
      2. [7.6.2
         The `data` member](#the-data-member-0)
   7. [7.7
      The `DigitalCredential` interface](#the-digitalcredential-interface)
      1. [7.7.1
         The `protocol` member](#the-protocol-member-1)
      2. [7.7.2
         The `data` member](#the-data-member-1)
      3. [7.7.3
         The `userAgentAllowsProtocol()`
         method](#the-useragentallowsprotocol-method)
   8. [7.8
      Supporting Data Structures](#supporting-data-structures)
      1. [7.8.1
         The request context struct](#the-request-context-struct)
      2. [7.8.2
         The `DigitalCredentialPresentationProtocol` enumeration](#the-digitalcredentialpresentationprotocol-enumeration)
      3. [7.8.3
         The `DigitalCredentialIssuanceProtocol` enumeration](#the-digitalcredentialissuanceprotocol-enumeration)
10. [8.
    Integration with Credential Management Level 1](#credential-management-integration)
    1. [8.1
       [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors)
       internal method](#discoverfromexternalsource-origin-options-sameoriginwithancestors-internal-method)
    2. [8.2
       [[Store]](credential, sameOriginWithAncestors) internal method](#store-credential-sameoriginwithancestors-internal-method)
    3. [8.3
       [[Create]](origin, options, sameOriginWithAncestors) internal method](#create-origin-options-sameoriginwithancestors-internal-method)
    4. [8.4
       [[type]] internal slot](#type-internal-slot)
    5. [8.5
       [[discovery]] internal slot](#discovery-internal-slot)
    6. [8.6
       User permission](#user-permission)
11. [9.
    Permissions Policy integration](#permissions-policy)
12. [10.
    Security Considerations](#security-considerations)
    1. [10.1
       Threat Model](#threat-model)
       1. [10.1.1
          In-Scope Threats](#in-scope-threats)
       2. [10.1.2
          Out of Scope Threats](#out-of-scope-threats)
    2. [10.2
       Mitigations](#mitigations)
    3. [10.3
       Signing presentation requests](#signing-presentation-requests)
    4. [10.4
       Cross-Device Security and Proximity](#cross-device-security-and-proximity)
13. [11.
    Privacy Considerations](#privacy-principles)
    1. [11.1
       Design Considerations and Alternatives](#design-considerations-and-alternatives)
    2. [11.2
       Spectrum of Privacy](#spectrum-of-privacy)
    3. [11.3
       Presentation Protocol and Credential Format](#presentation-protocol-and-credential-format)
       1. [11.3.1
          Presentation Protocol Considerations for User Privacy](#presentation-protocol-considerations-for-user-privacy)
          1. [11.3.1.1
             Selective disclosure](#selective-disclosure)
          2. [11.3.1.2
             Unlinkable presentations](#unlinkable-presentations)
          3. [11.3.1.3
             "Phone home" mechanisms](#phone-home-mechanisms)
          4. [11.3.1.4
             Unlinkable revocation](#unlinkable-revocation)
          5. [11.3.1.5
             Support for user transparency, permission and consent](#support-for-user-transparency-permission-and-consent)
          6. [11.3.1.6
             Support for verifier authorization](#support-for-verifier-authorization)
          7. [11.3.1.7
             Encrypting credential responses](#encrypting-credential-responses)
    4. [11.4
       Unnecessary Requests for Credentials](#unnecessary-requests-for-credentials)
       1. [11.4.1
          Government-issued credentials](#government-issued-credentials)
          1. [11.4.1.1
             Risk of theft and leakage of government credentials](#risk-of-theft-and-leakage-of-government-credentials)
          2. [11.4.1.2
             Risk of proliferation of requests for government credentials](#risk-of-proliferation-of-requests-for-government-credentials)
          3. [11.4.1.3
             Mitigating unnecessary requests for government credentials](#mitigating-unnecessary-requests-for-government-credentials)
       2. [11.4.2
          Non-government-issued credentials](#non-government-issued-credentials)
          1. [11.4.2.1
             Risk of theft and leakage of non-government credentials](#risk-of-theft-and-leakage-of-non-government-credentials)
          2. [11.4.2.2
             Risk of proliferation of requests for non-government credentials](#risk-of-proliferation-of-requests-for-non-government-credentials)
          3. [11.4.2.3
             Mitigating unnecessary requests for non-government credentials](#mitigating-unnecessary-requests-for-non-government-credentials)
          4. [11.4.2.4
             Reporting abuse](#reporting-abuse)
    5. [11.5
       Fingerprinting and Data Leakage](#fingerprinting-and-data-leakage)
       1. [11.5.1
          Browser fingerprinting](#browser-fingerprinting)
       2. [11.5.2
          Leaking incidental data with credential presentations](#leaking-incidental-data)
       3. [11.5.3
          Revealing device properties through protocol availability](#revealing-device-properties-through-protocol-availability)
       4. [11.5.4
          Avoiding leaks of credential availability](#avoiding-leaks-of-credential-availability)
    6. [11.6
       User Permission and Transparency](#user-permission-and-transparency)
       1. [11.6.1
          Handling multiple credential requests](#handling-multiple-credential-requests)
       2. [11.6.2
          Integrating Multiple User Agents](#multiple-user-agents)
       3. [11.6.3
          Permission Prior to Credential Manager Selection](#permission-prior-to-credential-manager-selection)
       4. [11.6.4
          Permission vs. Consent](#permission-vs-consent)
    7. [11.7
       Data Clearing and Persistent State](#data-clearing-and-persistent-state)
14. [12.
    Accessibility Considerations](#accessibility-considerations)
15. [13.
    Internationalization Considerations](#internationalization-considerations)
16. [14.
    Automated Testing](#automated-testing)
    1. [14.1
       The `digitalCredentials` Module](#the-digitalcredentials-module)
       1. [14.1.1
          Types](#types)
       2. [14.1.2
          Commands](#commands)
          1. [14.1.2.1
             The `digitalCredentials.setVirtualWalletBehavior` Command](#the-digitalcredentials-setvirtualwalletbehavior-command)
    2. [14.2
       Handle Virtual Wallet Behavior](#handle-virtual-wallet-behavior)
17. [A. Index](#index)
    1. [A.1 Terms defined by this specification](#index-defined-here)
    2. [A.2 Terms defined by reference](#index-defined-elsewhere)
18. [B. IDL Index](#idl-index)
19. [C. CDDL Index](#cddl-index)
    1. [C.1 Module: remote-cddl](#cddl-index-module-remote-cddl)
    2. [C.2 Module: local-cddl](#cddl-index-module-local-cddl)
20. [D. Conformance](#conformance)
21. [E.
    Acknowledgements](#acknowledgements)
22. [F. References](#references)
    1. [F.1 Normative references](#normative-references)
    2. [F.2 Informative references](#informative-references)

## 1. Introduction

*This section is non-normative.*

This document defines an API enabling a website to request presentation
and issuance of a [digital credential](#dfn-digital-credential).

The API is agnostic to credential formats and is designed to be
extensible to multiple [presentation protocols](#dfn-presentation-protocol) and
[issuance protocols](#dfn-issuance-protocol). See [5.
Protocols](#protocols).

The API is designed to support the following goals:

* Keep the acts of [requesting](#dfn-presentation-request) and [issuing](#dfn-issuance-request) separate from the specific [presentation protocol](#dfn-presentation-protocol) and [issuance protocol](#dfn-issuance-protocol) respectively; thereby enabling the extensibility of such
  protocols and credential formats.
* Require [presentation requests](#dfn-presentation-request) and [issuance requests](#dfn-issuance-request) to be unencrypted, enabling user-agent
  inspection for risk analysis.
* Assume opaque (i.e., encrypted) [presentation responses](#dfn-presentation-response) and [issuance responses](#dfn-issuance-response), enabling
  [issuers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers), [verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier), and [holders](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) to control where potentially
  sensitive personally identifiable information is exposed.
* Ensure that all credential interactions are user-mediated, giving
  users control and consent over the [presentation](#dfn-presentation-request) and [issuance](#dfn-issuance-request) of their [digital credentials](#dfn-digital-credential).
* Require [transient activation](https://html.spec.whatwg.org/multipage/interaction.html#transient-activation) to perform [presentation requests](#dfn-presentation-request) or [issuance requests](#dfn-issuance-request), ensuring that sites cannot silently request or issue digital
  credentials without the user's active participation.
* Enable platform-provided UX for credential and [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager)
  selection during requests for [presentation](#dfn-presentation-request) or [issuance](#dfn-issuance-request).
* Enable platforms to provide secure cross-device [presentation requests](#dfn-presentation-request) and [issuance requests](#dfn-issuance-request) with proximity checks.

[Digital credentials](#dfn-digital-credential) of many types can be presented and issued using
this API. Examples of these
types include:

* a driving license, passport, or other identity card issued by a
  government institution
* a travel authorization document issued by an embassy or consulate
* a proof of employment issued by a public or private organization
* a proof of education or professional training issued by an
  institution
* many other scenarios as described in [Verifiable Credentials Use Cases](https://www.w3.org/TR/vc-use-cases/)

## 2. Examples of usage

*This section is non-normative.*

The following examples illustrate how the [API](#DC-API) can be used
to request and issue digital credentials.

### 2.1 Feature Detection

Before using the [API](#DC-API), it's important to check if the user
agent supports the necessary features. This can be done using the
following code:

[Example 1](#example-checking-for-api-support): Checking for API support

```
if (typeof DigitalCredential !== "undefined") {
  // The API is supported
} else {
  // The API is not supported
}
```

### 2.2 Checking if protocol is allowed

The [`userAgentAllowsProtocol`](#dom-digitalcredential-useragentallowsprotocol)`()` static method can
be used to check if the user agent allows a specific protocol for
digital credential issuance or presentation. This is useful for
checking which protocols are allowed by the user's browsers prior to
making an API call. On browsers that implement [`DigitalCredential`](#dom-digitalcredential)
(detectable via the `typeof` check shown above), protocol identifiers
are added to [`DigitalCredentialProtocol`](#dom-digitalcredentialprotocol) progressively as [user agents](https://infra.spec.whatwg.org/#user-agent) adopt support for them, so calling this method with an unknown
protocol identifier safely returns `false` without
[throwing](https://webidl.spec.whatwg.org/#dfn-throw) an [exception](https://webidl.spec.whatwg.org/#dfn-exception). Note that calling this
method on a browser where [`DigitalCredential`](#dom-digitalcredential) is not defined will
throw a [`ReferenceError`](https://webidl.spec.whatwg.org/#exceptiondef-referenceerror), so the `typeof DigitalCredential !==
"undefined"` guard shown above is still required before using this
method.

[Example 2](#example-using-the-useragentallowsprotocol-static-method): Using the userAgentAllowsProtocol() static method

```
if (DigitalCredential.userAgentAllowsProtocol("example-protocol")) {
  // DC API supported. Proceed with issuance or presentation.
} else {
  // DC API not supported. Fall back to, for example,
  // a traditional HTML form-based approach.
  showHTMLForm();
}
```

Alternatively, one can check for support of multiple protocols,
filtering out those that are not supported:

[Example 3](#example-checking-multiple-protocols-with-useragentallowsprotocol): Checking multiple protocols with userAgentAllowsProtocol()

```
const protocols = [
  "example-issuance-protocol",
  "another-issuance-protocol"
];
const supportedProtocols = protocols.filter(DigitalCredential.userAgentAllowsProtocol);
if (supportedProtocols.length > 0) {
  // At least one protocol is supported. Proceed with issuance.
} else {
  // No protocols are supported. Fall back to a different issuance method.
}
```

Because protocol identifiers are added to [`DigitalCredentialProtocol`](#dom-digitalcredentialprotocol)
progressively, one can use this method to prefer a newer protocol while
gracefully falling back to an older one on legacy browsers:

[Example 4](#example-preferring-a-newer-protocol-with-fallback-to-an-older-one): Preferring a newer protocol with fallback to an older one

```
// Ordered by preference; on browsers that implement DigitalCredential,
// unknown protocols return false rather than throwing.
const protocol = [
  "example-new-protocol",
  "example-legacy-protocol",
].find(DigitalCredential.userAgentAllowsProtocol);

if (protocol) {
  // Use the best protocol this browser supports.
} else {
  // No supported protocol found. Fall back to another approach.
}
```

### 2.3 Requesting a digital credential

The following example shows how to request a digital credential using
the [API](#DC-API). The entry point for the API is the
`navigator.credentials.`[`get`](https://www.w3.org/TR/credential-management-1/#dom-credentialscontainer-get)`()` method, which is
used to request a [digital credential](#dfn-digital-credential) from the user agent. If the
user agent supports [presentation](#dfn-presentation-request), it allows the user to select a digital
credential through a [digital credential chooser](#dfn-digital-credential-chooser):

[Example 5](#example-requesting-a-digital-credential): Requesting a digital credential

```
<button>Verify Identity</button>
<script>
  const button = document.querySelector("button");
  button.addEventListener("click", async () => {
    const protocol = "example-request-protocol";
    // Check for DC API and protocol support
    if (!DigitalCredential.userAgentAllowsProtocol(protocol)) {
      // The browser doesn't allow the use of this protocol.
      // Fall back to a different verification method.
      showTraditionalVerificationForm();
      return;
    }
    try {
      const credential = await navigator.credentials.get({
        digital: {
          requests: [{
            protocol,
            data: { /* presentation request data */ }
          }]
        }
      });

      // Post it back to the verifier server for decryption and verification
      const response = await fetch("/verify-credential", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify(credential)
      });

      // Check response
      if (!response.ok) {
        throw new Error("Failed to verify credential");
      }

      // Render the verification result
      displayVerificationResult(await response.json());

    } catch (error) {
      console.error("Error requesting digital credential:", error);
    }
  });
</script>
```

Similarly, when a site needs to [issue](#dfn-issuance-request) a
digital credential, the [Digital Credentials API](#DC-API) mediates
the issuance of a digital credential between the site, the user agent,
and the [holder](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders)'s [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager), via a [credential manager chooser](#dfn-credential-manager-chooser).

### 2.4 Issuing a digital credential

The following example shows how to request the issuance of a digital
credential using the [Digital Credentials API](#DC-API). To issue a
digital credential, a site calls the
`navigator.credentials.`[`create`](https://www.w3.org/TR/credential-management-1/#dom-credentialscontainer-create)`()` method,
which, if the user agent supports issuance, would initiate the issuance
flow:

[Example 6](#example-requesting-issuance-of-a-digital-credential): Requesting issuance of a digital credential

```
<button>Request Digital Credential Issuance</button>
<script>
  const button = document.querySelector("button");
  button.addEventListener("click", async () => {
    const protocol = "example-issuance-protocol";
    // Check for DC API and protocol support
    if (!DigitalCredential.userAgentAllowsProtocol(protocol)) {
      // The browser doesn't allow the use of this protocol.
      // Fall back to a different issuance method.
      showTraditionalIssuanceForm();
      return;
    }
    try {
      const credential = await navigator.credentials.create({
        digital: {
          requests: [{
            protocol,
            data: { /* issuance request data */ }
          }]
        }
      });
    } catch (error) {
      console.error("Error issuing digital credential:", error);
    }
  });
</script>
```

### 2.5 Requesting a digital credential across origins

The specification allows usage of the API for presenting credentials
from a remote/third-party origin via the
["digital-credentials-get"](#dfn-digital-credentials-get) [policy-controlled feature](https://www.w3.org/TR/permissions-policy-1/#policy-controlled-feature). This is
useful for scenarios where a website wants to request digital
credentials from a verification service that is hosted on a different
origin. The Permissions Policy can be set on an iframe that embeds the
website that wants to use the API. Here is an example of how the
Permissions Policy can be set on an iframe:

[Example 7](#example-requesting-a-digital-credential-across-origins): Requesting a digital credential across origins

```
<iframe src="https://verifier-service.example.com"
        allow="digital-credentials-get">
</iframe>
```

### 2.6 Issuing a digital credential across origins

Similarly, the specification allows usage of the API for issuing
credentials from a remote/third-party origin via the
["digital-credentials-create"](#dfn-digital-credentials-create) [policy-controlled feature](https://www.w3.org/TR/permissions-policy-1/#policy-controlled-feature). This
is useful for scenarios where a website wants to request issuance of a
digital credential using an issuance service on a different origin. The
Permissions Policy can be set on an iframe embedding the [issuer's](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers)
interface. Here is an example:

[Example 8](#example-issuing-a-digital-credential-across-origins): Issuing a digital credential across origins

```
<iframe src="https://issuer.example.com"
        allow="digital-credentials-create">
</iframe>
```

## 3. Scope

*This section is non-normative.*

The following items are within the scope of this specification:

* [Presentation requests](#dfn-presentation-request) including
  mechanisms for [presentation](#dfn-presentation-request) of
  [digital credentials](#dfn-digital-credential).
* [Issuance requests](#dfn-issuance-request) for [digital credentials](#dfn-digital-credential).
* Mechanisms ensuring that, when an API call is made, the website does
  not learn anything about the [holder](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) nor any [digital credentials](#dfn-digital-credential)
  they hold, without explicit user consent.
* Ensuring that any installed application software will not learn
  anything about a given [issuance request](#dfn-issuance-request) or
  [presentation request](#dfn-presentation-request) unless the [holder](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders)
  explicitly consents to use that software.

The following items are out of scope:

* UI/UX considerations, except for accessibility and privacy aspects,
  which are addressed to ensure access to and protection of user data
  during [presentation](#dfn-presentation-request) and [issuance](#dfn-issuance-request) processes.
* Functionality outside the [user agent](https://infra.spec.whatwg.org/#user-agent) is out of scope, including
  platform-specific frameworks, native operating system APIs, standalone
  applications, and hardware components that store, manage, or process
  [digital credentials](#dfn-digital-credential). This includes the user interface and user
  interactions for selecting a specific credential and obtaining the user's
  permission to forward a request to the user-selected [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager).
* Implementation of [credential managers](https://www.w3.org/TR/credential-management-1/#credential-manager), specifically in the role
  of [holder](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) software (commonly known as "digital wallets"), including
  how they securely store or manage [digital credentials](#dfn-digital-credential) or advertise
  capabilities to [present](#dfn-presentation-request) or [issue](#dfn-issuance-request) them to the [user agent](https://infra.spec.whatwg.org/#user-agent), is out of scope.
  The only exception is the transmission of [issuance request data](#dfn-issuance-request-data) and [presentation request data](#dfn-presentation-request-data) to
  and from such software.

## 4. Terminology

Note: Definitions under discussion

The goal of the definitions in this section is to reuse or establish
terminology that is common across a variety of digital credential formats
and protocols. These definitions are actively evolving.

Credential manager chooser
:   A platform-provided user interface that presents one or more
    [credential managers](https://www.w3.org/TR/credential-management-1/#credential-manager) to the user, allowing them to choose a
    credential manager to handle the [issuance request](#dfn-issuance-request), or cancel the operation.

Credential request
:   A [presentation request](#dfn-presentation-request) or an [issuance request](#dfn-issuance-request).

Credential response
:   A [presentation response](#dfn-presentation-response) or an [issuance response](#dfn-issuance-response).

Digital credential
:   A cryptographically signed digital document containing one or more
    [claims](https://www.w3.org/TR/vc-data-model-2.0/#dfn-claims) made by an [issuer](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers) about one or more [subjects](https://www.w3.org/TR/vc-data-model-2.0/#dfn-subjects).

    Note: Focus on digital credentials about people

    This specification is currently focused on digital credentials
    pertaining to people.

Digital credential chooser
:   A platform-provided user interface that presents one or more [credential requests](#dfn-credential-request) to the user, allowing them to select a
    [digital credential](#dfn-digital-credential) or [holder](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) that can fulfill the request, or
    cancel the operation.

    Note: Relationship to credential chooser

    The [digital credential chooser](#dfn-digital-credential-chooser) may be invoked as part of a
    broader [credential chooser](https://www.w3.org/TR/credential-management-1/#credential-chooser), or as a separate platform-provided
    user interface. The exact relationship is implementation-defined.

Issuance protocol
:   A standardized protocol used for communication between an [issuer](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers)
    and a [holder](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) during the issuance of a [digital credential](#dfn-digital-credential). The
    issuance protocol is identified by a [protocol identifier](#dfn-protocol-identifier). See [5.
    Protocols](#protocols).

Issuance request
:   An issuance request is a request to issue a [digital credential](#dfn-digital-credential)
    composed of some [issuance request data](#dfn-issuance-request-data) and an
    [issuance protocol](#dfn-issuance-protocol).

Issuance request data
:   A data structure that an [issuer](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers) or a [user agent](https://infra.spec.whatwg.org/#user-agent), via an
    [issuance protocol](#dfn-issuance-protocol), to request the issuance of a
    [digital credential](#dfn-digital-credential) by an [issuer](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers).

Issuance response
:   A format that [holder](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) uses, via an [issuance protocol](#dfn-issuance-protocol), to respond to an [issuance request](#dfn-issuance-request) by
    an [issuer](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers).

Presentation protocol
:   A standardized protocol used for presenting a [digital credential](#dfn-digital-credential)
    between a [holder](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) and a [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier). A protocol is identified by a
    [protocol identifier](#dfn-protocol-identifier). See [5.
    Protocols](#protocols).

Presentation request
:   A presentation request is a request for a [digital credential](#dfn-digital-credential)
    composed of [presentation request data](#dfn-presentation-request-data) and a
    [presentation protocol](#dfn-presentation-protocol).

Presentation request data
:   A format that [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) software or a [user agent](https://infra.spec.whatwg.org/#user-agent) uses, via an
    [presentation protocol](#dfn-presentation-protocol), to request a [digital credential](#dfn-digital-credential) from a [holder](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders).

Presentation response
:   A format that a [holder's](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager), such as a digital
    wallet, uses, via an [presentation protocol](#dfn-presentation-protocol), to
    respond to a [presentation request](#dfn-presentation-request) by a
    [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier).

Protocol identifier
:   A [string](https://infra.spec.whatwg.org/#string) composed of one or more [ASCII lower alpha](https://infra.spec.whatwg.org/#ascii-lower-alpha) [code points](https://infra.spec.whatwg.org/#code-point), zero or more U+002D HYPHEN-MINUS [code points](https://infra.spec.whatwg.org/#code-point), and zero or
    more [ASCII digit](https://infra.spec.whatwg.org/#ascii-digit) [code points](https://infra.spec.whatwg.org/#code-point) (in any order). For example,
    "123a-protocol", "abc", or simply "a".

Request coordinator
:   See [credential request coordinator](#dfn-credential-request-coordinator).

## 5. Protocols

Use of the following [presentation protocols](#dfn-presentation-protocol) and
[issuance protocols](#dfn-issuance-protocol) is defined by this
specification.

A [user agent](https://infra.spec.whatwg.org/#user-agent) *MUST* support all the [presentation protocols](#dfn-presentation-protocol) listed in the [table of supported presentation and issuance protocols](#dfn-table-of-supported-presentation-and-issuance-protocols). It is *RECOMMENDED* that [user agents](https://infra.spec.whatwg.org/#user-agent) also support all of
the [issuance protocols](#dfn-issuance-protocol) listed in [that table](#dfn-table-of-supported-presentation-and-issuance-protocols).

Note: Rationale for the required protocols

Requiring every listed [presentation protocol](#dfn-presentation-protocol)
means a [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) can rely on the API regardless of the credential
format or request mode used. It also prevents [user agents](https://infra.spec.whatwg.org/#user-agent) from each
allowing a different subset, which would fragment the ecosystem.

Note: Checking which protocols a user agent allows

Developers can learn which [presentation protocols](#dfn-presentation-protocol) or [issuance protocols](#dfn-issuance-protocol) a user agent
allows by calling the
`DigitalCredential.`[`DigitalCredential`](#dom-digitalcredential).[`userAgentAllowsProtocol`](#dom-digitalcredential-useragentallowsprotocol)`()`
static method. See [2.2
Checking if protocol is allowed](#checking-if-protocol-is-allowed) for an
example of its use.

Table of supported [presentation](#dfn-presentation-protocol) and [issuance](#dfn-issuance-protocol) protocols

| [Identifier](#dfn-protocol-identifier) | Specification |
| --- | --- |
| [Presentation protocols](#dfn-presentation-protocol) | |
| --- | --- |
| `openid4vp-v1-unsigned` | [OpenID for Verifiable Presentations 1.0](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html) § [A.3.1. Unsigned Request](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html#name-unsigned-request) |
| `openid4vp-v1-signed` | [OpenID for Verifiable Presentations 1.0](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html) § [A.3.2. Signed Request](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html#name-signed-request) |
| `openid4vp-v1-multisigned` | [OpenID for Verifiable Presentations 1.0](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html) § [A.3.2.2. JWS JSON Serialization](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html#name-jws-json-serialization) (Multi-signed requests) |
| `org-iso-mdoc` | [ISO/IEC 18013-7:2025 ISO-compliant driving licence, Part 7: Mobile driving licence (mDL) add-on functions](https://www.iso.org/standard/91154.html) § Annex C |
| [Issuance protocols](#dfn-issuance-protocol) | |
| --- | --- |
| `openid4vci-v1` | [OpenID for Verifiable Credential Issuance 1.0](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html) § Coming Soon Issue: API Integration  The OpenID Foundation is working on integration with Digital Credentials API. You can track progress at [OpenID4VCI#410](https://github.com/openid/OpenID4VCI/issues/410). |

### 5.1 Convert request protocol

To convert request protocol given a
[`DigitalCredentialGetRequest`](#dom-digitalcredentialgetrequest) or [`DigitalCredentialCreateRequest`](#dom-digitalcredentialcreaterequest)
request:

1. If request is:

   A [`DigitalCredentialGetRequest`](#dom-digitalcredentialgetrequest):
   :   1. Let protocolString be request's
          [`protocol`](#dom-digitalcredentialgetrequest-protocol).
       2. If protocolString does not equal any [enumeration value](https://webidl.spec.whatwg.org/#dfn-enumeration-value)
          in [`DigitalCredentialPresentationProtocol`](#dom-digitalcredentialpresentationprotocol), return failure.
       3. Return the [`DigitalCredentialPresentationProtocol`](#dom-digitalcredentialpresentationprotocol)
          [enumeration value](https://webidl.spec.whatwg.org/#dfn-enumeration-value) whose value is protocolString.

   A [`DigitalCredentialCreateRequest`](#dom-digitalcredentialcreaterequest):
   :   1. Let protocolString be request's
          [`protocol`](#dom-digitalcredentialcreaterequest-protocol).
       2. If protocolString does not equal any [enumeration value](https://webidl.spec.whatwg.org/#dfn-enumeration-value)
          in [`DigitalCredentialIssuanceProtocol`](#dom-digitalcredentialissuanceprotocol), return failure.
       3. Return the [`DigitalCredentialIssuanceProtocol`](#dom-digitalcredentialissuanceprotocol)
          [enumeration value](https://webidl.spec.whatwg.org/#dfn-enumeration-value) whose value is protocolString.

## 6. Credential Request Coordinator

The credential request coordinator
is a user-agent-defined component that mediates [digital credential](#dfn-digital-credential)
interactions through the [top-level traversable](https://html.spec.whatwg.org/multipage/document-sequences.html#top-level-traversable). Each [top-level traversable](https://html.spec.whatwg.org/multipage/document-sequences.html#top-level-traversable) has exactly one associated coordinator. The coordinator
ensures that at most one interaction is active across all [child navigables](https://html.spec.whatwg.org/multipage/document-sequences.html#child-navigable), orchestrates the end-to-end flow of presentation or
issuance, and manages transitions between [interaction states](#dfn-interaction-states).

The [credential request coordinator](#dfn-credential-request-coordinator) maintains an active promise, which the user
agent initializes as `null`. Through this [`Promise`](https://webidl.spec.whatwg.org/#idl-promise), the
[coordinator](#dfn-credential-request-coordinator) reflects the state of the asynchronous [credential request](#dfn-credential-request) workflow to script and either
[resolves](https://webidl.spec.whatwg.org/#resolve) with a [credential response](#dfn-credential-response) when the
interaction completes successfully, or [rejects](https://webidl.spec.whatwg.org/#reject) when processing fails,
when the user cancels the request via the UI, or when script aborts the
operation via an [`AbortSignal`](https://dom.spec.whatwg.org/#abortsignal).

The [credential request coordinator](#dfn-credential-request-coordinator) maintains an abort signal, which the user agent
initializes as `null`.

The [credential request coordinator](#dfn-credential-request-coordinator) maintains an abort algorithm, which the user
agent initializes as `null`.

The [credential request coordinator](#dfn-credential-request-coordinator):

* Validates and transforms presentation or issuance inputs and outputs.
* Requests the platform to display, for user selection, the credentials
  that are available for the current request and/or the [holders](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) that
  can handle the current request. The availability of credentials and
  [holders](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) is determined by matching the request parameters, user
  consent, and platform policy.
* Manages [resolution](https://webidl.spec.whatwg.org/#resolve) or [rejection](https://webidl.spec.whatwg.org/#reject) of the
  [active promise](#dfn-active-promise) based on the
  interaction outcome.

A user agent *MAY* delegate some or all coordinator responsibilities to
external [credential managers](https://www.w3.org/TR/credential-management-1/#credential-manager), platform components, or other trusted
entities according to user or platform policy.

Note

Although the coordinator handles input/output coordination, it is the
responsibility of the platform together with available [credential managers](https://www.w3.org/TR/credential-management-1/#credential-manager), to present the UI that allows the user to choose a
[digital credential](#dfn-digital-credential) and/or a [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager).

### 6.1 Interaction states

The [credential request coordinator](#dfn-credential-request-coordinator) has a finite set of
interaction
states, which are used to manage the lifecycle of a [credential request](#dfn-credential-request):

"idle":
:   No [credential request](#dfn-credential-request) is currently in progress.

"requesting":
:   A [credential request](#dfn-credential-request) is in progress and the user
    interface is presented.

"aborting":
:   The active interaction is being canceled due to an error, a user
    action, or a [signal abort](https://dom.spec.whatwg.org/#abortcontroller-signal-abort); the coordinator is
    cleaning up before returning to "[idle](#dfn-idle)".

The coordinator is initialized in the [idle](#dfn-idle) [interaction state](#dfn-interaction-states).

### 6.2 Prepare credential requests

To prepare credential
requests given a [`Window`](https://html.spec.whatwg.org/multipage/nav-history-apis.html#window) global, an [origin](https://html.spec.whatwg.org/multipage/browsers.html#concept-origin) origin, a
[sequence](https://webidl.spec.whatwg.org/#idl-sequence) of [`DigitalCredentialGetRequest`](#dom-digitalcredentialgetrequest) values or a [sequence](https://webidl.spec.whatwg.org/#idl-sequence)
of [`DigitalCredentialCreateRequest`](#dom-digitalcredentialcreaterequest) values requests, and an optional
[`AbortSignal`](https://dom.spec.whatwg.org/#abortsignal) signal:

1. Let realm be global's [relevant realm](https://html.spec.whatwg.org/multipage/webappapis.html#concept-relevant-realm).
2. Let document be global's [associated `Document`](https://html.spec.whatwg.org/multipage/nav-history-apis.html#concept-document-window).
3. If document is not [fully active](https://html.spec.whatwg.org/multipage/document-sequences.html#fully-active), return [a promise rejected with](https://webidl.spec.whatwg.org/#a-promise-rejected-with) an "[`InvalidStateError`](https://webidl.spec.whatwg.org/#invalidstateerror)" [`DOMException`](https://webidl.spec.whatwg.org/#idl-DOMException) in realm.
4. If document is not a [fully active descendant of a top-level traversable with user attention](https://html.spec.whatwg.org/multipage/interaction.html#fully-active-descendant-of-a-top-level-traversable-with-user-attention), return [a promise rejected with](https://webidl.spec.whatwg.org/#a-promise-rejected-with) a "[`NotAllowedError`](https://webidl.spec.whatwg.org/#notallowederror)" [`DOMException`](https://webidl.spec.whatwg.org/#idl-DOMException) in realm.
5. If global does not have [transient activation](https://html.spec.whatwg.org/multipage/interaction.html#transient-activation), return [a promise rejected with](https://webidl.spec.whatwg.org/#a-promise-rejected-with) a "[`NotAllowedError`](https://webidl.spec.whatwg.org/#notallowederror)" [`DOMException`](https://webidl.spec.whatwg.org/#idl-DOMException) in
   realm.
6. [Consume user activation](https://html.spec.whatwg.org/multipage/interaction.html#consume-user-activation) of global.
7. Let promise be [a new promise](https://webidl.spec.whatwg.org/#a-new-promise) in realm.
8. If the [credential request coordinator](#dfn-credential-request-coordinator) is not in the "[idle](#dfn-idle)" [interaction state](#dfn-interaction-states):
   1. [Queue a global task](https://html.spec.whatwg.org/multipage/webappapis.html#queue-a-global-task) on the [DOM manipulation task source](https://html.spec.whatwg.org/multipage/webappapis.html#dom-manipulation-task-source)
      given global to [reject](https://webidl.spec.whatwg.org/#reject) promise with a "[`NotAllowedError`](https://webidl.spec.whatwg.org/#notallowederror)"
      [`DOMException`](https://webidl.spec.whatwg.org/#idl-DOMException).
   2. Return promise.
9. [Assert](https://infra.spec.whatwg.org/#assert): the [credential request coordinator](#dfn-credential-request-coordinator)'s [active promise](#dfn-active-promise) is `null`.
10. Set the [credential request coordinator](#dfn-credential-request-coordinator) [interaction state](#dfn-interaction-states) to "[requesting](#dfn-requesting)".
11. Set the [credential request coordinator](#dfn-credential-request-coordinator)'s [active promise](#dfn-active-promise) to promise.
12. Let validatedRequests be the result of [validate credential requests](#dfn-validate-credential-requests) given requests. If that
    [throws](https://webidl.spec.whatwg.org/#dfn-throw) an [exception](https://webidl.spec.whatwg.org/#dfn-exception) error, then:
    1. [Reject the credential request with](#dfn-reject-the-credential-request-with) error and promise.
    2. Return promise.
13. If validatedRequests [is empty](https://infra.spec.whatwg.org/#list-is-empty), then:
    1. [Reject the credential request with](#dfn-reject-the-credential-request-with) a newly created [`TypeError`](https://webidl.spec.whatwg.org/#exceptiondef-typeerror) and promise.
    2. Return promise.
14. If signal was passed, then:
    1. [Assert](https://infra.spec.whatwg.org/#assert): signal is not [aborted](https://dom.spec.whatwg.org/#abortsignal-aborted).

       Note

       [Pre-aborted](https://dom.spec.whatwg.org/#abortsignal-aborted) [signals](https://dom.spec.whatwg.org/#abortcontroller-signal)
       are handled by [request a `Credential`](https://www.w3.org/TR/credential-management-1/#abstract-opdef-request-a-credential) and [create a `Credential`](https://www.w3.org/TR/credential-management-1/#abstract-opdef-create-a-credential) before this algorithm is invoked.
    2. Set the [credential request coordinator](#dfn-credential-request-coordinator)'s [abort signal](#dfn-abort-signal) to signal.
    3. Let abortAlgorithm be the following algorithm, closing over
       promise and signal:
       1. If the [credential request coordinator](#dfn-credential-request-coordinator)'s [active promise](#dfn-active-promise) is not promise, return.
       2. [Abort the credential request](#dfn-abort-the-credential-request) given signal's [abort reason](https://dom.spec.whatwg.org/#abortsignal-abort-reason).
    4. Set the [credential request coordinator](#dfn-credential-request-coordinator)'s [abort algorithm](#dfn-abort-algorithm) to abortAlgorithm.
    5. [Add](https://dom.spec.whatwg.org/#abortsignal-add) abortAlgorithm to signal.
15. If document stops being [fully active](https://html.spec.whatwg.org/multipage/document-sequences.html#fully-active), [abort the credential request](#dfn-abort-the-credential-request) with an
    "[`AbortError`](https://webidl.spec.whatwg.org/#aborterror)" [`DOMException`](https://webidl.spec.whatwg.org/#idl-DOMException).
16. Let handled be the result of running [handle virtual wallet behavior](#dfn-handle-virtual-wallet-behavior) given promise and global.
17. If handled is `true`, return promise.
18. [Initiate the credential request](#dfn-initiate-the-credential-request)
    with document, validatedRequests, promise, and signal.
19. Return promise.

### 6.3 Filter credential requests

To filter credential
requests given a sequence of [`DigitalCredentialGetRequest`](#dom-digitalcredentialgetrequest) or
[`DigitalCredentialCreateRequest`](#dom-digitalcredentialcreaterequest) objects requests:

1. Let supportedRequests be a new empty [list](https://infra.spec.whatwg.org/#list).
2. [For each](https://infra.spec.whatwg.org/#list-iterate) request of requests:
   1. Let protocol be the result of running [convert request protocol](#dfn-convert-request-protocol) given request.
   2. If protocol is failure, [continue](https://infra.spec.whatwg.org/#iteration-continue).
   3. If [user agent allows protocol](#dfn-user-agent-allows-protocol) given protocol returns
      `false`, [continue](https://infra.spec.whatwg.org/#iteration-continue).
   4. [Append](https://infra.spec.whatwg.org/#list-append) request to supportedRequests.
3. Return supportedRequests.

Note

Filtering happens before [consuming user activation](https://html.spec.whatwg.org/multipage/interaction.html#consume-user-activation) so that a request whose protocols are all unsupported is
rejected with a [`TypeError`](https://webidl.spec.whatwg.org/#exceptiondef-typeerror) without consuming the user activation.
Subsequent validation in [validate credential requests](#dfn-validate-credential-requests) can safely assume all remaining requests use
supported protocols.

### 6.4 Validate credential requests

To validate credential
requests given a sequence of [`DigitalCredentialGetRequest`](#dom-digitalcredentialgetrequest) or
[`DigitalCredentialCreateRequest`](#dom-digitalcredentialcreaterequest) objects requests:

1. Let validatedRequests be a new empty [list](https://infra.spec.whatwg.org/#list).
2. [For each](https://infra.spec.whatwg.org/#list-iterate) request of requests:
   1. Let data be request's [`data`](#dom-digitalcredentialgetrequest-data),
      if request is a [`DigitalCredentialGetRequest`](#dom-digitalcredentialgetrequest), or request's
      [`data`](#dom-digitalcredentialcreaterequest-data), if request is a
      [`DigitalCredentialCreateRequest`](#dom-digitalcredentialcreaterequest).
   2. [Serialize](https://infra.spec.whatwg.org/#serialize-a-javascript-value-to-a-json-string)
      data to a JSON string.
   3. If serialization results in an [exception](https://webidl.spec.whatwg.org/#dfn-exception), [throw](https://webidl.spec.whatwg.org/#dfn-throw)
      that [exception](https://webidl.spec.whatwg.org/#dfn-exception).
   4. Validate request's [presentation request data](#dfn-presentation-request-data) or [issuance request data](#dfn-issuance-request-data) according to
      request's [presentation protocol](#dfn-presentation-protocol) or [issuance protocol](#dfn-issuance-protocol) or other criteria.

      In addition to protocol-defined requirements, a [user agent](https://infra.spec.whatwg.org/#user-agent)
      might apply validation criteria based on local policy,
      configuration, or the user's choices. For example, a [user agent](https://infra.spec.whatwg.org/#user-agent) might reject a request that seeks particular credential
      attributes.

      What constitutes a validation failure is protocol-specific, but
      how such a failure is classified into an exception type is
      defined below:

      Note: Protocol-specific validation details

      Validation includes verifying request's [presentation request data](#dfn-presentation-request-data) or [issuance request data](#dfn-issuance-request-data) conforms to the requirements
      of the specified [presentation protocol](#dfn-presentation-protocol)
      or [issuance protocol](#dfn-issuance-protocol). Please refer to
      the specification of the specific [presentation protocol](#dfn-presentation-protocol) or [issuance protocol](#dfn-issuance-protocol) for details, including potential
      reasons for validation failure, and any security and privacy
      considerations that need to be considered by implementers
      during validation.

      1. If validation fails:
         1. Let error be determined as follows:

            The [user agent](https://infra.spec.whatwg.org/#user-agent) does not permit the request based on local policy, configuration, or the user's choices:
            :   A [created](https://webidl.spec.whatwg.org/#dfn-create-exception) "[`NotAllowedError`](https://webidl.spec.whatwg.org/#notallowederror)"
                [`DOMException`](https://webidl.spec.whatwg.org/#idl-DOMException).

                Note

                "[`NotAllowedError`](https://webidl.spec.whatwg.org/#notallowederror)" is deliberately
                indistinguishable from the error returned when the
                user cancels the operation, so that a website cannot
                determine whether a request was refused by the user
                or by the [user agent](https://infra.spec.whatwg.org/#user-agent), nor infer anything about
                the user's configuration or credentials.

            The request is not permitted for security reasons unrelated to the user, such as the context or transport:
            :   A [created](https://webidl.spec.whatwg.org/#dfn-create-exception) "[`SecurityError`](https://webidl.spec.whatwg.org/#securityerror)"
                [`DOMException`](https://webidl.spec.whatwg.org/#idl-DOMException).

            The request data is malformed or invalid:
            :   A [created](https://webidl.spec.whatwg.org/#dfn-create-exception) [`TypeError`](https://webidl.spec.whatwg.org/#exceptiondef-typeerror).

            Otherwise:
            :   A [created](https://webidl.spec.whatwg.org/#dfn-create-exception) "[`OperationError`](https://webidl.spec.whatwg.org/#operationerror)"
                [`DOMException`](https://webidl.spec.whatwg.org/#idl-DOMException).
         2. [Throw](https://webidl.spec.whatwg.org/#dfn-throw) error.
      2. Otherwise, [append](https://infra.spec.whatwg.org/#list-append) request to validatedRequests.
3. Return validatedRequests.

### 6.5 Abort the credential request

To abort the
credential request given a JavaScript value error:

1. If the [credential request coordinator](#dfn-credential-request-coordinator)'s [active promise](#dfn-active-promise) is `null`, return.
2. Let activePromise be the [credential request coordinator](#dfn-credential-request-coordinator)'s
   [active promise](#dfn-active-promise).
3. If the [credential request coordinator](#dfn-credential-request-coordinator) is in the "[requesting](#dfn-requesting)" [interaction state](#dfn-interaction-states):
   1. Set the [credential request coordinator](#dfn-credential-request-coordinator) [interaction state](#dfn-interaction-states) to "[aborting](#dfn-aborting)".
   2. Dismiss the [digital credential chooser](#dfn-digital-credential-chooser) or [credential manager chooser](#dfn-credential-manager-chooser).

      Note

      Dismissal can fail (e.g., if the [digital credential chooser](#dfn-digital-credential-chooser)
      was destroyed due to memory pressure), but the [coordinator](#dfn-credential-request-coordinator)
      proceeds to complete the credential request regardless.
4. [Reject the credential request with](#dfn-reject-the-credential-request-with)
   error and activePromise.

### 6.6 Reject the credential request

To reject the
credential request with a (JavaScript Value) error and a
[`Promise`](https://webidl.spec.whatwg.org/#idl-promise) promise:

1. [Assert](https://infra.spec.whatwg.org/#assert): the [credential request coordinator](#dfn-credential-request-coordinator)'s [active promise](#dfn-active-promise) is promise.
2. [Queue a global task](https://html.spec.whatwg.org/multipage/webappapis.html#queue-a-global-task) on the [DOM manipulation task source](https://html.spec.whatwg.org/multipage/webappapis.html#dom-manipulation-task-source) given
   promise's [relevant global object](https://html.spec.whatwg.org/multipage/webappapis.html#concept-relevant-global) to perform the following steps:
   1. If the [credential request coordinator](#dfn-credential-request-coordinator)'s [active promise](#dfn-active-promise) is not promise, then return.
   2. Let signal be the [credential request coordinator](#dfn-credential-request-coordinator)'s
      [abort signal](#dfn-abort-signal).
   3. Let abortAlgorithm be the [credential request coordinator](#dfn-credential-request-coordinator)'s
      [abort algorithm](#dfn-abort-algorithm).
   4. If signal is not `null` and abortAlgorithm is not `null`:
      1. [Remove](https://dom.spec.whatwg.org/#abortsignal-remove) abortAlgorithm from signal.
   5. Set the [credential request coordinator](#dfn-credential-request-coordinator)'s [abort signal](#dfn-abort-signal) to `null`.
   6. Set the [credential request coordinator](#dfn-credential-request-coordinator)'s [abort algorithm](#dfn-abort-algorithm) to `null`.
   7. [Reject](https://webidl.spec.whatwg.org/#reject) promise with error.
   8. Set the [credential request coordinator](#dfn-credential-request-coordinator)'s [active promise](#dfn-active-promise) to `null`.
   9. Set the [credential request coordinator](#dfn-credential-request-coordinator) [interaction state](#dfn-interaction-states) to "[idle](#dfn-idle)".

### 6.7 Initiate the credential request

To initiate the
credential request given a [Document](https://dom.spec.whatwg.org/#concept-document) document, a [list](https://infra.spec.whatwg.org/#list) of
validated credential requests validatedRequests, a [`Promise`](https://webidl.spec.whatwg.org/#idl-promise)
promise, and an optional [`AbortSignal`](https://dom.spec.whatwg.org/#abortsignal) signal:

1. Let topLevelOrigin be document's [top-level traversable](https://html.spec.whatwg.org/multipage/document-sequences.html#top-level-traversable)'s
   [active document](https://html.spec.whatwg.org/multipage/document-sequences.html#nav-document)'s [relevant settings object](https://html.spec.whatwg.org/multipage/webappapis.html#relevant-settings-object)'s
   [origin](https://html.spec.whatwg.org/multipage/webappapis.html#concept-settings-object-origin).
2. Let requestData be a new [request context](#dfn-request-context) whose [requests](#dfn-requests) is validatedRequests and [top-level origin](#dfn-top-level-origin) is topLevelOrigin.
3. [In parallel](https://html.spec.whatwg.org/multipage/infrastructure.html#in-parallel):
   1. Display a [digital credential chooser](#dfn-digital-credential-chooser) with requestData and
      wait for one of the following outcomes:
      * The user selects a [digital credential](#dfn-digital-credential) or [holder](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) that
        can fulfill the request.
      * The user cancels the operation.
      * The platform encounters an error.

      When a [user agent](https://infra.spec.whatwg.org/#user-agent) communicates with a [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager)
      located on a different device, it is *RECOMMENDED* that the [user agent](https://infra.spec.whatwg.org/#user-agent) use [Client to Authenticator Protocol (CTAP)](https://fidoalliance.org/specs/fido-v2.3-ps-20260226/fido-client-to-authenticator-protocol-v2.3-ps-20260226.html).
   2. If signal is not null and signal is [aborted](https://dom.spec.whatwg.org/#abortsignal-aborted):
      1. Return.

         Note: Abort already handled

         The abort algorithm [added](https://dom.spec.whatwg.org/#abortsignal-add) to signal by
         the [prepare credential requests](#dfn-prepare-credential-requests) steps handles tearing down the [digital credential chooser](#dfn-digital-credential-chooser).
   3. If the user cancels the operation or no credential was selected:
      1. Let error be a newly created "[`NotAllowedError`](https://webidl.spec.whatwg.org/#notallowederror)"
         [`DOMException`](https://webidl.spec.whatwg.org/#idl-DOMException).
      2. [Reject the credential request with](#dfn-reject-the-credential-request-with) error and promise.
      3. Return.
   4. If the platform returns a platform-specific error:
      1. Let error be determined as follows:

         The user agent or platform does not permit the operation:
         :   A newly created "[`NotAllowedError`](https://webidl.spec.whatwg.org/#notallowederror)" [`DOMException`](https://webidl.spec.whatwg.org/#idl-DOMException).

         The request data is malformed or invalid:
         :   A newly created [`TypeError`](https://webidl.spec.whatwg.org/#exceptiondef-typeerror).

         A credential request is already in progress:
         :   A newly created "[`InvalidStateError`](https://webidl.spec.whatwg.org/#invalidstateerror)" [`DOMException`](https://webidl.spec.whatwg.org/#idl-DOMException).

         Otherwise:
         :   A newly created "[`OperationError`](https://webidl.spec.whatwg.org/#operationerror)" [`DOMException`](https://webidl.spec.whatwg.org/#idl-DOMException).
      2. [Reject the credential request with](#dfn-reject-the-credential-request-with) error and promise.
      3. Return.
   5. If a [digital credential](#dfn-digital-credential) was selected by the user:
      1. Let protocol be the [protocol identifier](#dfn-protocol-identifier) returned by the [digital credential chooser](#dfn-digital-credential-chooser) for
         this exchange.

         Note: Protocol is determined by the platform

         The [digital credential chooser](#dfn-digital-credential-chooser) or underlying platform
         determines which item in validatedRequests to forward to a
         [holder](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) and returns the [protocol identifier](#dfn-protocol-identifier) for that exchange. The user agent does not
         necessarily know which specific item was selected.
      2. Let responseData be a [string](https://infra.spec.whatwg.org/#string) [presentation response](#dfn-presentation-response) or [string](https://infra.spec.whatwg.org/#string) [issuance response](#dfn-issuance-response) returned by the [holder](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders).

         Note: Why the response is a string

         The response is a string because the user agent is
         responsible for parsing it into a JavaScript object in the
         correct realm, verifying it is valid JSON, and confirming the
         parsed value is an object, as required by the
         [`data`](#dom-digitalcredential-data) attribute.
      3. [Queue a global task](https://html.spec.whatwg.org/multipage/webappapis.html#queue-a-global-task) on the [DOM manipulation task source](https://html.spec.whatwg.org/multipage/webappapis.html#dom-manipulation-task-source) given document's [relevant global object](https://html.spec.whatwg.org/multipage/webappapis.html#concept-relevant-global) to perform
         the following steps:
         1. If the [credential request coordinator](#dfn-credential-request-coordinator)'s [active promise](#dfn-active-promise) is not promise, then
            return.
         2. Let parsedResponseDataOrError be the result of [parse a JSON string to a JavaScript value](https://infra.spec.whatwg.org/#parse-a-json-string-to-a-javascript-value) given responseData.
         3. Let abortSignal be the [credential request coordinator](#dfn-credential-request-coordinator)'s [abort signal](#dfn-abort-signal).
         4. Let abortAlgorithm be the [credential request coordinator](#dfn-credential-request-coordinator)'s [abort algorithm](#dfn-abort-algorithm).
         5. If abortSignal is not `null` and abortAlgorithm is
            not `null`, [Remove](https://dom.spec.whatwg.org/#abortsignal-remove) abortAlgorithm from
            abortSignal.
         6. Set the [credential request coordinator](#dfn-credential-request-coordinator)'s [abort signal](#dfn-abort-signal) to `null`.
         7. Set the [credential request coordinator](#dfn-credential-request-coordinator)'s [abort algorithm](#dfn-abort-algorithm) to `null`.
         8. If parsedResponseDataOrError is an [exception](https://webidl.spec.whatwg.org/#dfn-exception):
            1. [Reject](https://webidl.spec.whatwg.org/#reject) promise with
               parsedResponseDataOrError.
         9. Otherwise, if parsedResponseDataOrError is not an
            [object](https://html.spec.whatwg.org/multipage/iframe-embed-object.html#the-object-element):
            1. [Reject](https://webidl.spec.whatwg.org/#reject) promise with a newly created
               [`TypeError`](https://webidl.spec.whatwg.org/#exceptiondef-typeerror).
         10. Otherwise:
             1. Let credential be a newly created
                [`DigitalCredential`](#dom-digitalcredential) instance with its
                [`data`](#dom-digitalcredential-data) initialized to
                parsedResponseDataOrError and its
                [`protocol`](#dom-digitalcredential-protocol) initialized to protocol.
             2. [Resolve](https://webidl.spec.whatwg.org/#resolve) promise with credential.
         11. Set the [credential request coordinator](#dfn-credential-request-coordinator)'s [active promise](#dfn-active-promise) to `null`.
         12. Set the [credential request coordinator](#dfn-credential-request-coordinator) [interaction state](#dfn-interaction-states) to "[idle](#dfn-idle)".

## 7. The Digital Credentials API

The [Digital Credentials API](#DC-API) leverages the
[Credential Management Level 1](https://www.w3.org/TR/credential-management-1/) specification, allowing [user agents](https://infra.spec.whatwg.org/#user-agent) to
mediate the [issuance](#dfn-issuance-request) and [presentation](#dfn-presentation-request) of [digital credentials](#dfn-digital-credential).

The API allows [requesting](#dfn-presentation-request) a
[digital credential](#dfn-digital-credential) from the user agent, which in turn presents a
[digital credential chooser](#dfn-digital-credential-chooser) to the user, allowing them to select a
[digital credential](#dfn-digital-credential) that can fulfill the request. This is done by the
website calling the
`navigator.credentials.`[`get`](https://www.w3.org/TR/credential-management-1/#dom-credentialscontainer-get)`()` method, which runs
the [request a `Credential`](https://www.w3.org/TR/credential-management-1/#abstract-opdef-request-a-credential) algorithm of [Credential Management Level 1](https://www.w3.org/TR/credential-management-1/).
That algorithm then calls back into this specification's
[`DigitalCredential`](#dom-digitalcredential) interface's
[`[[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors)`](#dfn-discoverfromexternalsource-origin-options-sameoriginwithancestors) internal method.

Additionally, the API also allows [requesting issuance](#dfn-issuance-request) of a [digital credential](#dfn-digital-credential), which in turn
presents a [credential manager chooser](#dfn-credential-manager-chooser) to the user, allowing them to
select a [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager) to save the [digital credential](#dfn-digital-credential). This
is done by calling the
`navigator.credentials.`[`create`](https://www.w3.org/TR/credential-management-1/#dom-credentialscontainer-create)`()` method, which
runs the [create a credential](https://www.w3.org/TR/credential-management-1/#abstract-opdef-create-a-credential) algorithm of
[Credential Management Level 1](https://www.w3.org/TR/credential-management-1/). That algorithm then calls back into this
specification's [`DigitalCredential`](#dom-digitalcredential) interface's
[`[[Create]](origin, options, sameOriginWithAncestors)`](https://www.w3.org/TR/credential-management-1/#dom-credential-create-slot)
internal method.

[Digital credential issuance](#dfn-issuance-request) via
this API differs slightly from digital credential presentation. The
response data contains the protocol-specific response from the holder's
[credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager), as defined by the issuance protocol, and does not
represent the actual issued digital credential itself.

Please see [Credential Management
Integration](#credential-management-integration) for complete details of how to integrate with the
[Credential Management Level 1](https://www.w3.org/TR/credential-management-1/) specification.

### 7.1 Extensions to `CredentialRequestOptions` dictionary

```
WebIDLpartial dictionary CredentialRequestOptions {
  DigitalCredentialRequestOptions digital;
};
```

#### 7.1.1 The `digital` member

The `digital` member
allows for options to configure the request for a [digital credential](#dfn-digital-credential).

### 7.2 The `DigitalCredentialRequestOptions` dictionary

```
WebIDLdictionary DigitalCredentialRequestOptions {
  required sequence<DigitalCredentialGetRequest> requests;
};
```

#### 7.2.1 The `requests` member

The `requests`
specify an [presentation protocol](#dfn-presentation-protocol) and [presentation request data](#dfn-presentation-request-data), which the user agent *MAY* match
against a [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager), such as a digital wallet.

### 7.3 The `DigitalCredentialGetRequest` dictionary

The [`DigitalCredentialGetRequest`](#dom-digitalcredentialgetrequest) dictionary represents a [presentation request](#dfn-presentation-request). It is used to specify an [presentation protocol](#dfn-presentation-protocol) and some [presentation request data](#dfn-presentation-request-data), which the user agent *MAY* match
against a [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager), such as a digital wallet.

```
WebIDLdictionary DigitalCredentialGetRequest {
  required DOMString protocol;
  required object data;
};
```

#### 7.3.1 The `protocol` member

The `protocol` member
denotes the [presentation protocol](#dfn-presentation-protocol).

The [`protocol`](#dom-digitalcredentialgetrequest-protocol) member's value is one of the
[protocol identifiers](#dfn-protocol-identifier) defined in
[`DigitalCredentialPresentationProtocol`](#dom-digitalcredentialpresentationprotocol).

#### 7.3.2 The `data` member

The `data` member is
the [presentation request data](#dfn-presentation-request-data) to be handled by the
[holder's](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager), such as a digital identity wallet.

### 7.4 Extensions to `CredentialCreationOptions` dictionary

```
WebIDLpartial dictionary CredentialCreationOptions {
  DigitalCredentialCreationOptions digital;
};
```

#### 7.4.1 The `digital` member

The `digital` member
allows for options to configure the issuance of a [digital credential](#dfn-digital-credential).

### 7.5 The `DigitalCredentialCreationOptions` dictionary

```
WebIDLdictionary DigitalCredentialCreationOptions {
  required sequence<DigitalCredentialCreateRequest> requests;
};
```

#### 7.5.1 The `requests` member

The `requests`
specify an [issuance protocol](#dfn-issuance-protocol) and [issuance request data](#dfn-issuance-request-data), which the user agent *MAY* forward to a
[holder](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders).

### 7.6 The `DigitalCredentialCreateRequest` dictionary

The [`DigitalCredentialCreateRequest`](#dom-digitalcredentialcreaterequest) dictionary represents an [issuance request](#dfn-issuance-request). It is used to specify an [issuance protocol](#dfn-issuance-protocol) and some [issuance request data](#dfn-issuance-request-data), to communicate the issuance request between the
[issuer](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers) and the [holder](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders).

```
WebIDLdictionary DigitalCredentialCreateRequest {
  required DOMString protocol;
  required object data;
};
```

#### 7.6.1 The `protocol` member

The `protocol`
member denotes the [issuance protocol](#dfn-issuance-protocol).

The [`protocol`](#dom-digitalcredentialcreaterequest-protocol) member's value is one of
the [protocol identifiers](#dfn-protocol-identifier) defined in
[`DigitalCredentialIssuanceProtocol`](#dom-digitalcredentialissuanceprotocol).

#### 7.6.2 The `data` member

The `data` member
is the [issuance request data](#dfn-issuance-request-data) to be handled by the
[holder's](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager), such as a digital identity wallet.

### 7.7 The `DigitalCredential` interface

The `DigitalCredential` interface represents a conceptual
[digital credential](#dfn-digital-credential).

The [`DigitalCredential`](#dom-digitalcredential) interface mandates [user mediation](https://www.w3.org/TR/credential-management-1/#user-mediated) for all
operations to ensure user control and consent.

To simplify the developer experience of [`get`](https://www.w3.org/TR/credential-management-1/#dom-credentialscontainer-get)`()`
calls involving a [`DigitalCredential`](#dom-digitalcredential), [user agents](https://infra.spec.whatwg.org/#user-agent) *MUST NOT* throw
an error if the [`mediation`](https://www.w3.org/TR/credential-management-1/#dom-credentialrequestoptions-mediation) member is absent
or has a value other than "[`required`](https://www.w3.org/TR/credential-management-1/#dom-credentialmediationrequirement-required)".
Similarly, in [`create`](https://www.w3.org/TR/credential-management-1/#dom-credentialscontainer-create)`()` calls involving a
[`DigitalCredential`](#dom-digitalcredential), [user agents](https://infra.spec.whatwg.org/#user-agent) *MUST NOT* throw an error if the
[`mediation`](https://www.w3.org/TR/credential-management-1/#dom-credentialcreationoptions-mediation) member is absent or has a value
other than "[`required`](https://www.w3.org/TR/credential-management-1/#dom-credentialmediationrequirement-required)". This makes
"[`required`](https://www.w3.org/TR/credential-management-1/#dom-credentialmediationrequirement-required)" mediation an implicit and
non-overridable behavior of the [API](#DC-API).

```
WebIDLtypedef (DigitalCredentialPresentationProtocol or DigitalCredentialIssuanceProtocol) DigitalCredentialProtocol;

[Exposed=Window, SecureContext]
interface DigitalCredential : Credential {
  [Default] object toJSON();
  readonly attribute DigitalCredentialProtocol protocol;
  [SameObject] readonly attribute object data;
  static boolean userAgentAllowsProtocol(DOMString protocol);
};
```

[`DigitalCredential`](#dom-digitalcredential) instances are [origin bound](https://www.w3.org/TR/credential-management-1/#credential-origin-bound).

#### 7.7.1 The `protocol` member

The `protocol` member is the
[presentation protocol](#dfn-presentation-protocol) that was used to request the
[digital credential](#dfn-digital-credential), or the [issuance protocol](#dfn-issuance-protocol)
that was used to issue the [digital credential](#dfn-digital-credential).

#### 7.7.2 The `data` member

The `data` member is the
credential's response data. It contains the subset of JSON-parseable
object types.

#### 7.7.3 The `userAgentAllowsProtocol()` method

The [`userAgentAllowsProtocol`](#dom-digitalcredential-useragentallowsprotocol)`()` method allows digital
credential [verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) to determine which [presentation protocols](#dfn-presentation-protocol) and [issuance protocols](#dfn-issuance-protocol) the user agent allows.

Note

This method does not convey [presentation protocol](#dfn-presentation-protocol)
or [issuance protocol](#dfn-issuance-protocol) support in the underlying
OS/platform.

User agents *MUST NOT* vary the response value based on any information
about availability of hardware, presence or configuration of software,
[credential managers](https://www.w3.org/TR/credential-management-1/#credential-manager), or digital credentials, or user configuration or
preferences. If the response value varied, the user agent would introduce
risks both of fingerprinting and of silently revealing other details
about user behavior or configuration. The response value *SHOULD* vary only
by user agent major version and indicate whether the browser supports
distributing requests with that protocol to underlying platform or
provider.

To check whether a user agent allows protocol given a
[`DOMString`](https://webidl.spec.whatwg.org/#idl-DOMString) protocol, take the following steps:

1. If protocol is not an [enumeration value](https://webidl.spec.whatwg.org/#dfn-enumeration-value) of
   [`DigitalCredentialProtocol`](#dom-digitalcredentialprotocol), return `false`.
2. Return `true` if the user agent allows protocol, otherwise return
   `false`.

When this method is invoked, the user agent *MUST* return the result of
[user agent allows protocol](#dfn-user-agent-allows-protocol) given protocol.

### 7.8 Supporting Data Structures

Data structures, such as enumerations, which support
[`DigitalCredential`](#dom-digitalcredential) in this specification.

#### 7.8.1 The request context struct

A request context is a [struct](https://infra.spec.whatwg.org/#struct) with the following
[items](https://infra.spec.whatwg.org/#struct-item):

requests
:   A [list](https://infra.spec.whatwg.org/#list) of validated [credential requests](#dfn-credential-request).

top-level origin
:   An [environment settings object](https://html.spec.whatwg.org/multipage/webappapis.html#environment-settings-object)'s [origin](https://html.spec.whatwg.org/multipage/webappapis.html#concept-settings-object-origin).

#### 7.8.2 The [`DigitalCredentialPresentationProtocol`](#dom-digitalcredentialpresentationprotocol) enumeration

This enumeration's values correspond to the supported [presentation protocols](#dfn-presentation-protocol) listed in [5.
Protocols](#protocols).

```
WebIDLenum DigitalCredentialPresentationProtocol {
  "openid4vp-v1-unsigned",
  "openid4vp-v1-signed",
  "openid4vp-v1-multisigned",
  "org-iso-mdoc"
};
```

#### 7.8.3 The [`DigitalCredentialIssuanceProtocol`](#dom-digitalcredentialissuanceprotocol) enumeration

This enumeration's values correspond to the supported [issuance protocols](#dfn-issuance-protocol) listed in [5.
Protocols](#protocols).

```
WebIDLenum DigitalCredentialIssuanceProtocol {
  "openid4vci-v1",
};
```

## 8. Integration with [Credential Management Level 1](https://www.w3.org/TR/credential-management-1/)

### 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method

When invoked, the [[DiscoverFromExternalSource]](origin, options,
sameOriginWithAncestors) internal method, if the user agent doesn't
support [presentation requests](#dfn-presentation-request) (e.g., the platform
cannot provide a [digital credential chooser](#dfn-digital-credential-chooser)), call the default
implementation of [`Credential`](https://www.w3.org/TR/credential-management-1/#credential)'s
[`[[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors)`](https://www.w3.org/TR/credential-management-1/#dom-credential-discoverfromexternalsource-slot) internal method with the same arguments.
Otherwise:

1. Let requests be options's [`digital`](#dom-credentialrequestoptions-digital)'s
   [`requests`](#dom-digitalcredentialrequestoptions-requests) member.
2. Set requests to the result of [filter credential requests](#dfn-filter-credential-requests) given requests.
3. If requests [is empty](https://infra.spec.whatwg.org/#list-is-empty), return [a promise rejected with](https://webidl.spec.whatwg.org/#a-promise-rejected-with) a
   newly created [`TypeError`](https://webidl.spec.whatwg.org/#exceptiondef-typeerror).
4. Let signal be options's [`signal`](https://www.w3.org/TR/credential-management-1/#dom-credentialrequestoptions-signal), if
   present.
5. Let global be [this](https://webidl.spec.whatwg.org/#this)'s [relevant global object](https://html.spec.whatwg.org/multipage/webappapis.html#concept-relevant-global).
6. Return the result of [prepare credential requests](#dfn-prepare-credential-requests) given global, origin, requests, and signal.

### 8.2 [[Store]](credential, sameOriginWithAncestors) internal method

When invoked, the [[Store]](credential, sameOriginWithAncestors)
*MUST* call the default implementation of [`Credential`](https://www.w3.org/TR/credential-management-1/#credential)'s
[`[[Store]](credential, sameOriginWithAncestors)`](https://www.w3.org/TR/credential-management-1/#dom-credential-store-slot) internal
method with the same arguments.

### 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method

When invoked, the [[Create]](origin, options,
sameOriginWithAncestors) internal method, if the user agent doesn't
support [issuance requests](#dfn-issuance-request), call the default
implementation of [`Credential`](https://www.w3.org/TR/credential-management-1/#credential)'s [`[[Create]](origin, options, sameOriginWithAncestors)`](https://www.w3.org/TR/credential-management-1/#dom-credential-create-slot) internal method with the same
arguments. Otherwise:

1. Let requests be options's [`digital`](#dom-credentialcreationoptions-digital)'s
   [`requests`](#dom-digitalcredentialcreationoptions-requests) member.
2. Set requests to the result of [filter credential requests](#dfn-filter-credential-requests) given requests.
3. If requests [is empty](https://infra.spec.whatwg.org/#list-is-empty), return [a promise rejected with](https://webidl.spec.whatwg.org/#a-promise-rejected-with) a
   newly created [`TypeError`](https://webidl.spec.whatwg.org/#exceptiondef-typeerror).
4. Let signal be options's [`signal`](https://www.w3.org/TR/credential-management-1/#dom-credentialcreationoptions-signal), if
   present.
5. Let global be [this](https://webidl.spec.whatwg.org/#this)'s [relevant global object](https://html.spec.whatwg.org/multipage/webappapis.html#concept-relevant-global).
6. Return the result of [prepare credential requests](#dfn-prepare-credential-requests) given global, origin, requests, and signal.

### 8.4 [[type]] internal slot

The [`DigitalCredential`](#dom-digitalcredential) [interface object](https://webidl.spec.whatwg.org/#dfn-interface-object) has an internal slot named
[[type]]
whose value is "digital".

### 8.5 [[discovery]] internal slot

The [`DigitalCredential`](#dom-digitalcredential) [interface object](https://webidl.spec.whatwg.org/#dfn-interface-object) has an internal slot named
[[discovery]]
whose value is "remote".

### 8.6 User permission

*This section is non-normative.*

The [Digital Credentials API](#DC-API) is a [powerful feature](https://www.w3.org/TR/permissions/#dfn-powerful-feature) that
requires [express permission](https://www.w3.org/TR/permissions/#dfn-express-permission) from an end-user. This requirement is
normatively enforced when calling [`CredentialsContainer`](https://www.w3.org/TR/credential-management-1/#credentialscontainer)'s
[`get`](https://www.w3.org/TR/credential-management-1/#dom-credentialscontainer-get)`()` method.

## 9. Permissions Policy integration

This specification defines two [policy-controlled features](https://www.w3.org/TR/permissions-policy-1/#policy-controlled-feature):

"digital-credentials-get"
:   A [policy-controlled feature](https://www.w3.org/TR/permissions-policy-1/#policy-controlled-feature) that allows a [document](https://dom.spec.whatwg.org/#concept-document) to
    [request](#dfn-presentation-request) digital
    credentials. Its [default allowlists](https://www.w3.org/TR/permissions-policy-1/#policy-controlled-feature-default-allowlist) is
    ['self'](https://www.w3.org/TR/permissions-policy-1/#default-allowlist-self). The [request a `Credential`](https://www.w3.org/TR/credential-management-1/#abstract-opdef-request-a-credential)
    algorithm serves as the policy enforcement point.

"digital-credentials-create"
:   A [policy-controlled feature](https://www.w3.org/TR/permissions-policy-1/#policy-controlled-feature) that allows a [document](https://dom.spec.whatwg.org/#concept-document) to
    [issue](#dfn-issuance-request) digital credentials.
    Its [default allowlists](https://www.w3.org/TR/permissions-policy-1/#policy-controlled-feature-default-allowlist) is ['self'](https://www.w3.org/TR/permissions-policy-1/#default-allowlist-self). The [create a `Credential`](https://www.w3.org/TR/credential-management-1/#abstract-opdef-create-a-credential) algorithm serves as
    the policy enforcement point.

## 10. Security Considerations

*This section is non-normative.*

The sections that follow describe the API's security properties, the
threats in scope, the assumptions on which security depends, and
residual threats that remain after the mitigations are applied. This
specification defines requirements for the user agent's behavior only
when mediating [credential responses](#dfn-credential-response).

Note

Other security considerations that depend on protocols, credential
manager implementations, operating systems, or transport security are
described as expectations or preconditions, but these are not
normatively required by this specification unless already normatively
specified.

### 10.1 Threat Model

The threat model for this specification includes threats to this API
and to adjacent standards of the ecosystem.

For this specification, threats fall into two categories: [in-scope threats](#dfn-in-scope-threats) and [out-of-scope threats](#dfn-out-of-scope-threats).

#### 10.1.1 In-Scope Threats

In-Scope Threats are introduced or addressed by the DC API
itself. The following are [in-scope threats](#dfn-in-scope-threats) for this specification:

Request Tampering
:   A network attacker that can inject or modify page content in an
    insecure context attempts to alter a [`DigitalCredentialGetRequest`](#dom-digitalcredentialgetrequest)
    or [`DigitalCredentialCreateRequest`](#dom-digitalcredentialcreaterequest) before processing.

API Flooding
:   A malicious website attempts to overwhelm the API by making rapid,
    repeated requests to exhaust system resources, confuse the user,
    create unnecessary credential interactions, or cause prompt fatigue
    that degrades user experience. This includes making requests at
    inappropriate times, such as during page load or without meaningful
    user context.

Unauthorized Cross-Origin Access
:   A malicious website attempts to request or issue digital credentials
    through embedded third-party content, such as an `[iframe](https://html.spec.whatwg.org/multipage/iframe-embed-object.html#the-iframe-element)`, without
    explicit permission from the embedding site, potentially enabling
    credential harvesting or unauthorized access to sensitive user data.

Malicious Payloads to the Underlying Platform
:   A malicious website attempts to exploit vulnerabilities in the
    underlying operating system or [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager) by passing
    carefully crafted or malformed protocol requests through the API.

#### 10.1.2 Out of Scope Threats

Out-of-scope threats are those handled by protocols,
[credential managers](https://www.w3.org/TR/credential-management-1/#credential-manager), OS platform security, or transport layers.
Even if "out of scope", they are relevant because they influence the
end-to-end security of credential presentation and issuance. The
following defines the [out-of-scope threats](#dfn-out-of-scope-threats) for this specification:

OS or Device Compromise
:   An attacker who gains control over the user's operating system or
    device hardware could bypass [user agent](https://infra.spec.whatwg.org/#user-agent) protections, extract
    sensitive credential data directly from storage, or manipulate the
    API calls. This threat is addressed by OS platform security and
    hardware-backed keystores.

Malicious Credential Managers
:   A user might install, or be coerced by institutional mandate or
    essential services to use, a [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager) that
    intentionally leaks data, fails to securely encrypt credentials, or
    ignores user consent. While the API protects users prior to wallet
    selection through explicit user permission (see
    [11.6
    User Permission and Transparency](#user-permission-and-transparency)), it cannot govern the
    internal behavior of a [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager) once the user
    authorizes it to handle a request. Mitigating this risk relies on OS
    platform security, app store vetting, and legal/regulatory frameworks
    governing wallet providers.

Protocol and Format Vulnerabilities
:   Weaknesses in the specific [presentation protocol](#dfn-presentation-protocol), [issuance protocol](#dfn-issuance-protocol), or credential
    format being used (e.g., cryptographic flaws, unsafe algorithms, lack
    of replay protection, or missing request authentication) could allow
    attackers to intercept, forge, or tamper with credentials in transit.
    Mitigation occurs primarily at the protocol, format, and transport
    layers (e.g., mandating response encryption, request signing, and
    TLS). While the API does not define format-specific cryptography or
    inspect protocol payloads for cryptographic safety, it enforces
    baseline security criteria on supported protocols (such as requiring
    [response encryption](#encrypting-credential-responses) and
    encouraging [signed requests](#signing-presentation-requests)) to
    steer requests through the most secure path.

### 10.2 Mitigations

The following mitigations address [in-scope threats](#dfn-in-scope-threats) through
normative requirements in the specification.

WebIDL [interfaces](https://webidl.spec.whatwg.org/#dfn-interface) of the Digital Credential API are only exposed in
[secure contexts](https://html.spec.whatwg.org/multipage/webappapis.html#secure-context), reducing the risk of [tampering](#dfn-request-tampering) through
[insecure contexts](https://html.spec.whatwg.org/multipage/webappapis.html#secure-context) (e.g., a malicious script being
injected through the network). Please refer to the
[§ 5 Security Considerations](https://www.w3.org/TR/secure-contexts/#security-considerations) section of the
[Secure Contexts](https://www.w3.org/TR/secure-contexts/) specification for more information.

To mitigate the risk of [malicious payloads to the underlying platform](#dfn-malicious-payloads-to-the-underlying-platform), [user agents](https://infra.spec.whatwg.org/#user-agent) pass request parameters to the [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager) using [JSON serialization](https://infra.spec.whatwg.org/#serialize-a-javascript-value-to-a-json-string) (see [validate credential requests](#dfn-validate-credential-requests)). The underlying platform and [credential managers](https://www.w3.org/TR/credential-management-1/#credential-manager) are responsible for robustly parsing and validating these
protocol-specific JSON payloads before acting on them.

The Digital Credentials API reduces [API flooding](#dfn-api-flooding) through two
mechanisms:

* **Transient activation:** Both
  [`[[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors)`](#dfn-discoverfromexternalsource-origin-options-sameoriginwithancestors) and [`[[Create]](origin, options, sameOriginWithAncestors)`](#dfn-create-origin-options-sameoriginwithancestors) methods [Consume user activation](https://html.spec.whatwg.org/multipage/interaction.html#consume-user-activation), preventing automated or repeated requests without user
  interaction.
* **Always required mediation:** The API makes [user mediation](https://www.w3.org/TR/credential-management-1/#user-mediated) implicitly "[`required`](https://www.w3.org/TR/credential-management-1/#dom-credentialmediationrequirement-required)"
  (see [the DigitalCredential
  interface](#the-digitalcredential-interface)), ensuring that user permission is obtained through the
  platform's credential chooser interface for every credential
  operation.

For additional guidance on preventing abuse of credential requests,
please refer to the section
[§ 7 Privacy Considerations](https://www.w3.org/TR/credential-management-1/#privacy-considerations) of the
[Credential Management Level 1](https://www.w3.org/TR/credential-management-1/) specification. Note, however, that these
protections have limitations, as sites may still employ dark patterns
to encourage unnecessary user interactions that trigger credential
requests.

The Digital Credentials API reduces [cross-origin abuse](#dfn-unauthorized-cross-origin-access) through integration with
[Permissions Policy](https://www.w3.org/TR/permissions-policy-1/) (see [Permissions Policy
Integration](#permissions-policy)). The [request a `Credential`](https://www.w3.org/TR/credential-management-1/#abstract-opdef-request-a-credential) and [create a `Credential`](https://www.w3.org/TR/credential-management-1/#abstract-opdef-create-a-credential) algorithms respectively serve as policy enforcement
points for the ["digital-credentials-get"](#dfn-digital-credentials-get) and
["digital-credentials-create"](#dfn-digital-credentials-create) [policy-controlled features](https://www.w3.org/TR/permissions-policy-1/#policy-controlled-feature). The
two features are intentionally separate: a site may enable
["digital-credentials-get"](#dfn-digital-credentials-get) without enabling
["digital-credentials-create"](#dfn-digital-credentials-create), and vice versa, limiting each
embedded context to only the capability it requires. Please refer to
section [Permissions Policy](https://www.w3.org/TR/permissions-policy-1/#privacy-and-security) of the
[Permissions Policy](https://www.w3.org/TR/permissions-policy-1/) specification for additional security
properties provided by this integration.

Additionally, requests from an [opaque origin](https://html.spec.whatwg.org/multipage/browsers.html#concept-origin-opaque) are rejected. Because
[`DigitalCredential`](#dom-digitalcredential) instances are [origin bound](https://www.w3.org/TR/credential-management-1/#credential-origin-bound), calls
to request or create digital credentials from an [opaque origin](https://html.spec.whatwg.org/multipage/browsers.html#concept-origin-opaque) (for
example, a `data:` document, or a document sandboxed without
`allow-same-origin`) are rejected by [Credential Management Level 1](https://www.w3.org/TR/credential-management-1/),
reducing the risk of malicious extraction or spoofing from untrusted
environments.

### 10.3 Signing presentation requests

Where a [presentation protocol](#dfn-presentation-protocol) offers a way to
sign a request, a [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) is strongly encouraged to use it.

An unsigned request can be altered by a script running in the
verifier's own page, such as one injected by a malicious browser
extension. That script can change what is being asked for, turning a
narrow request into a demand for much more, and it can replace the
parameters used to [encrypt the
response](#encrypting-credential-responses) so that the response is encrypted to the attacker rather
than to the verifier. Requiring the API to be used in a [secure context](https://html.spec.whatwg.org/multipage/webappapis.html#secure-context) does not prevent this, because the attacker is already
inside one. With an unsigned request, the [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager) has
to trust that the verifier has kept its own page free of such
scripts. A signed request, on the other hand, gives the [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager) something to check, so the change can be detected instead
of passing unnoticed.

Even at that, signing only helps if the [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager) can
tell that the signature belongs to the verifier making the request. A
script inside the page can re-sign an altered request with a key of
its own, so a signature offers no protection against this attacker
unless it can be checked against a signing key that is already
recognized as the verifier's. Which signing keys to accept, and how
they are established, is decided by the ecosystem a credential
belongs to rather than by this specification, and the protection a
signed request actually offers depends on that decision. Beyond
protecting against same-device in-page tampering, request signing
also provides critical defense-in-depth when presenting credentials
across multiple devices (see
[10.4
Cross-Device Security and Proximity](#cross-device-security-and-proximity)).

### 10.4 Cross-Device Security and Proximity

The Digital Credentials API supports cross-device experiences where a
user presents a [digital credential](#dfn-digital-credential) from a secondary device, such
as a smartphone acting as a [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager), to a primary
device, such as a laptop. Although the specific data exchange
protocols (e.g., cryptographic formats and transports) are out of
scope for this API, such cross-device interactions typically rely on
established protocols like the Client to Authenticator Protocol
(CTAP) ([Client to Authenticator Protocol (CTAP)](https://fidoalliance.org/specs/fido-v2.3-ps-20260226/fido-client-to-authenticator-protocol-v2.3-ps-20260226.html)).

These protocols ensure security by establishing cryptographically
secure channels and enforcing physical proximity (e.g., via Bluetooth
Low Energy) to mitigate remote relay attacks. Crucially, in a
cross-device flow, the [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager) cannot inherently trust
the [origin](https://html.spec.whatwg.org/multipage/browsers.html#concept-origin) string forwarded by the primary device, as the primary
device or its browser might be compromised. Therefore, protocols that
employ signed requests, where the [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) cryptographically
proves its identity, provide significantly stronger security
assurances than relying solely on the browser-asserted [origin](https://html.spec.whatwg.org/multipage/browsers.html#concept-origin).

## 11. Privacy Considerations

*This section is non-normative.*

Issue: Privacy Considerations section is a work in progress

This section is a work in progress as this document evolves.

The Digital Credentials API integrates into a complex ecosystem with
multiple technology layers and various participants (including but not
limited to [verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier), [holders](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders), and [issuers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers)), each of which
have to consider different aspects of user privacy. This specification
does not attempt to exhaustively list all considerations for the
different participants. We would like to refer these parties to a
variety of other resources that explore the digital credentials threat
model more holistically:

* [User considerations for credentials on the Web](https://github.com/w3c/credential-considerations/blob/main/credentials-considerations.md)
* [Threat Model for Decentralized Credentials](https://www.w3.org/TR/threat-model-decentralized-credentials/)
* [§ 8 Privacy Considerations](https://www.w3.org/TR/vc-data-model-2.0/#privacy-considerations) of the
  [Verifiable Credentials Data Model v2.0](https://www.w3.org/TR/vc-data-model-2.0/) specification.
* [Preventing Abuse of Digital Credentials](https://www.w3.org/2001/tag/doc/prevent-credential-abuse/)

Instead, these considerations focus on the Digital Credentials API
itself, and describe how [user agents](https://infra.spec.whatwg.org/#user-agent) can satisfy their [user agent duties](https://www.w3.org/TR/privacy-principles/#dfn-user-agent-duties) in an implementation of the API, taking into account the
relevant privacy properties of the ecosystem it interacts with.

The privacy considerations for digital credentials are not static. They
will evolve over time as the ecosystem matures, and may be informed by
the behavior of other actors in the ecosystem, improvements in other
layers of the stack, new threats to user privacy, as well as changing
societal norms and regulations.

It is expected that the various groups involved in the design and
implementation of the Digital Credentials API actively monitor the
evolving privacy landscape and participate in the corresponding
evolution of the API.

### 11.1 Design Considerations and Alternatives

The Digital Credentials API is designed to mediate requests for
digital credentials from websites, being agnostic to the credential
format and the information contained in it, as well as the protocol
used to exchange it. This and other key design choices are derived
from the goal of providing a more secure and private credential
exchange experience for users than the existing alternatives (e.g.,
[[custom-schemes](#bib-custom-schemes "Concerns with custom schemes for identity presentment")]), that is still compatible with common exchange
protocols for ease of adoption.

The API provides the connection interface between [verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) and
[holders](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders), i.e. the means by which a [credential presentation protocol](#dfn-presentation-protocol)
is initiated and the user switches to the [holder](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) application to
select a credential. Solutions that have been used for this purpose
in the past include QR codes and custom URL schemes. As documented in
[Presenting Credentials on the Web](https://docs.google.com/document/d/1Ppaz_EnhzHqPOz5UusRJvbSunh-RXPWgJ3Np_TM2EE0/) and [Concerns with custom schemes for identity presentment](https://github.com/w3c-fedid/digital-credentials/blob/main/custom-schemes.md),
those solutions have security, privacy, and accessibility concerns.

With adoption of digital credential technology being driven by
ecosystem demand and regulatory mandates, the Web platform offers an
alternative to the aforementioned less-desirable technologies that is
easy to use for developers, is compatible with existing credential
[presentation protocols](#dfn-presentation-protocol) and, most importantly,
has better user privacy, security, and accessibility properties for
users than the aforementioned alternatives.

The Digital Credentials API offers the [user agent](https://infra.spec.whatwg.org/#user-agent) the ability to
intermediate on behalf of the user (e.g. in the form of a [digital credential chooser](#dfn-digital-credential-chooser) or a [credential manager chooser](#dfn-credential-manager-chooser)) to
contextualize requests and
[prevent
immediate exposure to holder applications](#permission-prior-to-credential-manager-selection). It also enforces
certain minimum requirements on supported protocols, such as
[response encryption](#encrypting-credential-responses).

Note

The Digital Credentials API is not intended to inhibit the
development of other standardized solutions that enhance user
privacy. For example, an API could be standardized that more strictly
enforces unlinkability for specific purposes such as age
verification. Higher-level, designed-for-purpose APIs often enable
[purpose limitation](https://www.w3.org/TR/privacy-principles/#purpose-limitation), ease
of explanation to the user, and privacy and security protections from
[user agents](https://infra.spec.whatwg.org/#user-agent).

### 11.2 Spectrum of Privacy

The Digital Credentials API serves a variety of use cases with
different grades of data disclosure and individual users with
different preferences depending on the context that they are in.
Notably, the privacy properties of a credential exchange mediated by
this API could be mandated by the legal and regulatory environment of
an individual user.

This means that some users might not want, or be allowed, to use the
most privacy-preserving means of exchanging credential information.
Nonetheless, [user agents](https://infra.spec.whatwg.org/#user-agent) need to serve users with an experience
that is private by default and protect them from harm.

Because of this spectrum of preferences and use cases, it can be
difficult for a [user agent](https://infra.spec.whatwg.org/#user-agent) to discern whether a user means to
expose their personal information or is being tricked into doing so.
It is thus the [user agent](https://infra.spec.whatwg.org/#user-agent)'s responsibility to ensure that every
user understands what data they are sharing and who will participate
in the exchange of information, before the exchange begins.

### 11.3 Presentation Protocol and Credential Format

Because the Digital Credentials API sits at the center of an exchange
that involves multiple independent parties, the [presentation protocol](#dfn-presentation-protocol) and credential format used by
these parties for exchanging user information are crucial to the
[user agent](https://infra.spec.whatwg.org/#user-agent)'s goal of protecting user privacy.

#### 11.3.1 Presentation Protocol Considerations for User Privacy

[Issue 255](https://github.com/w3c-fedid/digital-credentials/issues/255): Define concrete privacy and security requirements for the supported protocols [privacy-tracker](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22privacy-tracker%22)[security-tracker](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22security-tracker%22)[registry](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22registry%22)[privacy-considerations](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22privacy-considerations%22)[security-considerations](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22security-considerations%22)

There are two requirements for protocols that I think need further elaboration:

> MUST have undergone privacy review [...]

And

> MUST have undergone security review [...]

Technically, a review saying "this protocol is awful in every way" satisfies these criteria.

It would be more useful if there were a set of concrete privacy and security requirements that a protocol needed to satisfy, such a review would be able to say whether a standard was achieved or not. It might be the case that there are subjective elements to a review, but there should also be a minimum bar that each protocol needs to clear.

This goes beyond the present set of requirements in the current [inclusion criteria](https://w3c-fedid.github.io/digital-credentials/#general-inclusion-criteria). I don't have a comprehensive list to hand, but one should be possible to develop. And once developed, that list should be in the spec. For instance, does the protocol depend on [phoning home](https://nophonehome.com/)? Does the protocol (or the formats it conveys) guarantee unlinkability of presentations? Or - given that unlinkability doesn't make sense for some use cases - under what conditions does the API require the protocol provide unlinkability? What sort of transparency affordances does the protocol include? What sorts of covert channels are acceptable?

##### 11.3.1.1 Selective disclosure

[Selective
disclosure](https://github.com/w3c/credential-considerations/blob/main/credentials-considerations.md#selective-disclosure) is a fundamental technique for
[data minimization](https://www.w3.org/TR/privacy-principles/#data-minimization) that
allows [holders](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) to share the minimum required information that is
requested by a [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier). Protocols are expected to facilitate
selective disclosure by allowing the [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) to specify the
exact claims needed.

##### 11.3.1.2 Unlinkable presentations

[Unlinkability](https://github.com/w3c/credential-considerations/blob/main/credentials-considerations.md#unlinkable-presentations)
is a property that ensures that, if a user presents attributes from a
credential multiple times, [verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) cannot link these separate
presentations to conclude they concern the same user
(verifier-verifier linkability), or that [verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) cannot collude
with [issuers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers) to report the exchange of a credential from a
[credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager) to the [issuer](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers) (verifier-issuer
linkability). The former is a property that can be maintained by the
[holder](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) and [issuer](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers), e.g. through issuing fresh credentials for
individual [verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier).

While the latter is achievable, e.g. through
[zero-knowledge proofs](https://www.w3.org/TR/vc-data-model-2.0/#zero-knowledge-proofs),
design choices of the API such as encrypted responses make it
impossible for a [user agent](https://infra.spec.whatwg.org/#user-agent) to prove that verifier-issuer
unlinkability was achieved in practice. Nonetheless, protocols are
requested to limit linkability wherever possible.

Note that unlinkability is exclusively a consideration for attributes
that cannot be linked to a specific user identity. Inherently
linkable attributes such as names, driver's license numbers, or phone
numbers do not benefit from unlinkability.

Through the Digital Credentials API, the [user agent](https://infra.spec.whatwg.org/#user-agent) can help
[verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) and [credential managers](https://www.w3.org/TR/credential-management-1/#credential-manager) exchange unlinkable
attributes, but, because of response encryption, it cannot guarantee
that no linkable information is passed between [verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) and
[credential managers](https://www.w3.org/TR/credential-management-1/#credential-manager). It is recommended that [user agents](https://infra.spec.whatwg.org/#user-agent)
account for this fact in their user permission experience.

[Issue 279](https://github.com/w3c-fedid/digital-credentials/issues/279): Linkability and issuer involvement as a protocol requirement [privacy-tracker](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22privacy-tracker%22)

Which level of unlinkability is the goal for this API? Can we
normatively enforce support for any particular unlinkability
features?

##### 11.3.1.3 "Phone home" mechanisms

["Phoning home"](https://github.com/w3c/credential-considerations/blob/main/credentials-considerations.md#no-phoning-home) refers
to scenarios where the presentation or verification of a digital
credential causes a notification or communication back to the
[issuer](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers) or another central entity, which can lead to tracking and
profiling of individuals.

Similar to unlinkability, it is impossible for [user agents](https://infra.spec.whatwg.org/#user-agent) to
ensure that an [issuer](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers) isn't actively involved in the creation or
validation of credential presentations after a user has given
permission to proceed with a credential request. From that point on,
the [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager) owns this decision. While some credential
managers can be considered [user agents](https://infra.spec.whatwg.org/#user-agent), it is generally
recommended that the [user agent](https://infra.spec.whatwg.org/#user-agent) implementing the
[Digital Credentials API](#DC-API) designs its permission
experience to prevent
[exposure of a
request to the credential manager](#permission-prior-to-credential-manager-selection) before user confirmation
(keeping in mind [considerations for
integrating multiple cooperating user agents](#multiple-user-agents)).

Protocols are required to support mechanisms that allow [issuers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers),
[credential managers](https://www.w3.org/TR/credential-management-1/#credential-manager), and [verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) to avoid or reduce the
dependence on "phone home" mechanisms.

[Issue 279](https://github.com/w3c-fedid/digital-credentials/issues/279): Linkability and issuer involvement as a protocol requirement [privacy-tracker](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22privacy-tracker%22)

Which level of unlinkability is the goal for this API? To what degree
can the spec mandate restrictions to [issuer](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers) involvement?

##### 11.3.1.4 Unlinkable revocation

A common instance of [issuer](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers) involvement in a credential exchange
is for credential revocation checks. This is particularly challenging
when presentations are intended to be verifier-issuer unlinkable.
When credential presentations are made unlinkable through the use of
e.g. [zero-knowledge proofs](https://www.w3.org/TR/vc-data-model-2.0/#zero-knowledge-proofs),
the credential formats used in protocols are expected to support
offline revocation methods such as [Cryptographic
Accumulators](https://eprint.iacr.org/2024/657.pdf). It is further expected that protocol design and
specification discourages the involvement of [verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) for the
purpose of revocation where possible.

[Issue 280](https://github.com/w3c-fedid/digital-credentials/issues/280): Can we require protocols to support unlinkable revocation? [privacy-tracker](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22privacy-tracker%22)[registry](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22registry%22)

We should discuss whether unlinkable revocation techniques are
practical enough to be required normatively.

##### 11.3.1.5 Support for user transparency, permission and consent

User understanding and participation are non-negotiable properties of
a credential presentation. The protocol is expected to help all
involved parties enable user participation by providing the
information vital for informed permission and/or consent.

##### 11.3.1.6 Support for verifier authorization

Verifier authorization refers to the process by which a [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier)
proves its identity and demonstrates that it is legitimately entitled
to request specific attributes or credentials. This is particularly
useful when exchanging sensitive data, such as from government-issued
credentials. Verifier authorization can limit unnecessary or abusive
credential requests, and ensure that a [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier)'s access is
restricted to the specific credential attributes it registered for.

Checking verifier authorization is usually handled by the
[credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager), but [user agents](https://infra.spec.whatwg.org/#user-agent) could find the presence
of such a scheme helpful in preventing API abuse and designing a
well-informed user permission experience.

[Issue 281](https://github.com/w3c-fedid/digital-credentials/issues/281): User agents that only support authorized verifiers (for government credentials) [privacy-tracker](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22privacy-tracker%22)

Should we require protocols to include provisions that allow [user agents](https://infra.spec.whatwg.org/#user-agent) to understand verifier authorization?

##### 11.3.1.7 Encrypting credential responses

To prevent exposure of user information to other parties in
"transit", for example browser extensions loaded on [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier)
pages, and to encourage secure storage of user credentials by the
[verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier), protocols are required to support and mandate encrypted
responses in a credential exchange.

[Issue 109](https://github.com/w3c-fedid/digital-credentials/issues/109): Should response encryption be required [discussion](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22discussion%22)[pending closure](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22pending+closure%22)[privacy-tracker](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22privacy-tracker%22)[security-tracker](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22security-tracker%22)

Related to [#49](https://github.com/w3c-fedid/digital-credentials/issues/49) and several other discussions we've had: do we want to say that the response must always be encrypted (and if so, by which algorithms), or are we OK leaving that as optional?

### 11.4 Unnecessary Requests for Credentials

Unnecessary credential requests are a key privacy risk to the entire
digital credentials ecosystem. They could manifest in different ways
and from different motivations:

* Intentional abuse of the API to learn sensitive information about
  the user for the purpose of fraud, tracking, or sale of the data. For
  example, a site could trick a user into sharing their passport
  information through misleading content. This can lead to identity
  theft and financial loss, and severe loss of control and/or leakage
  of personal information.
* Unnecessary requests for credentials without the explicit intent
  of user harm, such as an online store requesting users to sign up
  with their driver's license instead of generic email & passkey or
  federated credentials. This can lead to
  [exclusion](https://www.w3.org/reports/identity-web-impact#opportunities-and-threats) of
  users without the ability or willingness to share such a credential
  with the site, a deterioration of the prompt experience on the web,
  and an increase in the risk of accidental data leakage.
* Requests for an excessive amount of information for valid
  purposes against the principle of data minimization. A common example
  is collection of a user's entire national identity document for age
  verification instead of relying on selective disclosure and age
  predicates.

One challenge here is determining what constitutes "valid" purposes
and which requests are therefore "unnecessary", and requires
participation from all parties involved in the credential exchange.

* Ideally, [verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) would self-regulate their requests for
  credentials. However, from a [user agent](https://infra.spec.whatwg.org/#user-agent)'s perspective,
  [verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) are potential attackers, and might not consider the
  user's best interest in their designs. The Digital Credentials API
  operates from an assumption that all [verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) might have
  incentives that motivate unnecessary requests and abuse, and protect
  users accordingly.
* [User agents](https://infra.spec.whatwg.org/#user-agent) are responsible for protecting their users
  against dangerous content and permission requests on the Web and
  could intervene on their behalf, proactively rejecting requests or
  requiring pre-authorization. To support this, this specification
  requires credential requests to be readable by the [user agent](https://infra.spec.whatwg.org/#user-agent)
  (i.e., not end-to-end encrypted to the [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier), see
  [5.
  Protocols](#protocols) and [6.2
  Prepare credential requests](#prepare-credential-requests)).
* [Issuers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers) and lawmakers might decide to restrict use of
  (particularly government-issued) credentials to specific
  [verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) with purpose attestations. [Credential managers](https://www.w3.org/TR/credential-management-1/#credential-manager)
  might be expected to enforce these restrictions by law or policy.
* The ultimate decision of whether or not to share their personal
  information lies with the user, which is why the API [requires](#dfn-initiate-the-credential-request) the
  [user agent](https://infra.spec.whatwg.org/#user-agent) to present a credential picker to the user, and other
  parties might additionally require confirmation or consent.

For a more detailed exploration of how to determine and address
unnecessary usage, it makes sense to consider government-issued
credentials and other credentials separately, as they potentially
differ in the sensitivity of their data and the potential harms from
misuse as well as legal & regulatory considerations.

A key component of risk mitigation and ensuring user control that
applies to both types of credentials is the [user agent](https://infra.spec.whatwg.org/#user-agent)'s ability
to inspect the credential request metadata and make decisions or UI
presentation based on it. This specification ensures this [user agent](https://infra.spec.whatwg.org/#user-agent) access through protocol requirements to transmit requests
unencrypted and include relevant information (see [5.
Protocols](#protocols)
and [6.2
Prepare credential requests](#prepare-credential-requests)).

#### 11.4.1 Government-issued credentials

[Government-issued
digital credentials](https://www.w3.org/reports/identity-web-impact#pure-digital-credentials) include travel documents, personal licenses,
proof of welfare and public health programs, vehicle registrations,
and other documents issued by government authorities, or other
documents representing this information. These documents are highly
sensitive, as they can contain permanent, irrevocable, unique
identifiers that are central to a person's individual identity and
ability to interact with vital public services.

##### 11.4.1.1 Risk of theft and leakage of government credentials

The high value of these credentials to users and attackers means
there is a significant risk of theft, and significant potential harm
from leakage to unauthorized third parties. This includes the request
of government identity for the purpose of tracking and
personalization.

##### 11.4.1.2 Risk of proliferation of requests for government credentials

A major concern with increased availability of government credentials
online is [Jevon's Paradox](https://en.wikipedia.org/wiki/Jevons_paradox),
i.e., the chance of increasing demand for credentials through lower
friction of access. This effect is not inherently caused by the
Digital Credentials API, but rather the overall increasing adoption
of digital credentials across the ecosystem, which, however, would
likely see additional momentum from [user agent](https://infra.spec.whatwg.org/#user-agent) implementation of
the Digital Credentials API. As such, the effect needs to be
considered by [user agents](https://infra.spec.whatwg.org/#user-agent) implementing the API, as it might
result in harmful outcomes for users:

* Increased risk of information leakage, and ultimately a less
  trusted user experience on the Web. When a large number of services
  access and store government-issued credentials in an insecure manner
  (i.e. not maintaining encryption or failing to safeguard private
  keys), the chance of data leaks and unauthorized access increases as
  well. Even seemingly non-identifying information like birthdates and
  postal codes, when combined, can statistically identify an
  individual.
* Prompt fatigue and a loss in trust by users when they are
  prompted by a large number of websites to share personal information.
* Increased potential for [surveillance](https://www.rfc-editor.org/info/rfc6973/#section-5.1.1)
  and restrictions on pseudonymous use of online services. Collusion
  between [verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) and [issuers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers), or other parties, might result
  in the ability to closely monitor a user's activity on the Web and
  take adverse action against this individual. Even when no action is
  taken, the possibility of surveillance alone can cause anxiety,
  discomfort, and behavioral changes such as inhibition and
  self-censorship, impacting individual autonomy and freedom of
  expression.
* [Exclusion
  and discrimination](https://github.com/w3c/credential-considerations/blob/main/credentials-considerations.md#restrictions-of-free-expression) of individuals who cannot, or do not want to,
  provide these credentials, prohibiting them from participation in
  services that would previously not require government-issued
  credentials, such as forums and social media platforms on the Web.

##### 11.4.1.3 Mitigating unnecessary requests for government credentials

The outlined risks of government-issued digital credentials present a
challenge that cannot be solved by a single participant in the
ecosystem, and will require a broader policy discussion within
individual sovereign nations about the risks and benefits of
accessing online services through real-world credentials.

It is desirable that a government that issues digital credentials
also enact laws and regulations that clearly define how and for what
purposes those credentials are able to be used. All parties involved
in the exchange, whether they are legally obliged to do so or not,
are advised to support any government [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) authentication
schemes, if they exist. The support for (and integration of)
[verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) authentication schemes such as [EUDI access and registration certificates](https://github.com/eu-digital-identity-wallet/eudi-doc-architecture-and-reference-framework/blob/main/docs/annexes/annex-2/annex-2-high-level-requirements.md#a2327-topic-27---registration-of-pid-providers-providers-of-qeaas-pub-eaas-and-non-qualified-eaas-and-relying-parties) can mitigate risks of
proliferation of unnecessary credential requests. However, the
presence of such schemes is not guaranteed, which significantly
increases the risk in a credential exchange.

There are other practical steps that [user agents](https://infra.spec.whatwg.org/#user-agent) implementing the
Digital Credentials API can take to reduce risk, increase user
understanding, and prevent certain types of harm:

* Only supporting protocols that enable selective disclosure and
  other techniques of data minimization can reduce the impact and
  likelihood of information leakage, and provide better context to
  users in permission and consent flows.
* Support for protocols that allow unlinkability mechanisms such as
  [Zero-Knowledge Proofs](https://www.w3.org/TR/vc-data-model-2.0/#zero-knowledge-proofs) can
  prevent [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier)-based surveillance and potential discrimination,
  by hiding the [issuer](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers).
* Offering useful context and a clearly understandable permission
  flow will help users make better decisions on whether or not to
  accept a credential exchange, which can reduce the viability of
  exchange requests that are made without a concrete user need.

It is further critical that [user agents](https://infra.spec.whatwg.org/#user-agent) design a permission
experience that accounts for the lack of these mitigations, e.g., the
exchange of personal information from government credentials without
any [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) authentication scheme. It is recommended that a
higher level of friction and clear user messaging that highlights the
involved risk be applied to these types of exchanges.

#### 11.4.2 Non-government-issued credentials

Non-government-issued credentials include all other digital
documents, certificates, and attestations that are not
government-issued and don't represent government-issued documents.
This could include proof of employment, (non-government) education
credentials, or cinema tickets. Notably, their exchange is likely
less restricted by laws and regulations. While these documents often
don't exhibit the same risks as government-issued credentials, they
could also contain identifiable or sensitive information.

##### 11.4.2.1 Risk of theft and leakage of non-government credentials

The impact and viability of credential theft and leakage of
non-government credentials is largely based on the content of each
individual credential type. In general, it could lead to loss of
control and exposure of sensitive private information, as well as
impersonation and data theft, which can increase the likelihood of
further attacks on the affected individual.

##### 11.4.2.2 Risk of proliferation of requests for non-government credentials

The flexibility and lack of regulation of non-government credentials
carries potential for abuse for the purpose of cross-site tracking
and linking identities through long-lived identifiers, such as email
address or phone number. [Verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) participating in a tracking
scheme based on digital credentials could create user incentives to
accept sharing identifier credentials across many sites ("loyalty
cards" for the Web), without fully understanding the implications on
their privacy.

Even users unwilling to share their information in such a scheme
could be affected by prompt fatigue and potentially risk exclusion
from using these services.

##### 11.4.2.3 Mitigating unnecessary requests for non-government credentials

For non-government-issued credentials, it is recommended that the
[user agent](https://infra.spec.whatwg.org/#user-agent) understand the requested credential format and its
privacy attributes, and build a risk framework that informs the
context that is shown to the user, as well as the amount of friction
that is appropriate for each credential type. Protocols and formats
involved in the exchange of these credentials are generally expected
to support features such as selective disclosure and unlinkability,
but these features might not always be appropriate or necessary in
the exchange of information, especially when it concerns low-risk
credentials such as cinema tickets.

A [user agent](https://infra.spec.whatwg.org/#user-agent) that recognizes the type of credential being
requested is encouraged to customize its permission experience to
best suit the requested credential and help users understand the
consequences of sharing it.

[User agents](https://infra.spec.whatwg.org/#user-agent) cannot be expected to understand all credential
requests. A [user agent](https://infra.spec.whatwg.org/#user-agent) that does not recognize the type of
credential being requested is advised to significantly increase user
friction in their permission experience, and clearly communicate the
risks of sharing unknown credentials with websites to the user. Note
that this could require integration between
[different user agents](#multiple-user-agents) to apply
appropriate levels of friction and transparency. For example, a
browser might delegate knowledge about credential requests to the
operating system, which might require [credential managers](https://www.w3.org/TR/credential-management-1/#credential-manager) to
register known credential types and reject an exchange request for an
unknown credential type.

[Issue 100](https://github.com/w3c-fedid/digital-credentials/issues/100): Consider applying the robustness principle with regard to user agent request validation [discussion](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22discussion%22)[privacy-considerations](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22privacy-considerations%22)

The need to provide users with appropriate transparency conflicts
with the desire to enable the ecosystem to develop new credential
formats without explicit [user agent](https://infra.spec.whatwg.org/#user-agent) buy-in.

##### 11.4.2.4 Reporting abuse

[Issue 267](https://github.com/w3c-fedid/digital-credentials/issues/267): reporting abuse of credential requests [privacy-tracker](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22privacy-tracker%22)[privacy-considerations](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22privacy-considerations%22)

Consider an interoperable abuse reporting system for [verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier)
making unnecessary and abusive requests.

### 11.5 Fingerprinting and Data Leakage

#### 11.5.1 Browser fingerprinting

While the API ensures that no user data is ever shared without a
permission prompt (see the [[[#user-permission-and-transparency|User
Permission and Transparency]] section), the longevity and uniqueness
of real-world identifiers that are likely to be returned by the
Digital Credentials API make it a potential target for trackers and
fingerprinters.

Even with selective disclosure, attackers might combine data from a
digital credential (such as the user's age, or the credential
[issuer](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers), timestamps; see the [[[#leaking-incidental-data|Leaking
Incidental Data]] section) to reidentify and/or fingerprint users.

This attack might be harder for third-party attackers (such as
scripts embedded on the [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier)'s pages but not actively
collaborating with them for the purpose of tracking) because response
encryption is mandatory and responses should be decrypted on the
[verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier)'s server. The [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) could thus ensure not to
reflect back decrypted information to client-side JavaScript. Not all
[verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) will choose to do so, however.

#### 11.5.2 Leaking incidental data with credential presentations

To ensure authenticity of a credential, its presentation to
[verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) generally includes more information than the content
the [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) is requesting access to. It will usually contain at
least a signature of the [issuer](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers) and the [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager),
and potentially other metadata.

This additional information could be used to reidentify and
fingerprint users, which is especially relevant when an otherwise
unlinkable presentation is made.

While the Digital Credentials API does not control the content of a
credential response, [user agents](https://infra.spec.whatwg.org/#user-agent) can help protect users against
this type of tracking through clearly highlighting which information
likely gets shared with the [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) beyond what was requested,
and, more broadly, by identifying and blocking fingerprinting through
the API by [verifiers](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier).

#### 11.5.3 Revealing device properties through protocol availability

The Digital Credentials API exposes information about which [presentation](#dfn-presentation-protocol) and [issuance](#dfn-issuance-protocol) protocols are supported by
the [user agent](https://infra.spec.whatwg.org/#user-agent) through
[`userAgentAllowsProtocol`](#dom-digitalcredential-useragentallowsprotocol)`()`. It mitigates browser
fingerprinting and revealing information about the user's device
configuration by not customizing its response based on, for example,
which [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager) applications are installed on a user's
device. The returned information is thus, at best, equivalent to a
[user agent](https://infra.spec.whatwg.org/#user-agent) version.

#### 11.5.4 Avoiding leaks of credential availability

The Digital Credentials API does not enable sites to learn whether a
credential is available without first going through a
[user permission flow](#user-permission-and-transparency).
Revealing the presence of credentials would be a risk to user
privacy, as the presence of a credential is personal information that
the user might not have preferred to share with the site, and, in
combination with other signals, could be used to identify the user
without their permission. It is also a risk to free expression, as
websites might increasingly start to demand the presentation of these
credentials from the user in order to access services, excluding
individuals who are unwilling to present credentials.

To ensure this protection is robust, errors returned by the API do
not leak information about the user's available credentials through
observable differences, such as distinct error types or timing
attacks. For example, rejecting a request because the user has no
matching credentials returns the same generic error as rejecting a
request because the user cancelled the prompt. Furthermore, to
prevent timing attacks without relying on artificial delays, [user agents](https://infra.spec.whatwg.org/#user-agent) present a user-facing dialog (such as an empty chooser or
notification) when no matching credentials are found, so that prompt
dismissal latency is indistinguishable from user cancellation.

### 11.6 User Permission and Transparency

Issue: Work in progress

The Digital Credentials API enables the sharing of highly personal,
sensitive, and at-risk user information with websites via
credentials, potentially granting the ability to track users online
and offline, through permanent, unique, irrevocable, cross-context
identifiers. It also reveals parts of the user's browsing activity as
well as their intent to identify to specific websites and/or
[credential managers](https://www.w3.org/TR/credential-management-1/#credential-manager). One crucial responsibility of the [user agent](https://infra.spec.whatwg.org/#user-agent) in a credential request is to gather permission from the user
to proceed with the exchange of information.

Important context details that are needed for a user to make an
informed decision about proceeding with a credential exchange include
the following:

* The origin of the [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) that requests the credential.
* The information that is being requested, or that would be
  revealed by responding to the request.
* Whether presenting this information will enable tracking.
* Which [credential managers](https://www.w3.org/TR/credential-management-1/#credential-manager) can be used to fulfill the
  credential request.
* Which credential would be used to share the requested
  information.

It is advised that [user agents](https://infra.spec.whatwg.org/#user-agent) in their implementation ensure
that the details listed are fully disclosed to the user before an
exchange of any user-related information occurs.

[Issue 252](https://github.com/w3c-fedid/digital-credentials/issues/252): Should we normatively define elements of a permission prompt? [privacy-considerations](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22privacy-considerations%22)

Should these be normative in the spec?

[Issue 44](https://github.com/w3c-fedid/digital-credentials/issues/44): API requests should provide the site with what they need to explain why and how requested credential information will be used [enhancement](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22enhancement%22)[pending closure](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22pending+closure%22)[privacy-tracker](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22privacy-tracker%22)

Should the API be designed so the site can provide in-context
explanations?

#### 11.6.1 Handling multiple credential requests

[Issue 286](https://github.com/w3c-fedid/digital-credentials/issues/286): Privacy Considerations for multiple presentation requests (and responses) [privacy-tracker](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22privacy-tracker%22)[privacy-considerations](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22privacy-considerations%22)[v2](https://github.com/w3c-fedid/digital-credentials/issues/?q=is%3Aissue+is%3Aopen+label%3A%22v2%22)

We need to describe concerns, tradeoffs and possible mitigations of
handling multiple requests and responses for credential presentation.

#### 11.6.2 Integrating Multiple User Agents

Depending on the technical architecture of a user's system, it is
likely that the definition of a "[user agent](https://infra.spec.whatwg.org/#user-agent)" will include
multiple cooperating layers of the software stack, such as a browser
and the operating system. The greatest priority for these layers has
to be a safe and well-informed user permission experience. As such,
integration can be vital for user safety. Some layers may hold
information that is inaccessible by other layers, such as the
availability of a user's credentials. Overprompting or prompting
without sufficient context could lead to (exploitable) confusion and
prompt blindness.

For this reason, [user agents](https://infra.spec.whatwg.org/#user-agent) prompting for permission are
encouraged to integrate software layers for an ideal user experience,
if they consider it safe to do so. This could happen, for example, if
a browser trusts the API contract of an operating system to show an
appropriate prompt, and thus does not show a prompt itself.

#### 11.6.3 Permission Prior to Credential Manager Selection

As part of the user permission flow, the [user agent](https://infra.spec.whatwg.org/#user-agent) needs to
ensure that users retain the power to choose whether to forward a
credential request to a [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager), and which credential
manager to select. This is due to the information disclosure that
happens as part of the request, and the ability of credential
managers to retain or share this information at the time of the
request.

#### 11.6.4 Permission vs. Consent

The permission mediated by the [user agent](https://infra.spec.whatwg.org/#user-agent) is not consent, which
has specific legal definitions that can vary among different legal
and regulatory environments and may need to be collected by the
[credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager) before sharing information with the
[verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier), or by the [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) itself before initiating the
request. With frameworks and regulations for obtaining consent still
being developed, this API aims to enable the exchange of the
necessary information, which could include the following:

* The privacy policy of the [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) receiving the credential.
* The purpose for which the [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier) is requesting the
  information.
* What the information will be used for.
* How the information will be shared or retained.
* Any evaluations and attestations of this information, if
  available.
* Assertions of the [verifier](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier)'s legitimacy and registration for
  accessing the credential, such as [EUDI access and registration certificates](https://github.com/eu-digital-identity-wallet/eudi-doc-architecture-and-reference-framework/blob/main/docs/annexes/annex-2/annex-2-high-level-requirements.md#a2327-topic-27---registration-of-pid-providers-providers-of-qeaas-pub-eaas-and-non-qualified-eaas-and-relying-parties).

As more of this information becomes available in a structured format,
we expect [user agents](https://infra.spec.whatwg.org/#user-agent) and this specification to leverage it to
improve the user permission experience as well.

### 11.7 Data Clearing and Persistent State

The Digital Credentials API itself does not introduce new
browser-managed persistent state or local storage mechanisms. The
credentials requested through this API are stored and managed by
external [credential managers](https://www.w3.org/TR/credential-management-1/#credential-manager) or the operating system.
Consequently, when a user clears their browsing data (e.g., cookies
or local storage) for a given origin or globally, it generally does
not clear or affect the credentials held within those external
managers.

## 12. Accessibility Considerations

The user interface for selecting and authorizing a [digital credential](#dfn-digital-credential) is provided by the platform and is largely outside the
scope of this specification; however, the accessibility of that
experience is within scope (see [3.
Scope](#scope)). The following guidance
applies to [user agents](https://infra.spec.whatwg.org/#user-agent) and platforms implementing the [digital credential chooser](#dfn-digital-credential-chooser), [credential manager chooser](#dfn-credential-manager-chooser) and the flows
around them, and references the relevant success criteria of
[[WCAG22](#bib-wcag22 "Web Content Accessibility Guidelines (WCAG) 2.2")]. Where either chooser is a non-web user interface, those
criteria apply as described in [[WCAG2ICT-22](#bib-wcag2ict-22 "Guidance on Applying WCAG 2 to Non-Web Information and Communications Technologies (WCAG2ICT)")].

The content of modal dialogs presented during [issuance](#dfn-issuance-request) or [presentation](#dfn-presentation-request), which can include
text, QR codes, and other visual media, *SHOULD* be labelled and exposed
to assistive technologies with appropriate names, roles, and values
(see [§ Success Criterion 4.1.2 Name, Role, Value](https://www.w3.org/TR/WCAG22/#name-role-value)), and *SHOULD* provide text
alternatives for non-text content (see [§ Success Criterion 1.1.1 Non-text Content](https://www.w3.org/TR/WCAG22/#non-text-content)).

Changes in the state of an interaction, such as waiting for another
device, a successful response, an error, or a cancellation, *SHOULD* be
programmatically determinable and conveyed to assistive technologies
without requiring a change of focus (see [§ Success Criterion 4.1.3 Status Messages](https://www.w3.org/TR/WCAG22/#status-messages)).

When an operation fails, the [user agent](https://infra.spec.whatwg.org/#user-agent) rejects with one of several
distinct errors; for example, a "[`NotAllowedError`](https://webidl.spec.whatwg.org/#notallowederror)",
"[`InvalidStateError`](https://webidl.spec.whatwg.org/#invalidstateerror)", or "[`OperationError`](https://webidl.spec.whatwg.org/#operationerror)" [`DOMException`](https://webidl.spec.whatwg.org/#idl-DOMException), or a
[`TypeError`](https://webidl.spec.whatwg.org/#exceptiondef-typeerror). Where the platform surfaces such a failure to the user,
it *SHOULD* identify in text what went wrong and, where applicable, how
to recover, rather than only signalling that an error occurred (see
[§ Success Criterion 3.3.1 Error Identification](https://www.w3.org/TR/WCAG22/#error-identification)).

Interactive elements, particularly those that allow the user to
continue or abort an [issuance](#dfn-issuance-request)
or [presentation](#dfn-presentation-request) request,
*MUST* be operable in a device-independent manner (for example, via the
keyboard; see [§ Success Criterion 2.1.1 Keyboard](https://www.w3.org/TR/WCAG22/#keyboard)). In particular, activation *MUST NOT* require a multipoint or path-based gesture (see
[§ Success Criterion 2.5.1 Pointer Gestures](https://www.w3.org/TR/WCAG22/#pointer-gestures)) or device motion (see
[§ Success Criterion 2.5.4 Motion Actuation](https://www.w3.org/TR/WCAG22/#motion-actuation)) as the only means of operation. The
[digital credential chooser](#dfn-digital-credential-chooser) and [credential manager chooser](#dfn-credential-manager-chooser)
*SHOULD* present their controls in a meaningful focus order (see
[§ Success Criterion 2.4.3 Focus Order](https://www.w3.org/TR/WCAG22/#focus-order)), move focus into the chooser when it is
opened; keep focus within it while it is shown; and restore focus to
the previously focused element, or another appropriate location, when
it is closed.

Where releasing a [digital credential](#dfn-digital-credential) requires the [holder](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders) to
authenticate, an accessible authentication method *SHOULD* be available.
Where a step relies on a cognitive function test, such as recalling a
password, an alternative that does not require one *SHOULD* be offered
(see [§ Success Criterion 3.3.8 Accessible Authentication (Minimum)](https://www.w3.org/TR/WCAG22/#accessible-authentication-minimum)); and
authentication *SHOULD NOT* depend solely on a single physical
characteristic, such as a biometric, that some users cannot provide.
This step is typically performed by the platform or [credential manager](https://www.w3.org/TR/credential-management-1/#credential-manager) and is otherwise outside the scope of this specification.

Some platforms fulfil [presentation requests](#dfn-presentation-request)
across devices; for example, by displaying a QR code for the user to
scan with a separate device. Because such flows can depend on vision, a
camera, or the use of a second device, platforms *SHOULD* provide an
equivalent and accessible means of completing the interaction that does
not rely on a single sensory ability or input modality. A cross-device
request conveyed only through a visual artifact such as a QR code, with
no accessible alternative, excludes users who cannot use that modality.

An interaction may be subject to time limits from more than one source.
These *SHOULD* be handled so that users who need more time are not
excluded (see [§ Success Criterion 2.2.1 Timing Adjustable](https://www.w3.org/TR/WCAG22/#timing-adjustable)):

* A site can bound the interaction by passing an [`AbortSignal`](https://dom.spec.whatwg.org/#abortsignal) as
  [`signal`](https://www.w3.org/TR/credential-management-1/#dom-credentialrequestoptions-signal); for example, one created with
  `AbortSignal.timeout()`. Sites *SHOULD* allow sufficient time and *SHOULD NOT* impose a short limit that rushes the user.
* A proximity check is a security-essential, real-time constraint
  that cannot be extended without defeating its purpose. In this case,
  the platform *SHOULD* make the remaining time programmatically
  determinable, and *SHOULD* allow the user to retry the interaction.
* The validity window of a cross-device request *SHOULD* be extendable
  or able to be retried.

The decision to review and disclose a [digital credential](#dfn-digital-credential) *SHOULD NOT*
be subject to a forcing countdown, including time pressure inherited
from the surrounding site flow.

Human-readable credential content shown during an interaction, together
with any accessible alternatives for it such as text alternatives for
images, is carried within the credential payload and is the
responsibility of the relevant credential format and protocol. Those
formats and protocols also determine the language and direction of that
content.

## 13. Internationalization Considerations

*This section is non-normative.*

This API is agnostic to credential formats and exchange protocols, and
treats the request payloads ([`DigitalCredentialGetRequest`](#dom-digitalcredentialgetrequest)'s
[`data`](#dom-digitalcredentialgetrequest-data) and
[`DigitalCredentialCreateRequest`](#dom-digitalcredentialcreaterequest)'s
[`data`](#dom-digitalcredentialcreaterequest-data)) and the response payload
([`DigitalCredential`](#dom-digitalcredential)'s [`data`](#dom-digitalcredential-data)) as opaque. As a
result, the API defines no string-typed values that carry
human-readable, natural language content:

* The string-typed values it defines, most notably [protocol identifiers](#dfn-protocol-identifier), are restricted
  to ASCII ([ASCII lower alpha](https://infra.spec.whatwg.org/#ascii-lower-alpha), U+002D HYPHEN-MINUS, and [ASCII digit](https://infra.spec.whatwg.org/#ascii-digit)) and compared by exact equality. They are machine identifiers,
  not human-readable text, so normalization, case folding, and language
  or direction metadata do not apply.
* All payloads are exchanged as JSON text and JavaScript values. When
  a JSON string is encoded as bytes (for example, for transport), it is
  encoded using UTF-8. Request payloads are serialized using [serialize a JavaScript value to a JSON string](https://infra.spec.whatwg.org/#serialize-a-javascript-value-to-a-json-string), which calls the ECMAScript
  `JSON.stringify` operation, and responses are parsed using [parse a JSON string to a JavaScript value](https://infra.spec.whatwg.org/#parse-a-json-string-to-a-javascript-value). Because `JSON.stringify` emits
  lone (unpaired) surrogate code points as `\uXXXX` escape sequences, the
  serialized request is always well-formed, UTF-8-encodable JSON.
* Human-readable, localizable credential content (for example, the
  values of credential claims such as a name or address, including their
  representation in different scripts and languages) is carried opaquely
  within the credential payload. Its internationalization is determined
  by the relevant credential format and [presentation protocol](#dfn-presentation-protocol) or [issuance protocol](#dfn-issuance-protocol) (for example,
  the formats defined in [ISO/IEC 18013-5:2021 ISO-compliant driving licence, Part 5: Mobile driving licence (mDL) application](https://www.iso.org/standard/69084.html), and protocols such as
  [OpenID for Verifiable Presentations 1.0](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html)), which this specification expects to provide language
  and direction metadata, and localized alternatives, where appropriate.
* The one value the API routes to the platform that a [user agent](https://infra.spec.whatwg.org/#user-agent)
  may display is the requesting [top-level origin](#dfn-top-level-origin).
  Rendering an origin's host to the user, including the handling of
  internationalized domain names and bidirectional text, follows the
  [host-rendering guidance in the URL
  Standard](https://url.spec.whatwg.org/#url-rendering-i18n) and is out of scope for this specification.
* Any other text presented to the user during a credential
  interaction is rendered either by the website (using HTML, which
  provides language and direction support through the host language), or
  by the platform's [digital credential chooser](#dfn-digital-credential-chooser) and [credential manager chooser](#dfn-credential-manager-chooser). The choosers are out of scope for this
  specification; where they display credential content, the language and
  direction of that content, as provided by the credential format and
  protocol, govern its presentation.

Consequently, this specification introduces no natural language text
that requires language or direction metadata. Were a future revision to
introduce site-authored human-readable text at the API layer,
normatively defined permission prompt text, or a user-agent-drawn
presentation element, that text would need to carry, or be associated
with, appropriate language and direction metadata.

## 14. Automated Testing

For purposes of user-agent automation and application testing, this
document defines extension modules for the [WebDriver BiDi](https://www.w3.org/TR/webdriver-bidi/)
specification. It is *OPTIONAL* for a [user agent](https://infra.spec.whatwg.org/#user-agent) to support them.

### 14.1 The `digitalCredentials` Module

The `digitalCredentials` module contains commands for managing and
simulating the remote end behavior of [credential managers](https://www.w3.org/TR/credential-management-1/#credential-manager) during
[`[[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors)`](#dfn-discoverfromexternalsource-origin-options-sameoriginwithancestors), and [`[[Create]](origin, options, sameOriginWithAncestors)`](https://www.w3.org/TR/credential-management-1/#dom-credential-create-slot) calls.

#### 14.1.1 Types

```
CDDLdigitalCredentials.VirtualWalletAction = "decline" / "respond" / "wait" / "clear"

digitalCredentials.SetVirtualWalletBehaviorParameters = {
  action: digitalCredentials.VirtualWalletAction,
  ? context: text,
  ? protocol: text,
  ? response: { * text => any },
}
```

The `[digitalCredentials.VirtualWalletAction](#cddl-type-digitalcredentials-virtualwalletaction)` type represents the
different types of virtual wallet actions.

`["decline"](#cddl-value-digitalcredentials-virtualwalletaction-decline)`
:   The virtual wallet simulates a user cancellation or rejection,
    aborting the request.

`["respond"](#cddl-value-digitalcredentials-virtualwalletaction-respond)`
:   The virtual wallet simulates a successful user interaction and
    returns the predefined credential response.

`["wait"](#cddl-value-digitalcredentials-virtualwalletaction-wait)`
:   The virtual wallet simulates an active, pending prompt, effectively
    leaving the active promise unsettled to test timeouts or concurrent
    request handling.

`["clear"](#cddl-value-digitalcredentials-virtualwalletaction-clear)`
:   Clears the active virtual wallet behavior.

#### 14.1.2 Commands

##### 14.1.2.1 The `digitalCredentials.setVirtualWalletBehavior` Command

Command Type
:   ```
    CDDLdigitalCredentials.SetVirtualWalletBehavior = (
      method: "digitalCredentials.setVirtualWalletBehavior",
      params: digitalCredentials.SetVirtualWalletBehaviorParameters
    )
    ```

Return Type
:   ```
    CDDLdigitalCredentials.SetVirtualWalletBehaviorResult = EmptyResult
    ```

The [remote end steps](https://www.w3.org/TR/webdriver2/#dfn-remote-end-steps) for the
`digitalCredentials.setVirtualWalletBehavior` command, given session
and command parameters, are:

1. Let action be command parameters["`action`"].
2. Let context be command parameters["`context`"], if present, and
   `null` otherwise.
3. Let protocol be command parameters["`protocol`"], if present,
   and `null` otherwise.
4. Let response be command parameters["`response`"], if present,
   and `null` otherwise.
5. If action is `"respond"`:
   1. If protocol is `null` or response is `null`, return an
      [error](https://www.w3.org/TR/webdriver2/#dfn-error) with [error code](https://www.w3.org/TR/webdriver2/#dfn-error-code) [invalid argument](https://www.w3.org/TR/webdriver2/#dfn-invalid-argument).
   2. If protocol is not an [enumeration value](https://webidl.spec.whatwg.org/#dfn-enumeration-value) of
      [`DigitalCredentialProtocol`](#dom-digitalcredentialprotocol), return an [error](https://www.w3.org/TR/webdriver2/#dfn-error) with [error code](https://www.w3.org/TR/webdriver2/#dfn-error-code) [invalid argument](https://www.w3.org/TR/webdriver2/#dfn-invalid-argument).
   3. [Serialize](https://infra.spec.whatwg.org/#serialize-an-infra-value-to-a-json-string)
      response to a JSON string.
   4. If serialization results in an [exception](https://webidl.spec.whatwg.org/#dfn-exception), return an
      [error](https://www.w3.org/TR/webdriver2/#dfn-error) with [error code](https://www.w3.org/TR/webdriver2/#dfn-error-code) [invalid argument](https://www.w3.org/TR/webdriver2/#dfn-invalid-argument).
6. Else:
   1. If response is not `null` or protocol is not `null`, return
      an [error](https://www.w3.org/TR/webdriver2/#dfn-error) with [error code](https://www.w3.org/TR/webdriver2/#dfn-error-code) [invalid argument](https://www.w3.org/TR/webdriver2/#dfn-invalid-argument).
7. If action is `"clear"`:
   1. If context is not `null`, remove the entry for context from
      the WebDriver [session](https://www.w3.org/TR/webdriver2/#dfn-webdriver-session)'s [active virtual wallet behavior](#dfn-active-virtual-wallet-behavior).
   2. Else, set the WebDriver [session](https://www.w3.org/TR/webdriver2/#dfn-webdriver-session)'s [active virtual wallet behavior](#dfn-active-virtual-wallet-behavior) to `null`.
8. Else:
   1. Let behavior be a tuple of (action, protocol,
      response).
   2. If context is not `null`, set the WebDriver [session](https://www.w3.org/TR/webdriver2/#dfn-webdriver-session)'s
      active virtual wallet behavior for the browsing context
      ID context to behavior.
   3. Else, set the WebDriver [session](https://www.w3.org/TR/webdriver2/#dfn-webdriver-session)'s default [active virtual wallet behavior](#dfn-active-virtual-wallet-behavior) to behavior.
9. Return [success](https://www.w3.org/TR/webdriver2/#dfn-success) with data `null`.

Note: Simulating wallet errors in tests

Developers writing automated tests can simulate wallet errors by
passing an [`AbortSignal`](https://dom.spec.whatwg.org/#abortsignal) as [`signal`](https://www.w3.org/TR/credential-management-1/#dom-credentialrequestoptions-signal) (for
[`get`](https://www.w3.org/TR/credential-management-1/#dom-credentialscontainer-get)`()`) or [`signal`](https://www.w3.org/TR/credential-management-1/#dom-credentialcreationoptions-signal)
(for [`create`](https://www.w3.org/TR/credential-management-1/#dom-credentialscontainer-create)`()`), then aborting it with the
desired [abort reason](https://dom.spec.whatwg.org/#abortsignal-abort-reason). This exercises the same abort
path used by the request algorithms.

[Example 9](#example-simulating-a-wallet-error-with-abortcontroller): Simulating a wallet error with AbortController

```
(async () => {
  const controller = new AbortController();
  const credentialPromise = navigator.credentials.get({
    digital: {
      requests: [{
        protocol: "example-request-protocol",
        data: { /* presentation request data */ }
      }]
    },
    signal: controller.signal
  });

  controller.abort(
    new DOMException("Simulated wallet failure", "OperationError")
  );

  try {
    await credentialPromise;
  } catch (error) {
    console.assert(error.name === "OperationError");
  }
})();
```

### 14.2 Handle Virtual Wallet Behavior

To handle virtual wallet behavior given a [`Promise`](https://webidl.spec.whatwg.org/#idl-promise)
promise and a global object global, run these steps:

1. If the [user agent](https://infra.spec.whatwg.org/#user-agent) is not under automation, return `false`.
2. Let context ID be the ID of global's [browsing context](https://html.spec.whatwg.org/multipage/document-sequences.html#browsing-context).
3. Let behavior be the current WebDriver [session](https://www.w3.org/TR/webdriver2/#dfn-webdriver-session)'s [active virtual wallet behavior](#dfn-active-virtual-wallet-behavior) for context ID.
4. If behavior is `null`, set behavior to the current WebDriver
   [session](https://www.w3.org/TR/webdriver2/#dfn-webdriver-session)'s default [active virtual wallet behavior](#dfn-active-virtual-wallet-behavior).
5. If behavior is `null`, return `false`.
6. Let (action, protocol, response) be behavior.
7. If action is `"wait"`, return `true`.
8. If action is `"decline"`:
   1. [Reject](https://webidl.spec.whatwg.org/#reject) promise with a "[`NotAllowedError`](https://webidl.spec.whatwg.org/#notallowederror)"
      [`DOMException`](https://webidl.spec.whatwg.org/#idl-DOMException).
   2. Return `true`.
9. If action is `"respond"`:
   1. Let JSON string be the result of [serializing](https://infra.spec.whatwg.org/#serialize-an-infra-value-to-a-json-string) response.
   2. Let JS object be the result of [parsing](https://infra.spec.whatwg.org/#parse-a-json-string-to-a-javascript-value) JSON string given global's
      [relevant realm](https://html.spec.whatwg.org/multipage/webappapis.html#concept-relevant-realm).
   3. Let credential be a new [`DigitalCredential`](#dom-digitalcredential) instance.
   4. Set credential's [`protocol`](#dom-digitalcredential-protocol) attribute to
      protocol.
   5. Set credential's [`data`](#dom-digitalcredential-data) attribute to JS
      object.
   6. [Queue a global task](https://html.spec.whatwg.org/multipage/webappapis.html#queue-a-global-task) on the [DOM manipulation task source](https://html.spec.whatwg.org/multipage/webappapis.html#dom-manipulation-task-source)
      given global to [resolve](https://webidl.spec.whatwg.org/#resolve) promise with credential.
   7. Return `true`.

## A. Index

### A.1 Terms defined by this specification

* [abort algorithm](#dfn-abort-algorithm)
  §6.
* [abort signal](#dfn-abort-signal)
  §6.
* [abort the credential request](#dfn-abort-the-credential-request)
  §6.5
* [aborting](#dfn-aborting)
  §6.1
* [`action`](#cddl-key-digitalcredentials-setvirtualwalletbehaviorparameters-action)
  §14.1.1
* [active promise](#dfn-active-promise)
  §6.
* [active virtual wallet behavior](#dfn-active-virtual-wallet-behavior)
  §14.1.2.1
* [API Flooding](#dfn-api-flooding)
  §10.1.1
* [`"clear"`](#cddl-value-digitalcredentials-virtualwalletaction-clear)
  §14.1.1
* [`context`](#cddl-key-digitalcredentials-setvirtualwalletbehaviorparameters-context)
  §14.1.1
* [convert request protocol](#dfn-convert-request-protocol)
  §5.1
* [`[[Create]](origin, options, sameOriginWithAncestors)`](#dfn-create-origin-options-sameoriginwithancestors) internal slot for `DigitalCredential`
  §8.3
* [Credential manager chooser](#dfn-credential-manager-chooser)
  §4.
* [Credential request](#dfn-credential-request)
  §4.
* [credential request coordinator](#dfn-credential-request-coordinator)
  §6.
* [Credential response](#dfn-credential-response)
  §4.
* data
  + [member for `DigitalCredentialGetRequest`](#dom-digitalcredentialgetrequest-data)
    §7.3.2
  + [member for `DigitalCredentialCreateRequest`](#dom-digitalcredentialcreaterequest-data)
    §7.6.2
  + [attribute for `DigitalCredential`](#dom-digitalcredential-data)
    §7.7.2
* [`"decline"`](#cddl-value-digitalcredentials-virtualwalletaction-decline)
  §14.1.1
* digital
  + [member for `CredentialRequestOptions`](#dom-credentialrequestoptions-digital)
    §7.1.1
  + [member for `CredentialCreationOptions`](#dom-credentialcreationoptions-digital)
    §7.4.1
* [Digital credential](#dfn-digital-credential)
  §4.
* [Digital credential chooser](#dfn-digital-credential-chooser)
  §4.
* ["digital-credentials-create"](#dfn-digital-credentials-create)
  §9.
* ["digital-credentials-get"](#dfn-digital-credentials-get)
  §9.
* [`DigitalCredential`](#dom-digitalcredential) interface
  §7.7
* [`DigitalCredentialCreateRequest`](#dom-digitalcredentialcreaterequest) dictionary
  §7.6
* [`DigitalCredentialCreationOptions`](#dom-digitalcredentialcreationoptions) dictionary
  §7.5
* [`DigitalCredentialGetRequest`](#dom-digitalcredentialgetrequest) dictionary
  §7.3
* [`DigitalCredentialIssuanceProtocol`](#dom-digitalcredentialissuanceprotocol) enum
  §7.8.3
* [`DigitalCredentialPresentationProtocol`](#dom-digitalcredentialpresentationprotocol) enum
  §7.8.2
* [`DigitalCredentialProtocol`](#dom-digitalcredentialprotocol)
  §7.7
* [`DigitalCredentialRequestOptions`](#dom-digitalcredentialrequestoptions) dictionary
  §7.2
* [`digitalCredentials.SetVirtualWalletBehavior`](#cddl-type-digitalcredentials-setvirtualwalletbehavior)
  §14.1.2.1
* [`"digitalCredentials.setVirtualWalletBehavior"`](#cddl-value-digitalcredentials-setvirtualwalletbehavior-digitalcredentials-setvirtualwalletbehavior)
  §14.1.2.1
* [`digitalCredentials.SetVirtualWalletBehaviorParameters`](#cddl-type-digitalcredentials-setvirtualwalletbehaviorparameters)
  §14.1.1
* [`digitalCredentials.SetVirtualWalletBehaviorResult`](#cddl-type-digitalcredentials-setvirtualwalletbehaviorresult)
  §14.1.2.1
* [`digitalCredentials.VirtualWalletAction`](#cddl-type-digitalcredentials-virtualwalletaction)
  §14.1.1
* [`[[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors)`](#dfn-discoverfromexternalsource-origin-options-sameoriginwithancestors) internal slot for `DigitalCredential`
  §8.1
* [`[[discovery]]`](#dfn-discovery) internal slot for `DigitalCredential`
  §8.5
* [Examples of these types](#dfn-credential-type-examples)
  §1.
* [filter credential requests](#dfn-filter-credential-requests)
  §6.3
* [handle virtual wallet behavior](#dfn-handle-virtual-wallet-behavior)
  §14.2
* [idle](#dfn-idle)
  §6.1
* [In-Scope Threats](#dfn-in-scope-threats)
  §10.1.1
* [initiate the credential request](#dfn-initiate-the-credential-request)
  §6.7
* [interaction states](#dfn-interaction-states)
  §6.1
* [Issuance protocol](#dfn-issuance-protocol)
  §4.
* [Issuance request](#dfn-issuance-request)
  §4.
* [Issuance request data](#dfn-issuance-request-data)
  §4.
* [Issuance response](#dfn-issuance-response)
  §4.
* [Malicious Credential Managers](#dfn-malicious-credential-managers)
  §10.1.2
* [Malicious Payloads to the Underlying Platform](#dfn-malicious-payloads-to-the-underlying-platform)
  §10.1.1
* [`method`](#cddl-key-digitalcredentials-setvirtualwalletbehavior-method)
  §14.1.2.1
* [`"openid4vci-v1"`](#dom-digitalcredentialissuanceprotocol-openid4vci-v1) enum value for `DigitalCredentialIssuanceProtocol`
  §5.
* [`"openid4vp-v1-multisigned"`](#dom-digitalcredentialpresentationprotocol-openid4vp-v1-multisigned) enum value for `DigitalCredentialPresentationProtocol`
  §5.
* [`"openid4vp-v1-signed"`](#dom-digitalcredentialpresentationprotocol-openid4vp-v1-signed) enum value for `DigitalCredentialPresentationProtocol`
  §5.
* [`"openid4vp-v1-unsigned"`](#dom-digitalcredentialpresentationprotocol-openid4vp-v1-unsigned) enum value for `DigitalCredentialPresentationProtocol`
  §5.
* [`"org-iso-mdoc"`](#dom-digitalcredentialpresentationprotocol-org-iso-mdoc) enum value for `DigitalCredentialPresentationProtocol`
  §5.
* [OS or Device Compromise](#dfn-os-or-device-compromise)
  §10.1.2
* [Out-of-scope threats](#dfn-out-of-scope-threats)
  §10.1.2
* [`params`](#cddl-key-digitalcredentials-setvirtualwalletbehavior-params)
  §14.1.2.1
* [prepare credential requests](#dfn-prepare-credential-requests)
  §6.2
* [Presentation protocol](#dfn-presentation-protocol)
  §4.
* [Presentation request](#dfn-presentation-request)
  §4.
* [Presentation request data](#dfn-presentation-request-data)
  §4.
* [Presentation response](#dfn-presentation-response)
  §4.
* protocol
  + [member for `DigitalCredentialGetRequest`](#dom-digitalcredentialgetrequest-protocol)
    §7.3.1
  + [member for `DigitalCredentialCreateRequest`](#dom-digitalcredentialcreaterequest-protocol)
    §7.6.1
  + [attribute for `DigitalCredential`](#dom-digitalcredential-protocol)
    §7.7.1
  + [definition of](#cddl-key-digitalcredentials-setvirtualwalletbehaviorparameters-protocol)
    §14.1.1
* [Protocol and Format Vulnerabilities](#dfn-protocol-and-format-vulnerabilities)
  §10.1.2
* [Protocol identifier](#dfn-protocol-identifier)
  §4.
* [reject the credential request with](#dfn-reject-the-credential-request-with)
  §6.6
* [request context](#dfn-request-context)
  §7.8.1
* [Request Tampering](#dfn-request-tampering)
  §10.1.1
* [requesting](#dfn-requesting)
  §6.1
* requests
  + [member for `DigitalCredentialRequestOptions`](#dom-digitalcredentialrequestoptions-requests)
    §7.2.1
  + [member for `DigitalCredentialCreationOptions`](#dom-digitalcredentialcreationoptions-requests)
    §7.5.1
  + [definition of](#dfn-requests)
    §7.8.1
* [`"respond"`](#cddl-value-digitalcredentials-virtualwalletaction-respond)
  §14.1.1
* [`response`](#cddl-key-digitalcredentials-setvirtualwalletbehaviorparameters-response)
  §14.1.1
* [`[[Store]](credential, sameOriginWithAncestors)`](#dfn-store-credential-sameoriginwithancestors) internal slot for `DigitalCredential`
  §8.2
* [Table of supported presentation and issuance protocols](#dfn-table-of-supported-presentation-and-issuance-protocols)
  §5.
* [`text`](#cddl-key-digitalcredentials-setvirtualwalletbehaviorparameters-text)
  §14.1.1
* [top-level origin](#dfn-top-level-origin)
  §7.8.1
* [`[[type]]`](#dfn-type) internal slot for `DigitalCredential`
  §8.4
* [Unauthorized Cross-Origin Access](#dfn-unauthorized-cross-origin-access)
  §10.1.1
* [user agent allows protocol](#dfn-user-agent-allows-protocol)
  §7.7.3
* [`userAgentAllowsProtocol()`](#dom-digitalcredential-useragentallowsprotocol) method for `DigitalCredential`
  §7.7.3
* [validate credential requests](#dfn-validate-credential-requests)
  §6.4
* [`"wait"`](#cddl-value-digitalcredentials-virtualwalletaction-wait)
  §14.1.1

### A.2 Terms defined by reference

* [[CREDENTIAL-MANAGEMENT](#bib-credential-management)] defines the following:
  + `[[Create]](origin, options, sameOriginWithAncestors)` (for `Credential`)
  + `[[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors)` (for `Credential`)
  + `[[Store]](credential, sameOriginWithAncestors)` (for `Credential`)
  + create a Credential
  + `create()` (for `CredentialsContainer`)
  + `Credential` interface
  + credential chooser
  + credential manager
  + `CredentialCreationOptions`
  + `CredentialRequestOptions`
  + `CredentialsContainer` interface
  + `get()` (for `CredentialsContainer`)
  + `mediation` (for `CredentialRequestOptions`)
  + `mediation` (for `CredentialCreationOptions`)
  + origin bound (for `Credential`)
  + request a Credential
  + `required` (for `CredentialMediationRequirement`)
  + `signal` (for `CredentialRequestOptions`)
  + `signal` (for `CredentialCreationOptions`)
  + user mediation
* [DOM Standard](#bib-dom) defines the following:
  + abort reason (for `AbortSignal`)
  + aborted (for `AbortSignal`)
  + `AbortSignal` interface
  + Add (for `AbortSignal`)
  + Document
  + Remove (for `AbortSignal`)
  + signal abort (for `AbortController`)
  + signals (for `AbortController`)
* [HTML Standard](#bib-html) defines the following:
  + active document (for `navigable`)
  + associated Document
  + browsing context
  + child navigables
  + Consume user activation
  + DOM manipulation task source
  + environment settings object
  + fully active (for `Document`)
  + fully active descendant of a top-level traversable with user attention (for `Document`)
  + `iframe` element
  + In parallel
  + `object` type
  + opaque origin
  + origin
  + origin (for environment settings object)
  + Queue a global task
  + relevant global object
  + relevant realm
  + relevant settings object
  + secure contexts
  + top-level traversable
  + transient activation
  + `Window` interface
* [Infra Standard](#bib-infra) defines the following:
  + Append (for `list`)
  + ASCII digit
  + ASCII lower alpha
  + Assert
  + code points
  + continue (for `iteration`)
  + For each (for `list`)
  + is empty (for `list`)
  + items (for `struct`)
  + list
  + parse a JSON string to a JavaScript value
  + serialize a JavaScript value to a JSON string
  + serialize an Infra value to a JSON string
  + string
  + struct
  + user agents
* [[PERMISSIONS](#bib-permissions)] defines the following:
  + express permission
  + powerful feature
* [[PERMISSIONS-POLICY](#bib-permissions-policy)] defines the following:
  + 'self' (for default allowlist)
  + default allowlists (for policy-controlled feature)
  + policy-controlled feature
* [[PRIVACY-PRINCIPLES](#bib-privacy-principles)] defines the following:
  + user agent duties
* [[VC-DATA-MODEL](#bib-vc-data-model)] defines the following:
  + claims
  + holders
  + issuers
  + subjects
  + verifiers
* [[WEBDRIVER](#bib-webdriver)] defines the following:
  + error
  + error code
  + invalid argument
  + remote end steps
  + session
  + success
* [Web IDL Standard](#bib-webidl) defines the following:
  + a new promise
  + a promise rejected with
  + `AbortError` exception
  + `boolean` type
  + create (for `exception`)
  + `[Default]` extended attribute
  + default toJSON steps
  + `DOMException` interface
  + `DOMString` interface
  + enumeration value
  + exception
  + `[Exposed]` extended attribute
  + interface object
  + interfaces
  + `InvalidStateError` exception
  + `NotAllowedError` exception
  + `object` type
  + `OperationError` exception
  + `Promise` interface
  + `ReferenceError` exception
  + rejects
  + resolves
  + `[SameObject]` extended attribute
  + `[SecureContext]` extended attribute
  + `SecurityError` exception
  + sequence
  + this
  + throw (for `exception`)
  + `TypeError` exception

## B. IDL Index

```
WebIDLpartial dictionary CredentialRequestOptions {
  DigitalCredentialRequestOptions digital;
};

dictionary DigitalCredentialRequestOptions {
  required sequence<DigitalCredentialGetRequest> requests;
};

dictionary DigitalCredentialGetRequest {
  required DOMString protocol;
  required object data;
};

partial dictionary CredentialCreationOptions {
  DigitalCredentialCreationOptions digital;
};

dictionary DigitalCredentialCreationOptions {
  required sequence<DigitalCredentialCreateRequest> requests;
};

dictionary DigitalCredentialCreateRequest {
  required DOMString protocol;
  required object data;
};

typedef (DigitalCredentialPresentationProtocol or DigitalCredentialIssuanceProtocol) DigitalCredentialProtocol;

[Exposed=Window, SecureContext]
interface DigitalCredential : Credential {
  [Default] object toJSON();
  readonly attribute DigitalCredentialProtocol protocol;
  [SameObject] readonly attribute object data;
  static boolean userAgentAllowsProtocol(DOMString protocol);
};

enum DigitalCredentialPresentationProtocol {
  "openid4vp-v1-unsigned",
  "openid4vp-v1-signed",
  "openid4vp-v1-multisigned",
  "org-iso-mdoc"
};

enum DigitalCredentialIssuanceProtocol {
  "openid4vci-v1",
};
```

## C. CDDL Index

### C.1 Module: remote-cddl

```
digitalCredentials.VirtualWalletAction = "decline" / "respond" / "wait" / "clear"

digitalCredentials.SetVirtualWalletBehaviorParameters = {
  action: digitalCredentials.VirtualWalletAction,
  ? context: text,
  ? protocol: text,
  ? response: { * text => any },
}

digitalCredentials.SetVirtualWalletBehavior = (
  method: "digitalCredentials.setVirtualWalletBehavior",
  params: digitalCredentials.SetVirtualWalletBehaviorParameters
)
```

### C.2 Module: local-cddl

```
digitalCredentials.SetVirtualWalletBehaviorResult = EmptyResult
```

## D. Conformance

As well as sections marked as non-normative, all authoring guidelines, diagrams, examples, and notes in this specification are non-normative. Everything else in this specification is normative.

The key words *MAY*, *MUST*, *MUST NOT*, *OPTIONAL*, *RECOMMENDED*, *SHOULD*, and *SHOULD NOT* in this document
are to be interpreted as described in
[BCP 14](https://www.rfc-editor.org/info/bcp14)
[[RFC2119](#bib-rfc2119 "Key words for use in RFCs to Indicate Requirement Levels")] [[RFC8174](#bib-rfc8174 "Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words")]
when, and only when, they appear in all
capitals, as shown here.

## E. Acknowledgements

Some of the Editors would like to thank the following individuals for
their feedback and contributions to this specification: Christian Bormann
(SPRIND), John Bradley (Yubico), Rick Byers (Google), Brian Campbell
(Ping Identity), Lee Campbell (Google), Nick Doty (CDT), Heather Flanagan
(Spherical Cow Consulting), Ryan Galluzzo (NIST), Joseph Heenan
(Authlete), Dominique Hazael-Massieux (W3C), Bjorn Hjelm (Yubico), Johann
Hofmann (Google), Mike Jones (Self-Issued Consulting), Tobias Looker
(MATTR), Matthew Miller (Cisco), Theresa O'Connor (Apple Inc.), Simone
Onofri (W3C), Helen Qin (Google), Wendy Seltzer (Invited Expert), Manu
Sporny (Digital Bazaar), Orie Steele (Transmute), Ted Thibodeau Jr
(OpenLink Software), David Waite (Ping Identity), and Kristina Yasuda
(SPRIND).

[Permalink](#dfn-credential-type-examples)

**Referenced in:**

* [§ Abstract](#ref-for-dfn-credential-type-examples-1 "§ Abstract")

[Permalink](#dfn-credential-manager-chooser)

**Referenced in:**

* [§ 2.3 Requesting a digital credential](#ref-for-dfn-credential-manager-chooser-1 "§ 2.3 Requesting a digital credential")
* [§ 6.5 Abort the credential request](#ref-for-dfn-credential-manager-chooser-2 "§ 6.5 Abort the credential request")
* [§ 7. The Digital Credentials API](#ref-for-dfn-credential-manager-chooser-3 "§ 7. The Digital Credentials API")
* [§ 11.1 Design Considerations and Alternatives](#ref-for-dfn-credential-manager-chooser-4 "§ 11.1 Design Considerations and Alternatives")
* [§ 12. Accessibility Considerations](#ref-for-dfn-credential-manager-chooser-5 "§ 12. Accessibility Considerations") [(2)](#ref-for-dfn-credential-manager-chooser-6 "Reference 2")
* [§ 13. Internationalization Considerations](#ref-for-dfn-credential-manager-chooser-7 "§ 13. Internationalization Considerations")

[Permalink](#dfn-credential-request)

**Referenced in:**

* [§ 4. Terminology](#ref-for-dfn-credential-request-1 "§ 4. Terminology")
* [§ 6. Credential Request Coordinator](#ref-for-dfn-credential-request-2 "§ 6. Credential Request Coordinator")
* [§ 6.1 Interaction states](#ref-for-dfn-credential-request-3 "§ 6.1 Interaction states") [(2)](#ref-for-dfn-credential-request-4 "Reference 2") [(3)](#ref-for-dfn-credential-request-5 "Reference 3")
* [§ 7.8.1 The request context struct](#ref-for-dfn-credential-request-6 "§ 7.8.1 The request context struct")

[Permalink](#dfn-credential-response)

**Referenced in:**

* [§ 6. Credential Request Coordinator](#ref-for-dfn-credential-response-1 "§ 6. Credential Request Coordinator")
* [§ 10. Security Considerations](#ref-for-dfn-credential-response-2 "§ 10. Security Considerations")

[Permalink](#dfn-digital-credential)

**Referenced in:**

* [§ Abstract](#ref-for-dfn-digital-credential-1 "§ Abstract")
* [§ 1. Introduction](#ref-for-dfn-digital-credential-2 "§ 1. Introduction") [(2)](#ref-for-dfn-digital-credential-3 "Reference 2") [(3)](#ref-for-dfn-digital-credential-4 "Reference 3")
* [§ 2.3 Requesting a digital credential](#ref-for-dfn-digital-credential-5 "§ 2.3 Requesting a digital credential")
* [§ 3. Scope](#ref-for-dfn-digital-credential-6 "§ 3. Scope") [(2)](#ref-for-dfn-digital-credential-7 "Reference 2") [(3)](#ref-for-dfn-digital-credential-8 "Reference 3") [(4)](#ref-for-dfn-digital-credential-9 "Reference 4") [(5)](#ref-for-dfn-digital-credential-10 "Reference 5")
* [§ 4. Terminology](#ref-for-dfn-digital-credential-11 "§ 4. Terminology") [(2)](#ref-for-dfn-digital-credential-12 "Reference 2") [(3)](#ref-for-dfn-digital-credential-13 "Reference 3") [(4)](#ref-for-dfn-digital-credential-14 "Reference 4") [(5)](#ref-for-dfn-digital-credential-15 "Reference 5") [(6)](#ref-for-dfn-digital-credential-16 "Reference 6") [(7)](#ref-for-dfn-digital-credential-17 "Reference 7")
* [§ 6. Credential Request Coordinator](#ref-for-dfn-digital-credential-18 "§ 6. Credential Request Coordinator") [(2)](#ref-for-dfn-digital-credential-19 "Reference 2")
* [§ 6.7 Initiate the credential request](#ref-for-dfn-digital-credential-20 "§ 6.7 Initiate the credential request") [(2)](#ref-for-dfn-digital-credential-21 "Reference 2")
* [§ 7. The Digital Credentials API](#ref-for-dfn-digital-credential-22 "§ 7. The Digital Credentials API") [(2)](#ref-for-dfn-digital-credential-23 "Reference 2") [(3)](#ref-for-dfn-digital-credential-24 "Reference 3") [(4)](#ref-for-dfn-digital-credential-25 "Reference 4") [(5)](#ref-for-dfn-digital-credential-26 "Reference 5")
* [§ 7.1.1 The digital member](#ref-for-dfn-digital-credential-27 "§ 7.1.1 The digital member")
* [§ 7.4.1 The digital member](#ref-for-dfn-digital-credential-28 "§ 7.4.1 The digital member")
* [§ 7.7 The DigitalCredential interface](#ref-for-dfn-digital-credential-29 "§ 7.7 The DigitalCredential interface")
* [§ 7.7.1 The protocol member](#ref-for-dfn-digital-credential-30 "§ 7.7.1 The protocol member") [(2)](#ref-for-dfn-digital-credential-31 "Reference 2")
* [§ 10.4 Cross-Device Security and Proximity](#ref-for-dfn-digital-credential-32 "§ 10.4 Cross-Device Security and Proximity")
* [§ 12. Accessibility Considerations](#ref-for-dfn-digital-credential-33 "§ 12. Accessibility Considerations") [(2)](#ref-for-dfn-digital-credential-34 "Reference 2") [(3)](#ref-for-dfn-digital-credential-35 "Reference 3")

[Permalink](#dfn-digital-credential-chooser)

**Referenced in:**

* [§ 2.3 Requesting a digital credential](#ref-for-dfn-digital-credential-chooser-1 "§ 2.3 Requesting a digital credential")
* [§ 4. Terminology](#ref-for-dfn-digital-credential-chooser-2 "§ 4. Terminology")
* [§ 6.5 Abort the credential request](#ref-for-dfn-digital-credential-chooser-3 "§ 6.5 Abort the credential request") [(2)](#ref-for-dfn-digital-credential-chooser-4 "Reference 2")
* [§ 6.7 Initiate the credential request](#ref-for-dfn-digital-credential-chooser-5 "§ 6.7 Initiate the credential request") [(2)](#ref-for-dfn-digital-credential-chooser-6 "Reference 2") [(3)](#ref-for-dfn-digital-credential-chooser-7 "Reference 3") [(4)](#ref-for-dfn-digital-credential-chooser-8 "Reference 4")
* [§ 7. The Digital Credentials API](#ref-for-dfn-digital-credential-chooser-9 "§ 7. The Digital Credentials API")
* [§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method](#ref-for-dfn-digital-credential-chooser-10 "§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method")
* [§ 11.1 Design Considerations and Alternatives](#ref-for-dfn-digital-credential-chooser-11 "§ 11.1 Design Considerations and Alternatives")
* [§ 12. Accessibility Considerations](#ref-for-dfn-digital-credential-chooser-12 "§ 12. Accessibility Considerations") [(2)](#ref-for-dfn-digital-credential-chooser-13 "Reference 2")
* [§ 13. Internationalization Considerations](#ref-for-dfn-digital-credential-chooser-14 "§ 13. Internationalization Considerations")

[Permalink](#dfn-issuance-protocol)

**Referenced in:**

* [§ 1. Introduction](#ref-for-dfn-issuance-protocol-1 "§ 1. Introduction") [(2)](#ref-for-dfn-issuance-protocol-2 "Reference 2")
* [§ 4. Terminology](#ref-for-dfn-issuance-protocol-3 "§ 4. Terminology") [(2)](#ref-for-dfn-issuance-protocol-4 "Reference 2") [(3)](#ref-for-dfn-issuance-protocol-5 "Reference 3")
* [§ 5. Protocols](#ref-for-dfn-issuance-protocol-6 "§ 5. Protocols") [(2)](#ref-for-dfn-issuance-protocol-7 "Reference 2") [(3)](#ref-for-dfn-issuance-protocol-8 "Reference 3") [(4)](#ref-for-dfn-issuance-protocol-9 "Reference 4") [(5)](#ref-for-dfn-issuance-protocol-10 "Reference 5")
* [§ 6.4 Validate credential requests](#ref-for-dfn-issuance-protocol-11 "§ 6.4 Validate credential requests") [(2)](#ref-for-dfn-issuance-protocol-12 "Reference 2") [(3)](#ref-for-dfn-issuance-protocol-13 "Reference 3")
* [§ 7.5.1 The requests member](#ref-for-dfn-issuance-protocol-14 "§ 7.5.1 The requests member")
* [§ 7.6 The DigitalCredentialCreateRequest dictionary](#ref-for-dfn-issuance-protocol-15 "§ 7.6 The DigitalCredentialCreateRequest dictionary")
* [§ 7.6.1 The protocol member](#ref-for-dfn-issuance-protocol-16 "§ 7.6.1 The protocol member")
* [§ 7.7.1 The protocol member](#ref-for-dfn-issuance-protocol-17 "§ 7.7.1 The protocol member")
* [§ 7.7.3 The userAgentAllowsProtocol() method](#ref-for-dfn-issuance-protocol-18 "§ 7.7.3 The userAgentAllowsProtocol() method") [(2)](#ref-for-dfn-issuance-protocol-19 "Reference 2")
* [§ 7.8.3 The DigitalCredentialIssuanceProtocol enumeration](#ref-for-dfn-issuance-protocol-20 "§ 7.8.3 The DigitalCredentialIssuanceProtocol enumeration")
* [§ 10.1.2 Out of Scope Threats](#ref-for-dfn-issuance-protocol-21 "§ 10.1.2 Out of Scope Threats")
* [§ 11.5.3 Revealing device properties through protocol availability](#ref-for-dfn-issuance-protocol-22 "§ 11.5.3 Revealing device properties through protocol availability")
* [§ 13. Internationalization Considerations](#ref-for-dfn-issuance-protocol-23 "§ 13. Internationalization Considerations")

[Permalink](#dfn-issuance-request)

**Referenced in:**

* [§ Abstract](#ref-for-dfn-issuance-request-1 "§ Abstract")
* [§ 1. Introduction](#ref-for-dfn-issuance-request-2 "§ 1. Introduction") [(2)](#ref-for-dfn-issuance-request-3 "Reference 2") [(3)](#ref-for-dfn-issuance-request-4 "Reference 3") [(4)](#ref-for-dfn-issuance-request-5 "Reference 4") [(5)](#ref-for-dfn-issuance-request-6 "Reference 5") [(6)](#ref-for-dfn-issuance-request-7 "Reference 6")
* [§ 2.3 Requesting a digital credential](#ref-for-dfn-issuance-request-8 "§ 2.3 Requesting a digital credential")
* [§ 3. Scope](#ref-for-dfn-issuance-request-9 "§ 3. Scope") [(2)](#ref-for-dfn-issuance-request-10 "Reference 2") [(3)](#ref-for-dfn-issuance-request-11 "Reference 3") [(4)](#ref-for-dfn-issuance-request-12 "Reference 4")
* [§ 4. Terminology](#ref-for-dfn-issuance-request-13 "§ 4. Terminology") [(2)](#ref-for-dfn-issuance-request-14 "Reference 2") [(3)](#ref-for-dfn-issuance-request-15 "Reference 3")
* [§ 7. The Digital Credentials API](#ref-for-dfn-issuance-request-16 "§ 7. The Digital Credentials API") [(2)](#ref-for-dfn-issuance-request-17 "Reference 2") [(3)](#ref-for-dfn-issuance-request-18 "Reference 3")
* [§ 7.6 The DigitalCredentialCreateRequest dictionary](#ref-for-dfn-issuance-request-19 "§ 7.6 The DigitalCredentialCreateRequest dictionary")
* [§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method](#ref-for-dfn-issuance-request-20 "§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method")
* [§ 9. Permissions Policy integration](#ref-for-dfn-issuance-request-21 "§ 9. Permissions Policy integration")
* [§ 12. Accessibility Considerations](#ref-for-dfn-issuance-request-22 "§ 12. Accessibility Considerations") [(2)](#ref-for-dfn-issuance-request-23 "Reference 2")

[Permalink](#dfn-issuance-request-data)

**Referenced in:**

* [§ 3. Scope](#ref-for-dfn-issuance-request-data-1 "§ 3. Scope")
* [§ 4. Terminology](#ref-for-dfn-issuance-request-data-2 "§ 4. Terminology")
* [§ 6.4 Validate credential requests](#ref-for-dfn-issuance-request-data-3 "§ 6.4 Validate credential requests") [(2)](#ref-for-dfn-issuance-request-data-4 "Reference 2")
* [§ 7.5.1 The requests member](#ref-for-dfn-issuance-request-data-5 "§ 7.5.1 The requests member")
* [§ 7.6 The DigitalCredentialCreateRequest dictionary](#ref-for-dfn-issuance-request-data-6 "§ 7.6 The DigitalCredentialCreateRequest dictionary")
* [§ 7.6.2 The data member](#ref-for-dfn-issuance-request-data-7 "§ 7.6.2 The data member")

[Permalink](#dfn-issuance-response)

**Referenced in:**

* [§ 1. Introduction](#ref-for-dfn-issuance-response-1 "§ 1. Introduction")
* [§ 4. Terminology](#ref-for-dfn-issuance-response-2 "§ 4. Terminology")
* [§ 6.7 Initiate the credential request](#ref-for-dfn-issuance-response-3 "§ 6.7 Initiate the credential request")

[Permalink](#dfn-presentation-protocol)

**Referenced in:**

* [§ 1. Introduction](#ref-for-dfn-presentation-protocol-1 "§ 1. Introduction") [(2)](#ref-for-dfn-presentation-protocol-2 "Reference 2")
* [§ 4. Terminology](#ref-for-dfn-presentation-protocol-3 "§ 4. Terminology") [(2)](#ref-for-dfn-presentation-protocol-4 "Reference 2") [(3)](#ref-for-dfn-presentation-protocol-5 "Reference 3")
* [§ 5. Protocols](#ref-for-dfn-presentation-protocol-6 "§ 5. Protocols") [(2)](#ref-for-dfn-presentation-protocol-7 "Reference 2") [(3)](#ref-for-dfn-presentation-protocol-8 "Reference 3") [(4)](#ref-for-dfn-presentation-protocol-9 "Reference 4") [(5)](#ref-for-dfn-presentation-protocol-10 "Reference 5") [(6)](#ref-for-dfn-presentation-protocol-11 "Reference 6")
* [§ 6.4 Validate credential requests](#ref-for-dfn-presentation-protocol-12 "§ 6.4 Validate credential requests") [(2)](#ref-for-dfn-presentation-protocol-13 "Reference 2") [(3)](#ref-for-dfn-presentation-protocol-14 "Reference 3")
* [§ 7.2.1 The requests member](#ref-for-dfn-presentation-protocol-15 "§ 7.2.1 The requests member")
* [§ 7.3 The DigitalCredentialGetRequest dictionary](#ref-for-dfn-presentation-protocol-16 "§ 7.3 The DigitalCredentialGetRequest dictionary")
* [§ 7.3.1 The protocol member](#ref-for-dfn-presentation-protocol-17 "§ 7.3.1 The protocol member")
* [§ 7.7.1 The protocol member](#ref-for-dfn-presentation-protocol-18 "§ 7.7.1 The protocol member")
* [§ 7.7.3 The userAgentAllowsProtocol() method](#ref-for-dfn-presentation-protocol-19 "§ 7.7.3 The userAgentAllowsProtocol() method") [(2)](#ref-for-dfn-presentation-protocol-20 "Reference 2")
* [§ 7.8.2 The DigitalCredentialPresentationProtocol enumeration](#ref-for-dfn-presentation-protocol-21 "§ 7.8.2 The DigitalCredentialPresentationProtocol enumeration")
* [§ 10.1.2 Out of Scope Threats](#ref-for-dfn-presentation-protocol-22 "§ 10.1.2 Out of Scope Threats")
* [§ 10.3 Signing presentation requests](#ref-for-dfn-presentation-protocol-23 "§ 10.3 Signing presentation requests")
* [§ 11.1 Design Considerations and Alternatives](#ref-for-dfn-presentation-protocol-24 "§ 11.1 Design Considerations and Alternatives") [(2)](#ref-for-dfn-presentation-protocol-25 "Reference 2")
* [§ 11.3 Presentation Protocol and Credential Format](#ref-for-dfn-presentation-protocol-26 "§ 11.3 Presentation Protocol and Credential Format")
* [§ 11.5.3 Revealing device properties through protocol availability](#ref-for-dfn-presentation-protocol-27 "§ 11.5.3 Revealing device properties through protocol availability")
* [§ 13. Internationalization Considerations](#ref-for-dfn-presentation-protocol-28 "§ 13. Internationalization Considerations")

[Permalink](#dfn-presentation-request)

**Referenced in:**

* [§ Abstract](#ref-for-dfn-presentation-request-1 "§ Abstract")
* [§ 1. Introduction](#ref-for-dfn-presentation-request-2 "§ 1. Introduction") [(2)](#ref-for-dfn-presentation-request-3 "Reference 2") [(3)](#ref-for-dfn-presentation-request-4 "Reference 3") [(4)](#ref-for-dfn-presentation-request-5 "Reference 4") [(5)](#ref-for-dfn-presentation-request-6 "Reference 5") [(6)](#ref-for-dfn-presentation-request-7 "Reference 6")
* [§ 2.3 Requesting a digital credential](#ref-for-dfn-presentation-request-8 "§ 2.3 Requesting a digital credential")
* [§ 3. Scope](#ref-for-dfn-presentation-request-9 "§ 3. Scope") [(2)](#ref-for-dfn-presentation-request-10 "Reference 2") [(3)](#ref-for-dfn-presentation-request-11 "Reference 3") [(4)](#ref-for-dfn-presentation-request-12 "Reference 4") [(5)](#ref-for-dfn-presentation-request-13 "Reference 5")
* [§ 4. Terminology](#ref-for-dfn-presentation-request-14 "§ 4. Terminology") [(2)](#ref-for-dfn-presentation-request-15 "Reference 2")
* [§ 7. The Digital Credentials API](#ref-for-dfn-presentation-request-16 "§ 7. The Digital Credentials API") [(2)](#ref-for-dfn-presentation-request-17 "Reference 2")
* [§ 7.3 The DigitalCredentialGetRequest dictionary](#ref-for-dfn-presentation-request-18 "§ 7.3 The DigitalCredentialGetRequest dictionary")
* [§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method](#ref-for-dfn-presentation-request-19 "§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method")
* [§ 9. Permissions Policy integration](#ref-for-dfn-presentation-request-20 "§ 9. Permissions Policy integration")
* [§ 12. Accessibility Considerations](#ref-for-dfn-presentation-request-21 "§ 12. Accessibility Considerations") [(2)](#ref-for-dfn-presentation-request-22 "Reference 2") [(3)](#ref-for-dfn-presentation-request-23 "Reference 3")

[Permalink](#dfn-presentation-request-data)

**Referenced in:**

* [§ 3. Scope](#ref-for-dfn-presentation-request-data-1 "§ 3. Scope")
* [§ 4. Terminology](#ref-for-dfn-presentation-request-data-2 "§ 4. Terminology")
* [§ 6.4 Validate credential requests](#ref-for-dfn-presentation-request-data-3 "§ 6.4 Validate credential requests") [(2)](#ref-for-dfn-presentation-request-data-4 "Reference 2")
* [§ 7.2.1 The requests member](#ref-for-dfn-presentation-request-data-5 "§ 7.2.1 The requests member")
* [§ 7.3 The DigitalCredentialGetRequest dictionary](#ref-for-dfn-presentation-request-data-6 "§ 7.3 The DigitalCredentialGetRequest dictionary")
* [§ 7.3.2 The data member](#ref-for-dfn-presentation-request-data-7 "§ 7.3.2 The data member")

[Permalink](#dfn-presentation-response)

**Referenced in:**

* [§ 1. Introduction](#ref-for-dfn-presentation-response-1 "§ 1. Introduction")
* [§ 4. Terminology](#ref-for-dfn-presentation-response-2 "§ 4. Terminology")
* [§ 6.7 Initiate the credential request](#ref-for-dfn-presentation-response-3 "§ 6.7 Initiate the credential request")

[Permalink](#dfn-protocol-identifier)

**Referenced in:**

* [§ 4. Terminology](#ref-for-dfn-protocol-identifier-1 "§ 4. Terminology") [(2)](#ref-for-dfn-protocol-identifier-2 "Reference 2")
* [§ 5. Protocols](#ref-for-dfn-protocol-identifier-3 "§ 5. Protocols")
* [§ 6.7 Initiate the credential request](#ref-for-dfn-protocol-identifier-4 "§ 6.7 Initiate the credential request") [(2)](#ref-for-dfn-protocol-identifier-5 "Reference 2")
* [§ 7.3.1 The protocol member](#ref-for-dfn-protocol-identifier-6 "§ 7.3.1 The protocol member")
* [§ 7.6.1 The protocol member](#ref-for-dfn-protocol-identifier-7 "§ 7.6.1 The protocol member")
* [§ 13. Internationalization Considerations](#ref-for-dfn-protocol-identifier-8 "§ 13. Internationalization Considerations")

[Permalink](#dfn-table-of-supported-presentation-and-issuance-protocols)
exported

**Referenced in:**

* [§ 5. Protocols](#ref-for-dfn-table-of-supported-presentation-and-issuance-protocols-1 "§ 5. Protocols") [(2)](#ref-for-dfn-table-of-supported-presentation-and-issuance-protocols-2 "Reference 2")

[Permalink](#dom-digitalcredentialpresentationprotocol-openid4vp-v1-unsigned)
exported [IDL](#webidl-1346526641 "Jump to IDL declaration")

**Referenced in:**

* [§ 7.8.2 The DigitalCredentialPresentationProtocol enumeration](#ref-for-dom-digitalcredentialpresentationprotocol-openid4vp-v1-unsigned-1 "§ 7.8.2 The DigitalCredentialPresentationProtocol enumeration")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialpresentationprotocol-openid4vp-v1-unsigned-2 "§ B. IDL Index")

[Permalink](#dom-digitalcredentialpresentationprotocol-openid4vp-v1-signed)
exported [IDL](#webidl-1346526641 "Jump to IDL declaration")

**Referenced in:**

* [§ 7.8.2 The DigitalCredentialPresentationProtocol enumeration](#ref-for-dom-digitalcredentialpresentationprotocol-openid4vp-v1-signed-1 "§ 7.8.2 The DigitalCredentialPresentationProtocol enumeration")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialpresentationprotocol-openid4vp-v1-signed-2 "§ B. IDL Index")

[Permalink](#dom-digitalcredentialpresentationprotocol-openid4vp-v1-multisigned)
exported [IDL](#webidl-1346526641 "Jump to IDL declaration")

**Referenced in:**

* [§ 7.8.2 The DigitalCredentialPresentationProtocol enumeration](#ref-for-dom-digitalcredentialpresentationprotocol-openid4vp-v1-multisigned-1 "§ 7.8.2 The DigitalCredentialPresentationProtocol enumeration")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialpresentationprotocol-openid4vp-v1-multisigned-2 "§ B. IDL Index")

[Permalink](#dom-digitalcredentialpresentationprotocol-org-iso-mdoc)
exported [IDL](#webidl-1346526641 "Jump to IDL declaration")

**Referenced in:**

* [§ 7.8.2 The DigitalCredentialPresentationProtocol enumeration](#ref-for-dom-digitalcredentialpresentationprotocol-org-iso-mdoc-1 "§ 7.8.2 The DigitalCredentialPresentationProtocol enumeration")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialpresentationprotocol-org-iso-mdoc-2 "§ B. IDL Index")

[Permalink](#dom-digitalcredentialissuanceprotocol-openid4vci-v1)
exported [IDL](#webidl-1572165639 "Jump to IDL declaration")

**Referenced in:**

* [§ 7.8.3 The DigitalCredentialIssuanceProtocol enumeration](#ref-for-dom-digitalcredentialissuanceprotocol-openid4vci-v1-1 "§ 7.8.3 The DigitalCredentialIssuanceProtocol enumeration")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialissuanceprotocol-openid4vci-v1-2 "§ B. IDL Index")

[Permalink](#dfn-convert-request-protocol)

**Referenced in:**

* [§ 6.3 Filter credential requests](#ref-for-dfn-convert-request-protocol-1 "§ 6.3 Filter credential requests")

[Permalink](#dfn-credential-request-coordinator)

**Referenced in:**

* [§ 4. Terminology](#ref-for-dfn-credential-request-coordinator-1 "§ 4. Terminology")
* [§ 6. Credential Request Coordinator](#ref-for-dfn-credential-request-coordinator-2 "§ 6. Credential Request Coordinator") [(2)](#ref-for-dfn-credential-request-coordinator-3 "Reference 2") [(3)](#ref-for-dfn-credential-request-coordinator-4 "Reference 3") [(4)](#ref-for-dfn-credential-request-coordinator-5 "Reference 4") [(5)](#ref-for-dfn-credential-request-coordinator-6 "Reference 5")
* [§ 6.1 Interaction states](#ref-for-dfn-credential-request-coordinator-7 "§ 6.1 Interaction states")
* [§ 6.2 Prepare credential requests](#ref-for-dfn-credential-request-coordinator-8 "§ 6.2 Prepare credential requests") [(2)](#ref-for-dfn-credential-request-coordinator-9 "Reference 2") [(3)](#ref-for-dfn-credential-request-coordinator-10 "Reference 3") [(4)](#ref-for-dfn-credential-request-coordinator-11 "Reference 4") [(5)](#ref-for-dfn-credential-request-coordinator-12 "Reference 5") [(6)](#ref-for-dfn-credential-request-coordinator-13 "Reference 6") [(7)](#ref-for-dfn-credential-request-coordinator-14 "Reference 7")
* [§ 6.5 Abort the credential request](#ref-for-dfn-credential-request-coordinator-15 "§ 6.5 Abort the credential request") [(2)](#ref-for-dfn-credential-request-coordinator-16 "Reference 2") [(3)](#ref-for-dfn-credential-request-coordinator-17 "Reference 3") [(4)](#ref-for-dfn-credential-request-coordinator-18 "Reference 4") [(5)](#ref-for-dfn-credential-request-coordinator-19 "Reference 5")
* [§ 6.6 Reject the credential request](#ref-for-dfn-credential-request-coordinator-20 "§ 6.6 Reject the credential request") [(2)](#ref-for-dfn-credential-request-coordinator-21 "Reference 2") [(3)](#ref-for-dfn-credential-request-coordinator-22 "Reference 3") [(4)](#ref-for-dfn-credential-request-coordinator-23 "Reference 4") [(5)](#ref-for-dfn-credential-request-coordinator-24 "Reference 5") [(6)](#ref-for-dfn-credential-request-coordinator-25 "Reference 6") [(7)](#ref-for-dfn-credential-request-coordinator-26 "Reference 7") [(8)](#ref-for-dfn-credential-request-coordinator-27 "Reference 8")
* [§ 6.7 Initiate the credential request](#ref-for-dfn-credential-request-coordinator-28 "§ 6.7 Initiate the credential request") [(2)](#ref-for-dfn-credential-request-coordinator-29 "Reference 2") [(3)](#ref-for-dfn-credential-request-coordinator-30 "Reference 3") [(4)](#ref-for-dfn-credential-request-coordinator-31 "Reference 4") [(5)](#ref-for-dfn-credential-request-coordinator-32 "Reference 5") [(6)](#ref-for-dfn-credential-request-coordinator-33 "Reference 6") [(7)](#ref-for-dfn-credential-request-coordinator-34 "Reference 7")

[Permalink](#dfn-active-promise)

**Referenced in:**

* [§ 6. Credential Request Coordinator](#ref-for-dfn-active-promise-1 "§ 6. Credential Request Coordinator")
* [§ 6.2 Prepare credential requests](#ref-for-dfn-active-promise-2 "§ 6.2 Prepare credential requests") [(2)](#ref-for-dfn-active-promise-3 "Reference 2") [(3)](#ref-for-dfn-active-promise-4 "Reference 3")
* [§ 6.5 Abort the credential request](#ref-for-dfn-active-promise-5 "§ 6.5 Abort the credential request") [(2)](#ref-for-dfn-active-promise-6 "Reference 2")
* [§ 6.6 Reject the credential request](#ref-for-dfn-active-promise-7 "§ 6.6 Reject the credential request") [(2)](#ref-for-dfn-active-promise-8 "Reference 2") [(3)](#ref-for-dfn-active-promise-9 "Reference 3")
* [§ 6.7 Initiate the credential request](#ref-for-dfn-active-promise-10 "§ 6.7 Initiate the credential request") [(2)](#ref-for-dfn-active-promise-11 "Reference 2")

[Permalink](#dfn-abort-signal)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-dfn-abort-signal-1 "§ 6.2 Prepare credential requests")
* [§ 6.6 Reject the credential request](#ref-for-dfn-abort-signal-2 "§ 6.6 Reject the credential request") [(2)](#ref-for-dfn-abort-signal-3 "Reference 2")
* [§ 6.7 Initiate the credential request](#ref-for-dfn-abort-signal-4 "§ 6.7 Initiate the credential request") [(2)](#ref-for-dfn-abort-signal-5 "Reference 2")

[Permalink](#dfn-abort-algorithm)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-dfn-abort-algorithm-1 "§ 6.2 Prepare credential requests")
* [§ 6.6 Reject the credential request](#ref-for-dfn-abort-algorithm-2 "§ 6.6 Reject the credential request") [(2)](#ref-for-dfn-abort-algorithm-3 "Reference 2")
* [§ 6.7 Initiate the credential request](#ref-for-dfn-abort-algorithm-4 "§ 6.7 Initiate the credential request") [(2)](#ref-for-dfn-abort-algorithm-5 "Reference 2")

[Permalink](#dfn-interaction-states)

**Referenced in:**

* [§ 6. Credential Request Coordinator](#ref-for-dfn-interaction-states-1 "§ 6. Credential Request Coordinator")
* [§ 6.1 Interaction states](#ref-for-dfn-interaction-states-2 "§ 6.1 Interaction states")
* [§ 6.2 Prepare credential requests](#ref-for-dfn-interaction-states-3 "§ 6.2 Prepare credential requests") [(2)](#ref-for-dfn-interaction-states-4 "Reference 2")
* [§ 6.5 Abort the credential request](#ref-for-dfn-interaction-states-5 "§ 6.5 Abort the credential request") [(2)](#ref-for-dfn-interaction-states-6 "Reference 2")
* [§ 6.6 Reject the credential request](#ref-for-dfn-interaction-states-7 "§ 6.6 Reject the credential request")
* [§ 6.7 Initiate the credential request](#ref-for-dfn-interaction-states-8 "§ 6.7 Initiate the credential request")

[Permalink](#dfn-idle)

**Referenced in:**

* [§ 6.1 Interaction states](#ref-for-dfn-idle-1 "§ 6.1 Interaction states") [(2)](#ref-for-dfn-idle-2 "Reference 2")
* [§ 6.2 Prepare credential requests](#ref-for-dfn-idle-3 "§ 6.2 Prepare credential requests")
* [§ 6.6 Reject the credential request](#ref-for-dfn-idle-4 "§ 6.6 Reject the credential request")
* [§ 6.7 Initiate the credential request](#ref-for-dfn-idle-5 "§ 6.7 Initiate the credential request")

[Permalink](#dfn-requesting)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-dfn-requesting-1 "§ 6.2 Prepare credential requests")
* [§ 6.5 Abort the credential request](#ref-for-dfn-requesting-2 "§ 6.5 Abort the credential request")

[Permalink](#dfn-aborting)

**Referenced in:**

* [§ 6.5 Abort the credential request](#ref-for-dfn-aborting-1 "§ 6.5 Abort the credential request")

[Permalink](#dfn-prepare-credential-requests)

**Referenced in:**

* [§ 6.7 Initiate the credential request](#ref-for-dfn-prepare-credential-requests-1 "§ 6.7 Initiate the credential request")
* [§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method](#ref-for-dfn-prepare-credential-requests-2 "§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method")
* [§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method](#ref-for-dfn-prepare-credential-requests-3 "§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method")

[Permalink](#dfn-filter-credential-requests)

**Referenced in:**

* [§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method](#ref-for-dfn-filter-credential-requests-1 "§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method")
* [§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method](#ref-for-dfn-filter-credential-requests-2 "§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method")

[Permalink](#dfn-validate-credential-requests)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-dfn-validate-credential-requests-1 "§ 6.2 Prepare credential requests")
* [§ 6.3 Filter credential requests](#ref-for-dfn-validate-credential-requests-2 "§ 6.3 Filter credential requests")
* [§ 10.2 Mitigations](#ref-for-dfn-validate-credential-requests-3 "§ 10.2 Mitigations")

[Permalink](#dfn-abort-the-credential-request)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-dfn-abort-the-credential-request-1 "§ 6.2 Prepare credential requests") [(2)](#ref-for-dfn-abort-the-credential-request-2 "Reference 2")

[Permalink](#dfn-reject-the-credential-request-with)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-dfn-reject-the-credential-request-with-1 "§ 6.2 Prepare credential requests") [(2)](#ref-for-dfn-reject-the-credential-request-with-2 "Reference 2")
* [§ 6.5 Abort the credential request](#ref-for-dfn-reject-the-credential-request-with-3 "§ 6.5 Abort the credential request")
* [§ 6.7 Initiate the credential request](#ref-for-dfn-reject-the-credential-request-with-4 "§ 6.7 Initiate the credential request") [(2)](#ref-for-dfn-reject-the-credential-request-with-5 "Reference 2")

[Permalink](#dfn-initiate-the-credential-request)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-dfn-initiate-the-credential-request-1 "§ 6.2 Prepare credential requests")
* [§ 11.4 Unnecessary Requests for Credentials](#ref-for-dfn-initiate-the-credential-request-2 "§ 11.4 Unnecessary Requests for Credentials")

[Permalink](#dom-credentialrequestoptions-digital)
exported [IDL](#webidl-1336694341 "Jump to IDL declaration")

**Referenced in:**

* [§ 7.1 Extensions to CredentialRequestOptions dictionary](#ref-for-dom-credentialrequestoptions-digital-1 "§ 7.1 Extensions to CredentialRequestOptions dictionary")
* [§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method](#ref-for-dom-credentialrequestoptions-digital-2 "§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method")
* [§ B. IDL Index](#ref-for-dom-credentialrequestoptions-digital-3 "§ B. IDL Index")

[Permalink](#dom-digitalcredentialrequestoptions)
exported

**Referenced in:**

* [§ 7.1 Extensions to CredentialRequestOptions dictionary](#ref-for-dom-digitalcredentialrequestoptions-1 "§ 7.1 Extensions to CredentialRequestOptions dictionary")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialrequestoptions-2 "§ B. IDL Index")

[Permalink](#dom-digitalcredentialrequestoptions-requests)
exported [IDL](#webidl-1036266394 "Jump to IDL declaration")

**Referenced in:**

* [§ 7.2 The DigitalCredentialRequestOptions dictionary](#ref-for-dom-digitalcredentialrequestoptions-requests-1 "§ 7.2 The DigitalCredentialRequestOptions dictionary")
* [§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method](#ref-for-dom-digitalcredentialrequestoptions-requests-2 "§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialrequestoptions-requests-3 "§ B. IDL Index")

[Permalink](#dom-digitalcredentialgetrequest)
exported

**Referenced in:**

* [§ 5.1 Convert request protocol](#ref-for-dom-digitalcredentialgetrequest-1 "§ 5.1 Convert request protocol") [(2)](#ref-for-dom-digitalcredentialgetrequest-2 "Reference 2")
* [§ 6.2 Prepare credential requests](#ref-for-dom-digitalcredentialgetrequest-3 "§ 6.2 Prepare credential requests")
* [§ 6.3 Filter credential requests](#ref-for-dom-digitalcredentialgetrequest-4 "§ 6.3 Filter credential requests")
* [§ 6.4 Validate credential requests](#ref-for-dom-digitalcredentialgetrequest-5 "§ 6.4 Validate credential requests") [(2)](#ref-for-dom-digitalcredentialgetrequest-6 "Reference 2")
* [§ 7.2 The DigitalCredentialRequestOptions dictionary](#ref-for-dom-digitalcredentialgetrequest-7 "§ 7.2 The DigitalCredentialRequestOptions dictionary")
* [§ 7.3 The DigitalCredentialGetRequest dictionary](#ref-for-dom-digitalcredentialgetrequest-8 "§ 7.3 The DigitalCredentialGetRequest dictionary")
* [§ 10.1.1 In-Scope Threats](#ref-for-dom-digitalcredentialgetrequest-9 "§ 10.1.1 In-Scope Threats")
* [§ 13. Internationalization Considerations](#ref-for-dom-digitalcredentialgetrequest-10 "§ 13. Internationalization Considerations")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialgetrequest-11 "§ B. IDL Index")

[Permalink](#dom-digitalcredentialgetrequest-protocol)
exported [IDL](#webidl-1753533423 "Jump to IDL declaration")

**Referenced in:**

* [§ 5.1 Convert request protocol](#ref-for-dom-digitalcredentialgetrequest-protocol-1 "§ 5.1 Convert request protocol")
* [§ 7.3 The DigitalCredentialGetRequest dictionary](#ref-for-dom-digitalcredentialgetrequest-protocol-2 "§ 7.3 The DigitalCredentialGetRequest dictionary")
* [§ 7.3.1 The protocol member](#ref-for-dom-digitalcredentialgetrequest-protocol-3 "§ 7.3.1 The protocol member")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialgetrequest-protocol-4 "§ B. IDL Index")

[Permalink](#dom-digitalcredentialgetrequest-data)
exported [IDL](#webidl-1753533423 "Jump to IDL declaration")

**Referenced in:**

* [§ 6.4 Validate credential requests](#ref-for-dom-digitalcredentialgetrequest-data-1 "§ 6.4 Validate credential requests")
* [§ 7.3 The DigitalCredentialGetRequest dictionary](#ref-for-dom-digitalcredentialgetrequest-data-2 "§ 7.3 The DigitalCredentialGetRequest dictionary")
* [§ 13. Internationalization Considerations](#ref-for-dom-digitalcredentialgetrequest-data-3 "§ 13. Internationalization Considerations")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialgetrequest-data-4 "§ B. IDL Index")

[Permalink](#dom-credentialcreationoptions-digital)
exported [IDL](#webidl-1126267341 "Jump to IDL declaration")

**Referenced in:**

* [§ 7.4 Extensions to CredentialCreationOptions dictionary](#ref-for-dom-credentialcreationoptions-digital-1 "§ 7.4 Extensions to CredentialCreationOptions dictionary")
* [§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method](#ref-for-dom-credentialcreationoptions-digital-2 "§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method")
* [§ B. IDL Index](#ref-for-dom-credentialcreationoptions-digital-3 "§ B. IDL Index")

[Permalink](#dom-digitalcredentialcreationoptions)
exported

**Referenced in:**

* [§ 7.4 Extensions to CredentialCreationOptions dictionary](#ref-for-dom-digitalcredentialcreationoptions-1 "§ 7.4 Extensions to CredentialCreationOptions dictionary")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialcreationoptions-2 "§ B. IDL Index")

[Permalink](#dom-digitalcredentialcreationoptions-requests)
exported [IDL](#webidl-185698318 "Jump to IDL declaration")

**Referenced in:**

* [§ 7.5 The DigitalCredentialCreationOptions dictionary](#ref-for-dom-digitalcredentialcreationoptions-requests-1 "§ 7.5 The DigitalCredentialCreationOptions dictionary")
* [§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method](#ref-for-dom-digitalcredentialcreationoptions-requests-2 "§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialcreationoptions-requests-3 "§ B. IDL Index")

[Permalink](#dom-digitalcredentialcreaterequest)
exported

**Referenced in:**

* [§ 5.1 Convert request protocol](#ref-for-dom-digitalcredentialcreaterequest-1 "§ 5.1 Convert request protocol") [(2)](#ref-for-dom-digitalcredentialcreaterequest-2 "Reference 2")
* [§ 6.2 Prepare credential requests](#ref-for-dom-digitalcredentialcreaterequest-3 "§ 6.2 Prepare credential requests")
* [§ 6.3 Filter credential requests](#ref-for-dom-digitalcredentialcreaterequest-4 "§ 6.3 Filter credential requests")
* [§ 6.4 Validate credential requests](#ref-for-dom-digitalcredentialcreaterequest-5 "§ 6.4 Validate credential requests") [(2)](#ref-for-dom-digitalcredentialcreaterequest-6 "Reference 2")
* [§ 7.5 The DigitalCredentialCreationOptions dictionary](#ref-for-dom-digitalcredentialcreaterequest-7 "§ 7.5 The DigitalCredentialCreationOptions dictionary")
* [§ 7.6 The DigitalCredentialCreateRequest dictionary](#ref-for-dom-digitalcredentialcreaterequest-8 "§ 7.6 The DigitalCredentialCreateRequest dictionary")
* [§ 10.1.1 In-Scope Threats](#ref-for-dom-digitalcredentialcreaterequest-9 "§ 10.1.1 In-Scope Threats")
* [§ 13. Internationalization Considerations](#ref-for-dom-digitalcredentialcreaterequest-10 "§ 13. Internationalization Considerations")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialcreaterequest-11 "§ B. IDL Index")

[Permalink](#dom-digitalcredentialcreaterequest-protocol)
exported [IDL](#webidl-1732532479 "Jump to IDL declaration")

**Referenced in:**

* [§ 5.1 Convert request protocol](#ref-for-dom-digitalcredentialcreaterequest-protocol-1 "§ 5.1 Convert request protocol")
* [§ 7.6 The DigitalCredentialCreateRequest dictionary](#ref-for-dom-digitalcredentialcreaterequest-protocol-2 "§ 7.6 The DigitalCredentialCreateRequest dictionary")
* [§ 7.6.1 The protocol member](#ref-for-dom-digitalcredentialcreaterequest-protocol-3 "§ 7.6.1 The protocol member")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialcreaterequest-protocol-4 "§ B. IDL Index")

[Permalink](#dom-digitalcredentialcreaterequest-data)
exported [IDL](#webidl-1732532479 "Jump to IDL declaration")

**Referenced in:**

* [§ 6.4 Validate credential requests](#ref-for-dom-digitalcredentialcreaterequest-data-1 "§ 6.4 Validate credential requests")
* [§ 7.6 The DigitalCredentialCreateRequest dictionary](#ref-for-dom-digitalcredentialcreaterequest-data-2 "§ 7.6 The DigitalCredentialCreateRequest dictionary")
* [§ 13. Internationalization Considerations](#ref-for-dom-digitalcredentialcreaterequest-data-3 "§ 13. Internationalization Considerations")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialcreaterequest-data-4 "§ B. IDL Index")

[Permalink](#dom-digitalcredential)
exported [IDL](#webidl-245360792 "Jump to IDL declaration")

**Referenced in:**

* [§ 2.2 Checking if protocol is allowed](#ref-for-dom-digitalcredential-1 "§ 2.2 Checking if protocol is allowed") [(2)](#ref-for-dom-digitalcredential-2 "Reference 2")
* [§ 5. Protocols](#ref-for-dom-digitalcredential-3 "§ 5. Protocols")
* [§ 6.7 Initiate the credential request](#ref-for-dom-digitalcredential-4 "§ 6.7 Initiate the credential request")
* [§ 7. The Digital Credentials API](#ref-for-dom-digitalcredential-5 "§ 7. The Digital Credentials API") [(2)](#ref-for-dom-digitalcredential-6 "Reference 2")
* [§ 7.7 The DigitalCredential interface](#ref-for-dom-digitalcredential-7 "§ 7.7 The DigitalCredential interface") [(2)](#ref-for-dom-digitalcredential-8 "Reference 2") [(3)](#ref-for-dom-digitalcredential-9 "Reference 3") [(4)](#ref-for-dom-digitalcredential-10 "Reference 4") [(5)](#ref-for-dom-digitalcredential-11 "Reference 5")
* [§ 7.8 Supporting Data Structures](#ref-for-dom-digitalcredential-12 "§ 7.8 Supporting Data Structures")
* [§ 8.4 [[type]] internal slot](#ref-for-dom-digitalcredential-13 "§ 8.4 [[type]] internal slot")
* [§ 8.5 [[discovery]] internal slot](#ref-for-dom-digitalcredential-14 "§ 8.5 [[discovery]] internal slot")
* [§ 10.2 Mitigations](#ref-for-dom-digitalcredential-15 "§ 10.2 Mitigations")
* [§ 13. Internationalization Considerations](#ref-for-dom-digitalcredential-16 "§ 13. Internationalization Considerations")
* [§ 14.2 Handle Virtual Wallet Behavior](#ref-for-dom-digitalcredential-17 "§ 14.2 Handle Virtual Wallet Behavior")
* [§ B. IDL Index](#ref-for-dom-digitalcredential-18 "§ B. IDL Index")

[Permalink](#dom-digitalcredentialprotocol)
exported

**Referenced in:**

* [§ 2.2 Checking if protocol is allowed](#ref-for-dom-digitalcredentialprotocol-1 "§ 2.2 Checking if protocol is allowed") [(2)](#ref-for-dom-digitalcredentialprotocol-2 "Reference 2")
* [§ 7.7 The DigitalCredential interface](#ref-for-dom-digitalcredentialprotocol-3 "§ 7.7 The DigitalCredential interface")
* [§ 7.7.3 The userAgentAllowsProtocol() method](#ref-for-dom-digitalcredentialprotocol-4 "§ 7.7.3 The userAgentAllowsProtocol() method")
* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-dom-digitalcredentialprotocol-5 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialprotocol-6 "§ B. IDL Index")

[Permalink](#dom-digitalcredential-protocol)
exported [IDL](#webidl-245360792 "Jump to IDL declaration")

**Referenced in:**

* [§ 6.7 Initiate the credential request](#ref-for-dom-digitalcredential-protocol-1 "§ 6.7 Initiate the credential request")
* [§ 7.7 The DigitalCredential interface](#ref-for-dom-digitalcredential-protocol-2 "§ 7.7 The DigitalCredential interface")
* [§ 14.2 Handle Virtual Wallet Behavior](#ref-for-dom-digitalcredential-protocol-3 "§ 14.2 Handle Virtual Wallet Behavior")
* [§ B. IDL Index](#ref-for-dom-digitalcredential-protocol-4 "§ B. IDL Index")

[Permalink](#dom-digitalcredential-data)
exported [IDL](#webidl-245360792 "Jump to IDL declaration")

**Referenced in:**

* [§ 6.7 Initiate the credential request](#ref-for-dom-digitalcredential-data-1 "§ 6.7 Initiate the credential request") [(2)](#ref-for-dom-digitalcredential-data-2 "Reference 2")
* [§ 7.7 The DigitalCredential interface](#ref-for-dom-digitalcredential-data-3 "§ 7.7 The DigitalCredential interface")
* [§ 13. Internationalization Considerations](#ref-for-dom-digitalcredential-data-4 "§ 13. Internationalization Considerations")
* [§ 14.2 Handle Virtual Wallet Behavior](#ref-for-dom-digitalcredential-data-5 "§ 14.2 Handle Virtual Wallet Behavior")
* [§ B. IDL Index](#ref-for-dom-digitalcredential-data-6 "§ B. IDL Index")

[Permalink](#dom-digitalcredential-useragentallowsprotocol)
exported [IDL](#webidl-245360792 "Jump to IDL declaration")

**Referenced in:**

* [§ 2.2 Checking if protocol is allowed](#ref-for-dom-digitalcredential-useragentallowsprotocol-1 "§ 2.2 Checking if protocol is allowed")
* [§ 5. Protocols](#ref-for-dom-digitalcredential-useragentallowsprotocol-2 "§ 5. Protocols")
* [§ 7.7 The DigitalCredential interface](#ref-for-dom-digitalcredential-useragentallowsprotocol-3 "§ 7.7 The DigitalCredential interface")
* [§ 7.7.3 The userAgentAllowsProtocol() method](#ref-for-dom-digitalcredential-useragentallowsprotocol-4 "§ 7.7.3 The userAgentAllowsProtocol() method")
* [§ 11.5.3 Revealing device properties through protocol availability](#ref-for-dom-digitalcredential-useragentallowsprotocol-5 "§ 11.5.3 Revealing device properties through protocol availability")
* [§ B. IDL Index](#ref-for-dom-digitalcredential-useragentallowsprotocol-6 "§ B. IDL Index")

[Permalink](#dfn-user-agent-allows-protocol)

**Referenced in:**

* [§ 6.3 Filter credential requests](#ref-for-dfn-user-agent-allows-protocol-1 "§ 6.3 Filter credential requests")
* [§ 7.7.3 The userAgentAllowsProtocol() method](#ref-for-dfn-user-agent-allows-protocol-2 "§ 7.7.3 The userAgentAllowsProtocol() method")

[Permalink](#dfn-request-context)

**Referenced in:**

* [§ 6.7 Initiate the credential request](#ref-for-dfn-request-context-1 "§ 6.7 Initiate the credential request")

[Permalink](#dfn-requests)

**Referenced in:**

* [§ 6.7 Initiate the credential request](#ref-for-dfn-requests-1 "§ 6.7 Initiate the credential request")

[Permalink](#dfn-top-level-origin)

**Referenced in:**

* [§ 6.7 Initiate the credential request](#ref-for-dfn-top-level-origin-1 "§ 6.7 Initiate the credential request")
* [§ 13. Internationalization Considerations](#ref-for-dfn-top-level-origin-2 "§ 13. Internationalization Considerations")

[Permalink](#dom-digitalcredentialpresentationprotocol)
exported

**Referenced in:**

* [§ 5.1 Convert request protocol](#ref-for-dom-digitalcredentialpresentationprotocol-1 "§ 5.1 Convert request protocol") [(2)](#ref-for-dom-digitalcredentialpresentationprotocol-2 "Reference 2")
* [§ 7.3.1 The protocol member](#ref-for-dom-digitalcredentialpresentationprotocol-3 "§ 7.3.1 The protocol member")
* [§ 7.7 The DigitalCredential interface](#ref-for-dom-digitalcredentialpresentationprotocol-4 "§ 7.7 The DigitalCredential interface")
* [§ 7.8.2 The DigitalCredentialPresentationProtocol enumeration](#ref-for-dom-digitalcredentialpresentationprotocol-5 "§ 7.8.2 The DigitalCredentialPresentationProtocol enumeration")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialpresentationprotocol-6 "§ B. IDL Index")

[Permalink](#dom-digitalcredentialissuanceprotocol)
exported

**Referenced in:**

* [§ 5.1 Convert request protocol](#ref-for-dom-digitalcredentialissuanceprotocol-1 "§ 5.1 Convert request protocol") [(2)](#ref-for-dom-digitalcredentialissuanceprotocol-2 "Reference 2")
* [§ 7.6.1 The protocol member](#ref-for-dom-digitalcredentialissuanceprotocol-3 "§ 7.6.1 The protocol member")
* [§ 7.7 The DigitalCredential interface](#ref-for-dom-digitalcredentialissuanceprotocol-4 "§ 7.7 The DigitalCredential interface")
* [§ 7.8.3 The DigitalCredentialIssuanceProtocol enumeration](#ref-for-dom-digitalcredentialissuanceprotocol-5 "§ 7.8.3 The DigitalCredentialIssuanceProtocol enumeration")
* [§ B. IDL Index](#ref-for-dom-digitalcredentialissuanceprotocol-6 "§ B. IDL Index")

[Permalink](#dfn-discoverfromexternalsource-origin-options-sameoriginwithancestors)
exported

**Referenced in:**

* [§ 7. The Digital Credentials API](#ref-for-dfn-discoverfromexternalsource-origin-options-sameoriginwithancestors-1 "§ 7. The Digital Credentials API")
* [§ 10.2 Mitigations](#ref-for-dfn-discoverfromexternalsource-origin-options-sameoriginwithancestors-2 "§ 10.2 Mitigations")
* [§ 14.1 The digitalCredentials Module](#ref-for-dfn-discoverfromexternalsource-origin-options-sameoriginwithancestors-3 "§ 14.1 The digitalCredentials Module")

[Permalink](#dfn-store-credential-sameoriginwithancestors)
exported

**Referenced in:**

* Not referenced in this document.

[Permalink](#dfn-create-origin-options-sameoriginwithancestors)
exported

**Referenced in:**

* [§ 10.2 Mitigations](#ref-for-dfn-create-origin-options-sameoriginwithancestors-1 "§ 10.2 Mitigations")

[Permalink](#dfn-type)
exported

**Referenced in:**

* Not referenced in this document.

[Permalink](#dfn-discovery)
exported

**Referenced in:**

* Not referenced in this document.

[Permalink](#dfn-digital-credentials-get)

**Referenced in:**

* [§ 2.5 Requesting a digital credential across origins](#ref-for-dfn-digital-credentials-get-1 "§ 2.5 Requesting a digital credential across origins")
* [§ 10.2 Mitigations](#ref-for-dfn-digital-credentials-get-2 "§ 10.2 Mitigations") [(2)](#ref-for-dfn-digital-credentials-get-3 "Reference 2")

[Permalink](#dfn-digital-credentials-create)

**Referenced in:**

* [§ 2.6 Issuing a digital credential across origins](#ref-for-dfn-digital-credentials-create-1 "§ 2.6 Issuing a digital credential across origins")
* [§ 10.2 Mitigations](#ref-for-dfn-digital-credentials-create-2 "§ 10.2 Mitigations") [(2)](#ref-for-dfn-digital-credentials-create-3 "Reference 2")

[Permalink](#dfn-in-scope-threats)

**Referenced in:**

* [§ 10.1 Threat Model](#ref-for-dfn-in-scope-threats-1 "§ 10.1 Threat Model")
* [§ 10.1.1 In-Scope Threats](#ref-for-dfn-in-scope-threats-2 "§ 10.1.1 In-Scope Threats")
* [§ 10.2 Mitigations](#ref-for-dfn-in-scope-threats-3 "§ 10.2 Mitigations")

[Permalink](#dfn-request-tampering)

**Referenced in:**

* [§ 10.2 Mitigations](#ref-for-dfn-request-tampering-1 "§ 10.2 Mitigations")

[Permalink](#dfn-api-flooding)

**Referenced in:**

* [§ 10.2 Mitigations](#ref-for-dfn-api-flooding-1 "§ 10.2 Mitigations")

[Permalink](#dfn-unauthorized-cross-origin-access)

**Referenced in:**

* [§ 10.2 Mitigations](#ref-for-dfn-unauthorized-cross-origin-access-1 "§ 10.2 Mitigations")

[Permalink](#dfn-malicious-payloads-to-the-underlying-platform)

**Referenced in:**

* [§ 10.2 Mitigations](#ref-for-dfn-malicious-payloads-to-the-underlying-platform-1 "§ 10.2 Mitigations")

[Permalink](#dfn-out-of-scope-threats)

**Referenced in:**

* [§ 10.1 Threat Model](#ref-for-dfn-out-of-scope-threats-1 "§ 10.1 Threat Model")
* [§ 10.1.2 Out of Scope Threats](#ref-for-dfn-out-of-scope-threats-2 "§ 10.1.2 Out of Scope Threats")

[Permalink](#dfn-os-or-device-compromise)

**Referenced in:**

* Not referenced in this document.

[Permalink](#dfn-malicious-credential-managers)

**Referenced in:**

* Not referenced in this document.

[Permalink](#dfn-protocol-and-format-vulnerabilities)

**Referenced in:**

* Not referenced in this document.

[Permalink](#cddl-type-digitalcredentials-virtualwalletaction)
exported
[CDDL](#cddl-block-1238149299 "Jump to CDDL declaration")

**Referenced in:**

* [§ 14.1.1 Types](#ref-for-cddl-type-digitalcredentials-virtualwalletaction-1 "§ 14.1.1 Types") [(2)](#ref-for-cddl-type-digitalcredentials-virtualwalletaction-2 "Reference 2")
* [§ C.1 Module: remote-cddl](#ref-for-cddl-type-digitalcredentials-virtualwalletaction-3 "§ C.1 Module: remote-cddl")

[Permalink](#cddl-value-digitalcredentials-virtualwalletaction-decline)
exported

**Referenced in:**

* [§ 14.1.1 Types](#ref-for-cddl-value-digitalcredentials-virtualwalletaction-decline-1 "§ 14.1.1 Types")

[Permalink](#cddl-value-digitalcredentials-virtualwalletaction-respond)
exported

**Referenced in:**

* [§ 14.1.1 Types](#ref-for-cddl-value-digitalcredentials-virtualwalletaction-respond-1 "§ 14.1.1 Types")

[Permalink](#cddl-value-digitalcredentials-virtualwalletaction-wait)
exported

**Referenced in:**

* [§ 14.1.1 Types](#ref-for-cddl-value-digitalcredentials-virtualwalletaction-wait-1 "§ 14.1.1 Types")

[Permalink](#cddl-value-digitalcredentials-virtualwalletaction-clear)
exported

**Referenced in:**

* [§ 14.1.1 Types](#ref-for-cddl-value-digitalcredentials-virtualwalletaction-clear-1 "§ 14.1.1 Types")

[Permalink](#cddl-type-digitalcredentials-setvirtualwalletbehaviorparameters)
exported
[CDDL](#cddl-block-387937039 "Jump to CDDL declaration")

**Referenced in:**

* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-cddl-type-digitalcredentials-setvirtualwalletbehaviorparameters-1 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command")
* [§ C.1 Module: remote-cddl](#ref-for-cddl-type-digitalcredentials-setvirtualwalletbehaviorparameters-2 "§ C.1 Module: remote-cddl")

[Permalink](#cddl-key-digitalcredentials-setvirtualwalletbehaviorparameters-action)
exported

**Referenced in:**

* Not referenced in this document.

[Permalink](#cddl-key-digitalcredentials-setvirtualwalletbehaviorparameters-context)
exported

**Referenced in:**

* Not referenced in this document.

[Permalink](#cddl-key-digitalcredentials-setvirtualwalletbehaviorparameters-protocol)
exported

**Referenced in:**

* Not referenced in this document.

[Permalink](#cddl-key-digitalcredentials-setvirtualwalletbehaviorparameters-response)
exported

**Referenced in:**

* Not referenced in this document.

[Permalink](#cddl-key-digitalcredentials-setvirtualwalletbehaviorparameters-text)
exported

**Referenced in:**

* Not referenced in this document.

[Permalink](#cddl-type-digitalcredentials-setvirtualwalletbehavior)
exported

**Referenced in:**

* Not referenced in this document.

[Permalink](#cddl-key-digitalcredentials-setvirtualwalletbehavior-method)
exported

**Referenced in:**

* Not referenced in this document.

[Permalink](#cddl-value-digitalcredentials-setvirtualwalletbehavior-digitalcredentials-setvirtualwalletbehavior)
exported

**Referenced in:**

* Not referenced in this document.

[Permalink](#cddl-key-digitalcredentials-setvirtualwalletbehavior-params)
exported

**Referenced in:**

* Not referenced in this document.

[Permalink](#cddl-type-digitalcredentials-setvirtualwalletbehaviorresult)
exported

**Referenced in:**

* Not referenced in this document.

[Permalink](#dfn-active-virtual-wallet-behavior)

**Referenced in:**

* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-dfn-active-virtual-wallet-behavior-1 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command") [(2)](#ref-for-dfn-active-virtual-wallet-behavior-2 "Reference 2") [(3)](#ref-for-dfn-active-virtual-wallet-behavior-3 "Reference 3")
* [§ 14.2 Handle Virtual Wallet Behavior](#ref-for-dfn-active-virtual-wallet-behavior-4 "§ 14.2 Handle Virtual Wallet Behavior") [(2)](#ref-for-dfn-active-virtual-wallet-behavior-5 "Reference 2")

[Permalink](#dfn-handle-virtual-wallet-behavior)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-dfn-handle-virtual-wallet-behavior-1 "§ 6.2 Prepare credential requests")

[Permalink](https://www.w3.org/TR/credential-management-1/#dom-credential-create-slot)

**Referenced in:**

* [§ 7. The Digital Credentials API](#ref-for-index-term-create-origin-options-sameoriginwithancestors-for-credential-1 "§ 7. The Digital Credentials API")
* [§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method](#ref-for-index-term-create-origin-options-sameoriginwithancestors-for-credential-2 "§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method")
* [§ 14.1 The digitalCredentials Module](#ref-for-index-term-create-origin-options-sameoriginwithancestors-for-credential-3 "§ 14.1 The digitalCredentials Module")

[Permalink](https://www.w3.org/TR/credential-management-1/#dom-credential-discoverfromexternalsource-slot)

**Referenced in:**

* [§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method](#ref-for-index-term-discoverfromexternalsource-origin-options-sameoriginwithancestors-for-credential-1 "§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method")

[Permalink](https://www.w3.org/TR/credential-management-1/#dom-credential-store-slot)

**Referenced in:**

* [§ 8.2 [[Store]](credential, sameOriginWithAncestors) internal method](#ref-for-index-term-store-credential-sameoriginwithancestors-for-credential-1 "§ 8.2 [[Store]](credential, sameOriginWithAncestors) internal method")

[Permalink](https://www.w3.org/TR/credential-management-1/#abstract-opdef-create-a-credential)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-create-a-credential-1 "§ 6.2 Prepare credential requests")
* [§ 7. The Digital Credentials API](#ref-for-index-term-create-a-credential-2 "§ 7. The Digital Credentials API")
* [§ 9. Permissions Policy integration](#ref-for-index-term-create-a-credential-3 "§ 9. Permissions Policy integration")
* [§ 10.2 Mitigations](#ref-for-index-term-create-a-credential-4 "§ 10.2 Mitigations")

[Permalink](https://www.w3.org/TR/credential-management-1/#dom-credentialscontainer-create)

**Referenced in:**

* [§ 2.4 Issuing a digital credential](#ref-for-index-term-create-for-credentialscontainer-1 "§ 2.4 Issuing a digital credential")
* [§ 7. The Digital Credentials API](#ref-for-index-term-create-for-credentialscontainer-2 "§ 7. The Digital Credentials API")
* [§ 7.7 The DigitalCredential interface](#ref-for-index-term-create-for-credentialscontainer-3 "§ 7.7 The DigitalCredential interface")
* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-index-term-create-for-credentialscontainer-4 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command")

[Permalink](https://www.w3.org/TR/credential-management-1/#credential)

**Referenced in:**

* [§ 7.7 The DigitalCredential interface](#ref-for-index-term-credential-interface-1 "§ 7.7 The DigitalCredential interface")
* [§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method](#ref-for-index-term-credential-interface-2 "§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method")
* [§ 8.2 [[Store]](credential, sameOriginWithAncestors) internal method](#ref-for-index-term-credential-interface-3 "§ 8.2 [[Store]](credential, sameOriginWithAncestors) internal method")
* [§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method](#ref-for-index-term-credential-interface-4 "§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method")
* [§ B. IDL Index](#ref-for-index-term-credential-interface-5 "§ B. IDL Index")

[Permalink](https://www.w3.org/TR/credential-management-1/#credential-chooser)

**Referenced in:**

* [§ 4. Terminology](#ref-for-index-term-credential-chooser-1 "§ 4. Terminology")

[Permalink](https://www.w3.org/TR/credential-management-1/#credential-manager)

**Referenced in:**

* [§ 1. Introduction](#ref-for-index-term-credential-manager-1 "§ 1. Introduction")
* [§ 2.3 Requesting a digital credential](#ref-for-index-term-credential-manager-2 "§ 2.3 Requesting a digital credential")
* [§ 3. Scope](#ref-for-index-term-credential-manager-3 "§ 3. Scope") [(2)](#ref-for-index-term-credential-manager-4 "Reference 2")
* [§ 4. Terminology](#ref-for-index-term-credential-manager-5 "§ 4. Terminology") [(2)](#ref-for-index-term-credential-manager-6 "Reference 2")
* [§ 6. Credential Request Coordinator](#ref-for-index-term-credential-manager-7 "§ 6. Credential Request Coordinator") [(2)](#ref-for-index-term-credential-manager-8 "Reference 2") [(3)](#ref-for-index-term-credential-manager-9 "Reference 3")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-credential-manager-10 "§ 6.7 Initiate the credential request")
* [§ 7. The Digital Credentials API](#ref-for-index-term-credential-manager-11 "§ 7. The Digital Credentials API") [(2)](#ref-for-index-term-credential-manager-12 "Reference 2")
* [§ 7.2.1 The requests member](#ref-for-index-term-credential-manager-13 "§ 7.2.1 The requests member")
* [§ 7.3 The DigitalCredentialGetRequest dictionary](#ref-for-index-term-credential-manager-14 "§ 7.3 The DigitalCredentialGetRequest dictionary")
* [§ 7.3.2 The data member](#ref-for-index-term-credential-manager-15 "§ 7.3.2 The data member")
* [§ 7.6.2 The data member](#ref-for-index-term-credential-manager-16 "§ 7.6.2 The data member")
* [§ 7.7.3 The userAgentAllowsProtocol() method](#ref-for-index-term-credential-manager-17 "§ 7.7.3 The userAgentAllowsProtocol() method")
* [§ 10.1.1 In-Scope Threats](#ref-for-index-term-credential-manager-18 "§ 10.1.1 In-Scope Threats")
* [§ 10.1.2 Out of Scope Threats](#ref-for-index-term-credential-manager-19 "§ 10.1.2 Out of Scope Threats") [(2)](#ref-for-index-term-credential-manager-20 "Reference 2") [(3)](#ref-for-index-term-credential-manager-21 "Reference 3")
* [§ 10.2 Mitigations](#ref-for-index-term-credential-manager-22 "§ 10.2 Mitigations") [(2)](#ref-for-index-term-credential-manager-23 "Reference 2")
* [§ 10.3 Signing presentation requests](#ref-for-index-term-credential-manager-24 "§ 10.3 Signing presentation requests") [(2)](#ref-for-index-term-credential-manager-25 "Reference 2") [(3)](#ref-for-index-term-credential-manager-26 "Reference 3")
* [§ 10.4 Cross-Device Security and Proximity](#ref-for-index-term-credential-manager-27 "§ 10.4 Cross-Device Security and Proximity") [(2)](#ref-for-index-term-credential-manager-28 "Reference 2")
* [§ 11.3.1.2 Unlinkable presentations](#ref-for-index-term-credential-manager-29 "§ 11.3.1.2 Unlinkable presentations") [(2)](#ref-for-index-term-credential-manager-30 "Reference 2") [(3)](#ref-for-index-term-credential-manager-31 "Reference 3")
* [§ 11.3.1.3 "Phone home" mechanisms](#ref-for-index-term-credential-manager-32 "§ 11.3.1.3 \"Phone home\" mechanisms") [(2)](#ref-for-index-term-credential-manager-33 "Reference 2")
* [§ 11.3.1.6 Support for verifier authorization](#ref-for-index-term-credential-manager-34 "§ 11.3.1.6 Support for verifier authorization")
* [§ 11.4 Unnecessary Requests for Credentials](#ref-for-index-term-credential-manager-35 "§ 11.4 Unnecessary Requests for Credentials")
* [§ 11.4.2.3 Mitigating unnecessary requests for non-government credentials](#ref-for-index-term-credential-manager-36 "§ 11.4.2.3 Mitigating unnecessary requests for non-government credentials")
* [§ 11.5.2 Leaking incidental data with credential presentations](#ref-for-index-term-credential-manager-37 "§ 11.5.2 Leaking incidental data with credential presentations")
* [§ 11.5.3 Revealing device properties through protocol availability](#ref-for-index-term-credential-manager-38 "§ 11.5.3 Revealing device properties through protocol availability")
* [§ 11.6 User Permission and Transparency](#ref-for-index-term-credential-manager-39 "§ 11.6 User Permission and Transparency") [(2)](#ref-for-index-term-credential-manager-40 "Reference 2")
* [§ 11.6.3 Permission Prior to Credential Manager Selection](#ref-for-index-term-credential-manager-41 "§ 11.6.3 Permission Prior to Credential Manager Selection")
* [§ 11.6.4 Permission vs. Consent](#ref-for-index-term-credential-manager-42 "§ 11.6.4 Permission vs. Consent")
* [§ 11.7 Data Clearing and Persistent State](#ref-for-index-term-credential-manager-43 "§ 11.7 Data Clearing and Persistent State")
* [§ 12. Accessibility Considerations](#ref-for-index-term-credential-manager-44 "§ 12. Accessibility Considerations")
* [§ 14.1 The digitalCredentials Module](#ref-for-index-term-credential-manager-45 "§ 14.1 The digitalCredentials Module")

[Permalink](https://www.w3.org/TR/credential-management-1/#dictdef-credentialcreationoptions)

**Referenced in:**

* [§ 7.4 Extensions to CredentialCreationOptions dictionary](#ref-for-index-term-credentialcreationoptions-1 "§ 7.4 Extensions to CredentialCreationOptions dictionary")
* [§ B. IDL Index](#ref-for-index-term-credentialcreationoptions-2 "§ B. IDL Index")

[Permalink](https://www.w3.org/TR/credential-management-1/#dictdef-credentialrequestoptions)

**Referenced in:**

* [§ 7.1 Extensions to CredentialRequestOptions dictionary](#ref-for-index-term-credentialrequestoptions-1 "§ 7.1 Extensions to CredentialRequestOptions dictionary")
* [§ B. IDL Index](#ref-for-index-term-credentialrequestoptions-2 "§ B. IDL Index")

[Permalink](https://www.w3.org/TR/credential-management-1/#credentialscontainer)

**Referenced in:**

* [§ 8.6 User permission](#ref-for-index-term-credentialscontainer-interface-1 "§ 8.6 User permission")

[Permalink](https://www.w3.org/TR/credential-management-1/#dom-credentialscontainer-get)

**Referenced in:**

* [§ 2.3 Requesting a digital credential](#ref-for-index-term-get-for-credentialscontainer-1 "§ 2.3 Requesting a digital credential")
* [§ 7. The Digital Credentials API](#ref-for-index-term-get-for-credentialscontainer-2 "§ 7. The Digital Credentials API")
* [§ 7.7 The DigitalCredential interface](#ref-for-index-term-get-for-credentialscontainer-3 "§ 7.7 The DigitalCredential interface")
* [§ 8.6 User permission](#ref-for-index-term-get-for-credentialscontainer-4 "§ 8.6 User permission")
* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-index-term-get-for-credentialscontainer-5 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command")

[Permalink](https://www.w3.org/TR/credential-management-1/#dom-credentialrequestoptions-mediation)

**Referenced in:**

* [§ 7.7 The DigitalCredential interface](#ref-for-index-term-mediation-for-credentialrequestoptions-1 "§ 7.7 The DigitalCredential interface")

[Permalink](https://www.w3.org/TR/credential-management-1/#dom-credentialcreationoptions-mediation)

**Referenced in:**

* [§ 7.7 The DigitalCredential interface](#ref-for-index-term-mediation-for-credentialcreationoptions-1 "§ 7.7 The DigitalCredential interface")

[Permalink](https://www.w3.org/TR/credential-management-1/#credential-origin-bound)

**Referenced in:**

* [§ 7.7 The DigitalCredential interface](#ref-for-index-term-origin-bound-for-credential-1 "§ 7.7 The DigitalCredential interface")
* [§ 10.2 Mitigations](#ref-for-index-term-origin-bound-for-credential-2 "§ 10.2 Mitigations")

[Permalink](https://www.w3.org/TR/credential-management-1/#abstract-opdef-request-a-credential)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-request-a-credential-1 "§ 6.2 Prepare credential requests")
* [§ 7. The Digital Credentials API](#ref-for-index-term-request-a-credential-2 "§ 7. The Digital Credentials API")
* [§ 9. Permissions Policy integration](#ref-for-index-term-request-a-credential-3 "§ 9. Permissions Policy integration")
* [§ 10.2 Mitigations](#ref-for-index-term-request-a-credential-4 "§ 10.2 Mitigations")

[Permalink](https://www.w3.org/TR/credential-management-1/#dom-credentialmediationrequirement-required)

**Referenced in:**

* [§ 7.7 The DigitalCredential interface](#ref-for-index-term-required-for-credentialmediationrequirement-1 "§ 7.7 The DigitalCredential interface") [(2)](#ref-for-index-term-required-for-credentialmediationrequirement-2 "Reference 2") [(3)](#ref-for-index-term-required-for-credentialmediationrequirement-3 "Reference 3")
* [§ 10.2 Mitigations](#ref-for-index-term-required-for-credentialmediationrequirement-4 "§ 10.2 Mitigations")

[Permalink](https://www.w3.org/TR/credential-management-1/#dom-credentialrequestoptions-signal)

**Referenced in:**

* [§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method](#ref-for-index-term-signal-for-credentialrequestoptions-1 "§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method")
* [§ 12. Accessibility Considerations](#ref-for-index-term-signal-for-credentialrequestoptions-2 "§ 12. Accessibility Considerations")
* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-index-term-signal-for-credentialrequestoptions-3 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command")

[Permalink](https://www.w3.org/TR/credential-management-1/#dom-credentialcreationoptions-signal)

**Referenced in:**

* [§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method](#ref-for-index-term-signal-for-credentialcreationoptions-1 "§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method")
* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-index-term-signal-for-credentialcreationoptions-2 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command")

[Permalink](https://www.w3.org/TR/credential-management-1/#user-mediated)

**Referenced in:**

* [§ 7.7 The DigitalCredential interface](#ref-for-index-term-user-mediation-1 "§ 7.7 The DigitalCredential interface")
* [§ 10.2 Mitigations](#ref-for-index-term-user-mediation-2 "§ 10.2 Mitigations")

[Permalink](https://dom.spec.whatwg.org/#abortsignal-abort-reason)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-abort-reason-for-abortsignal-1 "§ 6.2 Prepare credential requests")
* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-index-term-abort-reason-for-abortsignal-2 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command")

[Permalink](https://dom.spec.whatwg.org/#abortsignal-aborted)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-aborted-for-abortsignal-1 "§ 6.2 Prepare credential requests") [(2)](#ref-for-index-term-aborted-for-abortsignal-2 "Reference 2")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-aborted-for-abortsignal-3 "§ 6.7 Initiate the credential request")

[Permalink](https://dom.spec.whatwg.org/#abortsignal)

**Referenced in:**

* [§ 6. Credential Request Coordinator](#ref-for-index-term-abortsignal-interface-1 "§ 6. Credential Request Coordinator")
* [§ 6.2 Prepare credential requests](#ref-for-index-term-abortsignal-interface-2 "§ 6.2 Prepare credential requests")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-abortsignal-interface-3 "§ 6.7 Initiate the credential request")
* [§ 12. Accessibility Considerations](#ref-for-index-term-abortsignal-interface-4 "§ 12. Accessibility Considerations")
* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-index-term-abortsignal-interface-5 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command")

[Permalink](https://dom.spec.whatwg.org/#abortsignal-add)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-add-for-abortsignal-1 "§ 6.2 Prepare credential requests")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-add-for-abortsignal-2 "§ 6.7 Initiate the credential request")

[Permalink](https://dom.spec.whatwg.org/#concept-document)

**Referenced in:**

* [§ 6.7 Initiate the credential request](#ref-for-index-term-document-1 "§ 6.7 Initiate the credential request")
* [§ 9. Permissions Policy integration](#ref-for-index-term-document-2 "§ 9. Permissions Policy integration") [(2)](#ref-for-index-term-document-3 "Reference 2")

[Permalink](https://dom.spec.whatwg.org/#abortsignal-remove)

**Referenced in:**

* [§ 6.6 Reject the credential request](#ref-for-index-term-remove-for-abortsignal-1 "§ 6.6 Reject the credential request")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-remove-for-abortsignal-2 "§ 6.7 Initiate the credential request")

[Permalink](https://dom.spec.whatwg.org/#abortcontroller-signal-abort)

**Referenced in:**

* [§ 6.1 Interaction states](#ref-for-index-term-signal-abort-for-abortcontroller-1 "§ 6.1 Interaction states")

[Permalink](https://dom.spec.whatwg.org/#abortcontroller-signal)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-signals-for-abortcontroller-1 "§ 6.2 Prepare credential requests")

[Permalink](https://html.spec.whatwg.org/multipage/document-sequences.html#nav-document)

**Referenced in:**

* [§ 6.7 Initiate the credential request](#ref-for-index-term-active-document-for-navigable-1 "§ 6.7 Initiate the credential request")

[Permalink](https://html.spec.whatwg.org/multipage/nav-history-apis.html#concept-document-window)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-associated-document-1 "§ 6.2 Prepare credential requests")

[Permalink](https://html.spec.whatwg.org/multipage/document-sequences.html#browsing-context)

**Referenced in:**

* [§ 14.2 Handle Virtual Wallet Behavior](#ref-for-index-term-browsing-context-1 "§ 14.2 Handle Virtual Wallet Behavior")

[Permalink](https://html.spec.whatwg.org/multipage/document-sequences.html#child-navigable)

**Referenced in:**

* [§ 6. Credential Request Coordinator](#ref-for-index-term-child-navigables-1 "§ 6. Credential Request Coordinator")

[Permalink](https://html.spec.whatwg.org/multipage/interaction.html#consume-user-activation)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-consume-user-activation-1 "§ 6.2 Prepare credential requests")
* [§ 6.3 Filter credential requests](#ref-for-index-term-consume-user-activation-2 "§ 6.3 Filter credential requests")
* [§ 10.2 Mitigations](#ref-for-index-term-consume-user-activation-3 "§ 10.2 Mitigations")

[Permalink](https://html.spec.whatwg.org/multipage/webappapis.html#dom-manipulation-task-source)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-dom-manipulation-task-source-1 "§ 6.2 Prepare credential requests")
* [§ 6.6 Reject the credential request](#ref-for-index-term-dom-manipulation-task-source-2 "§ 6.6 Reject the credential request")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-dom-manipulation-task-source-3 "§ 6.7 Initiate the credential request")
* [§ 14.2 Handle Virtual Wallet Behavior](#ref-for-index-term-dom-manipulation-task-source-4 "§ 14.2 Handle Virtual Wallet Behavior")

[Permalink](https://html.spec.whatwg.org/multipage/webappapis.html#environment-settings-object)

**Referenced in:**

* [§ 7.8.1 The request context struct](#ref-for-index-term-environment-settings-object-1 "§ 7.8.1 The request context struct")

[Permalink](https://html.spec.whatwg.org/multipage/document-sequences.html#fully-active)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-fully-active-for-document-1 "§ 6.2 Prepare credential requests") [(2)](#ref-for-index-term-fully-active-for-document-2 "Reference 2")

[Permalink](https://html.spec.whatwg.org/multipage/interaction.html#fully-active-descendant-of-a-top-level-traversable-with-user-attention)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-fully-active-descendant-of-a-top-level-traversable-with-user-attention-for-document-1 "§ 6.2 Prepare credential requests")

[Permalink](https://html.spec.whatwg.org/multipage/iframe-embed-object.html#the-iframe-element)

**Referenced in:**

* [§ 10.1.1 In-Scope Threats](#ref-for-index-term-iframe-element-1 "§ 10.1.1 In-Scope Threats")

[Permalink](https://html.spec.whatwg.org/multipage/infrastructure.html#in-parallel)

**Referenced in:**

* [§ 6.7 Initiate the credential request](#ref-for-index-term-in-parallel-1 "§ 6.7 Initiate the credential request")

[Permalink](https://html.spec.whatwg.org/multipage/iframe-embed-object.html#the-object-element)

**Referenced in:**

* [§ 6.7 Initiate the credential request](#ref-for-index-term-object-type-1 "§ 6.7 Initiate the credential request")

[Permalink](https://html.spec.whatwg.org/multipage/browsers.html#concept-origin-opaque)

**Referenced in:**

* [§ 10.2 Mitigations](#ref-for-index-term-opaque-origin-1 "§ 10.2 Mitigations") [(2)](#ref-for-index-term-opaque-origin-2 "Reference 2")

[Permalink](https://html.spec.whatwg.org/multipage/browsers.html#concept-origin)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-origin-1 "§ 6.2 Prepare credential requests")
* [§ 10.4 Cross-Device Security and Proximity](#ref-for-index-term-origin-2 "§ 10.4 Cross-Device Security and Proximity") [(2)](#ref-for-index-term-origin-3 "Reference 2")

[Permalink](https://html.spec.whatwg.org/multipage/webappapis.html#concept-settings-object-origin)

**Referenced in:**

* [§ 6.7 Initiate the credential request](#ref-for-index-term-origin-for-environment-settings-object-1 "§ 6.7 Initiate the credential request")
* [§ 7.8.1 The request context struct](#ref-for-index-term-origin-for-environment-settings-object-2 "§ 7.8.1 The request context struct")

[Permalink](https://html.spec.whatwg.org/multipage/webappapis.html#queue-a-global-task)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-queue-a-global-task-1 "§ 6.2 Prepare credential requests")
* [§ 6.6 Reject the credential request](#ref-for-index-term-queue-a-global-task-2 "§ 6.6 Reject the credential request")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-queue-a-global-task-3 "§ 6.7 Initiate the credential request")
* [§ 14.2 Handle Virtual Wallet Behavior](#ref-for-index-term-queue-a-global-task-4 "§ 14.2 Handle Virtual Wallet Behavior")

[Permalink](https://html.spec.whatwg.org/multipage/webappapis.html#concept-relevant-global)

**Referenced in:**

* [§ 6.6 Reject the credential request](#ref-for-index-term-relevant-global-object-1 "§ 6.6 Reject the credential request")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-relevant-global-object-2 "§ 6.7 Initiate the credential request")
* [§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method](#ref-for-index-term-relevant-global-object-3 "§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method")
* [§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method](#ref-for-index-term-relevant-global-object-4 "§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method")

[Permalink](https://html.spec.whatwg.org/multipage/webappapis.html#concept-relevant-realm)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-relevant-realm-1 "§ 6.2 Prepare credential requests")
* [§ 14.2 Handle Virtual Wallet Behavior](#ref-for-index-term-relevant-realm-2 "§ 14.2 Handle Virtual Wallet Behavior")

[Permalink](https://html.spec.whatwg.org/multipage/webappapis.html#relevant-settings-object)

**Referenced in:**

* [§ 6.7 Initiate the credential request](#ref-for-index-term-relevant-settings-object-1 "§ 6.7 Initiate the credential request")

[Permalink](https://html.spec.whatwg.org/multipage/webappapis.html#secure-context)

**Referenced in:**

* [§ 10.2 Mitigations](#ref-for-index-term-secure-contexts-1 "§ 10.2 Mitigations") [(2)](#ref-for-index-term-secure-contexts-2 "Reference 2")
* [§ 10.3 Signing presentation requests](#ref-for-index-term-secure-contexts-3 "§ 10.3 Signing presentation requests")

[Permalink](https://html.spec.whatwg.org/multipage/document-sequences.html#top-level-traversable)

**Referenced in:**

* [§ 6. Credential Request Coordinator](#ref-for-index-term-top-level-traversable-1 "§ 6. Credential Request Coordinator") [(2)](#ref-for-index-term-top-level-traversable-2 "Reference 2")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-top-level-traversable-3 "§ 6.7 Initiate the credential request")

[Permalink](https://html.spec.whatwg.org/multipage/interaction.html#transient-activation)

**Referenced in:**

* [§ 1. Introduction](#ref-for-index-term-transient-activation-1 "§ 1. Introduction")
* [§ 6.2 Prepare credential requests](#ref-for-index-term-transient-activation-2 "§ 6.2 Prepare credential requests")

[Permalink](https://html.spec.whatwg.org/multipage/nav-history-apis.html#window)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-window-interface-1 "§ 6.2 Prepare credential requests")

[Permalink](https://infra.spec.whatwg.org/#list-append)

**Referenced in:**

* [§ 6.3 Filter credential requests](#ref-for-index-term-append-for-list-1 "§ 6.3 Filter credential requests")
* [§ 6.4 Validate credential requests](#ref-for-index-term-append-for-list-2 "§ 6.4 Validate credential requests")

[Permalink](https://infra.spec.whatwg.org/#ascii-digit)

**Referenced in:**

* [§ 4. Terminology](#ref-for-index-term-ascii-digit-1 "§ 4. Terminology")
* [§ 13. Internationalization Considerations](#ref-for-index-term-ascii-digit-2 "§ 13. Internationalization Considerations")

[Permalink](https://infra.spec.whatwg.org/#ascii-lower-alpha)

**Referenced in:**

* [§ 4. Terminology](#ref-for-index-term-ascii-lower-alpha-1 "§ 4. Terminology")
* [§ 13. Internationalization Considerations](#ref-for-index-term-ascii-lower-alpha-2 "§ 13. Internationalization Considerations")

[Permalink](https://infra.spec.whatwg.org/#assert)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-assert-1 "§ 6.2 Prepare credential requests") [(2)](#ref-for-index-term-assert-2 "Reference 2")
* [§ 6.6 Reject the credential request](#ref-for-index-term-assert-3 "§ 6.6 Reject the credential request")

[Permalink](https://infra.spec.whatwg.org/#code-point)

**Referenced in:**

* [§ 4. Terminology](#ref-for-index-term-code-points-1 "§ 4. Terminology") [(2)](#ref-for-index-term-code-points-2 "Reference 2") [(3)](#ref-for-index-term-code-points-3 "Reference 3")

[Permalink](https://infra.spec.whatwg.org/#iteration-continue)

**Referenced in:**

* [§ 6.3 Filter credential requests](#ref-for-index-term-continue-for-iteration-1 "§ 6.3 Filter credential requests") [(2)](#ref-for-index-term-continue-for-iteration-2 "Reference 2")

[Permalink](https://infra.spec.whatwg.org/#list-iterate)

**Referenced in:**

* [§ 6.3 Filter credential requests](#ref-for-index-term-for-each-for-list-1 "§ 6.3 Filter credential requests")
* [§ 6.4 Validate credential requests](#ref-for-index-term-for-each-for-list-2 "§ 6.4 Validate credential requests")

[Permalink](https://infra.spec.whatwg.org/#list-is-empty)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-is-empty-for-list-1 "§ 6.2 Prepare credential requests")
* [§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method](#ref-for-index-term-is-empty-for-list-2 "§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method")
* [§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method](#ref-for-index-term-is-empty-for-list-3 "§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method")

[Permalink](https://infra.spec.whatwg.org/#struct-item)

**Referenced in:**

* [§ 7.8.1 The request context struct](#ref-for-index-term-items-for-struct-1 "§ 7.8.1 The request context struct")

[Permalink](https://infra.spec.whatwg.org/#list)

**Referenced in:**

* [§ 6.3 Filter credential requests](#ref-for-index-term-list-1 "§ 6.3 Filter credential requests")
* [§ 6.4 Validate credential requests](#ref-for-index-term-list-2 "§ 6.4 Validate credential requests")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-list-3 "§ 6.7 Initiate the credential request")
* [§ 7.8.1 The request context struct](#ref-for-index-term-list-4 "§ 7.8.1 The request context struct")

[Permalink](https://infra.spec.whatwg.org/#parse-a-json-string-to-a-javascript-value)

**Referenced in:**

* [§ 6.7 Initiate the credential request](#ref-for-index-term-parse-a-json-string-to-a-javascript-value-1 "§ 6.7 Initiate the credential request")
* [§ 13. Internationalization Considerations](#ref-for-index-term-parse-a-json-string-to-a-javascript-value-2 "§ 13. Internationalization Considerations")
* [§ 14.2 Handle Virtual Wallet Behavior](#ref-for-index-term-parse-a-json-string-to-a-javascript-value-3 "§ 14.2 Handle Virtual Wallet Behavior")

[Permalink](https://infra.spec.whatwg.org/#serialize-a-javascript-value-to-a-json-string)

**Referenced in:**

* [§ 6.4 Validate credential requests](#ref-for-index-term-serialize-a-javascript-value-to-a-json-string-1 "§ 6.4 Validate credential requests")
* [§ 10.2 Mitigations](#ref-for-index-term-serialize-a-javascript-value-to-a-json-string-2 "§ 10.2 Mitigations")
* [§ 13. Internationalization Considerations](#ref-for-index-term-serialize-a-javascript-value-to-a-json-string-3 "§ 13. Internationalization Considerations")

[Permalink](https://infra.spec.whatwg.org/#serialize-an-infra-value-to-a-json-string)

**Referenced in:**

* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-index-term-serialize-an-infra-value-to-a-json-string-1 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command")
* [§ 14.2 Handle Virtual Wallet Behavior](#ref-for-index-term-serialize-an-infra-value-to-a-json-string-2 "§ 14.2 Handle Virtual Wallet Behavior")

[Permalink](https://infra.spec.whatwg.org/#string)

**Referenced in:**

* [§ 4. Terminology](#ref-for-index-term-string-1 "§ 4. Terminology")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-string-2 "§ 6.7 Initiate the credential request") [(2)](#ref-for-index-term-string-3 "Reference 2")

[Permalink](https://infra.spec.whatwg.org/#struct)

**Referenced in:**

* [§ 7.8.1 The request context struct](#ref-for-index-term-struct-1 "§ 7.8.1 The request context struct")

[Permalink](https://infra.spec.whatwg.org/#user-agent)

**Referenced in:**

* [§ Abstract](#ref-for-index-term-user-agents-1 "§ Abstract")
* [§ 2.2 Checking if protocol is allowed](#ref-for-index-term-user-agents-2 "§ 2.2 Checking if protocol is allowed")
* [§ 3. Scope](#ref-for-index-term-user-agents-3 "§ 3. Scope") [(2)](#ref-for-index-term-user-agents-4 "Reference 2")
* [§ 4. Terminology](#ref-for-index-term-user-agents-5 "§ 4. Terminology") [(2)](#ref-for-index-term-user-agents-6 "Reference 2")
* [§ 5. Protocols](#ref-for-index-term-user-agents-7 "§ 5. Protocols") [(2)](#ref-for-index-term-user-agents-8 "Reference 2") [(3)](#ref-for-index-term-user-agents-9 "Reference 3")
* [§ 6.4 Validate credential requests](#ref-for-index-term-user-agents-10 "§ 6.4 Validate credential requests") [(2)](#ref-for-index-term-user-agents-11 "Reference 2") [(3)](#ref-for-index-term-user-agents-12 "Reference 3") [(4)](#ref-for-index-term-user-agents-13 "Reference 4")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-user-agents-14 "§ 6.7 Initiate the credential request") [(2)](#ref-for-index-term-user-agents-15 "Reference 2")
* [§ 7. The Digital Credentials API](#ref-for-index-term-user-agents-16 "§ 7. The Digital Credentials API")
* [§ 7.7 The DigitalCredential interface](#ref-for-index-term-user-agents-17 "§ 7.7 The DigitalCredential interface") [(2)](#ref-for-index-term-user-agents-18 "Reference 2")
* [§ 10.1.2 Out of Scope Threats](#ref-for-index-term-user-agents-19 "§ 10.1.2 Out of Scope Threats")
* [§ 10.2 Mitigations](#ref-for-index-term-user-agents-20 "§ 10.2 Mitigations")
* [§ 11. Privacy Considerations](#ref-for-index-term-user-agents-21 "§ 11. Privacy Considerations")
* [§ 11.1 Design Considerations and Alternatives](#ref-for-index-term-user-agents-22 "§ 11.1 Design Considerations and Alternatives") [(2)](#ref-for-index-term-user-agents-23 "Reference 2")
* [§ 11.2 Spectrum of Privacy](#ref-for-index-term-user-agents-24 "§ 11.2 Spectrum of Privacy") [(2)](#ref-for-index-term-user-agents-25 "Reference 2") [(3)](#ref-for-index-term-user-agents-26 "Reference 3")
* [§ 11.3 Presentation Protocol and Credential Format](#ref-for-index-term-user-agents-27 "§ 11.3 Presentation Protocol and Credential Format")
* [§ 11.3.1.2 Unlinkable presentations](#ref-for-index-term-user-agents-28 "§ 11.3.1.2 Unlinkable presentations") [(2)](#ref-for-index-term-user-agents-29 "Reference 2") [(3)](#ref-for-index-term-user-agents-30 "Reference 3")
* [§ 11.3.1.3 "Phone home" mechanisms](#ref-for-index-term-user-agents-31 "§ 11.3.1.3 \"Phone home\" mechanisms") [(2)](#ref-for-index-term-user-agents-32 "Reference 2") [(3)](#ref-for-index-term-user-agents-33 "Reference 3")
* [§ 11.3.1.6 Support for verifier authorization](#ref-for-index-term-user-agents-34 "§ 11.3.1.6 Support for verifier authorization") [(2)](#ref-for-index-term-user-agents-35 "Reference 2")
* [§ 11.4 Unnecessary Requests for Credentials](#ref-for-index-term-user-agents-36 "§ 11.4 Unnecessary Requests for Credentials") [(2)](#ref-for-index-term-user-agents-37 "Reference 2") [(3)](#ref-for-index-term-user-agents-38 "Reference 3") [(4)](#ref-for-index-term-user-agents-39 "Reference 4") [(5)](#ref-for-index-term-user-agents-40 "Reference 5") [(6)](#ref-for-index-term-user-agents-41 "Reference 6")
* [§ 11.4.1.2 Risk of proliferation of requests for government credentials](#ref-for-index-term-user-agents-42 "§ 11.4.1.2 Risk of proliferation of requests for government credentials") [(2)](#ref-for-index-term-user-agents-43 "Reference 2")
* [§ 11.4.1.3 Mitigating unnecessary requests for government credentials](#ref-for-index-term-user-agents-44 "§ 11.4.1.3 Mitigating unnecessary requests for government credentials") [(2)](#ref-for-index-term-user-agents-45 "Reference 2")
* [§ 11.4.2.3 Mitigating unnecessary requests for non-government credentials](#ref-for-index-term-user-agents-46 "§ 11.4.2.3 Mitigating unnecessary requests for non-government credentials") [(2)](#ref-for-index-term-user-agents-47 "Reference 2") [(3)](#ref-for-index-term-user-agents-48 "Reference 3") [(4)](#ref-for-index-term-user-agents-49 "Reference 4") [(5)](#ref-for-index-term-user-agents-50 "Reference 5")
* [§ 11.5.2 Leaking incidental data with credential presentations](#ref-for-index-term-user-agents-51 "§ 11.5.2 Leaking incidental data with credential presentations")
* [§ 11.5.3 Revealing device properties through protocol availability](#ref-for-index-term-user-agents-52 "§ 11.5.3 Revealing device properties through protocol availability") [(2)](#ref-for-index-term-user-agents-53 "Reference 2")
* [§ 11.5.4 Avoiding leaks of credential availability](#ref-for-index-term-user-agents-54 "§ 11.5.4 Avoiding leaks of credential availability")
* [§ 11.6 User Permission and Transparency](#ref-for-index-term-user-agents-55 "§ 11.6 User Permission and Transparency") [(2)](#ref-for-index-term-user-agents-56 "Reference 2")
* [§ 11.6.2 Integrating Multiple User Agents](#ref-for-index-term-user-agents-57 "§ 11.6.2 Integrating Multiple User Agents") [(2)](#ref-for-index-term-user-agents-58 "Reference 2")
* [§ 11.6.3 Permission Prior to Credential Manager Selection](#ref-for-index-term-user-agents-59 "§ 11.6.3 Permission Prior to Credential Manager Selection")
* [§ 11.6.4 Permission vs. Consent](#ref-for-index-term-user-agents-60 "§ 11.6.4 Permission vs. Consent") [(2)](#ref-for-index-term-user-agents-61 "Reference 2")
* [§ 12. Accessibility Considerations](#ref-for-index-term-user-agents-62 "§ 12. Accessibility Considerations") [(2)](#ref-for-index-term-user-agents-63 "Reference 2")
* [§ 13. Internationalization Considerations](#ref-for-index-term-user-agents-64 "§ 13. Internationalization Considerations")
* [§ 14. Automated Testing](#ref-for-index-term-user-agents-65 "§ 14. Automated Testing")
* [§ 14.2 Handle Virtual Wallet Behavior](#ref-for-index-term-user-agents-66 "§ 14.2 Handle Virtual Wallet Behavior")

[Permalink](https://www.w3.org/TR/permissions/#dfn-express-permission)

**Referenced in:**

* [§ 8.6 User permission](#ref-for-index-term-express-permission-1 "§ 8.6 User permission")

[Permalink](https://www.w3.org/TR/permissions/#dfn-powerful-feature)

**Referenced in:**

* [§ 8.6 User permission](#ref-for-index-term-powerful-feature-1 "§ 8.6 User permission")

[Permalink](https://www.w3.org/TR/permissions-policy-1/#default-allowlist-self)

**Referenced in:**

* [§ 9. Permissions Policy integration](#ref-for-index-term-self-for-default-allowlist-1 "§ 9. Permissions Policy integration") [(2)](#ref-for-index-term-self-for-default-allowlist-2 "Reference 2")

[Permalink](https://www.w3.org/TR/permissions-policy-1/#policy-controlled-feature-default-allowlist)

**Referenced in:**

* [§ 9. Permissions Policy integration](#ref-for-index-term-default-allowlists-for-policy-controlled-feature-1 "§ 9. Permissions Policy integration") [(2)](#ref-for-index-term-default-allowlists-for-policy-controlled-feature-2 "Reference 2")

[Permalink](https://www.w3.org/TR/permissions-policy-1/#policy-controlled-feature)

**Referenced in:**

* [§ 2.5 Requesting a digital credential across origins](#ref-for-index-term-policy-controlled-feature-1 "§ 2.5 Requesting a digital credential across origins")
* [§ 2.6 Issuing a digital credential across origins](#ref-for-index-term-policy-controlled-feature-2 "§ 2.6 Issuing a digital credential across origins")
* [§ 9. Permissions Policy integration](#ref-for-index-term-policy-controlled-feature-3 "§ 9. Permissions Policy integration") [(2)](#ref-for-index-term-policy-controlled-feature-4 "Reference 2") [(3)](#ref-for-index-term-policy-controlled-feature-5 "Reference 3")
* [§ 10.2 Mitigations](#ref-for-index-term-policy-controlled-feature-6 "§ 10.2 Mitigations")

[Permalink](https://www.w3.org/TR/privacy-principles/#dfn-user-agent-duties)

**Referenced in:**

* [§ 11. Privacy Considerations](#ref-for-index-term-user-agent-duties-1 "§ 11. Privacy Considerations")

[Permalink](https://www.w3.org/TR/vc-data-model-2.0/#dfn-claims)

**Referenced in:**

* [§ 4. Terminology](#ref-for-index-term-claims-1 "§ 4. Terminology")

[Permalink](https://www.w3.org/TR/vc-data-model-2.0/#dfn-holders)

**Referenced in:**

* [§ 1. Introduction](#ref-for-index-term-holders-1 "§ 1. Introduction")
* [§ 2.3 Requesting a digital credential](#ref-for-index-term-holders-2 "§ 2.3 Requesting a digital credential")
* [§ 3. Scope](#ref-for-index-term-holders-3 "§ 3. Scope") [(2)](#ref-for-index-term-holders-4 "Reference 2") [(3)](#ref-for-index-term-holders-5 "Reference 3")
* [§ 4. Terminology](#ref-for-index-term-holders-6 "§ 4. Terminology") [(2)](#ref-for-index-term-holders-7 "Reference 2") [(3)](#ref-for-index-term-holders-8 "Reference 3") [(4)](#ref-for-index-term-holders-9 "Reference 4") [(5)](#ref-for-index-term-holders-10 "Reference 5") [(6)](#ref-for-index-term-holders-11 "Reference 6")
* [§ 6. Credential Request Coordinator](#ref-for-index-term-holders-12 "§ 6. Credential Request Coordinator") [(2)](#ref-for-index-term-holders-13 "Reference 2")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-holders-14 "§ 6.7 Initiate the credential request") [(2)](#ref-for-index-term-holders-15 "Reference 2") [(3)](#ref-for-index-term-holders-16 "Reference 3")
* [§ 7.3.2 The data member](#ref-for-index-term-holders-17 "§ 7.3.2 The data member")
* [§ 7.5.1 The requests member](#ref-for-index-term-holders-18 "§ 7.5.1 The requests member")
* [§ 7.6 The DigitalCredentialCreateRequest dictionary](#ref-for-index-term-holders-19 "§ 7.6 The DigitalCredentialCreateRequest dictionary")
* [§ 7.6.2 The data member](#ref-for-index-term-holders-20 "§ 7.6.2 The data member")
* [§ 11. Privacy Considerations](#ref-for-index-term-holders-21 "§ 11. Privacy Considerations")
* [§ 11.1 Design Considerations and Alternatives](#ref-for-index-term-holders-22 "§ 11.1 Design Considerations and Alternatives") [(2)](#ref-for-index-term-holders-23 "Reference 2")
* [§ 11.3.1.1 Selective disclosure](#ref-for-index-term-holders-24 "§ 11.3.1.1 Selective disclosure")
* [§ 11.3.1.2 Unlinkable presentations](#ref-for-index-term-holders-25 "§ 11.3.1.2 Unlinkable presentations")
* [§ 12. Accessibility Considerations](#ref-for-index-term-holders-26 "§ 12. Accessibility Considerations")

[Permalink](https://www.w3.org/TR/vc-data-model-2.0/#dfn-issuers)

**Referenced in:**

* [§ 1. Introduction](#ref-for-index-term-issuers-1 "§ 1. Introduction")
* [§ 2.6 Issuing a digital credential across origins](#ref-for-index-term-issuers-2 "§ 2.6 Issuing a digital credential across origins")
* [§ 4. Terminology](#ref-for-index-term-issuers-3 "§ 4. Terminology") [(2)](#ref-for-index-term-issuers-4 "Reference 2") [(3)](#ref-for-index-term-issuers-5 "Reference 3") [(4)](#ref-for-index-term-issuers-6 "Reference 4") [(5)](#ref-for-index-term-issuers-7 "Reference 5")
* [§ 7.6 The DigitalCredentialCreateRequest dictionary](#ref-for-index-term-issuers-8 "§ 7.6 The DigitalCredentialCreateRequest dictionary")
* [§ 11. Privacy Considerations](#ref-for-index-term-issuers-9 "§ 11. Privacy Considerations")
* [§ 11.3.1.2 Unlinkable presentations](#ref-for-index-term-issuers-10 "§ 11.3.1.2 Unlinkable presentations") [(2)](#ref-for-index-term-issuers-11 "Reference 2") [(3)](#ref-for-index-term-issuers-12 "Reference 3")
* [§ 11.3.1.3 "Phone home" mechanisms](#ref-for-index-term-issuers-13 "§ 11.3.1.3 \"Phone home\" mechanisms") [(2)](#ref-for-index-term-issuers-14 "Reference 2") [(3)](#ref-for-index-term-issuers-15 "Reference 3") [(4)](#ref-for-index-term-issuers-16 "Reference 4")
* [§ 11.3.1.4 Unlinkable revocation](#ref-for-index-term-issuers-17 "§ 11.3.1.4 Unlinkable revocation")
* [§ 11.4 Unnecessary Requests for Credentials](#ref-for-index-term-issuers-18 "§ 11.4 Unnecessary Requests for Credentials")
* [§ 11.4.1.2 Risk of proliferation of requests for government credentials](#ref-for-index-term-issuers-19 "§ 11.4.1.2 Risk of proliferation of requests for government credentials")
* [§ 11.4.1.3 Mitigating unnecessary requests for government credentials](#ref-for-index-term-issuers-20 "§ 11.4.1.3 Mitigating unnecessary requests for government credentials")
* [§ 11.5.1 Browser fingerprinting](#ref-for-index-term-issuers-21 "§ 11.5.1 Browser fingerprinting")
* [§ 11.5.2 Leaking incidental data with credential presentations](#ref-for-index-term-issuers-22 "§ 11.5.2 Leaking incidental data with credential presentations")

[Permalink](https://www.w3.org/TR/vc-data-model-2.0/#dfn-subjects)

**Referenced in:**

* [§ 4. Terminology](#ref-for-index-term-subjects-1 "§ 4. Terminology")

[Permalink](https://www.w3.org/TR/vc-data-model-2.0/#dfn-verifier)

**Referenced in:**

* [§ 1. Introduction](#ref-for-index-term-verifiers-1 "§ 1. Introduction")
* [§ 4. Terminology](#ref-for-index-term-verifiers-2 "§ 4. Terminology") [(2)](#ref-for-index-term-verifiers-3 "Reference 2") [(3)](#ref-for-index-term-verifiers-4 "Reference 3")
* [§ 5. Protocols](#ref-for-index-term-verifiers-5 "§ 5. Protocols")
* [§ 7.7.3 The userAgentAllowsProtocol() method](#ref-for-index-term-verifiers-6 "§ 7.7.3 The userAgentAllowsProtocol() method")
* [§ 10.3 Signing presentation requests](#ref-for-index-term-verifiers-7 "§ 10.3 Signing presentation requests")
* [§ 10.4 Cross-Device Security and Proximity](#ref-for-index-term-verifiers-8 "§ 10.4 Cross-Device Security and Proximity")
* [§ 11. Privacy Considerations](#ref-for-index-term-verifiers-9 "§ 11. Privacy Considerations")
* [§ 11.1 Design Considerations and Alternatives](#ref-for-index-term-verifiers-10 "§ 11.1 Design Considerations and Alternatives")
* [§ 11.3.1.1 Selective disclosure](#ref-for-index-term-verifiers-11 "§ 11.3.1.1 Selective disclosure") [(2)](#ref-for-index-term-verifiers-12 "Reference 2")
* [§ 11.3.1.2 Unlinkable presentations](#ref-for-index-term-verifiers-13 "§ 11.3.1.2 Unlinkable presentations") [(2)](#ref-for-index-term-verifiers-14 "Reference 2") [(3)](#ref-for-index-term-verifiers-15 "Reference 3") [(4)](#ref-for-index-term-verifiers-16 "Reference 4") [(5)](#ref-for-index-term-verifiers-17 "Reference 5")
* [§ 11.3.1.3 "Phone home" mechanisms](#ref-for-index-term-verifiers-18 "§ 11.3.1.3 \"Phone home\" mechanisms")
* [§ 11.3.1.4 Unlinkable revocation](#ref-for-index-term-verifiers-19 "§ 11.3.1.4 Unlinkable revocation")
* [§ 11.3.1.6 Support for verifier authorization](#ref-for-index-term-verifiers-20 "§ 11.3.1.6 Support for verifier authorization") [(2)](#ref-for-index-term-verifiers-21 "Reference 2")
* [§ 11.3.1.7 Encrypting credential responses](#ref-for-index-term-verifiers-22 "§ 11.3.1.7 Encrypting credential responses") [(2)](#ref-for-index-term-verifiers-23 "Reference 2")
* [§ 11.4 Unnecessary Requests for Credentials](#ref-for-index-term-verifiers-24 "§ 11.4 Unnecessary Requests for Credentials") [(2)](#ref-for-index-term-verifiers-25 "Reference 2") [(3)](#ref-for-index-term-verifiers-26 "Reference 3") [(4)](#ref-for-index-term-verifiers-27 "Reference 4") [(5)](#ref-for-index-term-verifiers-28 "Reference 5")
* [§ 11.4.1.2 Risk of proliferation of requests for government credentials](#ref-for-index-term-verifiers-29 "§ 11.4.1.2 Risk of proliferation of requests for government credentials")
* [§ 11.4.1.3 Mitigating unnecessary requests for government credentials](#ref-for-index-term-verifiers-30 "§ 11.4.1.3 Mitigating unnecessary requests for government credentials") [(2)](#ref-for-index-term-verifiers-31 "Reference 2") [(3)](#ref-for-index-term-verifiers-32 "Reference 3") [(4)](#ref-for-index-term-verifiers-33 "Reference 4")
* [§ 11.4.2.2 Risk of proliferation of requests for non-government credentials](#ref-for-index-term-verifiers-34 "§ 11.4.2.2 Risk of proliferation of requests for non-government credentials")
* [§ 11.4.2.4 Reporting abuse](#ref-for-index-term-verifiers-35 "§ 11.4.2.4 Reporting abuse")
* [§ 11.5.1 Browser fingerprinting](#ref-for-index-term-verifiers-36 "§ 11.5.1 Browser fingerprinting") [(2)](#ref-for-index-term-verifiers-37 "Reference 2") [(3)](#ref-for-index-term-verifiers-38 "Reference 3") [(4)](#ref-for-index-term-verifiers-39 "Reference 4")
* [§ 11.5.2 Leaking incidental data with credential presentations](#ref-for-index-term-verifiers-40 "§ 11.5.2 Leaking incidental data with credential presentations") [(2)](#ref-for-index-term-verifiers-41 "Reference 2") [(3)](#ref-for-index-term-verifiers-42 "Reference 3") [(4)](#ref-for-index-term-verifiers-43 "Reference 4")
* [§ 11.6 User Permission and Transparency](#ref-for-index-term-verifiers-44 "§ 11.6 User Permission and Transparency")
* [§ 11.6.4 Permission vs. Consent](#ref-for-index-term-verifiers-45 "§ 11.6.4 Permission vs. Consent") [(2)](#ref-for-index-term-verifiers-46 "Reference 2") [(3)](#ref-for-index-term-verifiers-47 "Reference 3") [(4)](#ref-for-index-term-verifiers-48 "Reference 4") [(5)](#ref-for-index-term-verifiers-49 "Reference 5")

[Permalink](https://www.w3.org/TR/webdriver2/#dfn-error)

**Referenced in:**

* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-index-term-error-1 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command") [(2)](#ref-for-index-term-error-2 "Reference 2") [(3)](#ref-for-index-term-error-3 "Reference 3") [(4)](#ref-for-index-term-error-4 "Reference 4")

[Permalink](https://www.w3.org/TR/webdriver2/#dfn-error-code)

**Referenced in:**

* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-index-term-error-code-1 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command") [(2)](#ref-for-index-term-error-code-2 "Reference 2") [(3)](#ref-for-index-term-error-code-3 "Reference 3") [(4)](#ref-for-index-term-error-code-4 "Reference 4")

[Permalink](https://www.w3.org/TR/webdriver2/#dfn-invalid-argument)

**Referenced in:**

* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-index-term-invalid-argument-1 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command") [(2)](#ref-for-index-term-invalid-argument-2 "Reference 2") [(3)](#ref-for-index-term-invalid-argument-3 "Reference 3") [(4)](#ref-for-index-term-invalid-argument-4 "Reference 4")

[Permalink](https://www.w3.org/TR/webdriver2/#dfn-remote-end-steps)

**Referenced in:**

* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-index-term-remote-end-steps-1 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command")

[Permalink](https://www.w3.org/TR/webdriver2/#dfn-webdriver-session)

**Referenced in:**

* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-index-term-session-1 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command") [(2)](#ref-for-index-term-session-2 "Reference 2") [(3)](#ref-for-index-term-session-3 "Reference 3") [(4)](#ref-for-index-term-session-4 "Reference 4")
* [§ 14.2 Handle Virtual Wallet Behavior](#ref-for-index-term-session-5 "§ 14.2 Handle Virtual Wallet Behavior") [(2)](#ref-for-index-term-session-6 "Reference 2")

[Permalink](https://www.w3.org/TR/webdriver2/#dfn-success)

**Referenced in:**

* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-index-term-success-1 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command")

[Permalink](https://webidl.spec.whatwg.org/#a-new-promise)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-a-new-promise-1 "§ 6.2 Prepare credential requests")

[Permalink](https://webidl.spec.whatwg.org/#a-promise-rejected-with)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-a-promise-rejected-with-1 "§ 6.2 Prepare credential requests") [(2)](#ref-for-index-term-a-promise-rejected-with-2 "Reference 2") [(3)](#ref-for-index-term-a-promise-rejected-with-3 "Reference 3")
* [§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method](#ref-for-index-term-a-promise-rejected-with-4 "§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method")
* [§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method](#ref-for-index-term-a-promise-rejected-with-5 "§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method")

[Permalink](https://webidl.spec.whatwg.org/#aborterror)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-aborterror-exception-1 "§ 6.2 Prepare credential requests")

[Permalink](https://webidl.spec.whatwg.org/#idl-boolean)

**Referenced in:**

* [§ 7.7 The DigitalCredential interface](#ref-for-index-term-boolean-type-1 "§ 7.7 The DigitalCredential interface")
* [§ B. IDL Index](#ref-for-index-term-boolean-type-2 "§ B. IDL Index")

[Permalink](https://webidl.spec.whatwg.org/#dfn-create-exception)

**Referenced in:**

* [§ 6.4 Validate credential requests](#ref-for-index-term-create-for-exception-1 "§ 6.4 Validate credential requests") [(2)](#ref-for-index-term-create-for-exception-2 "Reference 2") [(3)](#ref-for-index-term-create-for-exception-3 "Reference 3") [(4)](#ref-for-index-term-create-for-exception-4 "Reference 4")

[Permalink](https://webidl.spec.whatwg.org/#Default)

**Referenced in:**

* [§ 7.7 The DigitalCredential interface](#ref-for-index-term-default-extended-attribute-1 "§ 7.7 The DigitalCredential interface")
* [§ B. IDL Index](#ref-for-index-term-default-extended-attribute-2 "§ B. IDL Index")

[Permalink](https://webidl.spec.whatwg.org/#default-tojson-steps)

**Referenced in:**

* [§ 7.7 The DigitalCredential interface](#ref-for-index-term-default-tojson-steps-1 "§ 7.7 The DigitalCredential interface")
* [§ B. IDL Index](#ref-for-index-term-default-tojson-steps-2 "§ B. IDL Index")

[Permalink](https://webidl.spec.whatwg.org/#idl-DOMException)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-domexception-interface-1 "§ 6.2 Prepare credential requests") [(2)](#ref-for-index-term-domexception-interface-2 "Reference 2") [(3)](#ref-for-index-term-domexception-interface-3 "Reference 3") [(4)](#ref-for-index-term-domexception-interface-4 "Reference 4") [(5)](#ref-for-index-term-domexception-interface-5 "Reference 5")
* [§ 6.4 Validate credential requests](#ref-for-index-term-domexception-interface-6 "§ 6.4 Validate credential requests") [(2)](#ref-for-index-term-domexception-interface-7 "Reference 2") [(3)](#ref-for-index-term-domexception-interface-8 "Reference 3")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-domexception-interface-9 "§ 6.7 Initiate the credential request") [(2)](#ref-for-index-term-domexception-interface-10 "Reference 2") [(3)](#ref-for-index-term-domexception-interface-11 "Reference 3") [(4)](#ref-for-index-term-domexception-interface-12 "Reference 4")
* [§ 12. Accessibility Considerations](#ref-for-index-term-domexception-interface-13 "§ 12. Accessibility Considerations")
* [§ 14.2 Handle Virtual Wallet Behavior](#ref-for-index-term-domexception-interface-14 "§ 14.2 Handle Virtual Wallet Behavior")

[Permalink](https://webidl.spec.whatwg.org/#idl-DOMString)

**Referenced in:**

* [§ 7.3 The DigitalCredentialGetRequest dictionary](#ref-for-index-term-domstring-interface-1 "§ 7.3 The DigitalCredentialGetRequest dictionary")
* [§ 7.6 The DigitalCredentialCreateRequest dictionary](#ref-for-index-term-domstring-interface-2 "§ 7.6 The DigitalCredentialCreateRequest dictionary")
* [§ 7.7 The DigitalCredential interface](#ref-for-index-term-domstring-interface-3 "§ 7.7 The DigitalCredential interface")
* [§ 7.7.3 The userAgentAllowsProtocol() method](#ref-for-index-term-domstring-interface-4 "§ 7.7.3 The userAgentAllowsProtocol() method")
* [§ B. IDL Index](#ref-for-index-term-domstring-interface-5 "§ B. IDL Index") [(2)](#ref-for-index-term-domstring-interface-6 "Reference 2") [(3)](#ref-for-index-term-domstring-interface-7 "Reference 3")

[Permalink](https://webidl.spec.whatwg.org/#dfn-enumeration-value)

**Referenced in:**

* [§ 5.1 Convert request protocol](#ref-for-index-term-enumeration-value-1 "§ 5.1 Convert request protocol") [(2)](#ref-for-index-term-enumeration-value-2 "Reference 2") [(3)](#ref-for-index-term-enumeration-value-3 "Reference 3") [(4)](#ref-for-index-term-enumeration-value-4 "Reference 4")
* [§ 7.7.3 The userAgentAllowsProtocol() method](#ref-for-index-term-enumeration-value-5 "§ 7.7.3 The userAgentAllowsProtocol() method")
* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-index-term-enumeration-value-6 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command")

[Permalink](https://webidl.spec.whatwg.org/#dfn-exception)

**Referenced in:**

* [§ 2.2 Checking if protocol is allowed](#ref-for-index-term-exception-1 "§ 2.2 Checking if protocol is allowed")
* [§ 6.2 Prepare credential requests](#ref-for-index-term-exception-2 "§ 6.2 Prepare credential requests")
* [§ 6.4 Validate credential requests](#ref-for-index-term-exception-3 "§ 6.4 Validate credential requests") [(2)](#ref-for-index-term-exception-4 "Reference 2")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-exception-5 "§ 6.7 Initiate the credential request")
* [§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command](#ref-for-index-term-exception-6 "§ 14.1.2.1 The digitalCredentials.setVirtualWalletBehavior Command")

[Permalink](https://webidl.spec.whatwg.org/#Exposed)

**Referenced in:**

* [§ 7.7 The DigitalCredential interface](#ref-for-index-term-exposed-extended-attribute-1 "§ 7.7 The DigitalCredential interface")
* [§ B. IDL Index](#ref-for-index-term-exposed-extended-attribute-2 "§ B. IDL Index")

[Permalink](https://webidl.spec.whatwg.org/#dfn-interface-object)

**Referenced in:**

* [§ 8.4 [[type]] internal slot](#ref-for-index-term-interface-object-1 "§ 8.4 [[type]] internal slot")
* [§ 8.5 [[discovery]] internal slot](#ref-for-index-term-interface-object-2 "§ 8.5 [[discovery]] internal slot")

[Permalink](https://webidl.spec.whatwg.org/#dfn-interface)

**Referenced in:**

* [§ 10.2 Mitigations](#ref-for-index-term-interfaces-1 "§ 10.2 Mitigations")

[Permalink](https://webidl.spec.whatwg.org/#invalidstateerror)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-invalidstateerror-exception-1 "§ 6.2 Prepare credential requests")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-invalidstateerror-exception-2 "§ 6.7 Initiate the credential request")
* [§ 12. Accessibility Considerations](#ref-for-index-term-invalidstateerror-exception-3 "§ 12. Accessibility Considerations")

[Permalink](https://webidl.spec.whatwg.org/#notallowederror)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-notallowederror-exception-1 "§ 6.2 Prepare credential requests") [(2)](#ref-for-index-term-notallowederror-exception-2 "Reference 2") [(3)](#ref-for-index-term-notallowederror-exception-3 "Reference 3")
* [§ 6.4 Validate credential requests](#ref-for-index-term-notallowederror-exception-4 "§ 6.4 Validate credential requests") [(2)](#ref-for-index-term-notallowederror-exception-5 "Reference 2")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-notallowederror-exception-6 "§ 6.7 Initiate the credential request") [(2)](#ref-for-index-term-notallowederror-exception-7 "Reference 2")
* [§ 12. Accessibility Considerations](#ref-for-index-term-notallowederror-exception-8 "§ 12. Accessibility Considerations")
* [§ 14.2 Handle Virtual Wallet Behavior](#ref-for-index-term-notallowederror-exception-9 "§ 14.2 Handle Virtual Wallet Behavior")

[Permalink](https://webidl.spec.whatwg.org/#idl-object)

**Referenced in:**

* [§ 7.3 The DigitalCredentialGetRequest dictionary](#ref-for-index-term-object-type-0-1 "§ 7.3 The DigitalCredentialGetRequest dictionary")
* [§ 7.6 The DigitalCredentialCreateRequest dictionary](#ref-for-index-term-object-type-0-2 "§ 7.6 The DigitalCredentialCreateRequest dictionary")
* [§ 7.7 The DigitalCredential interface](#ref-for-index-term-object-type-0-3 "§ 7.7 The DigitalCredential interface") [(2)](#ref-for-index-term-object-type-0-4 "Reference 2")
* [§ B. IDL Index](#ref-for-index-term-object-type-0-5 "§ B. IDL Index") [(2)](#ref-for-index-term-object-type-0-6 "Reference 2") [(3)](#ref-for-index-term-object-type-0-7 "Reference 3") [(4)](#ref-for-index-term-object-type-0-8 "Reference 4")

[Permalink](https://webidl.spec.whatwg.org/#operationerror)

**Referenced in:**

* [§ 6.4 Validate credential requests](#ref-for-index-term-operationerror-exception-1 "§ 6.4 Validate credential requests")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-operationerror-exception-2 "§ 6.7 Initiate the credential request")
* [§ 12. Accessibility Considerations](#ref-for-index-term-operationerror-exception-3 "§ 12. Accessibility Considerations")

[Permalink](https://webidl.spec.whatwg.org/#idl-promise)

**Referenced in:**

* [§ 6. Credential Request Coordinator](#ref-for-index-term-promise-interface-1 "§ 6. Credential Request Coordinator")
* [§ 6.6 Reject the credential request](#ref-for-index-term-promise-interface-2 "§ 6.6 Reject the credential request")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-promise-interface-3 "§ 6.7 Initiate the credential request")
* [§ 14.2 Handle Virtual Wallet Behavior](#ref-for-index-term-promise-interface-4 "§ 14.2 Handle Virtual Wallet Behavior")

[Permalink](https://webidl.spec.whatwg.org/#exceptiondef-referenceerror)

**Referenced in:**

* [§ 2.2 Checking if protocol is allowed](#ref-for-index-term-referenceerror-exception-1 "§ 2.2 Checking if protocol is allowed")

[Permalink](https://webidl.spec.whatwg.org/#reject)

**Referenced in:**

* [§ 6. Credential Request Coordinator](#ref-for-index-term-rejects-1 "§ 6. Credential Request Coordinator") [(2)](#ref-for-index-term-rejects-2 "Reference 2")
* [§ 6.2 Prepare credential requests](#ref-for-index-term-rejects-3 "§ 6.2 Prepare credential requests")
* [§ 6.6 Reject the credential request](#ref-for-index-term-rejects-4 "§ 6.6 Reject the credential request")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-rejects-5 "§ 6.7 Initiate the credential request") [(2)](#ref-for-index-term-rejects-6 "Reference 2")
* [§ 14.2 Handle Virtual Wallet Behavior](#ref-for-index-term-rejects-7 "§ 14.2 Handle Virtual Wallet Behavior")

[Permalink](https://webidl.spec.whatwg.org/#resolve)

**Referenced in:**

* [§ 6. Credential Request Coordinator](#ref-for-index-term-resolves-1 "§ 6. Credential Request Coordinator") [(2)](#ref-for-index-term-resolves-2 "Reference 2")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-resolves-3 "§ 6.7 Initiate the credential request")
* [§ 14.2 Handle Virtual Wallet Behavior](#ref-for-index-term-resolves-4 "§ 14.2 Handle Virtual Wallet Behavior")

[Permalink](https://webidl.spec.whatwg.org/#SameObject)

**Referenced in:**

* [§ 7.7 The DigitalCredential interface](#ref-for-index-term-sameobject-extended-attribute-1 "§ 7.7 The DigitalCredential interface")
* [§ B. IDL Index](#ref-for-index-term-sameobject-extended-attribute-2 "§ B. IDL Index")

[Permalink](https://webidl.spec.whatwg.org/#SecureContext)

**Referenced in:**

* [§ 7.7 The DigitalCredential interface](#ref-for-index-term-securecontext-extended-attribute-1 "§ 7.7 The DigitalCredential interface")
* [§ B. IDL Index](#ref-for-index-term-securecontext-extended-attribute-2 "§ B. IDL Index")

[Permalink](https://webidl.spec.whatwg.org/#securityerror)

**Referenced in:**

* [§ 6.4 Validate credential requests](#ref-for-index-term-securityerror-exception-1 "§ 6.4 Validate credential requests")

[Permalink](https://webidl.spec.whatwg.org/#idl-sequence)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-sequence-1 "§ 6.2 Prepare credential requests") [(2)](#ref-for-index-term-sequence-2 "Reference 2")
* [§ 7.2 The DigitalCredentialRequestOptions dictionary](#ref-for-index-term-sequence-3 "§ 7.2 The DigitalCredentialRequestOptions dictionary")
* [§ 7.5 The DigitalCredentialCreationOptions dictionary](#ref-for-index-term-sequence-4 "§ 7.5 The DigitalCredentialCreationOptions dictionary")
* [§ B. IDL Index](#ref-for-index-term-sequence-5 "§ B. IDL Index") [(2)](#ref-for-index-term-sequence-6 "Reference 2")

[Permalink](https://webidl.spec.whatwg.org/#this)

**Referenced in:**

* [§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method](#ref-for-index-term-this-1 "§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method")
* [§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method](#ref-for-index-term-this-2 "§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method")

[Permalink](https://webidl.spec.whatwg.org/#dfn-throw)

**Referenced in:**

* [§ 2.2 Checking if protocol is allowed](#ref-for-index-term-throw-for-exception-1 "§ 2.2 Checking if protocol is allowed")
* [§ 6.2 Prepare credential requests](#ref-for-index-term-throw-for-exception-2 "§ 6.2 Prepare credential requests")
* [§ 6.4 Validate credential requests](#ref-for-index-term-throw-for-exception-3 "§ 6.4 Validate credential requests") [(2)](#ref-for-index-term-throw-for-exception-4 "Reference 2")

[Permalink](https://webidl.spec.whatwg.org/#exceptiondef-typeerror)

**Referenced in:**

* [§ 6.2 Prepare credential requests](#ref-for-index-term-typeerror-exception-1 "§ 6.2 Prepare credential requests")
* [§ 6.3 Filter credential requests](#ref-for-index-term-typeerror-exception-2 "§ 6.3 Filter credential requests")
* [§ 6.4 Validate credential requests](#ref-for-index-term-typeerror-exception-3 "§ 6.4 Validate credential requests")
* [§ 6.7 Initiate the credential request](#ref-for-index-term-typeerror-exception-4 "§ 6.7 Initiate the credential request") [(2)](#ref-for-index-term-typeerror-exception-5 "Reference 2")
* [§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method](#ref-for-index-term-typeerror-exception-6 "§ 8.1 [[DiscoverFromExternalSource]](origin, options, sameOriginWithAncestors) internal method")
* [§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method](#ref-for-index-term-typeerror-exception-7 "§ 8.3 [[Create]](origin, options, sameOriginWithAncestors) internal method")
* [§ 12. Accessibility Considerations](#ref-for-index-term-typeerror-exception-8 "§ 12. Accessibility Considerations")

## F. References

### F.1 Normative references

[credential-management]
:   [Credential Management Level 1](https://www.w3.org/TR/credential-management-1/). Nina Satragno; Marcos Caceres. W3C. 2 July 2026. W3C Working Draft. URL: <https://www.w3.org/TR/credential-management-1/>

[dom]
:   [DOM Standard](https://dom.spec.whatwg.org/). Anne van Kesteren. WHATWG. Living Standard. URL: <https://dom.spec.whatwg.org/>

[FIDO-CLIENT-TO-AUTHENTICATOR-PROTOCOL-V2.3]
:   [Client to Authenticator Protocol (CTAP)](https://fidoalliance.org/specs/fido-v2.3-ps-20260226/fido-client-to-authenticator-protocol-v2.3-ps-20260226.html). FIDO Alliance. Editor's Draft. URL: <https://fidoalliance.org/specs/fido-v2.3-ps-20260226/fido-client-to-authenticator-protocol-v2.3-ps-20260226.html>

[html]
:   [HTML Standard](https://html.spec.whatwg.org/multipage/). Anne van Kesteren; Domenic Denicola; Dominic Farolino; Ian Hickson; Philip Jägenstedt; Simon Pieters. WHATWG. Living Standard. URL: <https://html.spec.whatwg.org/multipage/>

[INFRA]
:   [Infra Standard](https://infra.spec.whatwg.org/). Anne van Kesteren; Domenic Denicola. WHATWG. Living Standard. URL: <https://infra.spec.whatwg.org/>

[ISO18013-7]
:   [ISO/IEC 18013-7:2025 ISO-compliant driving licence, Part 7: Mobile driving licence (mDL) add-on functions](https://www.iso.org/standard/91154.html). ISO/IEC JTC 1/SC 17. International Organization for Standardization. May 2025. URL: <https://www.iso.org/standard/91154.html>

[OPENID4VCI]
:   [OpenID for Verifiable Credential Issuance 1.0](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html). Torsten Lodderstedt; Kristina Yasuda; Tobias Looker; Paul Bastian. OpenID Foundation. 16 September 2025. Final. URL: <https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html>

[OPENID4VP]
:   [OpenID for Verifiable Presentations 1.0](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html). Oliver Terbu; Torsten Lodderstedt; Kristina Yasuda; Daniel Fett; Joseph Heenan. OpenID Foundation. 9 July 2025. Final. URL: <https://openid.net/specs/openid-4-verifiable-presentations-1_0.html>

[permissions]
:   [Permissions](https://www.w3.org/TR/permissions/). Marcos Caceres; Mike Taylor. W3C. 6 October 2025. W3C Working Draft. URL: <https://www.w3.org/TR/permissions/>

[permissions-policy]
:   [Permissions Policy](https://www.w3.org/TR/permissions-policy-1/). Ian Clelland. W3C. 18 June 2026. W3C Working Draft. URL: <https://www.w3.org/TR/permissions-policy-1/>

[RFC2119]
:   [Key words for use in RFCs to Indicate Requirement Levels](https://www.rfc-editor.org/info/rfc2119/). S. Bradner. IETF. March 1997. Best Current Practice. URL: <https://www.rfc-editor.org/info/rfc2119/>

[RFC8174]
:   [Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words](https://www.rfc-editor.org/info/rfc8174/). B. Leiba. IETF. May 2017. Best Current Practice. URL: <https://www.rfc-editor.org/info/rfc8174/>

[vc-data-model]
:   [Verifiable Credentials Data Model v2.0](https://www.w3.org/TR/vc-data-model-2.0/). Ivan Herman; Michael Jones; Manu Sporny; Ted Thibodeau Jr; Gabe Cohen. W3C. 15 May 2025. W3C Recommendation. URL: <https://www.w3.org/TR/vc-data-model-2.0/>

[vc-use-cases]
:   [Verifiable Credentials Use Cases](https://www.w3.org/TR/vc-use-cases/). Joe Andrieu; Kevin Dean. W3C. 18 March 2026. W3C Working Group Note. URL: <https://www.w3.org/TR/vc-use-cases/>

[WCAG22]
:   [Web Content Accessibility Guidelines (WCAG) 2.2](https://www.w3.org/TR/WCAG22/). Michael Cooper; Andrew Kirkpatrick; Alastair Campbell; Rachael Bradley Montgomery; Charles Adams. W3C. 12 December 2024. W3C Recommendation. URL: <https://www.w3.org/TR/WCAG22/>

[WCAG2ICT-22]
:   [Guidance on Applying WCAG 2 to Non-Web Information and Communications Technologies (WCAG2ICT)](https://www.w3.org/TR/wcag2ict-22/). Mary Jo Mueller; Phil Day; Daniel Montalvo. W3C. 11 December 2025. W3C Working Group Note. URL: <https://www.w3.org/TR/wcag2ict-22/>

[webdriver]
:   [WebDriver](https://www.w3.org/TR/webdriver2/). Simon Stewart; David Burns. W3C. 2 July 2026. W3C Working Draft. URL: <https://www.w3.org/TR/webdriver2/>

[webdriver-bidi]
:   [WebDriver BiDi](https://www.w3.org/TR/webdriver-bidi/). James Graham; Alex Rudenko; Maksim Sadym. W3C. 24 August 2026. W3C Working Draft. URL: <https://www.w3.org/TR/webdriver-bidi/>

[webidl]
:   [Web IDL Standard](https://webidl.spec.whatwg.org/). Edgar Chen; Timothy Gu. WHATWG. Living Standard. URL: <https://webidl.spec.whatwg.org/>

### F.2 Informative references

[credential-considerations]
:   [User considerations for credentials on the Web](https://github.com/w3c/credential-considerations/blob/main/credentials-considerations.md). Nick Doty; Rick Byers. W3C. 2025-03-26. URL: <https://github.com/w3c/credential-considerations/blob/main/credentials-considerations.md>

[custom-schemes]
:   [Concerns with custom schemes for identity presentment](https://github.com/w3c-fedid/digital-credentials/blob/main/custom-schemes.md). Rick Byers. W3C. 2024-05-01. URL: <https://github.com/w3c-fedid/digital-credentials/blob/main/custom-schemes.md>

[identity-web-impact]
:   [Identity & the Web](https://www.w3.org/reports/identity-web-impact). Simone Onofri. W3C. 2025-02-25. URL: <https://www.w3.org/reports/identity-web-impact>

[ISO18013-5]
:   [ISO/IEC 18013-5:2021 ISO-compliant driving licence, Part 5: Mobile driving licence (mDL) application](https://www.iso.org/standard/69084.html). ISO/IEC JTC 1/SC 17. International Organization for Standardization. September 2021. URL: <https://www.iso.org/standard/69084.html>

[presenting-credentials-on-the-web]
:   [Presenting Credentials on the Web](https://docs.google.com/document/d/1Ppaz_EnhzHqPOz5UusRJvbSunh-RXPWgJ3Np_TM2EE0/). Simone Onofri. URL: <https://docs.google.com/document/d/1Ppaz_EnhzHqPOz5UusRJvbSunh-RXPWgJ3Np_TM2EE0/>

[prevent-credential-abuse]
:   [Preventing Abuse of Digital Credentials](https://www.w3.org/2001/tag/doc/prevent-credential-abuse/). Daniel Appelquist; Martin Thomson. W3C. 14 November 2025. TAG Finding. URL: <https://www.w3.org/2001/tag/doc/prevent-credential-abuse/>

[privacy-principles]
:   [Privacy Principles](https://www.w3.org/TR/privacy-principles/). Robin Berjon; Jeffrey Yasskin. W3C. 15 May 2025. STMT. URL: <https://www.w3.org/TR/privacy-principles/>

[rfc6973]
:   [Privacy Considerations for Internet Protocols](https://www.rfc-editor.org/info/rfc6973/). A. Cooper; H. Tschofenig; B. Aboba; J. Peterson; J. Morris; M. Hansen; R. Smith. IETF. July 2013. Informational. URL: <https://www.rfc-editor.org/info/rfc6973/>

[secure-contexts]
:   [Secure Contexts](https://www.w3.org/TR/secure-contexts/). Mike West. W3C. 10 November 2023. CRD. URL: <https://www.w3.org/TR/secure-contexts/>

[threat-model-decentralized-credentials]
:   [Threat Model for Decentralized Credentials](https://www.w3.org/TR/threat-model-decentralized-credentials/). Simone Onofri; Amir Sharif. W3C. 22 June 2026. DNOTE. URL: <https://www.w3.org/TR/threat-model-decentralized-credentials/>

[URL]
:   [URL Standard](https://url.spec.whatwg.org/). Anne van Kesteren. WHATWG. Living Standard. URL: <https://url.spec.whatwg.org/>

[↑](#title)