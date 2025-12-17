---
title: Identified Threats for the swiyu Registry
header:
  teaser: ../assets/images/cookbook_generic_issuer.jpg
---

todo: update image

### Registry
| Summary | Description | STRIDE category | 
|-----------|-------------|-------------|
| Acquire signing private key | If an attacker gets access to the signing key, they can issue arbitrary VCs / trust statements / presentation requests in his name. | Spoofing (S) |
| Supply Chain attack | We rely on libraries in our code. We thus also rely on their security. A malicious library can gain information, make our system unavailable, or execute code on our systems. | Information Disclosure (I), Denial of Service (D), Elevation of Privilege (E) |
| Reroute / drop packets inside ecosystem | An attacker controlling DNS, a router, or sending malicious BGP messages can disable/reroute a connection to some actor. | Denial of Service (D) |
| Insecure configuration | Wrong configuration settings or wrong use of libraries can lead to vulnerabilities. | Elevation of Privilege (E) |
