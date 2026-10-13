[![](https://raw.githubusercontent.com/decentralized-identity/didwebvh/refs/heads/main/didwebvh.jpg)](https://github.com/decentralized-identity/didwebvh)

# [§](#the-didwebvh-did-methodbrv10) The `did:webvh` DID Method v1.0

![did:webvh Logo](https://raw.githubusercontent.com/decentralized-identity/didwebvh/refs/heads/main/didwebvh.jpg)

**Specification Status:** v1.0

This is the specification of the `did:webvh` DID Method, Version 1.0. Please note that we continue to make cleanups (e.g., fixing typos, broken links, missing references, etc.) and making wording clarifications in this version of the specification. With that work there will be no changes to the meaning of the specification.

The current [Editor’s Draft](../next) has diverged from this v1.0 version of the specification and is being updated with the intention of publishing a new version of the specification.

**Current Specification:** [v1.0](../)

**Specification Version:** v1.0 (see [Changelog](#didwebvh-version-changelog))

**Source of Latest Draft:**
<https://github.com/decentralized-identity/didwebvh>

**Previous Versions:**

* [v0.5](../v0.5)
* [v0.4](../v0.4)
* [v0.3](../v0.3)

**Information Site:**
<https://didwebvh.info/>

**Editors:**
:   [Stephen Curran](https://github.com/swcurran)
:   [John Jordan, BC Gov](https://github.com/jljordan42)
:   [Andrew Whitehead](https://github.com/andrewwhitehead)
:   [Brian Richter](https://github.com/brianorwhatever)
:   [Michel Sahli](https://github.com/bj-ms)
:   [Martina Kolpondinos](https://github.com/martipos)
:   [Dmitri Zagdulin](https://github.com/dmitrizagidulin)
:   [Alexander Shenshin](https://github.com/AlexanderShenshin)

**Participate:**
:   [GitHub repo](https://github.com/decentralized-identity/didwebvh)
:   [File a bug](https://github.com/decentralized-identity/didwebvh/issues)
:   [Commit history](https://github.com/decentralized-identity/didwebvh/commits/main)

**Interoperability Test Suite:**
:   [Test Suite](https://github.com/decentralized-identity/didwebvh-test-suite)

**Implementations:**
:   [TypeScript](https://github.com/decentralized-identity/trustdidweb-ts)
:   [Python](https://github.com/decentralized-identity/trustdidweb-py)
:   [Rust](https://github.com/decentralized-identity/didwebvh-rs)
:   [Java](https://github.com/decentralized-identity/didwebvh-java)
:   [Java EECC](https://github.com/european-epc-competence-center/didwebvh)
:   [Dart](https://github.com/decentralized-identity/didwebvh-dart)
:   [did:webvh Server](https://github.com/decentralized-identity/didwebvh-server-py)
:   [did:webvh ACA-Py Plugin](https://github.com/openwallet-foundation/acapy-plugins/tree/main/webvh)

---

## [§](#abstract) Abstract

DID Web + Verifiable History (`did:webvh`) is an enhancement to the [did:web](#term:did:web) DID method,
providing complementary features that address `did:web`’s
limitations as a long-lasting DID. `did:webvh` features include:

* The same DID-to-HTTPS transformation as `did:web`.
* Ongoing publishing of the full history of the DID, including all of the DID
  Document ([DIDDoc](#term:diddoc)) versions instead of, or alongside an existing
  `did:web` DIDDoc.
* The ability to resolve the full history of the DID using a verifiable chain of
  updates to the [DIDDoc](#term:diddoc) from genesis to deactivation.
* A [self-certifying identifier](#term:self-certifying-identifier) (SCID) for the DID. The [SCID](#term:scid), globally unique and
  embedded in the DID, is derived from the initial [DID log entry](#term:did-log-entry). It ensures the integrity
  of the DID’s history mitigating the risk of attackers creating a new object with
  the same identifier.
* An optional mechanism for enabling [DID portability](#term:did-portability) via the [SCID](#term:scid), allowing
  the DID’s web location to be moved and the DID string to be updated, both while retaining
  a connection to the predecessor DID(s) and preserving the DID’s verifiable history.
* [DIDDoc](#term:diddoc) updates contain a proof signed by the [DID Controller's](#term:did-controller's) *authorized* to
  update the DID.
* An optional mechanism for publishing “pre-rotation” keys to prevent the loss of
  control of a DID in cases where an active private key is compromised.
* An optional mechanism for having collaborating [witnesses](#term:witnesses)
  that approve of updates to the DID by a [DID Controller](#term:did-controller) before publication.
* Support for cryptographic agility through versioned specification upgrades,
  algorithm-identifying formats (e.g., [multihash](#term:multihash) and [Data Integrity](#term:data-integrity) proofs), and
  per-entry method parameters in the [DID log](#term:did-log) that enable DIDs to evolve
  cryptographically over time.
* An optional mechanism for publishing the location of `did:webvh` [watchers](#term:watchers) in the [DID log](#term:did-log) that resolvers can use as another
  source of DID data for long term resolution or detection of malicious [DID Controllers](#term:did-controllers).
* DID URL path handling that defaults (but can be overridden) to automatically
  resolving `<did>/path/to/file` by using a comparable DID-to-HTTPS translation
  as for the [DIDDoc](#term:diddoc).
* A DID URL path `<did>/whois` that defaults to automatically returning (if
  published by the [DID controller](#term:did-controller)) a [Verifiable Presentation](#term:verifiable-presentation)
  containing [Verifiable Credentials](#term:verifiable-credentials) with the DID as the
  `credentialSubject`, signed by the DID. It draws inspiration from the
  traditional WHOIS protocol [[RFC3912](#ref:RFC3912)], offering an easy-to-use,
  decentralized, trust registry.

Combined, the additional features enable greater trust, security and verifiability without
compromising the simplicity of `did:web`.

For information beyond this specification about the (`did:webvh`) DID method and how (and
where) it is used in practice, please visit
<https://didwebvh.info/>

## [§](#overview) Overview

The emergence of [Decentralized Identifiers](#term:decentralized-identifiers) (DIDs) and with them the
evolution of [DID Methods](#term:did-methods) continues to be a dynamic area of
development in the quest for trusted, secure and private digital identity
management where the users are in control of their own data.

The `did:web` method, for example, leverages the Domain Name System (DNS) to
perform the DID operations. This approach is praised for its simplicity and
ease of deployment, including DID-to-HTTPS transformation and addressing
some aspects of trust by allowing for DIDs to be associated with a domain’s
reputation or published on platforms such as GitHub. However, it is not
without its challenges–
from trust layers inherited from the web and the absence of a verifiable
history for the DID.

Tackling these concerns, the `did:webvh` (`did:web` + Verifiable History) DID
Method aims to enhance `did:web` by introducing features such as a [self-certifying identifier](#term:self-certifying-identifier) (SCID), update key(s) and a verifiable history,
akin to what is available with ledger-based DIDs, but without relying on a
ledger.

This approach not only maintains backward compatibility but also offers an
additional layer of assurance for those requiring more robust verification
processes. By publishing the resulting DID as both `did:web` and `did:webvh`, it
caters to a broader range of trust requirements, from those who are comfortable
with the existing `did:web` infrastructure to those seeking greater security
assurances provided by `did:webvh`. This innovative step represents a significant
stride towards a more trusted and secure web, where the integrity of
cryptographic key publishing is paramount.

The key differences between `did:web` and `did:webvh` revolve around the core
issues of decentralization and security. `did:web` is recognized for its
simplicity and cost-effectiveness, allowing for easy establishment of a
credential ecosystem. However, it is not inherently decentralized as it relies
on DNS domain names, which require centralized registries. Furthermore, it lacks a
cryptographically verifiable, tamper-resistant, and persistently stored DID
document. In contrast, `did:webvh` is an enhancement
to `did:web`, aiming to address these limitations by adding a verifiable history
to the DID without the need for a ledger. This method provides a more
decentralized approach by ensuring that the security of the embedded
SCID does not depend on DNS. `did:webvh` is
capable of resolving a cryptographically verifiable trust registry and status
lists, using DID-Linked Resources, which `did:web` lacks. These features are
designed to build a trusted web by offering a higher level of assurance for
cryptographic key publishing and management.

For backwards compatibility, and for verifiers that “trust” `did:web`, a
`did:webvh` can be trivially modified and published with a parallel `did:web`
DID. For resolvers that want more assurance, `did:webvh` provides a way to
verify a did:web using the features listed in the [Abstract](#abstract).

The following is a `tl;dr` summary of how `did:webvh` works:

1. `did:webvh` uses the same DID-to-HTTPS transformation as `did:web`, so
   `did:webvh`’s `did.jsonl` ([JSON Lines](#term:json-lines)) file is found in the same
   location as `did:web`’s `did.json` file, and supports an easy transition
   from `did:web` to gain the added benefits of `did:webvh`.
2. The `did.jsonl` is a list of JSON [DID log entries](#term:did-log-entries), one per line,
   whitespace removed (per [JSON Lines](#term:json-lines)). Each entry contains the
   information needed to derive a version of the [DIDDoc](#term:diddoc) from its preceding
   version. The `did.jsonl` is also referred to as the [DID Log](#term:did-log).
3. Each [DID log entry](#term:did-log-entry) is a JSON object containing the following properties:
   1. `versionId` – a value that combines the version number
      (starting at `1` and incremented by one per version), a literal dash
      `-`, and a hash of the entry. The [entry hash](#term:entry-hash) calculation links each entry
      to its predecessor in a ledger-like chain.
   2. `versionTime` – as asserted by the [DID Controller](#term:did-controller).
   3. `parameters` – a set of [parameters](#term:parameters) that impact the processing of the current and
      future [log entries](#term:log-entries).
      * Example [parameters](#term:parameters) are the version of the `did:webvh` specification and
        hash algorithm being used, as well as the [SCID](#term:scid) and update key(s).
   4. `state` – the new version of the [DIDDoc](#term:diddoc).
   5. A [Data Integrity](#term:data-integrity) (DI) proof across the entry, signed by a [DID Controller](#term:did-controller)-authorized key to update the [DIDDoc](#term:diddoc).
   6. If the [DID Controller](#term:did-controller) enables support for DID [witnesses](#term:witnesses), an
      extra file (`did-witness.json`) in the same web location contains [Data Integrity](#term:data-integrity) proofs from witnesses for [DID Log entries](#term:did-log-entries).
4. In generating the first version of the [DIDDoc](#term:diddoc), the [DID Controller](#term:did-controller) calculates the [SCID](#term:scid) for the DID from the first [log entry](#term:log-entry) (which includes the [DIDDoc](#term:diddoc)). This is done by using the
   string `"{SCID}"` everywhere the actual [SCID](#term:scid) is to be placed in order
   to generate the hash. The [DID Controller](#term:did-controller) then replaces the
   placeholders with the calculated [SCID](#term:scid), including it as a `parameter`
   in the first [log entry](#term:log-entry), and inserting it where needed in the initial
   (and all subsequent) DIDDocs. The [SCID](#term:scid) must be verified by the
   resolvers, to verify that the inception event has not been tampered with. The
   [SCID](#term:scid) also enables an optional [portability](#term:portability) capability,
   allowing a DID’s web location to be moved, while retaining the [SCID](#term:scid) and verifiable
   history of the identifier.
5. A [DID Controller](#term:did-controller) generates and publishes the new/updated [DID Log](#term:did-log) file by making it available at the appropriate location on the web,
   based on the DID’s identifier. If a `did:webvh` has [watchers](#term:watchers), a
   webhook is triggered to notify the [watchers](#term:watchers) that an update is
   available and should be retrieved.
6. Given a `did:webvh` DID, a resolver converts the DID to an HTTPS URL,
   retrieves, and processes the [DID Log](#term:did-log) `did.jsonl` file, generating and verifying
   each [log entry](#term:log-entry) as per the requirements outlined in this specification.
   * In the process, the resolver collects all the [DIDDoc](#term:diddoc) versions and public
     keys used by the DID currently, and in the past. This enables
     resolving both current and past versions of the DID and keys.
7. `did:webvh` DID URLs with paths and `/whois` are resolved to documents
   published by the [DID Controller](#term:did-controller) that are by default in the web location relative to the
   `did.jsonl` file. See the [note below](#the-whois-use-case) about the
   powerful capability enabled by the `/whois` DID URL path.
8. A [DID Controller](#term:did-controller) can easily generate and publish a `did:web` DIDDoc
   from the latest `did:webvh` [DIDDoc](#term:diddoc) in parallel with the `did:webvh` [DID Log](#term:did-log).

[WARNING](#warning-3)

```
A resolver settling for just the `did:web` version of the DID does not get the
verifiability of the `did:webvh` log.
```

An example of a `did:webvh` evolving through a series of versions can be seen in
the [`did:webvh` Examples](https://didwebvh.info/latest/example/) on the `did:webvh`
information site.

### [§](#the-whois-use-case) The `/whois` Use Case

The `did:webvh` DID Method introduces what we hope will be a widely embraced convention for
all [DID Methods](#term:did-methods) – the `/whois` path. This feature harkens back to the `WHOIS`
protocol that was created in the 1970s to provide a directory about people and
entities in the early days of ARPANET. In the 80’s, `whois` evolved into
[[RFC920](#ref:RFC920)] that has expanded into the [global
whois](https://en.wikipedia.org/wiki/WHOIS) feature we know today as
[[RFC3912](#ref:RFC3912)]. Submit a `whois` request about a domain name, and get
back the information published about that domain.

We propose that the `/whois` path for a DID enable a comparable, decentralized,
version of the `WHOIS` protocol for DIDs. Notably, when `<did>/whois` is
resolved (using a standard DID `service` that follows the [Linked-VP](#term:linked-vp)
specification), a [Verifiable Presentation](#term:verifiable-presentation) (VP) may be returned (if
published by the [DID Controller](#term:did-controller)) containing [Verifiable Credentials](#term:verifiable-credentials) with
the DID as the `credentialSubject`, and the VP signed by the DID. Given a DID,
one can gather verifiable data about the [DID Controller](#term:did-controller) by resolving
`<did>/whois` and processing the returned VP. That’s powerful – an efficient,
highly decentralized, trust registry. For `did:webvh`, the approach is very simple
– transform the DID to its HTTPS equivalent, and execute a `GET <https>/whois`.
Need to know who issued the VCs in the VP? Get the issuer DIDs from those VCs,
and resolve `<issuer did>/whois` for each. This is comparable to walking a CA
(Certificate Authority) hierarchy, but self-managed by the [DID Controllers](#term:did-controllers) –
and the issuers that attest to them.

The following is a use case for the `/whois` capability. Consider an example of
the `did:webvh` controller being a mining company that has exported a shipment and
created a “Product Passport” Verifiable Credential with information about the
shipment. A country importing the shipment (the Importer) might want to know
more about the issuer of the VC, and hence, the details of the shipment. They
resolve the `<did>/whois` of the entity and get back a Verifiable Presentation
about that DID. It might contain:

* A verifiable credential issued by the Legal Entity Registrar for the
  jurisdiction in which the mining company is headquartered.
  + Since the Importer knows about the Legal Entity Registrar, they can automate
    this lookup to get more information about the company from the VC – its
    legal name, when it was registered, contact information, etc.
* A verifiable credential for a “Mining Permit” issued by the mining authority
  for the jurisdiction in which the company operates.
  + Perhaps the Importer does not know about the mining authority for that
    jurisdiction. The Importer can repeat the `/whois` resolution process for
    the issuer of *that* credential. The Importer might (for example), resolve
    and verify the `did:webvh` DID for the Authority, and then resolve the
    `/whois` DID URL to find a verifiable credential issued by the government of
    the jurisdiction. The Importer recognizes and trusts that government’s
    authority, and so can decide to recognize and trust the mining permit
    authority.
* A verifiable credential about the auditing of the mining practices of the
  mining company. Again, the Importer doesn’t know about the issuer of the audit
  VC, so they resolve the `/whois` for the DID of the issuer, get its VP and
  find that it is accredited to audit mining companies by the [London Metal
  Exchange](https://www.lme.com/en/) according to one of its mining standards.
  As the Importer knows about both the London Metal Exchange and the standard,
  it can make a trust decision about the original Product Passport Verifiable
  Credential.

Such checks can all be done with a handful of HTTPS requests and the processing
of the DIDs and verifiable presentations. If the system cannot automatically
make a trust decision, lots of information has been quickly collected that can
be passed to a person to make such a decision.

The result is an efficient, verifiable, credential-based, decentralized,
multi-domain trust registry, empowering individuals and organizations to verify
the authenticity and legitimacy of DIDs. The convention promotes a decentralized
trust model where trust is established through cryptographic verification rather
than reliance on centralized authorities. By enabling anyone to access and
validate the information associated with a DID, the “/whois” path contributes to
the overall security and integrity of decentralized networks.

## [§](#didwebvh-did-method-specification) `did:webvh` DID Method Specification

### [§](#target-system) Target System

The target system of the `did:webvh` DID method is the host (or domain)
name when the domain specified by the DID is resolved through the Domain Name
System (DNS) and verified by processing a log of DID versions.

### [§](#method-name) Method Name

The namestring that identifies this DID method is: `webvh`. A DID that uses this
method MUST begin with the following prefix: `did:webvh`. Per the DID
specification, this string MUST be in lowercase. The remainder of the DID, after
the prefix, is the [method-specific identifier](#method-specific-identifier),
specified below.

### [§](#method-specific-identifier) Method-Specific Identifier

Every `did:webvh` DID **MUST** first conform to the DID Syntax ABNF Rules in [[DID-CORE](#ref:DID-CORE)] Section 3.1. The rules in this section are additional restrictions on, and do not replace, those rules. A `did:webvh` DID is valid only if it satisfies both the DID Core rules and the rules and validation requirements below.

When the DID Core `method-name` is `webvh`, the DID Core `method-specific-id` **MUST** additionally conform to the `webvh-method-specific-id` rule below. The rules `idchar` and `pct-encoded` are imported unchanged from DID Core. `ALPHA`, `DIGIT`, and `HEXDIG` are defined by [[RFC5234](#ref:RFC5234)].

```
webvh-method-specific-id = scid ":" webvh-domain
                             *( ":" webvh-path-segment )

scid                      = 46(base58btc-char)

base58btc-char            = %x31-39       ; 1-9
                          / %x41-48       ; A-H
                          / %x4A-4E       ; J-N
                          / %x50-5A       ; P-Z
                          / %x61-6B       ; a-k
                          / %x6D-7A       ; m-z

webvh-domain              = encoded-domain-name
                             [ percent-encoded-port ]

encoded-domain-name       = encoded-domain-label
                             1*( "." encoded-domain-label )

encoded-domain-label      = 1*( ALPHA / DIGIT / "-" / pct-encoded )

percent-encoded-port      = "%3A" port-number

port-number               = 1*5DIGIT

webvh-path-segment        = 1*idchar
```

ABNF character strings are case-insensitive by default, so `"%3A"` accepts either `%3A` or `%3a`. Producers **MUST** use the uppercase form `%3A` in the canonical representation.

The `scid` production describes the base58btc-encoded SHA-256 multihash generated and verified as specified in [SCID Generation and Verification](#scid-generation-and-verification). The `{SCID}` value used temporarily during DID creation is a placeholder and is not a conforming `scid`; it **MUST** be replaced before the DID is published or resolved.

The `webvh-domain` identifies the web origin from which the DID Log can be retrieved. After percent-decoding and applying the IDNA processing defined in [The DID to HTTPS Transformation](#the-did-to-https-transformation):

* the result **MUST** be a fully qualified domain name conforming to [[RFC1035](#ref:RFC1035)], [[RFC1123](#ref:RFC1123)], and [[RFC2181](#ref:RFC2181)];
* the domain name **MUST** match the applicable TLS server identity requirements in [[RFC9525](#ref:RFC9525)];
* the domain **MUST NOT** be an IPv4 or IPv6 address, including a non-canonical textual representation that a URL parser would normalize to an IP address;
* every DNS label **MUST** be non-empty, no more than 63 octets after IDNA processing, and the complete domain name **MUST** satisfy the DNS length limit; and
* percent-encoding **MUST** be valid and **MUST** be decoded exactly once before domain and port validation.

A percent-encoded colon (`%3A` or `%3a`) **MUST NOT** appear within `encoded-domain-name`. A `%3A` immediately followed by one to five decimal digits at the end of `webvh-domain` **MUST** be parsed as `percent-encoded-port`; if `percent-encoded-port` is present, `port-number` **MUST** represent a decimal integer in the range 1 through 65535 inclusive. The domain component **MUST NOT** contain more than one percent-encoded port separator.

Each `webvh-path-segment` represents one segment of the path used to retrieve the DID Log. A path segment **MUST** be non-empty. After percent-decoding exactly once, it:

* **MUST NOT** be `.` or `..`;
* **MUST NOT** contain `/`, `\\`, or U+0000; and
* **MUST NOT** begin or end with whitespace.

Invalid percent-encoding or failure of any decoded-value requirement **MUST** cause parsing, transformation, and resolution to fail with `invalidDid`.

The colons in `webvh-method-specific-id` delimit method-specific components. They are not DID URL path separators. For example, in:

```
did:webvh:<SCID>:example.com:issuers:business
```

`issuers` and `business` are method-specific deployment path segments used to locate the DID Log.

By contrast, `/`, `?`, and `#` introduce DID URL path, query, and fragment components under DID Core Section 3.2. They are not part of `webvh-method-specific-id`. A `did:webvh` DID URL **MUST** first conform to the DID URL Syntax ABNF Rules in DID Core Section 3.2, and its contained DID **MUST** satisfy the additional rules in this section. This specification does not otherwise replace DID Core’s `path-abempty`, `query`, or `fragment` productions.

The `id` of a resolved `did:webvh` DID Document identifies the DID subject and therefore **MUST** be a bare `did:webvh` DID. It **MUST NOT** contain a DID URL path, query, or fragment component.

Conforming identifiers have the following forms:

```
did:webvh:<SCID>:example.com
did:webvh:<SCID>:example.com%3A3000
did:webvh:<SCID>:example.com:dids:issuer
did:webvh:<SCID>:example.com%3A3000:dids:issuer
```

These are syntax templates: `<SCID>` stands for an actual conforming SCID and is not the literal characters `<SCID>`.

As specified in the [DID-to-HTTPS Transformation](#the-did-to-https-transformation) section of this specification, `did:webvh` and `did:web` DIDs that have the same fully qualified domain and path transform to the same HTTPS URL, with the exception of the final file: `did.json` for `did:web` and `did.jsonl` for `did:webvh`. For `did:webvh` DIDs using [witnesses](#term:witnesses), a `did-witness.json` file **MUST** also be available logically beside the `did.jsonl` file. See the [witnesses](#did-witnesses) section of this specification for details.

### [§](#the-did-to-https-transformation) The DID to HTTPS Transformation

The `did:webvh` [method-specific identifier](#method-specific-identifier) is
defined to enable a transformation of the DID to an HTTPS URL for publishing
and retrieving the [DID Log](#term:did-log). This section defines the transformation
from DID to HTTPS URL, including a number of examples.

Given a `did:webvh`, the HTTPS URL for the [DID Log](#term:did-log) is generated by
carrying out the following steps. The steps are carried out by the [DID Controller](#term:did-controller) to determine where to publish the [DID Log](#term:did-log), and by all resolvers to
retrieve the [DID Log](#term:did-log). The process described here includes the appropriate handling of [international domain names](#international-domain-names).

1. **Remove the ‘did:webvh:’ prefix** from the input identifier.
2. **Remove the SCID segment**, which is the first segment after the prefix.
3. **Transform the domain component**, which is the first component, up to the first `:` delimiter, of the remaining method-specific identifier.
   * Validate all percent-encoding and percent-decode the component exactly once.
   * If the decoded component contains a port separator, separate and validate the port as a decimal integer in the range 1 through 65535 inclusive.
   * Apply Unicode normalization and IDNA2008 processing to the decoded domain name.
   * Validate the resulting domain name and reject any IPv4 or IPv6 address, including an input that the URL parser normalizes to an IP address.
   * Re-encode the port separator as the canonical uppercase string `%3A` when producing a DID representation. Preserve the ordinary `:` separator when producing the HTTPS URL.
4. **Transform the method-specific deployment path**, consisting of the zero or more components after the domain component and delimited by `:` characters.
   * For each component, validate its percent-encoding and percent-decode it exactly once.
   * Reject a component if its decoded value is empty, is `.` or `..`, contains `/`, `\\`, or U+0000, or begins or ends with whitespace.
   * Percent-encode the validated decoded value according to [[RFC3986](#ref:RFC3986)], using uppercase hexadecimal digits.
   * Join the resulting encoded path segments using `/`.
5. **Reconstruct the HTTPS URL**:
   * Format as `https://{domain}:{port}/{encoded_path}/did.jsonl` if a port is present.
   * Format as `https://{domain}/{encoded_path}/did.jsonl` if there are path segments and no port.
   * If no path segments exist, format as `https://{domain}:{port}/.well-known/did.jsonl` or `https://{domain}/.well-known/did.jsonl` as applicable.
6. The content type for the `did.jsonl` file **SHOULD** be `text/jsonl`.

The DID URL path, query, and fragment, if present, **MUST** be separated from the DID before this transformation is applied. They **MUST NOT** be interpreted as part of the SCID, domain, port, or method-specific deployment path.

If the DID is using [witnesses](#term:witnesses), an extra JSON file containing the witness proofs for the [DID Log Entries](#term:did-log-entries) must be published and retrieved during resolution. The URL for the extra file is defined by replacing the `/did.jsonl` at the end of the [DID Log](#term:did-log) URL with `/did-witness.json`.

When this algorithm is used for resolving a DID path (such as `<did>/whois` or `<did>/path/to/file` as defined in the section [DID URL Handling](#did-url-resolution)) using the implicit `services`, update step **5.** to not include the `.well_known/` path segment, and to append the DID URL path instead of `did.jsonl`.

The following are some examples of various DID-to-HTTPS transformations based
on the processing steps specified above.

[EXAMPLE](#example-4)

`did:webvh` DIDs and the corresponding web locations of their `did:webvh` log file.
In the examples, `{SCID}` is a placeholder for where the generated [SCID](#term:scid) will be
placed in the actual DIDs and HTTPS URLs. Note that when the `{SCID}` follows
the literal `did:webvh:` as a separate element, the `{SCID}` is not part of the
HTTPS URL.

---

domain/`did:web`-compatible

`did:webvh:{SCID}:example.com` -->

`https://example.com/.well-known/did.jsonl`

subdomain

`did:webvh:{SCID}:issuer.example.com` -->

`https://issuer.example.com/.well-known/did.jsonl`

path

`did:webvh:{SCID}:example.com:dids:issuer` -->

`https://example.com/dids/issuer/did.jsonl`

path w/ port

`did:webvh:{SCID}:example.com%3A3000:dids:issuer` -->

`https://example.com:3000/dids/issuer/did.jsonl`

internationalized domain

`did:webvh:{SCID}:jp納豆.例.jp:用户` -->

`https://xn--jp-cd2fp15c.xn--fsq.jp/%E7%94%A8%E6%88%B7/did.jsonl`

A client resolving a `did:webvh` DID **MAY** choose to use a [watcher](#term:watcher) as the source of data about a `did:webvh` DID, rather than resolving the DID’s HTTPS location to retrieve the [DID Log](#term:did-log). See the specification section on [Watchers](#did-watchers) for information about `did:webvh` and [watchers](#term:watchers).

The location of the `did:webvh` `did.jsonl` [DID Log](#term:did-log) file is the same as
where the comparable `did:web`’s `did.json` file is published. A [DID Controller](#term:did-controller) **MAY** publish both DIDs and so, both files. The process
to do so is described in the [publishing a parallel `did:web`
DID](#publishing-a-parallel-didweb-did) section of this specification.

[WARNING](#warning-4)

While the transformation from a did:webvh identifier to an HTTPS resource relies on DNS resolution, clients should not assume that a `did:webvh` identifier is inherently bound to or controlled by the entity associated with the corresponding DNS domain. In fact, a `did:webvh` [DID Log](#term:did-log) may be obtained from sources other than its corresponding HTTPS location (perhaps indexed by its [SCID](#term:scid)), and in such cases, the same verification steps may be applied to determine its validity.

Verification of a did:webvh identifier using this specification ensures cryptographic validity, but that does not imbue “trust” in the identifier itself. Trust in a did:webvh DID should be derived from external sources, such as verifiable credentials issued by trusted parties (possibly discovered by resolving the DID’s [/whois](#did-url-whois-linkedvp-service) URL) or via Trust Registries that maintain authoritative records of trusted DIDs in a given context. Implementers should exercise caution and avoid conflating technical verification with trustworthiness, ensuring that reliance on a `did:webvh` identifier is informed by independent verification mechanisms.

### [§](#the-did-log-file) The DID Log File

The [DID log](#term:did-log) file contains a list of [entries](#term:entries), one for each version of the DID. A
version of the DID is an update to the contents of the resolved [DIDDoc](#term:diddoc) for the
DID, and/or a change to the [parameters](#term:parameters) that control the generation and
verification of the DID.

Each entry is a JSON object consisting of the following properties.

`{ "versionId": "", "versionTime": "", "parameters": {}, "state": {}, "proof" : [] }`

1. The [[JSON-SCHEMA-CORE](#ref:JSON-SCHEMA-CORE)] definition of the [DID log entry](#term:did-log-entry) data structure can be found in the [log\_entry.json](https://raw.githubusercontent.com/decentralized-identity/didwebvh/refs/heads/main/schemas/v1.0/log_entry.json) file in this repository.
2. The value of `versionId` **MUST** be a string consisting of the DID version number
   (starting at `1` and incrementing by one per DID version), a literal dash
   `-`, and the `entryHash`, a hash calculated across the [log entry](#term:log-entry)
   content. The input to the hash is chosen so as to link each entry to its
   predecessor in a ledger-like chain. The input to the hash is specified in the
   [Entry Hash Generation and
   Verification](#entry-hash-generation-and-verification) section of this
   specification.
3. The value of `versionTime` **MUST** be a timestamp in UTC of the entry in [ISO8601](#term:iso8601) format, as asserted by the [DID Controller](#term:did-controller). The timestamp
   **MUST** be the time the DID will be retrieved by a [witness](#term:witness) or resolver,
   or before.
4. The JSON object `parameters` contains the configurations/options set by the
   [DID Controller](#term:did-controller) to be used in the processing of current and future
   [log entries](#term:log-entries). Permitted `parameters` are defined in the [`did:webvh`
   DID Method Parameters](#didwebvh-did-method-parameters) section of this
   specification.
5. The JSON object `state` contains the [DIDDoc](#term:diddoc) for this version of the
   DID.
6. The JSON array `proof` contains a [Data Integrity](#term:data-integrity) proof created for
   the entry and signed by a key authorized to update the [DIDDoc](#term:diddoc).

After creation, each entry has (per the [JSON Lines](#term:json-lines) specification) all
extra whitespace removed, a `\n` character appended, and the result added to
the [DID Log](#term:did-log) file for publication.

A more comprehensive description of how to create and update a [DID log entry](#term:did-log-entry) is given in steps 4 - 6 of the [create DID](#create-register) section.

Examples of [DID Logs](#term:did-logs) and [DID log entries](#term:did-log-entries) can be found in the
[Examples](https://didwebvh.info/latest/example/) section on the `did:webvh` information website.

[EXAMPLE](#example-5)

**Examples of log entries that fail verification.** Illustrative and
non-exhaustive; the normative rejection criteria are defined in the DID
verification algorithm in this specification.

1. **Duplicate witness IDs.** `{"threshold": 1, "witnesses": [{"id": "did:key:X"}, {"id": "did:key:X"}]}` — the same `did:key` appears more than
   once in the witnesses list; each witness has to be unique.
2. **Pre-rotation active but `updateKeys` omitted.** If entry N-1 commits `nextKeyHashes: ["H1","H2"]`, then entry N has to contain an explicit `updateKeys` whose every member hashes to a value in `["H1","H2"]`. An entry N omitting `updateKeys` (intending to inherit) is invalid.
3. **Wrong cryptosuite on log-entry proof.** `{"type":"DataIntegrityProof","cryptosuite":"ecdsa-jcs-2019","proofPurpose":"assertionMethod"}` — rejected even if the signature is structurally valid, because `parameters.method` with value `did:webvh:1.0` requires `eddsa-jcs-2022`.
4. **`state.id` SCID in an entry does not match [SCID](#term:scid) in DID and in `parameters.scid`.** DID `did:webvh:Qm111...` [DID Log](#term:did-log) first entry has `parameters.scid: "Qm111..."` but in any entry has `state.id: "did:webvh:Qm222...:example.com"` — the [SCID](#term:scid) values are inconsistent.
5. **SCID changes under portability.** Entry N has `state.id: "did:webvh:Qm222...:new.example.com"` while entry N-1 carried `Qm111...` — the [SCID](#term:scid) is immutable across all entries.
6. **Unknown `method` value.** First entry has `parameters.method: "did:webvh:99.0"`, `"did:webvh:1.0-rc1"`, or `"didwebvh:1.0"` — unrecognised values are rejected and never silently downgraded.

### [§](#did-method-operations) DID Method Operations

#### [§](#create-register) Create (Register)

Creating a `did:webvh` DID is done by carrying out the following steps.

1. **Define the DID string**
   The start of the DID **MUST** be the literal string “`did:webvh:{SCID}:`”, where the `{SCID}` is
   a placeholder that will be replaced by the calculated [SCID](#term:scid) later in the process (see step
   5). This first part of the DID string is followed by a fully qualified domain name
   (with an optional path) that is secured by a TLS/SSL certificate and
   reflects the web location at which the [DID Log](#term:did-log) (`did.jsonl`) will be published

   The DID **MUST** be a valid `did:webvh` DID as per the ABNF of a `did:webvh` DID defined
   in the [Method-Specific Identifier](#method-specific-identifier) section of this specification.

   1. Note: the [SCID](#term:scid) for a `did:webvh` DID is not by default in the HTTPS
      URL for the DID. A [DID Controller](#term:did-controller) **MAY** include the [SCID](#term:scid) in the HTTPS URL by inserting additional placeholder `{SCID}`
      strings into the domain name or path components of the method-specific
      identifier when creating the DID. Additional instance(s) of the [SCID](#term:scid) in the domain and/or path parts of the DID does not alter the
      [DID-to-HTTPS transformation](#the-did-to-https-transformation).
2. **Generate the authorization key pair(s)**
   [Authorized keys](#authorized-keys) are authorized to control (create, update, deactivate) the DID.
   At the same time, generate any other key pairs that will be placed into the initial
   [DIDDoc](#term:diddoc) for the DID.

   1. If the DID is to use [pre-rotation](#term:pre-rotation), additional key generation will
      be necessary to generate the required “next” authorization keys and their
      corresponding [pre-rotation](#term:pre-rotation) hashes.
   2. For each authorization key pair, generate a [multikey](#term:multikey) based on the
      key pair’s public key. The [multikey](#term:multikey) representations of the public
      keys are placed in the `updateKeys` property in [parameters](#term:parameters).
   3. The public key(s) of the authorization key pair(s) **MAY** be used in the
      [DIDDoc](#term:diddoc) as well, but that is not required.
3. **Create the initial [DIDDoc](#term:diddoc) for the DID**
   The [DIDDoc](#term:diddoc) **MUST** contain the top level `id` property which **MUST** be the DID string from
   step 1, including the placement of the `{SICD}` placeholder for the [SCID](#term:scid). Other
   [DIDDoc](#term:diddoc) verifications **SHOULD** be performed.

   All other absolute references to the DID in the [DIDDoc](#term:diddoc) must use the form defined
   in step 1, with the identified placeholder for the [SCID](#term:scid) (e.g., `did:webvh:{SCID}:example.com#key-1`,
   `did:webvh:{SCID}:example.com:dids:issuer#key-1`, etc.).

   The [DIDDoc](#term:diddoc) can contain any other content as deemed necessary by the [DID Controller](#term:did-controller).

   1. Note: The placeholder (the string `{SCID}`) **MUST** be in every place in the [DIDDoc](#term:diddoc) where
      the [SCID](#term:scid) is to be placed.
4. **Generate a preliminary DID Log Entry** JSON object containing the same JSON
   properties that will be in the published [DID log entry](#term:did-log-entry), but with some
   values preset, pending calculation of the [SCID](#term:scid) and [entryHash](#term:entryhash) and
   without the `proof`.

   1. The value of `versionId` string **MUST** be the placeholder literal `"{SCID}"`.
   2. The value of `versionTime` string **MUST** be a valid UTC [ISO8601](#term:iso8601) date/time string,
      and the represented time **MUST** be before or equal to the current time.
   3. The value of the `parameters` property **MUST** be a JSON object defined at the
      discretion of the [DID Controller](#term:did-controller). The properties in this nested JSON object
      **MUST** be as permitted in the [DID Generation and Verification
      Parameters](#didwebvh-did-method-parameters) section of this specification,
      and all required values in the first version of the DID **MUST** be
      present. In addition, where the [SCID](#term:scid) of the DID is referenced in
      the parameters, the placeholder literal string `{SCID}` **MUST** be used
      in place of the to-be-calculated [SCID](#term:scid).
   4. The value of the `state` property **MUST** be the initial [DIDDoc](#term:diddoc) as
      defined in the previous step 3 of this process.
5. **Update the preliminary DID Log Entry to the initial DID Log Entry**
   Use the preliminary [DID log entry](#term:did-log-entry) to perform the consecutive steps:

   1. **Calculate the [SCID](#term:scid)**
      The preliminary JSON object **MUST** be used to calculate the [SCID](#term:scid) for the DID as defined in
      the [SCID Generation and Verification](#scid-generation-and-verification) section of this
      specification.
   2. **Replace the placeholder `{SCID}`** Treating the preliminary JSON object
      entry as a string, perform a literal text replacement of every occurrence of
      the placeholder `{SCID}` with the calculated [SCID](#term:scid) from the previous
      step.

      * NOTE: As a consequence, the literal string `{SCID}` cannot appear as a
        value anywhere in the first published [DID Log](#term:did-log) entry — it will
        always be replaced. If that string is required in the [DIDDoc](#term:diddoc), it
        can be introduced via an update in a subsequent [log entry](#term:log-entry).
   3. **Calculate the [Entry Hash](#term:entry-hash)**
      The preliminary JSON object updated in the previous step **MUST** be used to calculate the [Entry Hash](#term:entry-hash)
      (`entryHash`) for the [log entry](#term:log-entry), as defined in the
      [Entry Hash Generation and Verification](#entry-hash-generation-and-verification) section of
      this specification.
   4. **Replace the preliminary `versionId` value** The value of the `versionId`
      property **MUST** be updated with the literal string `1` (for version number 1),
      a literal `-`, followed by the `entryHash` value calculated in the previous
      step.
   5. **Generate the [Data Integrity](#term:data-integrity) proof** A [Data Integrity](#term:data-integrity)
      proof on the preliminary JSON object as updated in the previous step **MUST**
      be generated using an authorized key in the required `updateKeys` property in the
      [parameters](#term:parameters) object and the `proofPurpose` set to `assertionMethod`.
   6. **Add the [Data Integrity](#term:data-integrity) proof** The [Data Integrity](#term:data-integrity) proof
      is added to the preliminary JSON object. The resultant JSON object is the
      initial [DID log entry](#term:did-log-entry) for the DID.
6. **Generate the first [JSON Line](#term:json-line)**
   The [DID log entry](#term:did-log-entry) **MUST** be updated to be a [JSON Lines](#term:json-lines)
   entry by removing extraneous white space and appending a carriage return,
   and the result stored as the contents of the file `did.jsonl`.

   If the [DID Controller](#term:did-controller) has opted to use [witnesses](#term:witnesses) for the
   DID, the required proofs from the DID’s [witnesses](#term:witnesses) **MUST** be
   collected and published in the `did-witness.json` file before the [DID Log](#term:did-log) with the new version is published. See the [DID
   Witnesses](#did-witnesses) section of this specification.
7. **Publish the [DID Log](#term:did-log)**
   The complete [DID Log](#term:did-log) file **MUST** be published at the appropriate
   Web location defined by the `did:webvh` DID identifier (see step 1)

   * This is a logical operation – how a deployment serves the `did.jsonl`
     content is not constrained.
   * Use the [DID-to-HTTPS Transformation](#the-did-to-https-transformation)
     steps to transform the DID into the Web location of the [DID Log](#term:did-log)
     file.

   If there are [watchers](#term:watchers) configured for the DID, a webhook is triggered
   to notify the [watchers](#term:watchers) that a new DID is available and should be
   retrieved. See the [Watchers](#did-watchers) section of this specification for
   more details.

A controller **MAY** generate an equivalent `did:web` [DIDDoc](#term:diddoc) and publish it as
defined in the
[Publishing a Parallel `did:web` DID](#publishing-a-parallel-didweb-did) section
of this specification. The `did:web` [DIDDoc](#term:diddoc) could be used for backwards
compatibility as a transition is made from `did:web` to `did:webvh`. Verifiers
using the `did:web` lose the verifiable properties and history of the `did:webvh`
for the convenience of the simple retrieval of the `did:web` [DIDDoc](#term:diddoc).

#### [§](#read-resolve) Read (Resolve)

The following steps MUST be executed to resolve the [DIDDoc](#term:diddoc) for a `did:webvh` DID:

1. The [DID-to-HTTPS Transformation](#the-did-to-https-transformation) steps
   **MUST** be used to transform the DID into an HTTPS URL for the [DID Log](#term:did-log) file.
2. Perform an HTTPS `GET` request to the URL using an agent that can successfully
   negotiate a secure HTTPS connection, which enforces the security requirements
   as described in
   [Security considerations](#security-considerations).
3. When performing the DNS resolution during the HTTPS GET request, the client
   SHOULD utilize [[RFC8484](#ref:RFC8484)] in order to prevent tracking of the identity
   being resolved.
4. The [DID Log](#term:did-log) file **MUST** be processed as described below.

To process the retrieved [DID Log](#term:did-log) file, the resolver **MUST** carry out the following steps on each of the [log entries](#term:log-entries) in the order they appear in the file, applying the [parameters](#term:parameters) from the current and previous entries. Every step **MUST** be performed for **every** entry; in particular, [Data Integrity](#term:data-integrity) proof verification (step 2) and `entryHash` verification (step 3) **MUST NOT** be skipped for intermediate entries on the grounds that the resolver only needs the latest [DIDDoc](#term:diddoc).

[NOTE](#basic-note-1)

NOTE: A resolver implementation that caches previously verified state could
retrieve only subsequent entries and resume processing after the last verified
entry rather than reprocessing the full log, provided the cached state was
itself produced by full verification and the cache has not been modified
since.

As noted in the [DID Log File](#the-did-log-file) section, [log entries](#term:log-entries) are each a JSON object with the following properties:

1. `versionId`
2. `versionTime`
3. `parameters`
4. `state` – the version’s [DIDDoc](#term:diddoc).
5. `proof` – a [Data Integrity](#term:data-integrity) proof for the [log entry](#term:log-entry).

Initialize a counter `didIdMatchCount` to `0` before processing any entries.

For each entry:

1. Update the currently active [parameters](#term:parameters) with the [parameters](#term:parameters)
   from the entry (if any). The `parameters` **MUST** adhere to the [`did:webvh`
   DID Method Parameters](#didwebvh-did-method-parameters) section of this
   specification. Continue processing using the now active set of [parameters](#term:parameters).
   * While all [parameters](#term:parameters) in the first [Log Entry](#term:log-entry) take effect
     immediately, some kinds of [parameters](#term:parameters) defined in later [entries](#term:entries) only take effect *after* that entry has been published. For
     example, updates to the `witnesses` array take effect only
     *after* the entry in which they are defined has been published.
2. The [Data Integrity](#term:data-integrity) proof in the entry **MUST** be valid and signed by
   an authorized key as defined in the [Authorized Keys](#authorized-keys)
   section of this specification, and with a `proofPurpose` set to `assertionMethod`.
   1. If the [DID Controller](#term:did-controller) has opted to use [witnesses](#term:witnesses)
      resolvers **MUST** retrieve and verify the DID’s `did-witness.json` file. For
      details, see the [DID Witnesses](#did-witnesses) section of this
      specification.
3. Verify the `versionId` for the entry.
   1. The version number **MUST** be `1` for the first entry and **MUST** equal the previous entry’s version number + 1 for each subsequent entry. Gaps (e.g., entry 3 after entry 1) **MUST** terminate resolution.
   2. Exactly one dash `-` **MUST** follow the version number; missing or multiple dashes **MUST** cause rejection.
   3. The `entryHash` **MUST** follow the dash, **MUST** be a valid [multihash](#term:multihash) in the algorithm permitted by the active `method`, and **MUST** be verified per [Entry Hash Generation and Verification](#entry-hash-generation-and-verification). Verification **MUST** be performed for every entry.
4. The `versionTime` **MUST** be a valid UTC [ISO8601](#term:iso8601) string with explicit `Z` (or `+00:00`); values without a zone designator, or expressing a non-UTC zone, **MUST** be rejected.
   * The `versionTime` of **every** entry **MUST** be strictly greater than the immediately preceding entry’s. Equal timestamps **MUST** be rejected.
   * The `versionTime` of every entry **MUST NOT** be more than a small,
     implementation-defined tolerance in the future relative to the resolver’s
     current time. Resolvers **SHOULD** use a tolerance of no more than 5
     minutes. Entries that exceed this tolerance **MUST** cause resolution to
     fail.
5. When processing the first [DID log](#term:did-log) entry, verify the [SCID](#term:scid)
   (defined in the [parameters](#term:parameters)) according to the
   [SCID Generation and Verification](#scid-generation-and-verification) section
   of this specification.
6. Get the value of the [log entry](#term:log-entry) property `state`, which is the [DIDDoc](#term:diddoc) for the version.
   1. Parse the top-level `id` of `state` as a `did:webvh` DID per the [Method-Specific Identifier](#method-specific-identifier) ABNF; if parsing fails, resolution **MUST** terminate.
   2. The SCID segment of `state.id` **MUST** be byte-for-byte identical to the `scid` value in the DID and the first entry’s `parameters.scid`. This check **MUST** apply to **every** entry’s `state.id`, not just the first. A mismatch **MUST** terminate resolution.
   3. If the DID being resolved matches exactly the value of `state.id` in the current [DIDDoc](#term:diddoc) entry, increment `didIdMatchCount` by `1`.
7. If [Key Pre-Rotation](#term:key-pre-rotation) is active (the previously active `nextKeyHashes` is non-empty), the entry being processed **MUST** include an explicit `parameters.updateKeys` and **MUST NOT** rely on inheritance. The hash of **every** [multikey](#term:multikey) in `parameters.updateKeys` (computed per [Pre-Rotation Key Hash Generation and Verification](#pre-rotation-key-hash-generation-and-verification)) **MUST** appear in the previous entry’s `nextKeyHashes`. The check applies to the **full** `updateKeys` set, not only keys that are new relative to the previous entry. A key not in the previous entry’s `nextKeyHashes` **MUST** cause resolution to terminate, even if it appeared in an earlier entry’s `updateKeys`.
8. As each [log entry](#term:log-entry) is processed and verified, collect the following information
   about each version:
   1. The [DIDDoc](#term:diddoc).
   2. The `versionId` of the [DIDDoc](#term:diddoc).
   3. The UTC `versionTime` of the [DIDDoc](#term:diddoc).
   4. The latest list of active [multikey](#term:multikey) formatted public keys
      authorized to update the DID, from the `updateKeys` lists in the
      [parameters](#term:parameters).
   5. If [pre-rotation](#term:pre-rotation) is being used, the hashes of authorized keys that must
      be used in the `updateKeys` list of the next [DID log](#term:did-log) entry. The [pre-rotation](#term:pre-rotation) hashes are in the
      `nextKeyHashes` list in the [parameters](#term:parameters).
   6. All other `did:webvh` processing configuration settings as defined in the
      `parameters` object.
   7. Add the value of top level `id`.
   8. The value of `DIDIdMatchCount`.
9. If the `parameters` for any of the versions define that some or all of
   the [DID Log entries](#term:did-log-entries) must be witnessed, further verification of
   the [witness](#term:witness) proofs must be carried out, as defined in the [DID
   Witnesses](#did-witnesses) section of this specification.

At the end of verifying all [DID Log](#term:did-log) entries, the value of `didIdMatchCount` **MUST** be greater than `0`; if it is `0`, the
log **MUST** be rejected, as no entry’s `state.id` matches the DID being resolved.

10. Flag failed verifications appropriately, either invalidating the entire DID or marking all entries from the first invalid entry to the end of the log as invalid.
11. Respond to the resolution request based on verification results:

    1. If all verifications pass, resolve the DID, applying any query parameters as requested.
    2. If the request includes query parameters (e.g., `?versionId=` or `?versionTime=`) that reference valid [DID log entries](#term:did-log-entries), return the corresponding [DIDDoc](#term:diddoc) version with a successful status code—even if later entries in the log are invalid.
    3. If the DID or DID version being resolved is invalid, return an appropriate error code.

While resolver caching policies are an implementation matter and largely outside the scope of this specification, resolvers **SHOULD NOT** cache a DID that fails verification. This ensures that the DID’s [DID Controller](#term:did-controller) has the opportunity to recover a DID that may have been erroneously or maliciously invalidated.

A resolver **MAY** use a DID [watcher](#term:watcher) in addition to, or in place of retrieving the DID information from the source, and use that information based on their knowledge of the governance of the [watcher](#term:watcher). See the [Watchers](#did-watchers) section of this specification for more details.

As defined in the [[DID-RESOLUTION](#ref:DID-RESOLUTION)] specification, a did:webvh resolver should return the following DID Document Metadata when resolving a `did:webvh` DID Document:

```
{
  "versionId": "1-QmRRaLXwc6BjBuBPosSupJwEQ8w9f3znP7yfbpGfwcnLr6",
  "versionTime": "2025-01-23T04:12:36Z",
  "created": "2025-01-23T04:12:36Z",
  "updated": "2025-01-23T04:12:36Z",
  "scid": "QmPEQVM1JPTyrvEgBcDXwjK4TeyLGSX1PxjgyeAisdWM1p",
  "portable": false,
  "deactivated": false,
  "ttl": "3600",
  "witness": { ...
  },
  "watchers: [ ...
  ]
}
```

where the items in the Metadata JSON object are:

* `versionId` — The `versionId` from the [Log Entry](#term:log-entry) of the resolved DIDDoc version.
* `versionTime` — The `versionTime` from the [Log Entry](#term:log-entry) of the resolved DIDDoc version, in [ISO8601](#term:iso8601) timestamp format.
* `created` — The [ISO8601](#term:iso8601) timestamp of the DID’s first [log entry](#term:log-entry), indicating when (according to the [DID Controller](#term:did-controller)) the DID was created.
* `updated` — The [ISO8601](#term:iso8601) timestamp of the DID’s last valid [log entry](#term:log-entry).
* `scid` — The [SCID](#term:scid) of the resolved DID.
* `portable` — A boolean value indicating whether the resolved DID has [portability](#term:portability) active and so may be moved in the future, as defined in the [portability](#did-portability) section of this specification.
* `deactivated` — A boolean indicating whether the DID has been deactivated. When `true`, the DID is no longer active.
* `ttl` - A string containing the unsigned integer value of the DID’s `ttl` [parameter](#term:parameter) (time-to-live) in seconds. The TTL is guidance from the [DID Controller](#term:did-controller) for those resolving the DID about how long to cache the DID. The value is a string containing the integer value because the [[DID-RESOLUTION](#ref:DID-RESOLUTION)] specification requires that DID metadata not be integers. The value needs to be converted to an integer by the resolver client before use.
* `witness` — An object containing the current (active in the last valid [DID log entry](#term:did-log-entry)) configuration of witnesses for the DID. The object is as defined as the same named object in the [witness list](#witness-lists) section of this specification.
  + The value of the `threshold` attribute of the `witness` object is a string containing the integer value of `threshold` because the [[DID-RESOLUTION](#ref:DID-RESOLUTION)] specification requires that DID metadata not include integers. The value needs to be converted to an integer by the resolver client before use.
* `watchers` — An array containing the current (active in the last valid [DID log entry](#term:did-log-entry)) list of [watcher](#term:watcher) URLs that have agreed to monitor and cache the DID’s state.

The “last valid [log entry](#term:log-entry)” for some of the items above references the case where a DID resolution request references a DIDDoc that was valid, but where the DID Log has later [log entries](#term:log-entries) that fail verification, as noted in the DID resolution steps earlier in this section. If all [log entries](#term:log-entries) pass verification, the last valid [log entry](#term:log-entry) is the last [log entry](#term:log-entry).

When a DID resolution error occurs, the `error` field **MUST** be included in the `didResolutionMetadata`, as defined by the [[DID-RESOLUTION](#ref:DID-RESOLUTION)] specification. In addition, resolvers **SHOULD** provide supplemental “Problem Details” metadata following [[RFC9457](#ref:RFC9457)], using the following structure:

```
"didResolutionMetadata": {
  "error": "invalidDid",
  "problemDetails": {
    "type": "https://w3id.org/security#INVALID_CONTROLLED_IDENTIFIER_DOCUMENT_ID",
    "title": "The resolved DID is invalid.",
    "detail": "Parse error of the resolved DID at character 3, expected ':'."
  }
}
```

As described in [[DID-EXTENSION-RESOLUTION](#ref:DID-EXTENSION-RESOLUTION)], the following values **MUST** be used in the `error` field of the resolution metadata when resolving a `did:webvh` DID under the corresponding error conditions:

* `notFound` — The [DID Log](#term:did-log) or the resource referenced by a DID URL was not found. If the [DID Log](#term:did-log) does not exist at the DID’s designated HTTPS location (according to the [DID-to-HTTPS Transformation](#the-did-to-https-transformation)), the resolver **MAY** attempt to retrieve it from alternative sources, such as [Watchers](#term:watchers), for verification and resolution.
* `invalidDid` — Any error that renders the `did:webvh` DID invalid during resolution.

Resolvers **SHOULD** populate the `problemDetails` field to aid in diagnosing and understanding resolution failures. The [did:webvh information site](https://didwebvh.info) may serve as a non-normative reference for common `did:webvh` resolution error types and explanations.

##### [§](#reading-didwebvh-did-urls) Reading did:webvh DID URLs

A `did:webvh` DID identifies a log by its [SCID](#term:scid); host/path locate where the log is hosted. When a resolver receives a request, the [SCID](#term:scid) segment of the requested DID **MUST** equal the [SCID](#term:scid) segment of `state.id` in all entries of the retrieved log **and** equal `parameters.scid` from the first entry. A log whose `state.id` [SCID](#term:scid) does not match the requested DID — even if host/path matches — **MUST NOT** be returned; resolution **MUST** terminate. This rule applies independently of whether portability is enabled.

A `did:webvh` resolver **MUST** resolve the [[DID-CORE](#ref:DID-CORE)] `versionId` and
`versionTime` DID URL query parameters. The `versionId` query argument value
**MUST** match the full `versionId` from a [DID Log entry](#term:did-log-entry) for the
resolver to return that version of the DIDDoc. If a [DID Log entry](#term:did-log-entry) with
that `versionId` is not found, a `NotFound` **MUST** be returned. A specified
time in [ISO8601](#term:iso8601) format as the query argument for `versionTime` **MUST**
return the DIDDoc from the [DID Log entry](#term:did-log-entry) that was active at that time,
if any. If the DID was not active at the specified time, a `NotFound` **MUST**
be returned.

A `did:webvh` resolver **SHOULD** resolve the DID URL query parameter
`versionNumber` with an integer value if there is a [DID Log entry](#term:did-log-entry) with
a `versionId` with a matching integer prior to the literal `-` – the
`versionNumber` for that [DID Log entry](#term:did-log-entry) as defined in the process for
setting the `versionId` in the [creating the DID](#create-register) section of
this specification. The `versionNumber` query parameter is not in the
[[DID-CORE](#ref:DID-CORE)] specification.

A `did:webvh` resolver **MAY** implement the resolution of the `/whois` and a DID
URL Path using the [whois LinkedVP Service](#did-url-whois-linkedvp-service) and
[DID URL Path Resolution Service](#did-url-path-resolution) as defined in
this specification by processing the [DID Log](#term:did-log) and then dereferencing the
DID URL based on the contents of the [DIDDoc](#term:diddoc). The client of a resolver that does
not implement those capabilities must use the resolver to resolve the
appropriate [DIDDoc](#term:diddoc), and then process the resulting DID URLs themselves. Since
the default DID-to-HTTPS URL transformation is trivial, `did:webvh`
[DID Controllers](#term:did-controllers) are strongly encouraged to use the default behavior
for DID URL Path resolution.

#### [§](#update-rotate) Update (Rotate)

To update a DID, a new, verifiable [DID Log Entry](#term:did-log-entry) must be generated,
witnessed (if necessary), appended to the existing [DID Log](#term:did-log) (`did.jsonl`),
and published to the web location defined by the DID. The process to generate a
verifiable [DID Log Entry](#term:did-log-entry) follows a similar process to the
[Create](#create-register) process, as follows:

1. Make the desired changes to the [DIDDoc](#term:diddoc). The top-level `id` in the
   [DIDDoc](#term:diddoc) **MUST** contain the value of the DID.
   1. If the DID is configured to support [portability](#term:portability), the root `id`
      property in the [DIDDoc](#term:diddoc) **MAY** be changed when the [DID Controller](#term:did-controller) wants to (or
      is forced to) publish the DID at a different Internet location and wants
      to retain the [SCID](#term:scid) and history of the DID. For details, see the
      [DID Portability](#did-portability) section of this specification.
2. Define the [parameters](#term:parameters) JSON object to include the properties that affect the evolution of the
   DID. The `parameters` **MUST** be from those listed in the [`did:webvh` DID
   Method Parameters](#didwebvh-did-method-parameters) section of this
   specification. Any [parameters](#term:parameters) defined in the JSON object override the
   previously active value, while any [parameters](#term:parameters) not included imply the
   existing values remain in effect. If no changes to the [parameters](#term:parameters)
   are needed, an empty JSON object `{}` **MUST** be used.
   * While all [parameters](#term:parameters) in the first [Log Entry](#term:log-entry) take effect
     immediately, some types of [parameters](#term:parameters) defined in later [entries](#term:entries) only take
     effect after the entry has been published. For example, rotating the keys
     authorized to update a DID or changing the [witnesses](#term:witnesses) for a DID take effect
     only *after* the entry in which they are defined has been published.
3. Generate a preliminary [DID log entry](#term:did-log-entry) JSON object containing the following properties:
   1. The value of `versionId` **MUST** be the value of `versionId` from the *previous* [DID log entry](#term:did-log-entry).
   2. The `versionTime` value **MUST** be a string that is an [ISO8601](#term:iso8601)
      format UTC timestamp. The time **MUST** be greater than the time of the
      previous [log entry](#term:log-entry), and **MUST** be the time the DID will be
      retrieved by a [witness](#term:witness) or resolver, or before.
   3. The [parameters](#term:parameters) passed in as a JSON object.
   4. Set the `state` JSON object to be the new version of the [DIDDoc](#term:diddoc).
4. Calculate the new `versionId` of the new [DID Log Entry](#term:did-log-entry), including
   incrementing the version number integer and using the process described in
   the [Entry Hash Generation and Verification](#entry-hash-generation-and-verification)
   section of this specification.
5. Replace the value of the `versionId` property in the preliminary [DID Log Entry](#term:did-log-entry) with the value produced in the previous step.
6. Generate a [Data Integrity](#term:data-integrity) proof on the [DID log entry](#term:did-log-entry) using
   an authorized key, as defined in the [Authorized Keys](#authorized-keys)
   section of this specification, and the `proofPurpose` set to `assertionMethod`.
7. If [Key Pre-Rotation](#term:key-pre-rotation) is being used, the hash of all `updateKeys` entries
   in the `parameters` property **MUST** match a hash in
   the array of `nextKeyHashes` [parameter](#term:parameter) from the previous [DID log](#term:did-log) entry with the exception of the first entry, as defined in the
   [Pre-Rotation](#term:pre-rotation)[Key [Pre-Rotation](#term:pre-rotation) Hash Generation and Verification](#pre-rotation-key-hash-generation-and-verification)
   section of this specification.
8. The proof JSON object **MUST** be added as the value of the `proof` property in the [log entry](#term:log-entry).
9. The entry **MUST** be made a [JSON Line](#term:json-line) by removing extra whitespace, adding a `\n`
   to the entry.
10. If the [DID Controller](#term:did-controller) opts to use [witnesses](#term:witnesses) for the
    DID, the [DID Controller](#term:did-controller) **MUST** collect the [threshold](#term:threshold) of proofs
    from the DID’s [witnesses](#term:witnesses), and update and publish the DID’s
    `did-witness.json` file. The updated `did-witness.json` file **MUST** be published
    **BEFORE** the updated [DID Log](#term:did-log) file is published. See the [DID
    Witnesses](#did-witnesses) section of this specification.
11. The new [log entry](#term:log-entry) **MUST** be appended to the existing contents of
    the [DID Log](#term:did-log) file `did.jsonl`.
12. The updated [DID Log](#term:did-log) file **MUST** be published at the appropriate
    location defined by the `did:webvh` identifier.
    * This is a logical operation – how a deployment serves the `did.jsonl`
      content is not constrained.
    * If there are [watchers](#term:watchers) configured for the DID, webhooks are triggered
      to notify the [watchers](#term:watchers) that an update is available and should be
      retrieved. See the [Watchers](#did-watchers) section of this specification for
      more details.

A controller **MAY** generate an equivalent, updated `did:web` [DIDDoc](#term:diddoc) and
publish it as defined in the
[Publishing a Parallel `did:web` DID](#publishing-a-parallel-didweb-did)
section of this specification.

#### [§](#deactivate-revoke) Deactivate (Revoke)

Deactivating a DID allows a [DID Controller](#term:did-controller) to signal that the DID is no longer being maintained or updated. There is an explicit approach to deactivation that aligns with the [[DID-CORE](#ref:DID-CORE)] specification, and other approaches that a `did:webvh` [DID Controller](#term:did-controller) can use if the [[DID-CORE](#ref:DID-CORE)] approach does not achieve their desired outcome. This section covers the various methods for signaling that a DID is retired.

To deactivate a `did:webvh` DID per the [[DID-CORE](#ref:DID-CORE)] specification, the [DID Controller](#term:did-controller) **MUST** add to the [DID log entry](#term:did-log-entry) [parameters](#term:parameters) the property name and value `"deactivated": true`. Once done, a resolver **MUST NOT** return the [DIDDoc](#term:diddoc) and **MUST** include `"deactivated": true` in the DID Resolution Metadata. A [DID Controller](#term:did-controller) deactivating a `did:webvh` DID **MAY** update some [parameters](#term:parameters) attributes to further indicate the deactivation of the DID, such as setting the `updateKeys` array to `[]`, preventing further versions of the DID. If the DID is using [pre-rotation](#term:pre-rotation), two [DID log entries](#term:did-log-entries) are required to accomplish that state: the first to stop the use of pre-rotation, and the second to set `updateKeys` to []. For additional details about turning off [pre-rotation](#term:pre-rotation) see the [pre-rotation](#pre-rotation) section of this specification.

A concern with using the [[DID-CORE](#ref:DID-CORE)] approach to deactivation is the resolver requirement that the [DIDDoc](#term:diddoc) not be returned for a deactivated DID. A [DID Controller](#term:did-controller) might want the final [DIDDoc](#term:diddoc) to continue to be resolved, while also signaling that the DID is no longer being updated. In the future, a DID Resolution query parameter (`returnDeactivatedDidDocument=true`) has been proposed to be added to the [[DID-RESOLUTION](#ref:DID-RESOLUTION)] specification to allow a client to request the [DIDDoc](#term:diddoc) of a deactivated DID. However, even if that parameter is adopted, it places the burden on the resolver client to decide whether and how to use it. An alternative that a `did:webvh` [DID Controller](#term:did-controller) could use is to signal that a DID is no longer being updated by setting the `updateKeys` array to empty (`[]`), as discussed above, and not setting the `deactivated` [parameter](#term:parameter) to `true`. The result is that the final [DIDDoc](#term:diddoc) continues to be returned by default, and the DID Resolution Metadata indicates that the DID can no longer be updated.

To resolve a prior version of a deactivated `did:webvh` DID, a client can use the appropriate DID Resolution query [parameters](#term:parameters) `versionId`, `versionTime`, or the did:webvh-specific `versionNumber` (as described in the Read (Resolve) section of this specification). When such a DID is resolved in this way, the DID Resolution Metadata **MUST** include the property name and value `"deactivated": true`.

A [DID Controller](#term:did-controller) can “deactivate” a DID by removing the published [DID Log](#term:did-log) and associated files and resources. Once removed, attempts to retrieve the [DID Log](#term:did-log) will result in a `Not Found` error status when resolving the DID. [Watchers](#term:watchers) monitoring a removed DID **SHOULD** continue to cache the last known valid state of the DID indefinitely so that their clients can still resolve and reference it, even after the [DID Log](#term:did-log) has been deleted.

### [§](#did-method-processes) DID Method Processes

The [DID Method Operations](#did-method-operations) reference several processes
that are executed during [DIDDoc](#term:diddoc) generation and DID resolution verification. Each
of those processes is specified in the following sections.

#### [§](#didwebvh-did-method-parameters) `did:webvh` DID Method Parameters

All `did:webvh` [Log entries](#term:log-entries) contain the JSON object `parameters`. This object defines the DID processing [parameters](#term:parameters) used by the [DID Controller](#term:did-controller) when publishing the current and subsequent [DID log entries](#term:did-log-entries). DID Resolvers **MUST** use the same [parameters](#term:parameters) to process the [DID Log](#term:did-log) to resolve the DID. The `parameters` object **MUST** only include properties defined in the version of the `did:webvh` DID Method specification being used.

**General Rules for Parameters:**

* **Default Values**: When the `method` parameter (see below) sets the [[SEMVER](#ref:SEMVER)] version of this specification to be used for a DID, any parameter introduced by that version but not explicitly set in the same [log entry](#term:log-entry) **MUST** assume the default value defined in this section. The `method` parameter is required in the first [log entry](#term:log-entry) and may appear in later entries to upgrade the DID to a newer [[SEMVER](#ref:SEMVER)] version of the `did:webvh` specification.
* **Allowed Values**: Each parameter is constrained by the data type, structure and allowed values specified in this section. If a value does not conform, the parameter is invalid and resolvers **MUST** reject the [log entry](#term:log-entry).
* **Deactivation**: Parameters that support deactivation (such as `witness` or `nextKeyHashes`) are set to defined values, described below, to indicate they are no longer active.
* The JSON `null` value **MUST NOT** be used to indicate default or deactivated values, as it removes the typing information required for proper interpretation.

[NOTE](#note-2)

Some early `did:webvh` implementations used the JSON `null` value to indicate the deactivation of parameters such as `watchers`, `witness`, `updateKeys`, `nextKeyHashes`, and `ttl`. Although this usage is deprecated and not valid per the current specification, resolver implementations **SHOULD** gracefully accept `null` and immediately convert the value to their equivalent default value for the parameter when processing [DID Log entries](#term:did-log-entries).

[EXAMPLE](#example-6)

An example of the `parameters` property in the first [DID Log](#term:did-log) entry:

```
{
  "portable": true,
  "updateKeys": [
    "z82LkqR25TU88tztBEiFydNf4fUPn8oWBANckcmuqgonz9TAbK9a7WGQ5dm7jyqyRMpaRAe"
  ],
  "nextKeyHashes": [
    "enkkrohe5ccxyc7zghic6qux5inyzthg2tqka4b57kvtorysc3aa"
  ],
  "method": "did:webvh:1.0",
  "scid": "{SCID}"
}
```

The following lists the [parameters](#term:parameters), their data types, and enumerated values.

* `method`: Specifies the `did:webvh` [[SEMVER](#ref:SEMVER)] specification version to be used for processing the DID’s log. Each acceptable value in turn defines what cryptographic algorithms are permitted for the current and subsequent [DID log entries](#term:did-log-entries). An update to the specification version in the middle of a [DID Log](#term:did-log) could introduce new [parameters](#term:parameters).
  + **MUST** appear in the first [log entry](#term:log-entry) and **MUST** be one of the enumerated acceptable values below.
  + Resolvers **MUST** reject any `method` value that is not **exactly** one of the acceptable values for the version(s) of this specification the resolver supports. Unknown values **MUST NOT** be silently downgraded, defaulted, or ignored — resolution **MUST** terminate.
  + If not present in later entries, the previous value continues to be active.
  + **MAY** appear in later entries to upgrade the spec version. A change to a *lower* version than currently active **MUST** be rejected.
  + Acceptable values:
    - `did:webvh:1.0`
      * Permitted hash algorithms: `SHA-256` [[RFC6234](#ref:RFC6234)] (multihash code `0x12`) **only**. Any other algorithm **MUST** cause resolution to terminate.
      * Permitted [Data Integrity](#term:data-integrity) cryptosuites for **both** log-entry proofs **and** witness proofs: exactly `eddsa-jcs-2022` [[DI-EDDSA-V1.0](#ref:DI-EDDSA-V1.0)]. Resolvers **MUST** verify the proof’s `cryptosuite` property; an absent, mismatched, or non-conformant `cryptosuite` **MUST** cause the entry to be rejected. Verifying only `proofPurpose` is **insufficient**.
        + [witness](#term:witness) [did:key](#term:did:key) identifiers **MUST** use a key compliant with the `eddsa-jcs-2022` cryptosuite defined in [[DI-EDDSA-V1.0](#ref:DI-EDDSA-V1.0)].
* `scid`: The [SCID](#term:scid) value for the DID.
  + **MUST** appear in the first [log entry](#term:log-entry).
  + **MUST NOT** appear in later [log entries](#term:log-entries).
* `updateKeys`: A JSON array of [multikey](#term:multikey) formatted public keys associated with the private keys that are authorized to sign the log entries that update the DID. See the [Authorized Keys](#authorized-keys) section of this specification for additional details.
  + This property **MUST** appear in the first [log entry](#term:log-entry) and **MAY** appear in subsequent entries.
  + If not present in later [DID log entries](#term:did-log-entries), the previous value continues to apply.
  + A key from the active `updateKeys` array **MUST** be used to authorize each [log entry](#term:log-entry), where active is defined as follows.
    - In the first [log entry](#term:log-entry), the active `updateKeys` is the one defined in that entry.
    - In all other [log entries](#term:log-entries) *without* [Key Pre-Rotation](#term:key-pre-rotation) active, the active `updateKeys` is that of the most recent **prior** [log entry](#term:log-entry).
    - In all other [log entries](#term:log-entries) *with* [Key Pre-Rotation](#term:key-pre-rotation) active, the active `updateKeys` is that of the most current [log entry](#term:log-entry).
  + `updateKeys` **SHOULD** be set to an empty array `[]` when deactivating the DID. See the [deactivate](#deactivate-revoke) section of this specification for more details.
* `nextKeyHashes`: A JSON array of strings that are hashes of [multikey](#term:multikey) formatted public keys that **MAY** be added to the `updateKeys` list in the next [log entry](#term:log-entry). At least one entry of `nextKeyHashes` **MUST** be added to the next `updateKeys` list.
  + The process for generating the hashes and additional details for using [pre-rotation](#term:pre-rotation) are defined in the [Pre-Rotation Key Hash Generation and Verification](#pre-rotation-key-hash-generation-and-verification) section of this specification.
  + If not set in the first [log entry](#term:log-entry), its value defaults to an empty array (`[]`).
  + If not set in other [log entries](#term:log-entries), its value is retained from the most recent prior value.
  + Once `nextKeyHashes` has been set to a non-empty array, [Key Pre-Rotation](#term:key-pre-rotation) is active. While active, **both** `nextKeyHashes` **AND** `updateKeys` **MUST** be present as explicit properties in every subsequent [log entry](#term:log-entry) until pre-rotation is deactivated (by setting `nextKeyHashes` to `[]`). A subsequent entry that omits `updateKeys` **MUST** be rejected by resolvers, even if the omission would otherwise inherit the previous value. Inheritance of `updateKeys` is **never** permitted while pre-rotation is active — that bypass would defeat the pre-rotation commitment.
  + While [Key Pre-Rotation](#term:key-pre-rotation) is active, **every** [multikey](#term:multikey) in the current entry’s `updateKeys` (not only those that appear new) **MUST** have its hash in the previous entry’s `nextKeyHashes`.
  + A [DID Controller](#term:did-controller) **MAY** include extra hashes in the `nextKeyHashes` array that are not subsequently used in an `updateKeys` entry. Any unused hashes in `nextKeyHashes` arrays are ignored.
  + The value of `nextKeyHashes` **MAY** be set to an empty array (`[]`) to deactivate [pre-rotation](#term:pre-rotation). For additional details about turning off [pre-rotation](#term:pre-rotation), see the [Pre-Rotation Key Hash Generation and Verification](#pre-rotation-key-hash-generation-and-verification) section of this specification.
* `witness`: A JSON object declaring the set of witnesses and threshold number of witness proofs required to update the DID. For details of this data and its usage in the DID update approval process, see the [DID Witnesses](#did-witnesses) section of this specification.
  + Defaults to `{}` if not set in the first [log entry](#term:log-entry).
  + If not set in other [log entries](#term:log-entries), its value is retained from the most recent prior value.
  + If the `witness` property is updated from `{}`, the change is immediately active, and the corresponding [log entry](#term:log-entry) **MUST** be [witnessed](#term:witnessed).
  + The `witness` [parameter](#term:parameter) **MAY** be set to `{}` to indicate that
    witnesses are not (or no longer) being used. If witnesses are active when the
    `witness` [parameter](#term:parameter) is set to `{}`, that [log entry](#term:log-entry)
    **MUST** be [witnessed](#term:witnessed).
* `watchers`: An optional entry whose value is a JSON array containing a list of URLs ([[RFC9110](#ref:RFC9110)]) that have notified the DID Controller that they are willing to watch the DID. See the [Watchers](#did-watchers) section of this specification for more details.
  + Defaults to `[]` if not set in the first [log entry](#term:log-entry).
  + If not set in other [log entries](#term:log-entries), its value is retained from the most recent prior value.
  + **MAY** be set to an empty array `[]` to indicate that watchers are not (or no longer) being used.
* `portable`: Boolean (JSON `true` / `false`) indicating if the DID is portable, allowing a DID Controller to control if a DID can be moved, while retaining its [SCID](#term:scid) and verifiable history. See the [DID Portability](#did-portability) section of this specification for more details.
  + Setting `portable: true` is permitted **only** in the first entry. A later entry that sets `portable: true` **MUST** be rejected by resolvers, regardless of historical state.
  + Defaults to `false` if omitted in the first entry. Resolvers **SHOULD** warn if `portable` is omitted from the first entry.
  + Retains value if omitted in later entries.
  + Setting `portable: false` in any later entry permanently disables portability; later entries **MUST NOT** set it back to `true`.
  + Even when `portable: true`, the SCID segment of `state.id` (and of `parameters.scid` in the first entry) **MUST NOT** change for the life of the DID. Only host/path portions may change.
* `deactivated`: A JSON boolean that indicates whether the DID has been deactivated. A deactivated DID is no longer subject to updates but remains resolvable. See the [deactivate (revoke)](#deactivate-revoke) section of this specification for more details.
  + Defaults to `false` if not set in the first [DID log entry](#term:did-log-entry).
  + If set to `true`, the DID is considered deactivated and no further updates to the DID are permitted.
* `ttl`: An unsigned integer that indicates how long, in seconds, a resolver should cache the resolved `did:webvh` DID before refreshing. It provides guidance from the [DID Controller](#term:did-controller) on cache duration, with a range of 0 to 2[[RFC2181](#ref:RFC2181)][DIDDoc](#term:diddoc)[DIDDoc](#term:diddoc)[DIDDoc](#term:diddoc)[DID Log](#term:did-log)^31. The parameter is analogous to the `TTL` parameter used in DNS [[RFC2181](#ref:RFC2181)]. Caching a `did:webvh` can be valuable in places where the business rules require resolving a number of DID URLs for the same DID. For example, a client might want to call the resolver to get the current [DIDDoc](#term:diddoc), and then make repeated calls to get all of the previous versions of the [DIDDoc](#term:diddoc). By caching the [DIDDoc](#term:diddoc) state, the resolver would not have to retrieve and process the [DID Log](#term:did-log) on each call.
  + Defaults to `3600` (1 hour) if not set in the first [DID log entry](#term:did-log-entry).
  + If set to `0`, indicates that the DID should not be cached.

#### [§](#cryptographic-agility) Cryptographic Agility

The `did:webvh` DID method is designed to support cryptographic agility—the ability to adapt to evolving cryptographic algorithms and suites over time without breaking compatibility or requiring global coordination.

Cryptographic agility in `did:webvh` is achieved through the following mechanisms:

* **Self-describing cryptographic formats:** All cryptographically generated data (e.g., hashes and signatures) use formats that encode the algorithm used. Hashes use the [Multihash](#term:multihash) format, and signatures use the [Data Integrity](#term:data-integrity) Proofs. These formats allow verifiers to determine the algorithm from the data itself, enabling flexible and extensible support.
* **Specification versioning via the `method` parameter:** Each [DID Log Entry](#term:did-log-entry) may include a `method` parameter that specifies the version of the `did:webvh` specification being used for the current and subsequent [log entries](#term:log-entries). This parameter is required in the initial log entry and may be updated in later entries to adopt newer versions of the specification. This allows long-lived DIDs to transition to updated algorithm sets over time.
* **Version-specific algorithm policies:** Each version of the `did:webvh` specification defines the permitted cryptographic algorithms and suites for that version. This constrains what algorithms [DID Controllers](#term:did-controllers) may use and limits the verification requirements placed on resolvers. For example, the v1.0 specification permits only one hash algorithm and one [Data Integrity](#term:data-integrity) cryptosuite, while future versions may change or expand this set.
* **Response to cryptographic vulnerabilities:** If flaws are identified in a cryptographic algorithm permitted by a given version of the specification, a new version of the `did:webvh` specification will be released that removes or replaces the compromised algorithms. DID Controllers may then rotate to the newer version by updating the `method` parameter in a new log entry.

This design allows `did:webvh` to remain interoperable and verifiable across cryptographic eras while minimizing the burden on resolvers and preserving backward compatibility where safe to do so.

#### [§](#scid-generation-and-verification) SCID Generation and Verification

The [self-certifying identifier](#term:self-certifying-identifier) or `SCID` is a required [parameter](#term:parameter) in the
first [DID log entry](#term:did-log-entry) and is the hash of the DID’s inception event.

##### [§](#generate-scid) Generate SCID

To generate the [SCID](#term:scid) for a `did:webvh` DID, the DID Controller
**MUST** execute the following function:

`base58btc(multihash(JCS(preliminary log entry with placeholders), <hash algorithm>))`

Where:

1. The `preliminary log entry with placeholders` consists of the following
   pre-publication JSON object of what will become the first [log entry](#term:log-entry). The
   placeholder is the literal string “`{SCID}`”.

   * The `versionId` entry, which **MUST** be `{SCID}`.
   * The `versionTime` entry, which **MUST** be a string that is the current time in
     UTC [ISO8601](#term:iso8601) format, e.g., `"2024-04-05T07:32:58Z"`
   * The complete `parameters` for the initial [log entry](#term:log-entry) as defined by the
     [DID Controller](#term:did-controller), with the placeholder wherever the [SCID](#term:scid) will
     eventually be placed.
   * The `state` JSON object with the value being the initial [DIDDoc](#term:diddoc)
     with placeholders (the literal string “`{SCID}`”) wherever the [SCID](#term:scid) will eventually be placed in the [DIDDoc](#term:diddoc).
2. `JCS` is an implementation of the [JSON Canonicalization Scheme](#term:json-canonicalization-scheme)
   [[RFC8785](#ref:RFC8785)]. It outputs a canonicalized representation of its JSON
   input.
3. `multihash` is an implementation of the [multihash](#term:multihash) specification. Its
   output is a hash of the input using the associated `<hash algorithm>`,
   prefixed with a hash algorithm identifier and the hash size.
4. `<hash algorithm>` is the hash algorithm used by the [DID Controller](#term:did-controller).
   The hash algorithm **MUST** be one listed in the
   [parameters](#didwebvh-did-method-parameters) defined by the version of the
   `did:webvh` specification being used by the [DID Controller](#term:did-controller).
5. `base58btc` is an implementation of the [base58btc](#term:base58btc) function.
   Its output is the base58 encoded string of its input.

##### [§](#verify-scid) Verify SCID

To verify the [SCID](#term:scid) of a `did:webvh` DID being resolved, the resolver
**MUST** execute the following process:

1. Extract the first [DID log entry](#term:did-log-entry) and use it for the rest of the steps
   in this process.
2. Extract the `scid` property value from the [parameters](#term:parameters) in the [DID log entry](#term:did-log-entry).
3. Determine the hash algorithm used by the [DID Controller](#term:did-controller) from the [multihash](#term:multihash) `scid` value.
   * The hash algorithm **MUST** be one listed in the
     [parameters](#didwebvh-did-method-parameters) defined by the version of the
     `did:webvh` specification being used by the [DID Controller](#term:did-controller) based on the active
     `method` [parameters](#term:parameters) property.
4. Remove the [data integrity](#term:data-integrity) proof property from the [DID log entry](#term:did-log-entry).
5. Replace the `versionId` property value with the literal `"{SCID}"`.
6. Treat the resulting [log entry](#term:log-entry) as a string and do a text replacement of the `scid`
   value from Step 2 with the literal string `{SCID}`.
7. Use the result and the hash algorithm (from Step 3) as input to the function
   defined in the [Generate SCID](#generate-scid) section (above).
8. The output string **MUST** match the `scid` extracted
   in Step 2. If not, terminate the resolution process with an error.

#### [§](#entry-hash-generation-and-verification) Entry Hash Generation and Verification

The `entryHash` follows the version number and dash character `-` in the
`versionId` property in each DID log entry. Each `entryHash` is calculated
across its [log entry](#term:log-entry), excluding the [Data Integrity](#term:data-integrity) proof. The
`versionId` used in the input to the hash is a predecessor value to the current
[log entry](#term:log-entry), ensuring that the [entries](#term:entries) are cryptographically “chained”
together in a microledger. For the first [log entry](#term:log-entry), the predecessor
`versionId` is the SCID (itself a hash), while for all other entries it is the
`versionId` property from the previous log entry.

##### [§](#generate-entry-hash) Generate Entry Hash

To generate the required hash for a `did:webvh` [log entry](#term:log-entry), the [DID Controller](#term:did-controller)
**MUST** execute the process `base58btc(multihash(JCS(entry), <hash algorithm>))` given a
preliminary [log entry](#term:log-entry) as the string `entry`, where:

1. `JCS` is an implementation of the [JSON Canonicalization Scheme](#term:json-canonicalization-scheme)
   ([[RFC8785](#ref:RFC8785)]). Its output is a canonicalized representation of its
   input.
2. `multihash` is an implementation of the [multihash](#term:multihash) specification. Its
   output is a hash of the input using the associated `<hash algorithm>`,
   prefixed with a hash algorithm identifier and the hash size.
3. `<hash algorithm>` is the hash algorithm used by the [DID Controller](#term:did-controller).
   The hash algorithm **MUST** be one listed in the
   [parameters](#didwebvh-did-method-parameters) defined by the version of the
   `did:webvh` specification being used by the [DID Controller](#term:did-controller).
4. `base58btc` is an implementation of the [base58btc](#term:base58btc) function.
   Its output is the base58 encoded string of its input.

The following is an example of a preliminary [log entry](#term:log-entry) that is processed to
produce an [entry hash](#term:entry-hash). As this is a first entry in a [DID Log](#term:did-log), the input
`versionId` is the [SCID](#term:scid) of the DID.

```
{"versionId": "QmdmPkUdYzbr9txmx8gM2rsHPgr5L6m3gHjJGAf4vUFoGE", "versionTime": "2025-04-01T17:39:50Z", "parameters": {"witness": {"threshold": 2, "witnesses": [{"id": "did:key:z6Mkkc51mg2vpQzKWAbWQZupeGYhowaBjYkmvcKMTqteqHB4", "weight": 1}, {"id": "did:key:z6MkuDdJdKLCgwZuQuEi9xG6LVgJJ9Tebr74CXPYPSumqgJs", "weight": 1}, {"id": "did:key:z6MkoSWmQyp4fTk4ZQy4KUsss9dFX51XfEUzKKKj1J1JUsrF", "weight": 1}]}, "updateKeys": ["z6MkgzBDcBFV3sk4ypPE5YXMZHmS213A3HpYY2LmcVKV15jr"], "nextKeyHashes": ["QmZreDcjvWEpyRFznQeExWNCsvMLk5i59AcRJJuQC8UodJ"], "method": "did:webvh:0.5", "scid": "QmdmPkUdYzbr9txmx8gM2rsHPgr5L6m3gHjJGAf4vUFoGE"}, "state": {"@context": ["https://www.w3.org/ns/did/v1"], "id": "did:webvh:QmdmPkUdYzbr9txmx8gM2rsHPgr5L6m3gHjJGAf4vUFoGE:domain.example"}}
```

Resulting [entryHash](#term:entryhash): `QmQ6FJ4fk2xheSSQoEjVpTgx9AQPKhJgtR9hn1nr4EeCrZ`

##### [§](#verify-the-entry-hash) Verify The Entry Hash

To verify the `entryHash` for a given `did:webvh` [DID log entry](#term:did-log-entry), a DID
Resolver **MUST** execute the following process:

1. Extract the `versionId` in the [DID log entry](#term:did-log-entry), and
   remove from it the version number and dash prefix, leaving the log entry
   `entryHash` value.
2. Determine the hash algorithm used by the [DID Controller](#term:did-controller) from the [multihash](#term:multihash) `entryHash` value.
   * The hash algorithm **MUST** be one listed in the
     [parameters](#didwebvh-did-method-parameters) defined by the version of the
     `did:webvh` specification being used by the [DID Controller](#term:did-controller) based on the
     `method` [parameters](#term:parameters) property set in the current or most recent prior [log entry](#term:log-entry).
3. Remove the [Data Integrity](#term:data-integrity) `proof` from the [log entry](#term:log-entry).
4. Set the `versionId` in the entry object to be the `versionId` from the
   previous [log entry](#term:log-entry). If this is the first entry in the log, set the value to
   `<scid>`, the value of the [SCID](#term:scid) of the DID.
5. Calculate the hash string as `base58btc(multihash(JCS(entry), <hash algorithm>))`, where:
   1. `entry` is the data from the previous step.
   2. `JCS` is an implementation of the [JSON Canonicalization Scheme](#term:json-canonicalization-scheme)
      ([[RFC8785](#ref:RFC8785)]). Its output is a canonicalized representation of its
      input.
   3. `multihash` is an implementation of the [multihash](#term:multihash) specification.
      Its output is a hash of the input using the associated `<hash algorithm>`,
      prefixed with a hash algorithm identifier and the hash size.
   4. `<hash algorithm>` is the hash algorithm from Step 2.
   5. `base58btc` is an implementation of the [base58btc](#term:base58btc) function.
      Its output is the base58 encoded string of its input.
6. Verify that the calculated value matches the extracted `entryHash` value from
   Step 1. If not, terminate the resolution process with an error.

#### [§](#authorized-keys) Authorized Keys

Each entry in the [DID Log](#term:did-log) **MUST** include a [Data Integrity](#term:data-integrity) `proof` where, at minimum:

1. `type` is `DataIntegrityProof`,
2. `cryptosuite` **MUST** be one listed in the
   [parameters](#didwebvh-did-method-parameters) defined by the version of the
   `did:webvh` specification being used by the [DID Controller](#term:did-controller) based on the active
   `method` [parameters](#term:parameters) property.
3. `proofPurpose` is `assertionMethod`,
4. `verificationMethod` resolves to a [multikey](#term:multikey) that appears verbatim in the **active** `updateKeys`.

Resolvers **MUST** reject an entry whose proof fails *any* check. A structurally-valid signature over a *different* cryptosuite than allowed by the active `method` parameter **MUST NOT** be accepted.

The authorized verification keys for `did:webvh` are the [multikey](#term:multikey)-formatted
public keys in the **active** `updateKeys` list from the `parameters` property of
the [log entries](#term:log-entries). Any of the authorized verification keys may be referenced
in the [Data Integrity](#term:data-integrity) proof.

For the first [log entry](#term:log-entry) the **active** `updateKeys` list is the one in
that first [log entry](#term:log-entry).

A resolver of the DID **MUST** verify the signature and the key used for signing
each [DID Log](#term:did-log) entry **MUST** be one from the list of active
`updateKeys`. If not, terminate the resolution process with an error.

The `did:webvh` Implementation Guide contains further discussion on the management
of keys authorized to update the DID.

The **active** `updateKeys` for subsequent [entries](#term:entries) depends on whether [Pre-Rotation](#term:pre-rotation) is active or not.

##### [§](#no-key-prerotation) No Key Prerotation

For all subsequent [entries](#term:entries), the **active** list
is the most recent `updateKeys` **before** the [log entry](#term:log-entry) to be verified. Thus,
the general case is that each [log entry](#term:log-entry) is signed by the keys from the
**previous** [log entry](#term:log-entry). Once a [log entry](#term:log-entry) containing an `updateKeys` list is
published, that `updateKeys` becomes the active list, and previous
`updateKeys` are ignored.

##### [§](#pre-rotation) Pre-rotation

For all subsequent [entries](#term:entries), the **active** list
is the `updateKeys` from the **current** [log entry](#term:log-entry) to be verified. Thus,
the general case is that each [log entry](#term:log-entry) is signed by the keys from the
**current** [log entry](#term:log-entry).

#### [§](#did-portability) DID Portability

As noted in the [Update (rotate)](#update-rotate) section of the specification,
a `did:webvh` DID can be renamed by changing the `id` DID string in the
DIDDoc to one that resolves to a different HTTPS URL if the following conditions are met.

* The [DID Log](#term:did-log) of the renamed DID **MUST** contain all of the [log entries](#term:log-entries)
  from the creation of the DID.
* The [log entry](#term:log-entry) in which the DID is renamed **MUST** be a valid DID entry
  building on the prior [DID log entries](#term:did-log-entries), per this specification.
* The [parameter](#term:parameter) `portable` **MUST** be set to `true` in the **first** [log entry](#term:log-entry). An entry that introduces `portable: true` after the first entry **MUST** be rejected.
* The [SCID](#term:scid) **MUST** be the same in the original and renamed DID. Specifically, the SCID segment of `state.id` in **every** [log entry](#term:log-entry) (including the renamed entry and all subsequent entries) **MUST** equal the `parameters.scid` from the first entry. Only the host/path portion of `state.id` may change under portability; the SCID segment is immutable for the life of the DID. A “portable rename” entry whose `state.id` carries a different SCID **MUST** be rejected.
* The [DIDDoc](#term:diddoc) **MUST** contain the prior DID string as an `alsoKnownAs` entry.
* [DID Controllers](#term:did-controllers) **SHOULD** account for any DNS requirements in making domain changes that impact a `did:webvh` DID being moved, such as those outlined in [[RFC1034](#ref:RFC1034)] (“Domain Names - Concepts and Facilities”), and [[RFC1035](#ref:RFC1035)] (“Domain Names Implementation and Specification”).

**Security Note — Misleading Prior Domain Association**

When using portability, a `did:webvh` identifier may include a domain component that was never actually used to host its DID Log before being “moved” to a domain under the [DID Controller](#term:did-controller)’s control. This creates a potential for misleading claims of association with the original domain. Resolvers and clients of resolvers **MUST** ignore any prior domain components when evaluating the history or trustworthiness of a `did:webvh` DID; only the current hosting location and its associated verifiable history are relevant. In addition, the [whois](#did-url-whois-linkedvp-service) DID URL capability can be used to obtain attestations about the DID and [DID Controller](#term:did-controller) from relevant authorities.

#### [§](#pre-rotation-key-hash-generation-and-verification) Pre-Rotation Key Hash Generation and Verification

Pre-rotation requires a [DID Controller](#term:did-controller) to commit to the authorization
keys that will be used (“rotated to”) in the next [log entry](#term:log-entry) for updating the [DIDDoc](#term:diddoc). The purpose
of committing to future keys is that if the currently authorized keys are
compromised by an attacker, the attacker should not be able to take control of
the DID by using the compromised keys to rotate to new keys the attacker
controls. Assuming the attacker has not also compromised the committed key
pairs, they cannot rotate the authorization keys without detection. See the
non-normative section about [Using Pre-Rotation Keys](https://didwebvh.info/latest/implementers-guide/prerotation-keys/)
in the `did:webvh` Implementer’s Guide for additional guidance.

As described in the [parameters](#didwebvh-did-method-parameters) section of
this specification, a [DID Controller](#term:did-controller) **MAY** include the [parameter](#term:parameter)
`nextKeyHashes` with a non-empty list in any [DID log entry](#term:did-log-entry) to activate
the [pre-rotation](#term:pre-rotation) feature. When [pre-rotation](#term:pre-rotation) is active, all
[multikey](#term:multikey) representations of the public keys in the `updateKeys` [parameters](#term:parameters) property in other than the initial version of the [DID log entry](#term:did-log-entry) **MUST** have their hash in the `nextKeyHashes` array from the previous
[DID log entry](#term:did-log-entry). If not, terminate the resolution process with an error.

A [DID Controller](#term:did-controller) may turn off the use of pre-rotation by setting the
[parameter](#term:parameter) `nextKeyHashes` to `[]` (empty array) in any [DID log entry](#term:did-log-entry). If
there is an active set of `nextKeyHashes` at the time, the pre-rotation
requirements remain in effect for the [DID Log entry](#term:did-log-entry). The subsequent
[DID Log entry](#term:did-log-entry) **MUST** use the non-pre-rotation rules.

To create a hash to be included in the `nextKeyHashes` array, the [DID Controller](#term:did-controller) **MUST** execute the following process for each possible future
authorization key.

1. Generate a new key pair. The key type **MUST** be one that can be used as a
   `did:webvh` authorization key.
2. Generate a [multikey](#term:multikey) representation of the public key of the new key
   pair.
3. Calculate the hash string as `base58btc(multihash(multikey))`, where:
   1. `multikey` is the [multikey](#term:multikey) representation of the public key from Step 2.
   2. `multihash` is an implementation of the [multihash](#term:multihash) specification.
      Its output is a hash of the input using the associated `<hash algorithm>`,
      prefixed with a hash algorithm identifier and the hash size.
   3. `<hash algorithm>` is the hash algorithm used by the [DID Controller](#term:did-controller).
      The hash algorithm **MUST** be one listed in the
      [parameters](#didwebvh-did-method-parameters) defined by the version of the
      `did:webvh` specification being used by the [DID Controller](#term:did-controller).
   4. `base58btc` is an implementation of the [base58btc](#term:base58btc) function.
      Its output is the base58 encoded string of its input.
4. Insert the calculated hash into the `nextKeyHashes` array being built up within
   the [parameters](#term:parameters) property.
5. The generated key pair **SHOULD** be safely stored so that it can be used in
   the next [log entry](#term:log-entry) to become a DID authorization key. At that time, the
   [multikey](#term:multikey) representation of the public key will be inserted into the
   `updateKeys` property in the [parameters](#term:parameters) and the private key can be used to sign the [log entry](#term:log-entry)'s DID update authorizations
   proofs.

A [DID Controller](#term:did-controller) **MAY** include extra entries (for keys or just random
strings) in a `nextKeyHashes` array.

After rotating from a pre‑rotation public key, the corresponding private key
**SHOULD** be treated as **spent** and **securely destroyed**. Reusing a
revealed pre‑rotation key is strongly discouraged because it weakens the
intended containment and forward‑security properties of pre‑rotation.

When processing other than the first [DID log entry](#term:did-log-entry) where
[pre-rotation](#term:pre-rotation) feature is active, a `did:webvh` resolver **MUST**:

1. For each [multikey](#term:multikey) in the `updateKeys` property in the `parameters` of
   the [log entry](#term:log-entry), calculate the hash and hash algorithm for the [multihash](#term:multihash)
   [multikey](#term:multikey).
2. The hash algorithm **MUST** be one listed in the
   [parameters](#didwebvh-did-method-parameters) defined by the version of the
   `did:webvh` specification being used by the [DID Controller](#term:did-controller).
3. The resultant hash **MUST** be in the `nextKeyHashes` array from the previous [log entry](#term:log-entry) prior to
   being processed. If not, terminate the resolution
   process with an error.
4. A new `nextKeyHashes` list **MUST** be in the `parameters` of the [log entry](#term:log-entry)
   currently being processed. If not, terminate the resolution process with an error.

#### [§](#did-witnesses) DID Witnesses

The [witness](#term:witness) process for a `did:webvh` DID provides a way for
collaborators to work with the [DID Controller](#term:did-controller) to “witness” the
publication of new versions of the DID. This specification defines the technical
mechanism for using [witnesses](#term:witnesses). Governance and policy questions about
when and how to use the technical mechanism are outside the scope of this
specification.

Witnesses can prevent a [DID Controller](#term:did-controller) from updating/removing
versions of a DID without detection by the witnesses. [Witnesses](#term:witnesses) are
also a further mitigation against malicious actors compromising both a [DID Controller](#term:did-controller)'s authorization key(s) to update the DID, and the [DID Controller](#term:did-controller)'s web site where the [DID log](#term:did-log) is published. With both
compromises, a malicious actor might be able to take control over the DID by rewriting the
[DID Log](#term:did-log) using the keys they have compromised. By adding [witnesses](#term:witnesses) to monitor and approve each version update, a malicious actor cannot
rewrite the previous history without having compromised a sufficient number of
[witnesses](#term:witnesses), the [DID Controller](#term:did-controller)'s key(s), and the Web Server on
which the [DID Log](#term:did-log) is published.

##### [§](#witness-lists) Witness Lists

The list of DIDs that witness DID updates is defined in the `witness`
parameter, as described in the [Parameters](#didwebvh-did-method-parameters)
section of this specification. After the first `witness` parameter has been set
to other than `{}` (empty object) in a [DID log entry](#term:did-log-entry), and while there
are active witnesses, a [threshold](#term:threshold) of the active witnesses must provide
valid proofs associated with each [DID log entry](#term:did-log-entry) before the [DID log entry](#term:did-log-entry) can be published. If a [DID log entry](#term:did-log-entry) contains a new
(replacement) list of witnesses (by including a new `witness` [parameter](#term:parameter)) that new list becomes active **AFTER** the new [DID log entry](#term:did-log-entry) has been published. Such a replacement **MAY** be a `{}` (empty object).
Once the `witness` attribute set to `{}` becomes active, updates to the DID are
not [witnessed](#term:witnessed).

##### [§](#witness-dids-and-reputation) Witness DIDs and Reputation

Since `did:webvh` witness DIDs must be `did:key` DIDs, there is not an
explicitly published identifier for each witness. If there is a need in an ecosystem
to identify who the witnesses are, a mechanism should be defined by the
governance of the ecosystem, such as the entry of the DID in a trust registry.
Such mechanisms are outside the scope of this specification.

When a [did:key](#term:did:key) DID is used in any `did:webvh` context — as a witness `id`, as a `verificationMethod` controller, or as an `assertionMethod` reference in a [Data Integrity](#term:data-integrity) proof — the [did:key](#term:did:key) specification **MUST** be followed. Notably, the multibase value in the method-specific identifier (the **body** of the DID) **MUST** equal the multibase value in any fragment identifier (if present) that references the lone verification method within the DID. For `did:key:z6MkABC...#z6MkABC...`, body and fragment **MUST** be byte-for-byte equal. Verifiers **MUST** reject any reference where they differ, because the body authoritatively defines the public key while the fragment is the Verification Method id; permitting divergence would let an attacker claim a proof was made by `did:key:A` while actually signing with `did:key:B`.

##### [§](#the-witness-parameter) The `witness` Parameter

The `witness` element in a [parameters](#term:parameters) object of a [DID Log entry](#term:did-log-entry)
has the following data structure:

```
"witness" : {
  "threshold": n,
  "witnesses" : [
      {
         "id": "<did:key DID of witness>"
      }
   ]
}
```

where:

* `threshold`: a positive integer (JSON number, no fractional part, value ≥ 1) that **MUST** be attained or surpassed by the count of **distinct** verified [witness](#term:witness) approvals for a [DID log entry](#term:did-log-entry) to be considered approved. The `threshold` **MUST** be between 1 and the number of **distinct** `witnesses[].id` values, inclusive. A `witness` parameter where `threshold` is missing, non-integer, < 1, or > count(distinct ids) **MUST** be rejected; resolvers **MUST NOT** silently coerce a malformed `witness` to “no witnesses” — they **MUST** terminate resolution with an error.
* `witnesses`: the array of [witnesses](#term:witnesses) that **MUST** be non-empty, with each entry including the field:
  + `id`: (required) the DID of the witness. The DID **MUST** be a `did:key` DID and **MUST** be unique within the array (compared byte-for-byte after Unicode NFC normalisation). Each `id` contributes at most one approval to threshold counting, regardless of how many proofs are attributed to it.
  + The `did:key` used as a witness `id` **MUST** decode to a public key compatible with one of the cryptosuites listed in the
    [parameters](#didwebvh-did-method-parameters) defined by the version of the
    `did:webvh` specification being used by the [DID Controller](#term:did-controller) based on the active
    `method` [parameters](#term:parameters) property. A witness `id` whose body decodes to a key of any other type **MUST** be rejected at parameter-validation time — not at signature-verification time — so an invalid witness configuration cannot ever take effect.

##### [§](#witness-threshold-algorithm) Witness Threshold Algorithm

The use of the [threshold](#term:threshold) versus needing approvals from all [witnesses](#term:witnesses) is to prevent faulty [witnesses](#term:witnesses) from blocking the publishing
of a new version of the DID. To determine if the [threshold](#term:threshold) has been
met, participants **MUST**:

1. Verify each [Data Integrity](#term:data-integrity) proof in `did-witness.json` for the relevant `versionId` independently.
2. Attribute each verified proof to a witness `id` from the **active** `witnesses` list. Proofs that cannot be attributed (the proof’s key does not belong to any listed witness) **MUST** be discarded.
3. Form the set of **distinct** attributed `id` values. The threshold check applies to the size of this set, not to the raw proof count.
4. If `|set| ≥ threshold`, the update is “[witnessed](#term:witnessed)”; otherwise resolution **MUST** terminate with an error.

The client of a DID Resolver can evaluate the witnesses according to
the governance of the ecosystem. Such an evaluation is outside the scope of this
specification.

##### [§](#the-witness-proofs-file) The Witness Proofs File

Proofs from [witnesses](#term:witnesses) are placed into a separate file
(`did-witness.json`) from the [DID Log](#term:did-log). The same [DID to HTTPS
Transformation](#the-did-to-https-transformation) used for the [DID Log](#term:did-log)
is used to locate the `did-witness.json` resource, with only the last element
changed (`did.jsonl` to `did-witness.json`). The media type of the file
**SHOULD** be `application/json`.

The data model for the `did-witness.json` file is:

```
[
  {
    "versionId": "1-Qmba111111...",
    "proof": [{ ... }, { ... }]
  },
  {
    "versionId": "2-Qzmb222222...",
    "proof": [{ ... }, { ... }]
  }
]
```

Where:

* `versionId` is the `versionId` of the [DID log entry](#term:did-log-entry) to which the
  [witness](#term:witness) proofs apply.
* `proof` is an array of [Data Integrity](#term:data-integrity) proofs that use the `versionId`
  as input data. The permitted [Data Integrity](#term:data-integrity) cryptosuite **MUST** be one listed in the
  [parameters](#didwebvh-did-method-parameters) defined by the version of the
  `did:webvh` specification being used by the [DID Controller](#term:did-controller) based on the active
  `method` [parameters](#term:parameters) property, and the `proofPurpose` set to `assertionMethod`.

Because a witness `id` is a `did:key` DID, the verification key is fully determined by decoding the `did:key` body — no DID resolution is required and no `verificationMethod` lookup is permitted. Resolvers verifying a witness proof **MUST**:

1. Parse the proof’s `verificationMethod` as `did:key:<multibase>#<multibase>` and recover the public key by decoding the body multibase per the [did:key](#term:did:key) specification.
2. Verify the signature using **only** that key. Resolvers **MUST NOT** dereference the witness DID for a key, **MUST NOT** consult any other key store, and **MUST NOT** accept a proof whose body multibase decodes to a key structurally invalid for the cryptosuites mandated by the active `method`.

A valid proof from a [witness](#term:witness) carries the implication that **ALL** prior
[DID Log entries](#term:did-log-entries) are also approved by that witness. To maintain a
manageable `did-witness.json` file size, the [DID Controller](#term:did-controller) **SHOULD**
remove all older proofs for **published** [DID Log entries](#term:did-log-entries), keeping only the
latest proof for each witness.

To eliminate the race condition in publishing the [DID Log](#term:did-log) and
`did-witness.json` files, when a new [DID Log entry](#term:did-log-entry) is being added,
[witness](#term:witness) proofs **MUST** be added to the `did-witness.json` file and
that file published **BEFORE** publishing the [DID Log](#term:did-log) file containing
the new [DID Log entry](#term:did-log-entry). As a result, `did:webvh` resolvers may find
proofs for unpublished [DID log entries](#term:did-log-entries) in the `did-witness.json` file.
Resolvers **MUST** ignore proofs with `versionId`s not in the [DID Log](#term:did-log)
file. Since resolvers cannot verify an unpublished [DID log entry](#term:did-log-entry), the
[witness](#term:witness) proofs on unpublished [DID log entries](#term:did-log-entries) do not carry the
implication of approval of prior [DID Log entries](#term:did-log-entries). Therefore, at times
there may be two proofs in the `did-witness.json` file for a [witness](#term:witness):

* The most recent proof for a published [DID Log entry](#term:did-log-entry).
* An additional proof that applies to an unpublished [DID Log entry](#term:did-log-entry).

To avoid unnecessary clutter in the `did-witness.json` file, array entries
without proofs (e.g., containing only the `versionId`) **SHOULD** be removed.

##### [§](#witnessing-a-did-version-update) Witnessing a DID Version Update

The following process is used to witness a DID version update:

* The [DID Controller](#term:did-controller) prepares the full [DID Log Entry](#term:did-log-entry) (including the
  `proof` element) for the new version of the DID, and shares it with the active [witnesses](#term:witnesses).
  + The specification leaves to implementers *how* the [log entry](#term:log-entry) data is provided to the [witnesses](#term:witnesses).
* Each [witness](#term:witness) **MUST** hold its own copy of the published [DID Log](#term:did-log) (`did.jsonl`) prior to witnessing, and **MUST** confirm that the controller-supplied candidate entry verifies as the next entry to that [DID Log](#term:did-log).
* Each [witness](#term:witness) **MUST** independently verify the candidate entry using every step in [Read (Resolve)](#read-resolve). Any failure **MUST** cause the witness to refuse approval.
* Each [witness](#term:witness) determines (based on the governance of the ecosystem)
  if they approve of the DID version update.
  + The meaning of “approve” for any given implementation is outside the scope of this specification.
* If the verification is successful and approval granted, the [witness](#term:witness)
  creates and sends to the [DID Controller](#term:did-controller) a [Data Integrity](#term:data-integrity)
  proof signed using the [witness](#term:witness)'s `did:key` DID.
  + The specification leaves to implementers how [witness](#term:witness) proofs are
    conveyed to the [DID Controller](#term:did-controller).
* The [DID Controller](#term:did-controller) **MUST** add the proof to the record for
  the applicable `versionId` for the unpublished [DID log entry](#term:did-log-entry)
  to the `did-witness.json` file.
  + The [DID Controller](#term:did-controller) **MAY** publish the updated `did-witness.json` file
    as new witness proofs are added to the file.
  + The [DID Controller](#term:did-controller) **MUST** publish the updated `did-witness.json` file
    **after** a [threshold](#term:threshold) of witness proofs have been received and **before** the
    witnessed [DID Log](#term:did-log) file is published.

##### [§](#verifying-witness-proofs-during-resolution) Verifying Witness Proofs During Resolution

A `did:webvh` resolver **MUST** verify that all [DID Log entries](#term:did-log-entries) that have active [witnesses](#term:witnesses) have a [threshold](#term:threshold) of approving witnesses. Resolvers **MUST**:

1. Complete all non-witness verifications of the [DID Log](#term:did-log) **before** processing any witness proof. Witness verification **MUST NOT** substitute for entry-hash or signature verification.
2. Retrieve the `did-witness.json`.
3. For each entry in `did-witness.json`, confirm its `versionId` matches a `versionId` present in **this** `did.jsonl` log. Non-matching entries, including those for future entries, **MUST** be discarded and **MUST NOT** be treated as evidence of witnessing for any other entry.
4. Verify enough proofs to meet the [threshold](#term:threshold) for all entries requiring witnessing.
5. For each entry requiring witnessing, confirm a threshold of verified, distinct-witness proofs whose `versionId` matches the current or any later published entry. Otherwise, terminate with an error.

For each witness proof, the resolver **MUST** extract `verificationMethod` and confirm that:

1. It is a valid, [did:key](#term:did:key) specification-compliant DID URL of the form `did:key:<multibase>#<multibase>` where body and fragment multibases are byte-equal (see [`did:key` body/fragment check](#witness-dids-and-reputation)).
2. No previously verified proof was found in the witnesses array for the same `versionId` and `id` (one count per witness per entry).

A proof failing either requirement **MUST** be discarded from threshold counting.

A [DID Controller](#term:did-controller) is expected to prune the `did-witness.json` file to include only the last proof for each witness for a published [DID log entry](#term:did-log-entry). However, if a [DID Controller](#term:did-controller) does not prune the file, a resolver **MAY** do the pruning as part of the resolution process, verifying only the minimum number of proofs needed to meet the [threshold](#term:threshold) for each [DID log entry](#term:did-log-entry). While it is expected that a [DID Controller](#term:did-controller) will exclude any proofs that fail verification, a resolver **MAY** ignore any proofs that fail verification and still resolve the DID if there are enough valid proofs to meet the [threshold](#term:threshold) requirements.

If you want to learn more about the practical application of witnesses, see the
Implementer’s Guide section on
[Witnesses](https://didwebvh.info/latest/implementers-guide/witnesses/) on the
`did:webvh` information site for more discussion on the witness capability and
using it in production scenarios.

#### [§](#did-watchers) DID Watchers

[Watchers](#term:watchers) are components found in some digital trust and DID ecosystems that monitor DIDs on behalf of clients for various purposes, such as:

* **Caching verified DIDs:** Storing verified DID documents to facilitate efficient resolution.
* **Ensuring persistence:** Maintaining access to DIDs even after removal by the [DID Controller](#term:did-controller). For example, the [Verifiable Data Gateway](https://github.com/LedgerDomain/did-webplus?tab=readme-ov-file#verifiable-data-gateway-vdg) in [did](https://github.com/LedgerDomain/did-webplus/blob/main/README.md)[:webplus](https://github.com/LedgerDomain/did-webplus/blob/main/README.md) could function as a [watcher](#term:watcher) for enduring DIDs.
* **Detecting inconsistencies:** Identifying malicious behavior by the [DID Controller](#term:did-controller), such as republishing altered [DID Logs](#term:did-logs). A network of [watchers](#term:watchers) can reach consensus independently of [witnesses](#term:witnesses).

Any party may set up a [watcher](#term:watcher) for `did:webvh` DIDs. However, a `did:webvh` DID Controller may opt to collaborate with specific [watchers](#term:watchers) by publishing their URIs in the [parameters](#term:parameters) of [DID log entries](#term:did-log-entries). It is outside the scope of this specification how a [DID controller](#term:did-controller) requests a [watcher](#term:watcher) monitor a DID or how a [watcher](#term:watcher) requests it be included in the [DID Log](#term:did-log) of a DID.

The governance of [watchers](#term:watchers) is out of scope for this specification, which defines only the technical mechanisms for notifying and querying [watcher](#term:watcher) services.

##### [§](#publishing-watcher-urls) Publishing Watcher URLs

did:webvh provides a mechanism for notifying resolvers (and their clients via [[DID-RESOLUTION](#ref:DID-RESOLUTION)] metadata) about configured [watchers](#term:watchers). The `watchers` [parameter](#term:parameter) lists URIs that identify the DID’s [watchers](#term:watchers).

[Watchers](#term:watchers) can be used by `did:webvh` resolvers and resolver clients. When resolving a `did:webvh` DID, `did:webvh` resolvers **MUST** provide the active list of [watchers](#term:watchers) in the DID metadata, as noted in the [read/resolve](#read-resolve) section of this specification.

Watcher URIs MAY use schemes other than HTTP(S), such as a DID ([[DID-CORE](#ref:DID-CORE)]), depending on the specific implementation or network requirements. However, this specification does not define how non-HTTP(S) [watcher](#term:watcher) URIs should be resolved or interacted with. If a [watcher](#term:watcher) uses an HTTP(S) URL, it **MUST** support the HTTP-based interaction model defined in the [Watcher Endpoints and Behavior](#watcher-endpoints-and-behavior) section.

If a `watchers` entry is included in a [DID log entry](#term:did-log-entry), it replaces the active set of [watchers](#term:watchers).

If a new [watcher](#term:watcher) is added after a DID has existed for some time, the [DID Controller](#term:did-controller) **SHOULD** notify the new [watcher](#term:watcher) about previously created [DID Resources](#term:did-resources).

[Watchers](#term:watchers) do not need to be listed in the [DID log](#term:did-log). [Watchers](#term:watchers) can operate independently of the [DID Controller](#term:did-controller) by polling for updates. [DID Controllers](#term:did-controllers) **MAY** send notifications to [watchers](#term:watchers) that the [DID Controller](#term:did-controller) is aware of but does not list in the [DID Log](#term:did-log).

##### [§](#watcher-endpoints-and-behavior) Watcher Endpoints and Behavior

A [watcher](#term:watcher) is a web server accessible via HTTP that **MUST** support the following capabilities:

* **Client Requests:**
  + Retrieve the [DID log](#term:did-log) file for a given [SCID](#term:scid).
  + Retrieve the witness file for a given [SCID](#term:scid).
  + Retrieve a resource for a given [SCID](#term:scid) and resource path.
* **Notifications (typically) from the [DID Controller](#term:did-controller):**
  + Notify the [watcher](#term:watcher) about a new log entry for a DID.
  + Notify the [watcher](#term:watcher) about a new or updated [DID resource](#term:did-resource).
  + Request removal of a given [SCID](#term:scid) from the [watcher](#term:watcher)'s cache.
  + Request removal of a given DID resource [SCID](#term:scid) from the [watcher](#term:watcher)'s cache.

##### [§](#watcher-http-api-operations) Watcher HTTP API Operations

The following HTTP API operations define the interaction between [watchers](#term:watchers) and other components. Included with the specification is the [did:webvh v1.0 Watcher OpenAPI YML Definition](https://raw.githubusercontent.com/decentralized-identity/didwebvh/refs/heads/main/watcherOpenAPI/watcher-v1.0.0.yml) that includes the request and response data models and status codes for each of the endpoints.

* **GET `<WATCHER URL>/log?scid=<SCID>`**: Returns the latest [DID Log](#term:did-log) for the given [SCID](#term:scid).
* **POST `<WATCHER URL>/log?did=<DID>`**: Notifies the [watcher](#term:watcher) of a log update, prompting retrieval of the latest [DID Log](#term:did-log) and [witness](#term:witness) file. This endpoint uses the `did` as the query parameter instead of the [SCID](#term:scid) to ensure that the [watcher](#term:watcher) is notified in the case of the DID moving to a new web location. The [watcher](#term:watcher) is expected to continue indexing the DID using its [SCID](#term:scid).
* **POST `<WATCHER URL>/log/delete?scid=<SCID>`**: Notifies the [watcher](#term:watcher) that the given `<SCID>` should be deleted from the [watcher](#term:watcher)'s cache. If removed, subsequent requests for that `<SCID>` from clients should return a `404 Not Found` status. The body of the request is a Data Integrity proof from the requester that may be used by the [Watcher](#term:watcher) to decide on the legitimacy of the request. The [Watcher](#term:watcher) will act (or not) on the request according to its governance, which is out of scope of this specification. For example, a [watcher](#term:watcher) might implement a workflow that must be completed to approve the deletion of a `<SCID>` from the [watcher](#term:watcher)'s cache. The endpoint could be used to carry out a “right to be forgotten” order, such as might be required under Europe’s [General Data Protection Regulation (GDPR)](https://gdpr-info.eu/).
* **GET `<WATCHER URL>/witness?scid=<SCID>`**: Returns the latest `witness.json` file for the given [SCID](#term:scid).
* **GET `<WATCHER URL>/resource?scid=<SCID>&path=<resourcePath>`**: Retrieves the requested resource.
* **POST `<WATCHER URL>/resource?scid=<SCID>&path=<resourcePath>`**: Notifies the [watcher](#term:watcher) of a new or updated resource.
* **POST `<WATCHER URL>/resource/delete?scid=<SCID>&path=<resourcePath>`**: Notifies the [watcher](#term:watcher) that the given `<resourcePath>` associated with the `<SCID>` should be deleted from the [watcher](#term:watcher)'s cache. If removed, subsequent requests for that `<SCID>` and `<resourcePath>` from clients should return a `404 Not Found` status. The body of the request is a Data Integrity proof from the requester that may be used by the [Watcher](#term:watcher) to decide on the legitimacy of the request. The [Watcher](#term:watcher) will act (or not) on the request according to its governance, which is out of scope of this specification. For example, a [watcher](#term:watcher) might implement a workflow that must be completed to approve the deletion of a `<SCID>` from the [watcher](#term:watcher)'s cache. The endpoint could be used to carry out a “right to be forgotten” order, such as might be required under Europe’s [General Data Protection Regulation (GDPR)](https://gdpr-info.eu/).

#### [§](#publishing-a-parallel-didweb-did) Publishing a Parallel `did:web` DID

Each time a `did:webvh` version is created, the [DID Controller](#term:did-controller) **MAY**
generate a corresponding `did:web` to publish along with the `did:webvh`. If
this is being done, the `did:webvh` DIDDoc **SHOULD** have the corresponding
`did:web` in the `alsoKnownAs` array. To publish a parallel `did:web` DIDDoc, the
[DID Controller](#term:did-controller) **MUST**:

1. Start with the resolved version of the [DIDDoc](#term:diddoc) from `did:webvh`.
2. If the “implicit” `did:webvh` services (as defined in the [DID URL
   Resolution](#did-url-resolution) section) are not already present in the
   [DIDDoc](#term:diddoc), they **MUST** be added. These services are the `relativeRef`
   service with `id: "#files"` or `id: "<did>#files"` and the `whois` service
   with `id: "#whois"` or `id: "<did>#whois"`, with the `serviceEndpoint` for
   both derived from the [DID-to-HTTPS
   transformation](#the-did-to-https-transformation).
3. Execute a text replacement across the [DIDDoc](#term:diddoc) of `did:webvh:<SCID>:` to
   `did:web:`, where `<scid>` is the actual `did:webvh` [SCID](#term:scid).
4. Add to the [DIDDoc](#term:diddoc) `alsoKnownAs` array, the full `did:webvh` DID. If
   the `alsoKnownAs` array does not exist in the [DIDDoc](#term:diddoc), it **MUST** be
   added.
5. Remove any duplicate entries in the `alsoKnownAs` array, including the
   `did:web` DID itself if it was duplicated in the earlier steps.
6. Publish the resulting [DIDDoc](#term:diddoc) as the file `did.json` at the web location
   determined by the specified `did:web` DID-to-HTTPS transformation.

The benefit of doing this is that resolvers that have not been updated to
support `did:webvh` can continue to resolve the [DID Controller](#term:did-controller)'s DIDs.
`did:web` resolvers that are aware of `did:webvh` features can use that knowledge,
and the existence of the `alsoKnownAs` `did:webvh` data in the [DIDDoc](#term:diddoc) to get the
verifiable history of the DID.

The risk of publishing the `did:web` in parallel with the `did:webvh` is that the
added security and convenience of using `did:webvh` are lost.

### [§](#did-url-resolution) DID URL Resolution

The `did:webvh` DID method embraces the expressive power of DID URLs while
preserving the semantic simplicity of a web-based resolution model. In
particular, `did:webvh` implementations **MUST** support path-based DID URL
resolution in a manner consistent with the [DID Core
specification](https://www.w3.org/TR/did-core/#did-url-path).

Specifically, a `did:webvh` resolver **MUST**:

* Resolve any `did:webvh` DID URL with a path component using an implicit
  `relativeRef` service as defined in [[DID-CORE](#ref:DID-CORE)]. The path is appended
  directly to the HTTPS URL obtained from the [DID-to-HTTPS
  transformation](#the-did-to-https-transformation), excluding any `.well-known`
  prefix.

  + For example, resolving
    `did:webvh:{SCID}:example.com/governance/issuers.json` retrieves the file
    located at `https://example.com/governance/issuers.json`.
  + This behavior can be overridden by defining an explicit service in the DID
    Document.
* Resolve the special path `/whois` using an implicit [[LINKED-VP](#ref:LINKED-VP)]
  service. This applies regardless of whether a `whois` service is explicitly
  defined in the [DIDDoc](#term:diddoc). The resolver **MUST** retrieve the Verifiable
  Presentation, if published by the [DID Controller](#term:did-controller), from the web
  location corresponding to the DID-to-HTTPS transformation (excluding
  `.well-known`), using the path `/whois.vp` and media type `application/vp` as
  registered in the [IANA Media Types
  Registry](https://www.iana.org/assignments/media-types/application/vp).

  + For example, resolving `did:webvh:{SCID}:example.com/whois` returns the
    content of `https://example.com/whois.vp` if available.

In both cases, a [DID Controller](#term:did-controller) **MAY** override the implicit
resolution behavior by defining explicit services in the DID Document, which
take precedence over the defaults.

The sections below formalize the structure and resolution rules for each default
service and describe how they may be overridden by the [DID Controller](#term:did-controller).

#### [§](#did-url-path-resolution) DID URL Path Resolution

The automatic resolution of `did:webvh` DID URL paths follows the
[[DID-CORE](#ref:DID-CORE)] `relativeRef` mechanism, enabling path-based access to web
resources directly tied to the DID’s domain. The approach is derived from
Examples 2 and 8 in [Section 3.2 of DID
Core](https://www.w3.org/TR/did-core/#did-url-syntax):

* A DID URL such as `did:example:123456/resume.pdf` (see Example 2)
  is semantically equivalent to:
  `did:example:123456?service=files&relativeRef=/resume.pdf` (see Example 8).
* The `service=files` reference resolves against a DID Document service with
  `"id": "#files"` or `"id": "<did>#files"` and a `type` of `relativeRef`.

The `did:webvh` method implicitly defines this service, with a `serviceEndpoint`
derived from the [DID-to-HTTPS
transformation](#the-did-to-https-transformation). The final path segment
(`did.jsonl`) is replaced by the DID URL path. If the resulting HTTPS URL
contains `.well-known/`, that segment **MUST** be removed before dereferencing
the resource.

For example, the following is the implicit service definition for the DID
`did:<scid>:webvh:example.com`:

```
{
  "id": "#files",
  "type": "relativeRef",
  "serviceEndpoint": "https://example.com/"
}
```

A [DID Controller](#term:did-controller) **MAY** explicitly define a service entry with `"id": "#files"` in the [DIDDoc](#term:diddoc). If present, this **MUST** override the
implicit service described above. `id` can be an absolute reference that
includes the DID with the `#files` fragment (`<did>#files`), or a relative
reference as above.

To resolve a DID URL of the form `<did:webvh DID>/path/to/file`, a did:webvh
resolver MUST:

1. Resolve the base did:webvh DID by retrieving, verifying, and processing its
   [DID Log](#term:did-log), as defined in this specification.
2. Locate the service entry with `id` `"#files"` or `"<did>#files"` in the
   resulting [DIDDoc](#term:diddoc), or fall back to the implicit service if none is
   defined.
3. Construct the URL by appending the DID URL path to the serviceEndpoint, and
   attempt to retrieve the resource from that location.

   * If the scheme of the serviceEndpoint is not supported by the resolver
     (e.g., non-HTTP(S) protocol), the resolver **MUST** return an `invalidDid`
     error.
   * If the resolution of the constructed URL fails with a “not found” condition
     (e.g., HTTP 404), the resolver **MUST** return the `notFound` error.

#### [§](#did-url-whois-linkedvp-service) DID URL whois LinkedVP Service

The `#whois` service enables recipients of a `did:webvh` DID to retrieve a
[Verifiable Presentation](#term:verifiable-presentation)—optionally published by the [DID Controller](#term:did-controller)—containing one or more embedded [Verifiable Credentials](#term:verifiable-credentials).
These credentials may help resolvers or relying parties make informed trust
decisions about the controller of the DID.

The intention is that resolving `<did:webvh DID>/whois` yields a [Verifiable Presentation](#term:verifiable-presentation) published by the [DID Controller](#term:did-controller) that includes
credentials with the DID as the `credentialSubject`. The contents of the
presentation are determined solely by the [DID Controller](#term:did-controller), who selects
which credentials to include. It is up to the resolver or relying party to
decide what assertions (and issuers) are relevant for establishing trust.

`did:webvh` DIDs **automatically** support a `/whois` service endpoint,
implicitly defined using the [[LINKED-VP](#ref:LINKED-VP)] service type. The
`serviceEndpoint` is computed using the standard [DID-to-HTTPS
transformation](#the-did-to-https-transformation), replacing `did.jsonl` with
`whois.vp`, and omitting any `.well-known/` prefix.

The default `#whois` service is:

```
{
  "@context": "https://identity.foundation/linked-vp/contexts/v1",
  "id": "#whois",
  "type": "LinkedVerifiablePresentation",
  "serviceEndpoint": "<did-to-https-translation>/whois.vp"
}
```

The file located at the `serviceEndpoint` **MUST** contain a [Verifiable Presentation](#term:verifiable-presentation) conforming to the [W3C VCDM](#term:w3c-vcdm). It **MUST** be signed by the
DID. `id` can be an absolute reference that includes the DID with the
`#whois` fragment (`<did>#whois`), or a relative reference as above.

The presentation **MUST** include at least one [Verifiable Credential](#term:verifiable-credential)
where the `credentialSubject.id` is the DID. Such [Verifiable Credentials](#term:verifiable-credentials) might serve to bind the DID to other identifiers associated with
the [DID Controller](#term:did-controller). Additional credentials in the presentation **MAY**
be associated with those other identifiers, rather than the DID itself. For
example, the presentation could include a credential linking the DID for a
business to that business’s registration ID, and a second credential (perhaps an
ISO certification) where the `credentialSubject.id` is the registration ID.

A [DID Controller](#term:did-controller) **MAY** explicitly define a `service` with `"id": "#whois"` in the [DIDDoc](#term:diddoc). If present, this entry **MUST** override the
implicit service defined above. This is required if the controller wishes to:

* Publish the WHOIS Verifiable Presentation in a different format (i.e., not
  [W3C VCDM](#term:w3c-vcdm))
* Serve the WHOIS presentation from a different location or using a non-default
  media type

To resolve the DID URL `<did:webvh DID>/whois`, a resolver MUST:

1. Resolve the base `did:webvh` DID by retrieving, verifying, and processing the
   [DID Log](#term:did-log). The resolver will use either an explicitly defined service
   with `"id": "#whois"` or `"id": "<did>#whois"`, or the implicit service defined above.
2. Construct and attempt to retrieve the resource from the `serviceEndpoint`
   URL.
   * If the scheme of the `serviceEndpoint` is unsupported by the resolver
     (e.g., non-HTTP(S)), the resolver **MUST** return the `invalidDid` error.
   * If the request to the service endpoint results in a “not found” condition
     (e.g., HTTP 404), the resolver **MUST** return the `notFound` error.

The returned `whois.vp` **MUST** contain a [W3C VCDM](#term:w3c-vcdm) [verifiable presentation](#term:verifiable-presentation) signed by the DID and containing [verifiable credentials](#term:verifiable-credentials)
that **MUST** have the DID as the `credentialSubject`.

If a [DID Controller](#term:did-controller) publishes a parallel `did:web` DID and a `whois.vp`
file, the `/whois` endpoint can be resolved using either DID, returning the same
content either way. The [verifiable presentation](#term:verifiable-presentation) proof can reference
either DID or include two proofs, each referencing a verification method for one
of the DIDs. If only one DID is referenced, since both DIDs will have an
`alsoKnownAs` for one another and include the same verification methods, a
resolver using the DID not referenced in the proof can choose to verify the
proof with the already resolved DID, or resolve the referenced DID before
verifying the proof.

A [DID Controller](#term:did-controller) **MAY** explicitly add to their [DIDDoc](#term:diddoc) a
`did:webvh` service with the `"id": "#whois"` or `"id": "<did>#whois"`. Such an
entry **MUST** override the implicit `service` above. If the [DID Controller](#term:did-controller) wants to publish the `whois` [verifiable presentation](#term:verifiable-presentation) in a
different format than the [W3C VCDM](#term:w3c-vcdm) format, they **MUST** explicitly add
to their [DIDDoc](#term:diddoc) a service with the `"id": "#whois"` or `"id": "<did>#whois"` to specify the name and implied format of the [verifiable presentation](#term:verifiable-presentation).

## [§](#security-considerations) Security Considerations

This section follows the guidelines in [[RFC3552](#ref:RFC3552)] and addresses the security requirements for all DID operations defined in the `did:webvh` method specification. It draws on the method-specific characteristics of `did:webvh` while aligning with the [[DID-CORE](#ref:DID-CORE)] requirements in [DID Core 7.3](https://www.w3.org/TR/did-core/#security-requirements).

### [§](#threats-and-attacks) Threats and Attacks

Implementations of `did:webvh` **MUST** mitigate the following classes of attack for all DID operations:

* **Eavesdropping** — All network communication (e.g., retrieval of `did.jsonl`, `witness.json` files, or other DID-associated resources) **SHOULD** be performed over TLS (HTTPS). Plaintext HTTP **MUST NOT** be used except for testing or non-production deployments where confidentiality is not required. This requirement is not unique to the `did:webvh` method; its application here is as with general web traffic. The verifiability of `did:webvh` ensures that tampering with the contents of individual log entries is detectable; TLS protects against passive observation and other network-based risks.
* **Replay attacks** — Implementations **MUST** verify the DID Log (including monotonic progression and referenced hashes) and reject logs that do not verify as outlined in the [Read](#read-resolve) section of this specification.
* **Message insertion, deletion, and modification** — Each DID Log entry and witness file is integrity-protected using cryptographic signatures. Implementations **MUST** verify the DID Log and reject any log that fails verification as outlined in the [Read](#read-resolve) section of this specification.
* **Truncation or withholding of log entries** — An attacker (or misconfigured intermediary) could serve an older-but-valid prefix of the DID Log, truncating newer entries and presenting a stale DID state.

  + **Mitigations (non-exhaustive):**
    - **Resolver cache-and-compare:** Resolvers **SHOULD** remember the latest `versionId` previously observed for a DID and **SHOULD** warn or fail resolution when presented with a truncated log.
    - **Witness verification:** Where DID Controllers utilize witnesses, resolvers **MUST** verify that all entries are properly witnessed according to the [Witness Verification](#did-witnesses) section of this specification. Notably, witness proofs of unpublished or truncated entries **MUST** be ignored.
    - **Multi-source resolution:** Resolvers **MAY** attempt retrieval from multiple [`did:webvh` Watchers](#did-watchers) and detect divergence in latest entries.
    - **End-to-end TLS:** While signatures detect per-entry tampering, use of TLS **SHOULD** be enforced to reduce opportunities for active truncation in transit.
* **Denial of Service (DoS) and amplification** — A malicious or compromised DID
  Log server could attempt to exhaust resolver resources by serving
  pathologically large log files, or by holding a connection open and streaming
  log entries indefinitely. This risk is most acute for resolvers that encounter
  previously-unseen DIDs on behalf of their clients — for example, a service
  that performs DID resolution in onboarding new users. In such cases an
  attacker need only find a service that will pass their DID through to a
  resolver on their behalf.

  + The one second `versionTime` monotonicity requirement provides a natural constraint on log length — a log file with implausibly rapid `versionTime` progression is likely malformed and resolvers are advised to reject it. However this does not fully prevent the attack, as a patient attacker can pace log entry generation to match valid `versionTime` increments.
  + Resolvers are advised to require a `Content-Length` header in HTTP responses before processing begins, allowing them to determine file size upfront and reject oversized logs before expending processing resources. The presence of HTTP range request support (`Accept-Ranges: bytes`) is a useful positive signal that a server is serving a static resource rather than dynamically generated content. Regardless of server behavior, since a declared `Content-Length` cannot itself be relied upon as a security guarantee, resolvers are advised to apply the following defensive practices:

    - Apply a maximum byte limit on log file retrieval, terminating the connection if exceeded regardless of declared `Content-Length`; treat absence of `Content-Length` as grounds for a more conservative limit or outright rejection
    - Apply a hard timeout on the entire fetch-and-process operation for a single resolution request
    - Apply rate limiting on resolution requests, particularly for previously-unseen DIDs
    - Apply concurrency limits to bound the number of simultaneous resolution operations
  + The subjective elements of these limits (e.g., what constitutes “excessively large” or “repeated”) are best established through community or ecosystem governance. These mitigations are standard HTTP service hardening practices and are not unique to `did:webvh`.
* **Man-in-the-middle (MitM)** — HTTPS and signature verification of DID Log entries and witness proofs protect against undetected modification of individual entries. Risks specific to withholding or truncation are addressed in **Truncation or withholding of log entries** above. Use of TLS further ensures server authenticity and reduces opportunities for active interference.
* **Conflicting parallel updates / split view** — Multiple authorized updates from the same parent entry can produce divergent logs. Publication components **MUST** enforce monotonic extension of the current tip; witnesses **MUST NOT** sign more than one child of the same parent; consolidation of `witness.json` **MUST** fail on conflicting branches. Resolvers **SHOULD** cache the highest observed version/hash and **SHOULD** detect/warn on older branches; Watchers **SHOULD** detect and report divergence across sources.
* **Other attacks** — The required `did:webvh` verification process mitigates downgrade attacks on cryptographic algorithms and prevents poisoning of log or witness files, since unauthorized changes fail signature verification. Verification does not, however, address availability risks; implementers **SHOULD** consider operational measures (e.g., [watchers](#did-watchers) and well-known web techniques) to improve resilience.
* **Misleading prior-domain association** — A DID may be ported from a domain it never actually used, creating a false impression of association with that domain. Mitigation: resolvers and clients **MUST** ignore prior domain components when evaluating the DID, as described in [Unique Assignment of DIDs](#unique-assignment-of-dids).

The use of DNSSEC [[RFC4033](#ref:RFC4033)], [[RFC4034](#ref:RFC4034)], [[RFC4035](#ref:RFC4035)] is essential to prevent spoofing and ensure authenticity of DNS records.

### [§](#residual-risks) Residual Risks

Residual risks include:

* Compromise of the web hosting infrastructure serving the DID resources.
  + While this can impact access to the DID Log and associated files, it does not compromise the integrity of the log entries themselves, nor the verifiability of the DID.
* Compromise of controller private keys.
  + A `did:webvh` [DID Controller](#term:did-controller) can mitigate this risk through the use of [pre-rotation keys](#pre-rotation-key-hash-generation-and-verification).
  + In doing so, [DID Controllers](#term:did-controllers) **SHOULD** avoid reusing revealed pre‑rotation keys. While not invalid per this specification, re‑use of a pre‑rotation key after disclosure reduces compromise containment. Mitigation: follow the one‑time‑use best practice and securely destroy revealed private keys (see [Pre‑rotation Key Hash Generation and Verification](#pre-rotation-key-hash-generation-and-verification)). Resolvers are **NOT REQUIRED** to enforce this, but **MAY** warn.
  + Additional good security practices **SHOULD** also be followed, such as using hardware security modules (HSMs) or secure enclaves for key storage, enforcing strong access controls, maintaining secure backups of critical keys, and performing regular key rotations.
* Weaknesses in underlying cryptographic algorithms after deployment.
* Misconfiguration of cache control or TTL values.
* Implementation errors in DID resolvers or controllers.
* Resolvers operating in contexts where they may encounter large numbers of previously-unseen DIDs — such as open verification services — face elevated resource exhaustion risk and are advised to implement rate limiting and monitoring for abusive resolution patterns, with the ability to block offending sources.

### [§](#integrity-protection-and-update-authentication) Integrity Protection and Update Authentication

All DID operations (create, update, deactivate) are integrity-protected by the cryptographic verification of DID Log entries. Update authentication is provided by verifying the [DID Controller](#term:did-controller)'s proof(s) against the valid `updateKeys` in the DID [Parameters](#term:parameters).

Because a `did:webvh` DID document and its associated log entries are self-certifying, they can be verified and trusted regardless of how they are retrieved — whether directly from the host, via a cache, through a CDN, from a [DID Watcher](#did-watchers), or via a trusted resolver service. The verification process ensures authenticity and integrity independent of the transport channel.

### [§](#authentication-characteristics) Authentication Characteristics

The authentication of DID updates is based on possession of the private keys associated with the update and pre-rotation keys. The security of the DID therefore depends on the strength of these keys, their secure storage, and the cryptographic algorithms used.

### [§](#unique-assignment-of-dids) Unique Assignment of DIDs

In `did:webvh`, uniqueness of a DID is based on the [self-certifying identifier](#term:self-certifying-identifier) (SCID) generated at the inception of the DID. The SCID is cryptographically bound to the DID Controller’s keys and ensures that no two independently created DIDs can have the same identifier.

The DNS portion of the DID is used solely for discovery of the DID Log and associated files; it is not used for verification of DID control. Further, the DNS name does not need to be owned or directly controlled by the DID Controller. For example, a DID can be published within a namespace provided by a hosting platform (e.g., a GitHub repository or pages site) that serves static files over HTTPS. In such cases, platform policies and HTTPS server authentication are relied upon for access and integrity at the transport layer, while DID verification is provided entirely by the SCID and verifiable history of the DID.

A `did:webvh` identifier may include a domain component that was never actually used to host its DID Log, before being moved — via the [did:webvh portability](#did-portability) capability — to a different domain under the [DID Controller](#term:did-controller)’s control. This creates a potential for misleading claims of association with the original domain. To prevent this, resolvers and clients of resolvers **MUST** ignore any prior domain components when evaluating the history or trustworthiness of a `did:webvh` DID; only the current hosting location and its associated verifiable history are relevant. In addition, the [whois](#did-url-whois-linkedvp-service) DID URL capability **SHOULD** be used to obtain attestations about the DID and [DID Controller](#term:did-controller) from relevant authorities.

### [§](#endpoint-authentication) Endpoint Authentication

DID resource retrieval endpoints **MUST** be authenticated using TLS server authentication. Self-signed certificates **SHOULD NOT** be used in production. This requirement is not unique to the `did:webvh` method; it applies to all web traffic. While the verifiability of `did:webvh` ensures that any tampering with the contents of individual log entries is detectable, TLS provides additional protection against active network attacks (including truncation or withholding) and ensures the authenticity of the server providing the DID resources.

### [§](#resolver-transport-hardening-ssrf-and-network-boundary) Resolver Transport Hardening (SSRF and Network Boundary)

A `did:webvh` resolver acts as an HTTP client on behalf of an untrusted DID string — a Server-Side Request Forgery vector without explicit safeguards. Resolvers **MUST**:

1. **No automatic redirects.** Do not auto-follow HTTP 3xx responses when fetching `did.jsonl` or `did-witness.json`. If redirect-following is an opt-in, re-apply every check below at each target.
2. **IP-literal rejection.** Reject IPv4/IPv6 literal hosts both (a) after percent-decoding the DID’s domain segment, and (b) after DNS resolution. Default deny: loopback (`127.0.0.0/8`, `::1`), private (`10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`, `fc00::/7`), link-local (`169.254.0.0/16`, `fe80::/10`). Dev opt-ins permitted but off by default.
3. **Case-insensitive percent-decoding.** Per [[RFC3986](#ref:RFC3986)] §2.1, normalise hex case **before** any allow/deny decision. Rejecting `%3A` but accepting `%3a` is non-compliant.
4. **Re-validate after decoding.** All host/path checks apply to decoded values. Percent-encoded IP literals and traversal sequences (`%2E%2E`, `%2e%2e`) **MUST** be rejected after decoding.
5. **Response size cap.** Enforce a max body size for both files; check `Content-Length` first; treat absence as grounds for a stricter cap or rejection. Suggested default: 5 MiB.
6. **Operation timeout.** Enforce a wall-clock timeout on the complete resolution. Suggested default: 30 s.
7. **HTTPS only.** Reject any non-`https` scheme, including after a redirect.
8. **No localhost in production.** Do not issue requests to `localhost`, `127.0.0.0/8`, `::1`, or names resolving to them. Test opt-ins off by default.

These are standard SSRF defences; stated normatively here because all four reviewed implementations were vulnerable to at least one of (1)–(4).

### [§](#network-topology) Network Topology

Unlike DLT-based DID methods, `did:webvh` relies on web infrastructure and does not require peer-to-peer networking. However, implementations relying on CDN caching or load balancers **MUST** ensure these intermediaries do not serve stale or tampered DID data.

### [§](#cryptographic-protection) Cryptographic Protection

The following data is protected:

* **DID Log entries** — Signed by the DID controller’s keys.
* **Witness proofs** — Signed by witness nodes’ keys.

These signatures provide integrity and update authentication but not confidentiality; DID Log entries are public.

Secret data (e.g., controller private keys, witness private keys, random seeds) **MUST** be protected in secure storage and never exposed in the DID Log.

### [§](#signature-implementation) Signature Implementation

`did:webvh` uses standard [Data Integrity](#term:data-integrity) proof mechanisms for signing DID Log entries and witness proofs, as defined in the cryptographic suite used. Implementations **MUST** follow the suite’s signature generation and verification requirements.

### [§](#international-domain-names) International Domain Names

`did:webvh` implementers **MAY** publish [DID Logs](#term:did-logs) on domains that use international domain names.
The [DID-to-HTTPS Transformation](#the-did-to-https-transformation) section of this specification
**MUST** be followed by [DID Controllers](#term:did-controllers) and DID resolvers to ensure the proper
handling of international domains.

### [§](#cross-origin-resource-sharing-cors-policy-considerations) Cross-Origin Resource Sharing (CORS) Policy Considerations

To support scenarios where DID resolution is performed by client applications running in a web browser, the file served for the [DID Log](#term:did-log) needs to be accessible by any origin. To enable this, the [DID Log](#term:did-log) HTTP response MUST include the following header:

`Access-Control-Allow-Origin: *`

### [§](#publishing-parallel-didweb) Publishing parallel `did:web`

`did:webvh` implementers that consider [publishing parallel `did:web` DID](#publishing-a-parallel-didweb-did) **SHOULD** evaluate
security impact from losing added security properties of `did:webvh`
and refer to [did:web Security and Privacy Considerations](https://w3c-ccg.github.io/did-method-web/#dns-considerations) for additional guidance.

### [§](#post-quantum-attacks) Post Quantum Attacks

The `did:webvh` [Key Pre-Rotation](#term:key-pre-rotation) approach provides enough flexibility for “post-quantum safety”.
For guidance on post-quantum attacks mitigation, implementers **SHOULD** refer to the [corresponding Implementation Guide section](https://didwebvh.info/latest/implementers-guide/prerotation-keys/#post-quantum-attacks).

### [§](#resolver-validation-checklist-informative) Resolver Validation Checklist (informative)

The following checklist maps normative resolver requirements to concrete
validation points, and is intended to assist conformance test suite authors and
implementers auditing their own resolver implementations. An entry appearing
here does not restate or replace the normative requirements defined in the
verification algorithm in this specification.

**Transport:** HTTPS only; no auto 3xx; reject IP literals before & after percent-decoding; reject private/loopback/link-local DNS resolutions in production; normalize percent-encoding case; validate path segments after decoding (`.`, `..`, `/`, `\`, NUL, leading/trailing whitespace); enforce max response size with `Content-Length` first; enforce a wall-clock timeout.

**Log structure:** unbroken `1, 2, 3, ...` version sequence; strictly increasing UTC ISO8601 `versionTime`; every `versionTime` ≤ now (bounded skew); `entryHash` chain verified for every entry; `method` is an explicitly supported value (never silently downgraded).

**SCID & identity:** first entry’s `parameters.scid` is the genesis self-hash; every entry’s `state.id` parses as a `did:webvh` DID; every entry’s `state.id` [SCID](#term:scid) equals first entry’s `parameters.scid` and [SCID](#term:scid) in the DID; requested DID matches at least one entry’s `state.id`; `portable: true` only in first entry; [SCID](#term:scid) never changes.

**Keys & proofs:** every proof has `type: DataIntegrityProof`, the `cryptosuite`
and `proofPurpose` required by the active `method`; `verificationMethod` key in
active `updateKeys`; under pre-rotation, `updateKeys` explicit in every entry
and every key hashes to a value in previous `nextKeyHashes`.

**Witnesses:** `threshold` is positive integer ≤ count of distinct `witnesses[].id`; all `witnesses[].id` distinct; threshold met by counting verified proofs from distinct witness identifiers, not total proof count; each accepted proof’s `versionId` corresponds to an entry in the `did.jsonl` being verified; proofs verified with key from the `did:key` body; `did:key` DID URL in proofs references the same key material in body and fragment (multibase values byte-equal).

**Failure modes:** unknown parameter values, malformed `witness`, hash algorithm mismatch, and cryptosuite mismatch all **MUST** fail resolution — never silently coerced.

## [§](#privacy-considerations) Privacy Considerations

This section addresses the privacy considerations in alignment with [[RFC6973](#ref:RFC6973)] Section 5 and the [[DID-CORE](#ref:DID-CORE)] requirements in [DID Core 7.4](https://www.w3.org/TR/did-core/#privacy-requirements).

### [§](#surveillance) Surveillance

The `did:webvh` method publishes DID logs to publicly accessible HTTPS endpoints. While the contents of the DID Log are generally intended to be public, the timing, frequency, and correlation of updates can be observed and may reveal operational patterns or associations.

Resolution of a `did:webvh` identifier also exposes the resolver’s network activity to DNS providers and web servers, which could be used for tracking. Controllers and resolvers **MAY** use privacy-enhancing technologies such as VPNs, TOR, or trusted universal resolver services, and **MAY** adopt emerging approaches such as [Oblivious DNS over HTTPS (ODoH)](https://datatracker.ietf.org/doc/html/draft-pauly-dprive-oblivious-doh-03) to reduce this risk.

### [§](#stored-data-compromise) Stored Data Compromise

DID data is stored on web servers. A compromise of the hosting infrastructure could allow tampering with DID resources. HTTPS and cryptographic signatures protect integrity, but confidentiality is not provided.

### [§](#implementation-hygiene-informative) Implementation Hygiene (informative)

The following practices are not unique to `did:webvh` but represent recurring
failure points observed across `did:webvh` DID Method implementations.
Implementers should treat these as baseline hygiene.

* **Dependency currency.** Keep cryptographic and HTTP dependencies on supported, patched versions. Run a vulnerability scanner (`cargo audit`, `pip-audit`, `npm audit`, OWASP Dependency-Check) on every build.
* **Filesystem permissions.** Private keys and secret-bearing configuration files **SHOULD** be created with owner-only permissions (e.g., `0600` on POSIX). **SHOULD NOT** read secret material from the current working directory or other untrusted locations by default.
* **CLI tools.** **MUST NOT** print private keys, mnemonics, or other long-lived secrets to stdout/stderr or shell history. Where display is necessary, prompt before printing and offer a file-output alternative with restrictive permissions.
* **HTTPS certificate validation.** **MUST NOT** disable certificate validation by default. Certificate pinning is not required (and incompatible with platform hosting), but ecosystems with appropriate trust models **MAY** opt in.
* **Error messages.** Resolvers **SHOULD NOT** include internal stack traces, file paths, or library versions in `problemDetails` returned to clients.

### [§](#unsolicited-traffic) Unsolicited Traffic

Publishing a DID Log does not inherently solicit inbound traffic beyond normal DID resolution. However, public exposure of service endpoints in the DID Document may increase unsolicited interactions. [DID Controllers](#term:did-controllers) SHOULD avoid publishing unnecessary endpoints.

### [§](#misattribution) Misattribution

Because the DNS portion of the DID is used for discovery, a misattribution risk arises if that DNS name is reassigned without the associated DID resources being updated or removed. Controllers **SHOULD** ensure DID deactivation before relinquishing a DNS name or namespace.

Where possible, Controllers **SHOULD** use the [DID Portability](#did-portability) mechanism defined in this specification to move the DID to a new location under their control. When portability is used, an HTTP redirect from the old location to the new one is the preferred approach, even in cases where DID ownership is transferred, as it enables seamless resolution while preserving the DID’s verifiable history.

### [§](#correlation) Correlation

The use of a static DID and public DID Log entries can enable correlation of activities over time. Controllers SHOULD avoid embedding personal identifiers or unnecessary service endpoints in DID documents.

### [§](#identification) Identification

DIDs are public identifiers and can be linked to real-world identities through their domain ownership. Entities that require anonymity SHOULD consider DID methods designed for pseudonymity.

### [§](#right-to-erasure-gdpr-art-17) Right to Erasure ([GDPR Art. 17](https://gdpr-info.eu/art-17-gdpr/))

While it’s possible for a [DID Controller](#term:did-controller) to delete published data as described in [Deactivate (Revoke) operation](#deactivate-revoke),
it’s **RECOMMENDED** for monitoring [watchers](#term:watchers) to cache last known state indefinitely.
This means that the ability and specific process of complete data erasure depends on [watchers](#term:watchers)’ behavior
and **SHOULD** be defined by ecosystem governance.

### [§](#secondary-use) Secondary Use

Information published in the DID Log may be repurposed by third parties. Controllers SHOULD minimize the publication of data that could be used for purposes beyond the intended use.

### [§](#disclosure) Disclosure

All data in the DID Log is publicly accessible. Sensitive data MUST NOT be included.

### [§](#exclusion) Exclusion

`did:webvh` uses DNS for discovery, and while the DID Controller may control the web server on which a `did:webvh` DID is published, the DID Method does **not** require controller ownership of a DNS domain. Controllers **MAY** publish the DID Log and associated resources under a namespace they control on a web‑hosting platform that serves static files over HTTPS (for example, a GitHub repository or pages space). This reduces barriers to participation.

Residual exclusion risks remain: access to such platforms typically requires an account and compliance with provider terms of service; platforms might impose geoblocking, payment requirements, or content restrictions; and accounts can be suspended. Controllers **SHOULD** maintain the ability to republish or mirror DID resources under alternative hosts (including using `did:webvh` [Watchers](#did-watchers)) and **SHOULD** document a transition plan so that participants are not locked out if a hosting provider becomes unavailable. The verifiable history of the DID ensures that the DID can be verified regardless of the source of the [DID Log](#term:did-log) and related files.

### [§](#no-phone-home-mitigations) No Phone Home Mitigations

A privacy concern in decentralized identity ecosystems is the possibility of an issuer of identity information (such as Verifiable Credentials) being notified when and where individuals present those credentials. This “phone home” surveillance problem (such as described by [nophonehome.com](https://nophonehome.com)) can occur if the presentation of a credential requires contacting the issuer’s infrastructure, either directly or indirectly, in a way that can be linked to the credential holder. As `did:webvh` issuer DIDs may be self-hosted, this is particularly relevant.

While this concern is generally associated with the use of verifiable credentials rather than about the resolution of DIDs, a `did:webvh` server operated by an issuer might host related resources that are retrieved at credential presentation time — for example, revocation registries or status lists. If these resources are implemented in a way that enables linking access patterns to individual credential holders, the [DID Controller](#term:did-controller) could use that information for surveillance.

Privacy-respecting credential issuers, credential holders, and verifiers all have a role in preventing “phone home” surveillance. The following practices can help:

* **Privacy-respecting Issuers (including DID Controllers hosting VC-related resources)**

  + **SHOULD NOT** design or deploy credential-related resources (such as revocation registries) in a way that enables the identification of individual holders at presentation time.
  + Use privacy-preserving designs — such as compact status lists, batching, and/or large revocation registries that provide “lost in a crowd” anonymity — to prevent correlation of access patterns to specific credential holders.
  + Use HTTP caching headers (e.g., `Cache-Control`, `ETag`) to enable CDNs, browsers, and resolvers to cache DID resources efficiently, reducing repeated origin requests that could enable tracking and improving performance.
* **Holders**

  + Use privacy-preserving techniques such as using [DID Watchers](#did-watchers), trusted intermediaries, or privacy-enhancing network tools (e.g., TOR, VPN) to retrieve revocation status data without revealing the holder’s location or identity to the issuer.
  + Separate in time interactions with the issuer (e.g., retrieving revocation status) from credential presentations to verifiers, and structure retrievals to avoid creating identifiable access patterns that could enable correlation or surveillance.
* **Verifiers**

  + Be flexible in the timeliness of credential status checks, and consider omitting them entirely when risk is low, reducing or eliminating the need for the retrieval of status data.
  + Separate the retrieval of status or issuer data from the verification process by caching issuer-provided information where possible, so holders are not required to contact the issuer in real time.
  + Use privacy-enhancing network tools (e.g., TOR, VPN) or trusted intermediary resolvers to retrieve DID resources in a way that avoids revealing verifier identity or network location to the issuer or hosting provider.
  + Where possible, support privacy-preserving resolution protocols or intermediaries offered by the hosting party.

A related risk is that an issuer may deliberately or inadvertently create **holder-specific identifiers** for data elements that are expected to be common across all holders — for example, by issuing personalized revocation list URLs or unique resource paths. This enables tracking of specific holders even if the underlying credential is otherwise privacy-preserving. Preventing this requires shared responsibility: issuers **MUST NOT** generate such holder-specific identifiers; holders and verifiers **SHOULD** reject credentials or status mechanisms that contain them; and independent third parties, including [DID Watchers](#did-watchers), **SHOULD** monitor issuer implementations to detect and report violations of this principle.

## [§](#definitions) Definitions

base58btc
:   Applies [[DRAFT-MSPORNY-BASE58-03](#ref:DRAFT-MSPORNY-BASE58-03)] to convert
    data to a `base58` encoding. Used in `did:webvh` for encoding hashes for [SCIDs](#term:scids) and [entry hashes](#term:entry-hashes).

Data Integrity
:   [W3C Data
    Integrity](https://www.w3.org/community/reports/credentials/CG-FINAL-data-integrity-20220722/)
    is a specification of mechanisms for ensuring the authenticity and integrity of
    structured digital documents using cryptography, such as digital signatures and
    other digital mathematical proofs.

Decentralized Identifier
:   Decentralized Identifiers (DIDs) [[DID-CORE](#ref:DID-CORE)] are a type of identifier that enable
    verifiable, decentralized digital identities. A DID refers to any subject (e.g.,
    a person, organization, thing, data model, abstract entity, etc.) as determined
    by the controller of the DID.

DID Controller
:   The entity that controls (creates, updates, deletes) a given DID, as defined
    in the [[DID-CORE](#ref:DID-CORE)].

DIDDoc
:   A DID Document as defined by the [[DID-CORE](#ref:DID-CORE)] – the document returned when a DID is resolved.

DID Log
:   A DID Log is a list of [Entries](#term:entries), with an entry added for each update of the DID,
    including new versions of the [DIDDoc](#term:diddoc) or changed information necessary to generate or validate the DID.

DID Log Entry
:   A DID Log Entry is a JSON object that defines the authorized
    transformation of a [DIDDoc](#term:diddoc) from one version to the next. The initial entry
    establishes the DID and version 1 of the [DIDDoc](#term:diddoc). All entries are stored
    in the [DID Log](#term:did-log).

DID Method
:   DID methods are the mechanism by which a particular type of DID and its
    associated DID document are created, resolved, updated, and deactivated. DID
    methods are defined using separate DID method specifications. This document is
    the DID Method Specification for `did:webvh`.

DID Portability
:   `did:webvh` portability is the capability to change the DID string for the
    DID while retaining the [SCID](#term:scid) and the history of the DID. This is useful
    when forced to change (such as when an organization is acquired by another,
    resulting in a change of domain names) and when changing DID hosting service
    providers.

DID Resources
:   A DID Resource is an object (often a file) that is referenced by a DID URL, with a path to the resource. The DID URL allows resolvers to locate and retrieve specific content associated with a DID. Examples include configuration files, schemas, credential definitions, or other structured data linked to the DID.

did:web
:   `did:web` as described in the [W3C specification](https://w3c-ccg.github.io/did-method-web/)
    is a DID method that leverages the Domain Name System (DNS) to perform the DID operations.
    It is valued for its simplicity and ease of deployment compared to [DID methods](#term:did-methods) that are
    based on distributed ledgers or blockchain technology, but also comes with increased
    challenges related to trust, security and verifiability. `did:web` provides a starting point for `did:webvh`,
    which complements `did:web` with specific features to address its challenges
    while still providing ease of deployment.

did:key
:   `did:key` as described in the [W3C
    specification](https://w3c-ccg.github.io/did-key-spec/) is a DID method that
    derives a DID document directly from a single, encoded cryptographic public key,
    requiring no registry, ledger, or network interaction to resolve. It is valued
    for its simplicity and self-contained nature, making it well-suited for
    ephemeral, offline, or peer-to-peer use cases. However, `did:key` DIDs are
    inherently static — they cannot be updated or rotated — which limits their use
    in long-lived or high-assurance contexts. `did:key` is commonly used in
    `did:webvh` implementations for keys such as the [Pre-Rotation Key](#term:pre-rotation-key) and Update Key, where its simplicity and cryptographic
    self-sufficiency are advantageous.

Entry Hash
:   A `did:webvh` entry hash is a hash generated using a formally defined process
    over the input data to a [log entry](#term:log-entry), excluding the [Data Integrity](#term:data-integrity)
    proof. The input data includes content from the predecessor to the
    version of the DID, ensuring that all the versions are “chained” together in a
    sort of microledger. The generated [entry hash](#term:entry-hash) is subsequently included in the
    `versionId` of the [log entry](#term:log-entry) and **MUST** be verified by a
    resolver.

ISO8601
:   A date/time expressed using the [ISO8601
    Standard](https://en.wikipedia.org/wiki/ISO_8601).

JSON Canonicalization Scheme
:   [[RFC8785](#ref:RFC8785)] defines a method for canonicalizing a JSON
    structure such that it is suitable for verifiable hashing or signing.

JSON Lines
:   A file of JSON Lines, as described on the site
    <https://jsonlines.org/>. In short, `JSONL` is lines of JSON with
    whitespace removed and separated by a newline that is convenient for handling
    streaming JSON data or log files.

Pre-Rotation
:   A technique for a controller of a cryptographic key to commit to the public
    key it will rotate to next, without exposing that actual public key. It protects
    from an attacker that gains knowledge of the current private key from being
    able to rotate to a new key known only to the attacker.

Linked-VP
:   A [[DID-CORE](#ref:DID-CORE)] `service` entry that specifies where a [verifiable presentation](#term:verifiable-presentation)
    about the DID subject can be found. The [Decentralized Identity
    Foundation](https://identity.foundation/) hosts the [Linked VP
    Specification](https://identity.foundation/linked-vp/).

multibase
:   A specification for encoding binary data as a string using a prefix that
    indicates the encoding.

multikey
:   A verification method that encodes key types into a single binary stream that
    is then encoded as a [multibase](#term:multibase) value.

multihash
:   Per the [[MULTIFORMATS](#ref:MULTIFORMATS)], [multihash](#term:multihash) is a specification
    for differentiating instances of hashes. Software creating a hash prefixes
    (according to the specification) data to the hash indicating the algorithm used
    and the length of the hash, so that software receiving the hash knows how to
    verify it. Although [multihash](#term:multihash) supports many hash algorithms, for
    interoperability, [DID Controllers](#term:did-controllers) **MUST** only use the hash algorithms defined
    in this specification as permitted.

parameters
:   `did:webvh` parameters are a defined set of configurations that control how the
    issuer has generated the DID, and how the resolver must process the DID [Log entries](#term:log-entries). The use of parameters allows for the controlled evolution of
    `did:webvh` log handling, such as evolving the set of permitted hash algorithms or
    cryptosuites. This enables support for very long lasting identifiers – decades.

self-certifying identifier
:   An object identifier derived from initial data such that an attacker could not
    create a new object with the same identifier. The input for a `did:webvh` SCID is
    the initial [DIDDoc](#term:diddoc) with the placeholder `{SCID}` wherever the SCID is to be
    placed.

Verifiable Credential
:   A verifiable credential can represent all of the same information that a physical credential represents, adding technologies such as digital signatures, to make the credentials more tamper-evident and so more trustworthy than their physical counterparts. The [Verifiable Credential Data Model](https://www.w3.org/TR/vc-data-model/) is a W3C Standard.

Verifiable Presentation
:   A [verifiable presentation](#term:verifiable-presentation) data model is part of W3C’s [Verifiable Credential Data
    Model](https://www.w3.org/TR/vc-data-model/) that contains a set of [verifiable credentials](#term:verifiable-credentials) about a `credentialSubject`, and a signature across the
    verifiable credentials generated by that subject. In this specification, the use
    case of primary interest is where the DID is the `credentialSubject` and the DID
    signs the [verifiable presentation](#term:verifiable-presentation).

watcher
:   Watchers are entities within a decentralized trust ecosystem that monitor Decentralized Identifiers (DIDs) for changes or updates on behalf of their clients. Watchers maintain a historical cache of DID document versions and verify that the [DID Controller](#term:did-controller) is consistently following the prescribed evolution process. By ensuring integrity and traceability, watchers help foster trust among clients who rely on up-to-date and authentic DID information. `did:webvh` watchers provide endpoints for retrieving DID information and to receive [webhooks](#term:webhooks) notifying the watcher about updates to the DID and deletion requests.

webhook
:   A webhook is a mechanism that enables real-time communication between systems by sending HTTP callbacks (typically POST requests) to a specified URL when an event occurs. Webhooks are commonly used for event-driven integrations and automation. Although webhooks are an implementation pattern rather than a formal standard, best practices are documented in [[RFC8030](#ref:RFC8030)].

witness
:   Witnesses are participants in the process of creating and verifying a version
    of a `did:webvh` [DIDDoc](#term:diddoc). Notably, a witness receives from the [DID Controller](#term:did-controller) a [DID Log](#term:did-log) entry ready for publication, verifies it according to this specification,
    and approves it according to its ecosystem governance (whatever that might be). If the verification and
    approval process results are positive, the witness returns to the DID Controller a [Data Integrity](#term:data-integrity) proof
    attesting to that positive result.

threshold
:   An algorithm that defines when a sufficient number of [witnesses](#term:witnesses) have
    submitted valid [Data Integrity](#term:data-integrity) proofs for a [DID Log entry](#term:did-log-entry) such
    that it is approved and can be published. The algorithm details are in the
    [Witness Threshold Algorithm](#witness-threshold-algorithm) section of this
    specification.

W3C VCDM
:   A Verifiable Credential that uses the Data Model defined by the W3C [[VC-DATA-MODEL](#ref:VC-DATA-MODEL)] specification.

## [§](#references) References

DI-EDDSA-V1.0
:   [Data Integrity EdDSA Cryptosuites v1.0](https://www.w3.org/TR/vc-di-eddsa).
    Dave Longley; Manu Sporny; 2024-12-08. Status: W3C Technical Recommendation.

DID-CORE
:   [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/).
    Manu Sporny; Amy Guy; Markus Sabadello; Drummond Reed; 2022-07-19. Status: REC.

DID-EXTENSION-RESOLUTION
:   [DID Resolution Extensions Registry](https://w3c.github.io/did-extensions-resolution/).
    The Decentralized Identifier Working Group (W3C); 2024-11-19. Status: W3C Technical Report.

DID-RESOLUTION
:   [Decentralized Identifier Resolution (DID Resolution) v1](https://w3c.github.io/did-resolution/).
    Stephen Curran; Joe Andrieu; 2026-09-02. Status: W3C Editor's Draft.

DRAFT-MSPORNY-BASE58-03
:   [The Base58 Encoding Scheme](https://datatracker.ietf.org/doc/html/draft-msporny-base58-03).
    S. Nakamoto; Manu Sporny; 2021-03-31. Status: Internet Draft.

JSON-SCHEMA-CORE
:   [JSON Schema: A Media Type for Describing JSON Documents](https://json-schema.org/draft/2020-12/json-schema-core).
    A. Wright; H. Andrews; B. Hutton; G. Dennis; 2022-06-16. Status: Internet Draft.

LINKED-VP
:   [Linked Verifiable Presentation v1.0.0](https://identity.foundation/linked-vp/spec/v1.0.0/).
    Jan Christoph Ebersbach (identinet); Brian Richter (Aviary Tech); Markus Sabadello (Danube Tech); 2025-07-16. Status: DIF Ratified Specification.

MULTIFORMATS
:   [Multiformats](https://datatracker.ietf.org/doc/draft-multiformats-multibase/08/).
    Juan Benet; Manu Sporny; 2024-02-21. Status: Internet Draft.

RFC1034
:   [Domain names - concepts and facilities](https://www.rfc-editor.org/rfc/rfc1034).
    P. Mockapetris; 1987-11. Status: Internet Standard.

RFC1035
:   [Domain names - implementation and specification](https://www.rfc-editor.org/rfc/rfc1035).
    P. Mockapetris; 1987-11. Status: Internet Standard.

RFC1123
:   [Requirements for Internet Hosts - Application and Support](https://www.rfc-editor.org/rfc/rfc1123).
    R. Braden, Ed.; 1989-10. Status: Internet Standard.

RFC2181
:   [Clarifications to the DNS Specification](https://www.rfc-editor.org/rfc/rfc2181).
    R. Elz; R. Bush; 1997-07. Status: Proposed Standard.

RFC3552
:   [Guidelines for Writing RFC Text on Security Considerations](https://www.rfc-editor.org/rfc/rfc3552).
    E. Rescorla; B. Korver; 2003-07. Status: Best Current Practice.

RFC3912
:   [WHOIS Protocol Specification](https://www.rfc-editor.org/rfc/rfc3912).
    L. Daigle; 2004-09. Status: Draft Standard.

RFC3986
:   [Uniform Resource Identifier (URI): Generic Syntax](https://www.rfc-editor.org/rfc/rfc3986).
    T. Berners-Lee; R. Fielding; L. Masinter; 2005-01. Status: Internet Standard.

RFC4033
:   [DNS Security Introduction and Requirements](https://www.rfc-editor.org/rfc/rfc4033).
    R. Arends; R. Austein; M. Larson; D. Massey; S. Rose; 2005-03. Status: Proposed Standard.

RFC4034
:   [Resource Records for the DNS Security Extensions](https://www.rfc-editor.org/rfc/rfc4034).
    R. Arends; R. Austein; M. Larson; D. Massey; S. Rose; 2005-03. Status: Proposed Standard.

RFC4035
:   [Protocol Modifications for the DNS Security Extensions](https://www.rfc-editor.org/rfc/rfc4035).
    R. Arends; R. Austein; M. Larson; D. Massey; S. Rose; 2005-03. Status: Proposed Standard.

RFC5234
:   [Augmented BNF for Syntax Specifications: ABNF](https://www.rfc-editor.org/rfc/rfc5234).
    D. Crocker, Ed.; P. Overell; 2008-01. Status: Internet Standard.

RFC6234
:   [US Secure Hash Algorithms (SHA and SHA-based HMAC and HKDF)](https://www.rfc-editor.org/rfc/rfc6234).
    D. Eastlake 3rd; T. Hansen; 2011-05. Status: Informational.

RFC6973
:   [Privacy Considerations for Internet Protocols](https://www.rfc-editor.org/rfc/rfc6973).
    A. Cooper; H. Tschofenig; B. Aboba; J. Peterson; J. Morris; M. Hansen; R. Smith; 2013-07. Status: Informational.

RFC8030
:   [Generic Event Delivery Using HTTP Push](https://www.rfc-editor.org/rfc/rfc8030).
    M. Thomson; E. Damaggio; B. Raymor, Ed.; 2016-12. Status: Proposed Standard.

RFC8484
:   [DNS Queries over HTTPS (DoH)](https://www.rfc-editor.org/rfc/rfc8484).
    P. Hoffman; P. McManus; 2018-10. Status: Proposed Standard.

RFC8785
:   [JSON Canonicalization Scheme (JCS)](https://www.rfc-editor.org/rfc/rfc8785).
    A. Rundgren; B. Jordan; S. Erdtman; 2020-06. Status: Informational.

RFC9110
:   [HTTP Semantics](https://httpwg.org/specs/rfc9110.html).
    R. Fielding, Ed.; M. Nottingham, Ed.; J. Reschke, Ed.; 2022-06. Status: Internet Standard.

RFC9457
:   [Problem Details for HTTP APIs](https://www.rfc-editor.org/rfc/rfc9457).
    M. Nottingham; E. Wilde; S. Dalal; 2023-07. Status: Proposed Standard.

RFC9525
:   [Service Identity in TLS](https://www.rfc-editor.org/rfc/rfc9525).
    P. Saint-Andre; R. Salz; 2023-11. Status: Proposed Standard.

SEMVER
:   [Semantic Versioning 2.0.0](https://semver.org).
    Tom Preston-Werner; 2013-06-18. Status: Internet Draft.

VC-DATA-MODEL
:   [Verifiable Credentials Data Model v1.1](https://www.w3.org/TR/vc-data-model/).
    Manu Sporny; Grant Noble; Dave Longley; Daniel Burnett; Brent Zundel; Kyle Den Hartog; 2022-03-03. Status: REC.

## [§](#didwebvh-version-changelog) `did:webvh` Version Changelog

The following lists the substantive changes in each version of the specification.

* Version 1.0

  + Adds clarifications about the handling of default values for unspecified parameters when introduced, and defines that `null` should **NOT** be used for parameters, to ensure that the parameter data types are always retained.
  + Removes the `weight` value and clarifies permitted values of `threshold`.
  + Adds the concept of a `watcher` to the specification, including the technical details of deploying and using a `watcher`.
  + Clarifies the [DID-to-HTTPS Transformation](#the-did-to-https-transformation) to include support for domain names using Unicode international languages.
* Version 0.5

  + Remove the `prerotation` parameter. The feature is automatically enforced
    when `nextKeyHashes` is present.
  + Clarify the way the [Pre-Rotation](#term:pre-rotation) feature works, once a `nextKeyHashes`
    is committed, the next [DID log entry](#term:did-log-entry) has to be signed by one of the committed keys.
  + Clarify how to stop using [pre-rotation](#term:pre-rotation), including when deactivating the DID.
  + Change the [witness](#term:witness) handling by removing the witness [Data Integrity](#term:data-integrity)
    proofs from the [DID Log](#term:did-log) file and putting them into a separate file
    `did-witness.json`. Adjustments to the witness threshold algorithm were also
    made, such as removing the [DID Controllers](#term:did-controllers)’ `selfweight` attribute,
    and defining that all witness DIDs must be `did:key` DIDs.
  + Clarify how to stop using witnesses.
  + Clarify the initialization values of [parameters](#term:parameters) and that array
    [parameters](#term:parameters) must use `null` and **not** use empty lists (`[]`) when
    not active.
  + Rename the DID Method to `did:webvh` (`did:web` + Verifiable History)
  + Move the DID Method information site to <https://didwebvh.info>.
* Version 0.4

  + Removes large non-normative sections, such as the implementer’s guide, as they are now published on the <https://didwebvh.info> information site.
  + Removes the use of JSON Patch from the specification. The full DIDDoc is included in each [DID log entry](#term:did-log-entry).
  + Changes the data format of the [DID log entries](#term:did-log-entries) from an array to an object. The [DID Log](#term:did-log) remains in the [JSON Lines](#term:json-lines) format.
  + Changes the [DID log entry](#term:did-log-entry) array to be named JSON objects or properties.
  + Makes each DID version’s [Data Integrity](#term:data-integrity) proof apply across the JSON
    [DID log entry](#term:did-log-entry) object, as is typical with [Data Integrity](#term:data-integrity) proofs.
    Previously, the [Data Integrity](#term:data-integrity) proof was generated across
    the current DIDDoc version, with the `versionId` as the challenge.
  + Specified that the `versionTime` must be recorded as a UTC time zone timestamp.
* Version 0.3

  + Removes the `cryptosuite` [parameter](#term:parameter), moving it to implied based on the `method` [parameter](#term:parameter).
  + Replace base32 encoding with [base58btc](#term:base58btc), as it offers a better expansion rate.
  + Remove the step to extract part of the [base58btc](#term:base58btc) result during the generation of the [SCID](#term:scid).
  + Use [multihash](#term:multihash) in the [SCID](#term:scid) to differentiate the different hash function outputs.
* Version 0.2

  + Changes the location of the [SCID](#term:scid) in the DID to always be the first
    component after the DID Method prefix – `did:tdw:<scid>:...`.
  + Adds the [parameter](#term:parameter) `portable` to enable the capability to move a
    `did:tdw` during the creation of the DID.
  + Removes the first two [Log Entry](#term:log-entry) items `entryHash` and `versionId`
    and replaces them with the new `versionId` as the first item in each
    [log entry](#term:log-entry). The new versionId takes the form `<version number>-<entryHash>`,
    where `<version number>` is the incrementing integer of version of the
    entry: 1, 2, 3, etc.
  + The `<did>/whois` media type is changed to `application/vp` and the file is
    changed to `whois.vp` to match the IANA registration of a [Verifiable Presentation](#term:verifiable-presentation).

✕

Table of Contents
✕

* [Abstract](#abstract)
* [Overview](#overview)
  + [The `/whois` Use Case](#the-whois-use-case)
* [`did:webvh` DID Method Specification](#didwebvh-did-method-specification)
  + [Target System](#target-system)
  + [Method Name](#method-name)
  + [Method-Specific Identifier](#method-specific-identifier)
  + [The DID to HTTPS Transformation](#the-did-to-https-transformation)
  + [The DID Log File](#the-did-log-file)
  + [DID Method Operations](#did-method-operations)
    - [Create (Register)](#create-register)
    - [Read (Resolve)](#read-resolve)
    - [Update (Rotate)](#update-rotate)
    - [Deactivate (Revoke)](#deactivate-revoke)
  + [DID Method Processes](#did-method-processes)
    - [`did:webvh` DID Method Parameters](#didwebvh-did-method-parameters)
    - [Cryptographic Agility](#cryptographic-agility)
    - [SCID Generation and Verification](#scid-generation-and-verification)
    - [Entry Hash Generation and Verification](#entry-hash-generation-and-verification)
    - [Authorized Keys](#authorized-keys)
    - [DID Portability](#did-portability)
    - [Pre-Rotation Key Hash Generation and Verification](#pre-rotation-key-hash-generation-and-verification)
    - [DID Witnesses](#did-witnesses)
    - [DID Watchers](#did-watchers)
    - [Publishing a Parallel `did:web` DID](#publishing-a-parallel-didweb-did)
  + [DID URL Resolution](#did-url-resolution)
    - [DID URL Path Resolution](#did-url-path-resolution)
    - [DID URL whois LinkedVP Service](#did-url-whois-linkedvp-service)
* [Security Considerations](#security-considerations)
  + [Threats and Attacks](#threats-and-attacks)
  + [Residual Risks](#residual-risks)
  + [Integrity Protection and Update Authentication](#integrity-protection-and-update-authentication)
  + [Authentication Characteristics](#authentication-characteristics)
  + [Unique Assignment of DIDs](#unique-assignment-of-dids)
  + [Endpoint Authentication](#endpoint-authentication)
  + [Resolver Transport Hardening (SSRF and Network Boundary)](#resolver-transport-hardening-ssrf-and-network-boundary)
  + [Network Topology](#network-topology)
  + [Cryptographic Protection](#cryptographic-protection)
  + [Signature Implementation](#signature-implementation)
  + [International Domain Names](#international-domain-names)
  + [Cross-Origin Resource Sharing (CORS) Policy Considerations](#cross-origin-resource-sharing-cors-policy-considerations)
  + [Publishing parallel `did:web`](#publishing-parallel-didweb)
  + [Post Quantum Attacks](#post-quantum-attacks)
  + [Resolver Validation Checklist (informative)](#resolver-validation-checklist-informative)
* [Privacy Considerations](#privacy-considerations)
  + [Surveillance](#surveillance)
  + [Stored Data Compromise](#stored-data-compromise)
  + [Implementation Hygiene (informative)](#implementation-hygiene-informative)
  + [Unsolicited Traffic](#unsolicited-traffic)
  + [Misattribution](#misattribution)
  + [Correlation](#correlation)
  + [Identification](#identification)
  + [Right to Erasure (GDPR Art. 17)](#right-to-erasure-gdpr-art-17)
  + [Secondary Use](#secondary-use)
  + [Disclosure](#disclosure)
  + [Exclusion](#exclusion)
  + [No Phone Home Mitigations](#no-phone-home-mitigations)
* [Definitions](#definitions)
* [References](#references)
* [`did:webvh` Version Changelog](#didwebvh-version-changelog)