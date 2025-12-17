---
title: Identified Threats for the swiyu Generic Issuer
header:
  teaser: ../assets/images/cookbook_generic_issuer.jpg
---

### swiyu Generic Issuer

| Summary | Description | STRIDE category | 
|-----------|-------------|-------------|
| Impersonated malicious / privileged actions | An attacker can impersonate an actor and get this issuer listed on the non-compliant list or revoked from the trust registry. | Spoofing (S), Denial of Service (D), Elevation of Privilege (E) |
| Get physical access to issuer cooperation | An attacker can get access to the issuer's machine to issue malicious credentials. | Spoofing (S) |
| Acquire signing private key | If an attacker gets access to the signing key, they can issue arbitrary VCs / trust statements / presentation requests in his name. | Spoofing (S) |
| Acquire DID update key | If an attacker gets access to the DID update key, it can change the DID log and therefore (1) invalidate all credentials from this actor, and (2) insert their own key to sign VCs in the name of this actor. | Spoofing (S), Tampering (T) |
| Wrong generic components usage | A company can make mistakes integrating the FOITT-provided issuer/verifier. A wrong implementation includes using insecure configurations or changing the supplied code. | Tampering (T), Information Disclosure (I), Denial of Service (D) |
| Manipulate issuer configuration | An attacker inside the organization changes configuration data (e.g., disables holder binding, allows weak cryptography). | Tampering (T) |
| Changing URL content | When URLs are included in the credential (e.g. vct, image, content), the credential's signature only protects against changing the URL. The data is not integrity protected by the JWT signature if the URL resolves to a different content. | Tampering (T) |
| Change VC status | An Attacker can change the status of the VC without authority. | Tampering (T) |
| Holder denies request to revoke VC | A holder can deny the request to revoke the VC. | Non-Repudiation (R) |
| Holder denies having requested a VC | A holder can deny requesting a VC from the Issuer. | Non-Repudiation (R) |
| Holder denies having received a VC | A holder can deny receiving a VC from an issuer. | Non-Repudiation (R) |
| Holder denies deleting / not storing VC | A holder can deny deleting or storing a received VC. | Non-Repudiation (R) |
| Holder denies leaking bound private key | A holder can deny leaking the private key. | Non-Repudiation (R) |
| Holder (deliberately) looses / destroys device | A holder can deny having (deliberately) lost / destroyed the device. | Non-Repudiation (R) |
| Supply Chain attack | We rely on libraries in our code. We thus also rely on their security. A malicious library can gain information, make our system unavailable, or execute code on our systems. | Information Disclosure (I), Denial of Service (D), Elevation of Privilege (E) |
| Management endpoint is unprotected or publicly acessible | An attacker can reach the management endpoint without protection (e.g., mTLS) or is even publicly accessible.     ([Source](https://github.com/swiyu-admin-ch/swiyu-issuer?tab=readme-ov-file#deployment-considerations)) | Information Disclosure (I), Elevation of Privilege (E) |
| An actor discloses the private key | An attacker can disclose the private key from an issuer. | Information Disclosure (I) |
| Disclose access token | An attacker can disclose the access token / refresh token from an issuer. | Information Disclosure (I) |
| Track issuer through side channel | An issuer can disclose information about the issuance through side channels (e.g., index in status list = number of VCs issued). | Information Disclosure (I) |
| Delete DID update key | An actor without the update key loses the possibility to change the DID document. | Denial of Service (D) |
| Delete issuing private key | An issuer without the private key for signing the VCs cannot issue new VCs. | Denial of Service (D) |
| Reroute / drop packets inside ecosystem | An attacker controlling DNS, a router, or sending malicious BGP messages can disable/reroute a connection to some actor. | Denial of Service (D) |
| Exploit credential renewal flow | An attacker can exploit the credential renewal flow to e.g. issue the credential to a self controlled wallet. | Elevation of Privilege (E) |
| Insecure configuration | Wrong configuration settings or wrong use of libraries can lead to vulnerabilities. | Elevation of Privilege (E) |
| Issue credential for attacker | An attacker can force (e.g., through social engineering) the issuer to issue a credential for the attacker. | Elevation of Privilege (E) |
