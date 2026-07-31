---
title: "New swiyu Generic Issuer and Verifier"
categories:
  - PublicBeta
---

We released a new versions of our generic verifier due to a security vulnarabilty. 

## Generic Verifier [Version 4.1.2](https://github.com/swiyu-admin-ch/swiyu-verifier/releases/tag/4.1.2)
* 🚨 **Critical vulnerability fix** VC Authorization Bypass, upgrade ASAP
* Trust validation is now bound to the DID from the `kid` header (actual signer) instead of the `iss` claim
* See [Change Dossier CD-008](https://swiyu-admin-ch.github.io/change-dossiers/CD-008-Critical-Vulnerability-Generic-Verifier/) for full details on the vulnerability, root cause, and timeline
* For more details, please refer to the [changelog](https://github.com/swiyu-admin-ch/swiyu-verifier/blob/main/CHANGELOG.md)

There are no breaking changes associated with this fix, so no specific migration steps are necessary.

  
