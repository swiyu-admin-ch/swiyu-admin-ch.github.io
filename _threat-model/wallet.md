---
title: Identified Threats for the swiyu Wallet
header:
  teaser: ../assets/images/cookbook_beta_eid.jpg
---

todo: update image

### Wallet

| Summary | Description | STRIDE category | 
|-----------|-------------|-------------|
| Impersonated malicious / privileged actions | An attacker can impersonate an actor and get this issuer listed on the non-compliant list or revoked from the trust registry. | Spoofing (S), Denial of Service (D), Elevation of Privilege (E) |
| Acquire pre_auth-code during issuance | An attacker can try to steal the pre_auth-code to steal the VC. | Spoofing (S) |
| Steal credential offer during issuance | An attacker can try to steal the credential offer and thus steal the whole VC from the victim. | Spoofing (S) |
| Impersonate legitimate verifier | An attacker can impersonate a legitimate verifier to get the personal data of the holder. | Spoofing (S) |
| Man in the middle during credential transmission | An attacker can perform a man-in-the-middle attack to get access to the VC's content.  This can be done by creating a proxy issuer / verifier. | Spoofing (S) |
| Impersonate holder | An attacker can impersonate a holder to steal the VC. | Spoofing (S) |
| Acquire credential issuance access token | An attacker can try to steal the Access Token required to access the VC. | Spoofing (S) |
| Acquire transaction_id during deferred issuance | An attacker can try to steal the transaction_id to steal the VC. | Spoofing (S) |
| Physical access to wallet | An attacker can steal or otherwise access the holder's device. | Spoofing (S) |
| Exploit recovery mechanism | A badly implemented recovery mechanism can lead to the loss of identity. | Spoofing (S) |
| Spoof attestation service | An attacker can create an own attestation service that spoofs the original FOITT attestation service. | Spoofing (S) |
| Changing URL content | When URLs are included in the credential (e.g. vct, image, content), the credential's signature only protects against changing the URL. The data is not integrity protected by the JWT signature if the URL resolves to a different content. | Tampering (T) |
| Issuer denies storing credential | An issuer can deny storing a credential after having it issued | Non-Repudiation (R) |
| Verifier denies storing a received VP | A verifier can deny storing a received VP against suggestions of FOITT. | Non-Repudiation (R) |
| Verifier denies verifying a VP | A verifier can claim they never checked a VP for validity. | Non-Repudiation (R) |
| Verifier denies accepting/denying VP | A verifier can deny making an access control decision based on the received VP. | Non-Repudiation (R) |
| FOITT denies to have received non-compliance report | BIT denies to have ever received a non-compliance report about an actor. | Non-Repudiation (R) |
| Support staff denies ever receiving a support message | FOITT can deny to have ever received the support ticket sent by the user. | Non-Repudiation (R) |
| Supply Chain attack | We rely on libraries in our code. We thus also rely on their security. A malicious library can gain information, make our system unavailable, or execute code on our systems. | Information Disclosure (I), Denial of Service (D), Elevation of Privilege (E) |
| Registry observability / trackability | The registry can infer actions of the Holder by watching the requests done to the registry endpoints. | Information Disclosure (I) |
| Issuer DID log tracking | An issuer can create a DID log for every issued credential and can track the user by observing the network requests made for that DID log. | Information Disclosure (I) |
| Issuer tracks credential holders | An issuer can track the holders of a credential despite self sovereign design principles. | Information Disclosure (I) |
| Issuer tracks user through content URLs | An issuer can provide metadata links (such as image URLs) that require the wallet to request this resource on usage. An issuer can then track requests made to this endpoint to guess the usage of its credentials. | Information Disclosure (I) |
| Issuer status list tracking | An issuer can create its status list for every user and can track the user by observing the network requests made. | Information Disclosure (I) |
| Credential claims not disclosable | An issuer can create a VC with non-disclosable private data. | Information Disclosure (I) |
| Issuer leaks stored VCs | An issuer storing the issued VCs could leak their content. | Information Disclosure (I) |
| Credential contains unessesary personal data | An issuer embeds unnecessary or too much personal data inside the VC. | Information Disclosure (I) |
| Unnecessarily disclose sensitive data during presentation | A holder can send too much data to a verifier. | Information Disclosure (I) |
| Batch issuing correlation | When issuing a batch, a malicious verifier can link the credentials together by the metadata of the credential (e.g., iat, exp). An issuer can determine the amount of verifications made by tracking the requests for new batches. | Information Disclosure (I) |
| Issuer & Verifier collusion | An issuer can collude with verifiers to track the holder's actions | Information Disclosure (I) |
| Issuer discloses credential offer | An attacker can force the issuer to disclose the content of the credential offer yet to be sent. An issuer can leak the personal data of the user stored in the credential offer. | Information Disclosure (I) |
| Issuer & Registry collusion | An issuer can collude with the Registries (the FOITT) to track the holder's actions | Information Disclosure (I) |
| Verifier & verifier collusion | A verifier can collude with another verifier to create a profile of the holder. | Information Disclosure (I) |
| Break / loose device | An attacker can break / loose the device where the VC is stored. | Denial of Service (D) |
| External services unavailable | The services we rely on in our systems are not available (e.g., attestation service by Apple and Google, routers, DNS, etc.). | Denial of Service (D) |
| Force credential revocation | An attacker can force (or trick) the issuer to revoke the credential of the holder to make the VC unusable. | Denial of Service (D) |
| Expired credential | A credential that is expired cannot be used for verification anymore. | Denial of Service (D) |
| Insecure configuration | Wrong configuration settings or wrong use of libraries can lead to vulnerabilities. | Elevation of Privilege (E) |

