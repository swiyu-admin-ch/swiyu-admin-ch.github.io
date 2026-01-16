# 1 Compromise component
**Description**:
An internal worker with privileges or an attacker that compromised a central system can perform more harmful behavior to the swiyu ecosystem.
**Stride**:
Elevation of Privilege (E)
**Components**:
Issuer, Registry, Verifier, Wallet

## 1.1 Internal operating information leak
**Description**:
A internal worker or attacker with access discloses internal documents to the public either deliberately or accidentally.
**Stride**:
Information Disclosure (I)
**Components**:
Registry

### 1.1.1 Support worker leaks support request
**Description**:
A Support worker leaks a support ticket that contained sensitive data about a holder.
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

## 1.2 Design / Implementation flaws
**Description**:
A flawed design or insecure implementation can lead to an attacker gaining unauthorized privileges in the ecosystem.
**Stride**:
Elevation of Privilege (E)
**Components**:
Issuer, Registry, Verifier, Wallet

### 1.2.1 Supply Chain attack
**Description**:
We rely on libraries in our code. We thus also rely on their security. A malicious library can gain information, make our system unavailable, or execute code on our systems.
**Stride**:
Information Disclosure (I), Denial of Service (D), Elevation of Privilege (E)
**Components**:
Issuer, Registry, Verifier, Wallet

### 1.2.2 Swiss Trust Protocol flaws
**Description**:
A self-designed trust protocol brings the risk of design or implementation flaws because of lack of widespread testing / maturity.
**Stride**:
Elevation of Privilege (E)
**Components**:
Registry

### 1.2.3 Reach hidden/protected endpoints
**Description**:
An attacker can reach hidden or protected endpoints externally.
**Stride**:
Information Disclosure (I), Elevation of Privilege (E)
**Components**:
Issuer, Registry, Verifier

### 1.2.4 Insecure configuration
**Description**:
Wrong configuration settings or wrong use of libraries can lead to vulnerabilities.
**Stride**:
Elevation of Privilege (E)
**Components**:
Issuer, Registry, Verifier, Wallet

### 1.2.5 Malicious requests to swiyu components
**Description**:
Malicious requests can cause the component to be unavailable (e.g., crash, out of Memory, CPU loop).
**Stride**:
Denial of Service (D)
**Components**:
Issuer, Registry, Verifier, Wallet

### 1.2.6 Impersonated malicious privileged actions
**Description**:
An attacker can impersonate an actor and get this issuer listed on the non-compliant list or revoked from the trust registry.
**Stride**:
Spoofing (S), Denial of Service (D), Elevation of Privilege (E)
**Components**:
Issuer, Verifier, Wallet

## 1.3 Spoof communication partner
**Description**:
An attacker can act like the wanted communication partner but is malicious.
**Stride**:
Spoofing (S)
**Components**:
Issuer, Registry, Verifier, Wallet

## 1.4 Unallowed change of message or data
**Description**:
An attacker can change a message or data unauthorized.
**Stride**:
Tampering (T)
**Components**:
Issuer, Registry, Verifier, Wallet

### 1.4.1 Unallowed change of registry content
**Description**:
An attacker can change the content hosted at the registries. This can be through the public API or by e.g., having access to the underlying database.
**Stride**:
Tampering (T), Denial of Service (D)
**Components**:
Registry

# 2 Ecosystem unavailable
**Description**:
Nobody can use the swiyu Ecosystem including the e-ID if it is unavailable.
**Stride**:
Denial of Service (D)
**Components**:
N/A

## 2.1 External services unavailable
**Description**:
The services we rely on in our systems are not available (e.g., attestation service by Apple and Google, routers, DNS, etc.).
**Stride**:
Denial of Service (D)
**Components**:
Wallet

## 2.2 Unavailable Attestation Service
**Description**:
If the attestation service is unavailable, high security credentials (that is required for hardware holder binding) cannot be issued anymore.
**Stride**:
Denial of Service (D)
**Components**:
Issuer, Wallet

## 2.3 Wallet unavailable
**Description**:
If the wallet is not available the user cannot use the credentials inside it.
**Stride**:
Denial of Service (D)
**Components**:
Wallet

## 2.4 Support not available
**Description**:
Holders cannot contact support or create non-compliance reports.
**Stride**:
Denial of Service (D)
**Components**:
N/A

## 2.5 Registries unavailable
**Description**:
Since the registries are a single point of failure, if they are unavailable the whole ecosystem is unusable.
**Stride**:
Denial of Service (D)
**Components**:
Registry

## 2.6 Credential not accessible
**Description**:
A credential that is not accessible prevents the holder from using the swiyu ecosystem.
**Stride**:
Denial of Service (D)
**Components**:
Wallet

## 2.7 Actor unavailable
**Description**:
If the Issuer or Verifier are unavailable they cannot participate in any action (e.g., issuing or verification of credentials). 
**Stride**:
Denial of Service (D)
**Components**:
Issuer, Verifier

# 3 Steal verifiable credential
**Description**:
If an attacker can somehow steal a credential (create an own, steal credential offer, steal holder wallet) the issuer looses trust and the holder potentially sensitive information.
**Stride**:
Information Disclosure (I), Elevation of Privilege (E)
**Components**:
Issuer, Wallet

## 3.1 Circumvent verification
**Description**:
A wallet can circumvent verification so that an invalid VP is considered valid.
**Stride**:
Elevation of Privilege (E)
**Components**:
Verifier

## 3.2 Issue credential for attacker
**Description**:
An attacker can force (e.g., through social engineering) the issuer to issue a credential for the attacker.
**Stride**:
Elevation of Privilege (E)
**Components**:
Issuer

### 3.2.1 Steal credential offer during issuance
**Description**:
An attacker can try to steal the credential offer and thus steal the whole VC from the victim.
**Stride**:
Spoofing (S)
**Components**:
Wallet

### 3.2.2 Impersonate legitimate issuer
**Description**:
An attacker can impersonate a legitimate issuer to get the personal data of the holder or issue a restricted VC.
**Stride**:
Spoofing (S)
**Components**:
Issuer, Wallet

### 3.2.3 Impersonate holder
**Description**:
An attacker can impersonate a holder to steal the VC.
**Stride**:
Spoofing (S)
**Components**:
Wallet

#### 3.2.3.1 Exploit e-ID request flow
**Description**:
An attacker that can bypass the e-ID request flow (AV session) can get an e-ID without being eligible or for another person.
**Stride**:
Elevation of Privilege (E)
**Components**:
N/A

#### 3.2.3.2 Unauthorized credential access
**Description**:
An attacker can trick the user into giving him access to the VC (by Phishing / Social Engineering).
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

##### 3.2.3.2.1 Unauthorized access to backup
**Description**:
An attacker can get access to a backup made with the credentials of the user.
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

##### 3.2.3.2.2 Physical access to wallet
**Description**:
An attacker can steal or otherwise access the holder's device.
**Stride**:
Spoofing (S)
**Components**:
Wallet

#### 3.2.3.3 Exploit credential renewal flow
**Description**:
An attacker can exploit the credential renewal flow to e.g. issue the credential to a self controlled wallet.
**Stride**:
Elevation of Privilege (E)
**Components**:
Issuer

#### 3.2.3.4 Verification with friend credential
**Description**:
A wallet can forward the request to a friend who then sends their credential.
**Stride**:
Elevation of Privilege (E)
**Components**:
Verifier

#### 3.2.3.5 Exploit recovery mechanism
**Description**:
A badly implemented recovery mechanism can lead to the loss of identity.
**Stride**:
Spoofing (S)
**Components**:
Wallet

##### 3.2.3.5.1 Unauthorized access to backup
**Description**:
An attacker can get access to a backup made with the credentials of the user.
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

### 3.2.4 Issue restricted schema
**Description**:
An issuer can issue a VC without authorization to do so.
**Stride**:
Spoofing (S)
**Components**:
Issuer

## 3.3 Change sent VC
**Description**:
An attacker can change the content of the VC sent to the wallet after an issuer sends it.
**Stride**:
Tampering (T)
**Components**:
Issuer

## 3.4 Change credential request
**Description**:
An attacker can change the content of the credential request (e.g., remove holder binding requirement).
**Stride**:
Tampering (T)
**Components**:
Issuer

# 4 Exfiltrate User Data
**Description**:
An attacker can get access to sensitive information about the user.
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

## 4.1 Holder tracking
**Description**:
Bad actors can track the actions of the holder and gain sensitive information (e.g., about credential usage).
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

### 4.1.1 Attestation + Push Notification Service observability / trackability
**Description**:
The attestation service and push notification service can infer actions of the Holder by watching the requests done for hardware bound key attestations.  Client attestations and push notification can expose information about the e-ID usage.
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

### 4.1.2 Registry observability / trackability
**Description**:
The registry can infer actions of the Holder by watching the requests done to the registry endpoints.
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

### 4.1.3 Verifier stores data to track user
**Description**:
A verifier can store data to track the holder further. (e.g., status URI + index to track if the user lost driver's license).
**Stride**:
Information Disclosure (I)
**Components**:
Verifier

### 4.1.4 Collusion against Holder
**Description**:
Bad actors can combine their knowledge about a Holder to track their actions.
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

#### 4.1.4.1 Issuer & Verifier collusion
**Description**:
An issuer can collude with verifiers to track the holder's actions
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

#### 4.1.4.2 Verifier & Verifier collusion
**Description**:
A verifier can collude with another verifier to create a profile of the holder.
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

#### 4.1.4.3 Issuer & Registry collusion
**Description**:
An issuer can collude with the Registries (the FOITT) to track the holder's actions
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

### 4.1.5 Issuer tracks credential holders
**Description**:
An issuer can track the holders of a credential despite self sovereign design principles.
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

## 4.2 Unauthorized credential access
**Description**:
An attacker can trick the user into giving him access to the VC (by Phishing / Social Engineering).
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

### 4.2.1 Unauthorized access to backup
**Description**:
An attacker can get access to a backup made with the credentials of the user.
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

### 4.2.2 Physical access to wallet
**Description**:
An attacker can steal or otherwise access the holder's device.
**Stride**:
Spoofing (S)
**Components**:
Wallet

## 4.3 Support worker leaks support request
**Description**:
A Support worker leaks a support ticket that contained sensitive data about a holder.
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

## 4.4 Holder information to underlying infrastructure
**Description**:
The underlying infrastructure gets data about the holder (e.g., through network, os calls, or libraries).
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

### 4.4.1 Supply Chain attack
**Description**:
We rely on libraries in our code. We thus also rely on their security. A malicious library can gain information, make our system unavailable, or execute code on our systems.
**Stride**:
Information Disclosure (I), Denial of Service (D), Elevation of Privilege (E)
**Components**:
Issuer, Registry, Verifier, Wallet

## 4.5 Issuer leaks sensitive data
**Description**:
An issuer can leak sensitive data about the holder or make self sovereignty hard for the holder.
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

## 4.6 Verifier leaks sensitive data
**Description**:
A verifier leaks sensitive data that was sent by the user.
**Stride**:
Spoofing (S), Information Disclosure (I)
**Components**:
Wallet

### 4.6.1 Impersonate legitimate verifier
**Description**:
An attacker can impersonate a legitimate verifier to get the personal data of the holder.
**Stride**:
Spoofing (S)
**Components**:
Verifier, Wallet

### 4.6.2 Verifier stores data to track user
**Description**:
A verifier can store data to track the holder further. (e.g., status URI + index to track if the user lost driver's license).
**Stride**:
Information Disclosure (I)
**Components**:
Verifier

### 4.6.3 Verifier requests too much data
**Description**:
A verifier can request more data than is used to get the private information of the holder.
**Stride**:
Information Disclosure (I)
**Components**:
Verifier

### 4.6.4 Leak personal information through side channel
**Description**:
Personal information can sometimes be inferred by other actions or related claims without explicitly sharing them.

 
**Stride**:
Information Disclosure (I)
**Components**:
Wallet

# 5 Deny Action
**Description**:
An attacker can deny having done an action.
**Stride**:
Non-Repudiation (R)
**Components**:
Issuer, Registry, Verifier, Wallet

## 5.1 Deny receiving message
**Description**:
An attacker can deny ever receiving a message from some communication partner
**Stride**:
Non-Repudiation (R)
**Components**:
Issuer, Registry, Verifier, Wallet

## 5.2 Deny processing message
**Description**:
An attacker can deny ever processing a message from some communication partner
**Stride**:
Non-Repudiation (R)
**Components**:
Issuer, Registry, Verifier, Wallet

## 5.3 Deny sending message
**Description**:
An attacker can deny ever sending a message to some communication partner
**Stride**:
Non-Repudiation (R)
**Components**:
Issuer, Registry, Verifier, Wallet

