
### Verifier
| Summary | Description | STRIDE category | 
|-----------|-------------|-------------|
| Impersonated malicious / privileged actions | An attacker can impersonate an actor and get this issuer listed on the non-compliant list or revoked from the trust registry. | Spoofing (S), Denial of Service (D), Elevation of Privilege (E) |
| Impersonate legitimate verifier | An attacker can impersonate a legitimate verifier to get the personal data of the holder. | Spoofing (S) |
| Acquire signing private key | If an attacker gets access to the signing key, they can issue arbitrary VCs / trust statements / presentation requests in his name. | Spoofing (S) |
| Acquire DID update key | If an attacker gets access to the DID update key, it can change the DID log and therefore (1) invalidate all credentials from this actor, and (2) insert their own key to sign VCs in the name of this actor. | Spoofing (S), Tampering (T) |
| Wrong generic components usage | A company can make mistakes integrating the FOITT-provided issuer/verifier. A wrong implementation includes using insecure configurations or changing the supplied code. | Tampering (T), Information Disclosure (I), Denial of Service (D) |
| Manipulate verification configuration | An attacker can change the content of the verification process to accept invalid VPs (e.g., change allowed_issuer_dids / allow bad cryptography/change schema requested). | Tampering (T) |
| Inject malicious code into verifier | An attacker can change the code that verifies VPs to accept malicious credentials. | Tampering (T) |
| Holder denies having sent selective disclosures | A holder can deny sending particular disclosures together with the disclosed  VC. | Non-Repudiation (R) |
| Holder denies having presented a credential | A holder can deny presenting a VC to a verifier. | Non-Repudiation (R) |
| Supply Chain attack | We rely on libraries in our code. We thus also rely on their security. A malicious library can gain information, make our system unavailable, or execute code on our systems. | Information Disclosure (I), Denial of Service (D), Elevation of Privilege (E) |
| Management endpoint is unprotected or publicly acessible | An attacker can reach the management endpoint without protection (e.g., mTLS) or is even publicly accessible.     ([Source](https://github.com/swiyu-admin-ch/swiyu-issuer?tab=readme-ov-file#deployment-considerations)) | Information Disclosure (I), Elevation of Privilege (E) |
| Verifier requests too much data | A verifier can request more data than is used to get the private information of the holder. | Information Disclosure (I) |
| Verifier stores data to track user | A verifier can store data to track the holder further. (e.g., status URI + index to track if the user lost driver's license). | Information Disclosure (I) |
| Verifier discloses received data | A verifier can publicly disclose private data disclosed by the holder. | Information Disclosure (I) |
| An actor discloses the private key | An attacker can disclose the private key from an issuer. | Information Disclosure (I) |
| Disclose access token | An attacker can disclose the access token / refresh token from an issuer. | Information Disclosure (I) |
| Delete DID update key | An actor without the update key loses the possibility to change the DID document. | Denial of Service (D) |
| Reroute / drop packets inside ecosystem | An attacker controlling DNS, a router, or sending malicious BGP messages can disable/reroute a connection to some actor. | Denial of Service (D) |
| Insecure configuration | Wrong configuration settings or wrong use of libraries can lead to vulnerabilities. | Elevation of Privilege (E) |
| Verification with friend credential | A wallet can forward the request to a friend who then sends their credential. | Elevation of Privilege (E) |
| Forwarding phone | The legitimate holder gives the phone with the PIN to another person. | Elevation of Privilege (E) |
