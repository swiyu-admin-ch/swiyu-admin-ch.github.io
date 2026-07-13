---
title: CDC-004 - Issuer Trust Protocol 2.0, Security Enforcements and Updates
excerpt: blabla
header:
  teaser: ../assets/images/none.jpg
---


{% capture notice-text %}

Status: Draft <br>
Published: <br>
Effective: <br>
Affected Components: <br>
Internal Reference: EIDARTFE-1526, EIDARTFE-1726 <br>

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Swiss Profile VC V1.0</h4>
  {{ notice-text | markdownify }}
</div>

This change closes all remaining Status List gaps against the current swiss-profile VC required for the swiyu 1.0 go-live. It introduces ttl/exp handling for Status List Tokens, mandatory validation rules on the Status Registry (JWT header typ, profile_version enforcement, expiry, and size constraints), configurable verifier tolerance for status-check failures, and caching of Status List Tokens according to their ttl/exp claims. Together these changes make the Status List implementation in the ecosystem ready for the swiyu 1.0 go-live.


## Action required
Update the componets like follows.

Tag ⚠️ Required soon
Tag 🚨 Breaking
Tag 🆕 Optional
Tag ✅ Improvement
Tag 🐞 Fix

### Generic Issuer
Version 3.<br>
⚠️ Add support for ttl and exp claims when issuing Status List Tokens, so that consumers can determine cache validity and expiry per the OAuth Status List draft, Status List Update Interval. <br>

### Generic Verifier
Version?<br>
🆕 Allow configuration of the degree to which a status verification may fail while still accepting a VC. <br>
⚠️ Implement caching of the Status List Token according to its ttl/exp claims, instead of re-fetching on every check. <br>
🚨 Apply Validation Rules: if any status check fails, the Referenced Token SHOULD in most cases be rejected; verifiers configured to tolerate unknown state MAY deviate from this default. <br>

### Wallet
Version ?<br>

### Check App
Version ?<br>

### Status Registry
🚨 Reject Status List Token uploads where exp is missing or already expired; exp MUST be set on upload. <br>
🚨 Enforce that the JWT header typ is statuslist+jwt <br>
🚨 Enforce that the JWT header profile_version matches an allowed value. Implement this as a list of allowed profile versions (e.g. allowed_profile_versions.includes(JWTheader["profile_version"])) rather than a single hardcoded value, to support future EMC cases. For this dossier, the enforced value is swiss-profile-vc:1.0.0. <br>
🚨 Reject Status Lists whose bit size is not evenly divisible into bytes (size-in-bits % 8 == 0) <br>
🚨 Reject Status Lists whose decompressed size exceeds 200 KB <br>

## Migration steps
1. Update Generic Issuer and Generic Verifier
2. Make sure the exp and statuslist+jwt ist correctly configured.


## Timeline
??