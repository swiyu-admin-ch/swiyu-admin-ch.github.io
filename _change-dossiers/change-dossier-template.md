---
title: Template for a Change Dossier
excerpt: This text will be shown on the overview page 
header:
  teaser: ../assets/images/none.jpg
---

{% capture notice-text %}

Status: <br>
Published: <br>
Effective: <br>
Affected Components: <br>

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Change Dossier XY</h4>
  {{ notice-text | markdownify }}
</div>

Description of the Change Dossier eg. The entire Trust Protocol changes. Registries, Issuer, Verifier and Wallet must support it. It introduces protected issuance and verification, AHV-number restriction, verifier-query registration and non-compliance handling. During a transition period, components support both the old and the new protocol; afterwards TP 1.0 is no longer supported and old Issuers and Verifiers can no longer interact.

## Action required

### Component 1

Tag ⚠️ Required soon
Tag 🚨 Breaking
Tag 🆕 Optional
Tag ✅ Improvement
Tag 🐞 Fix

### Component 2

## Migration steps



## Timeline
