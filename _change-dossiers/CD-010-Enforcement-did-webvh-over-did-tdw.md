---
title: CD-010 - Enforcement did:webvh over did:tdw
excerpt: Migration from did:tdw to did:webvh for credential issuance
header:
  teaser: ../assets/images/none.jpg
---
{% capture notice-text %}
Status: Planned <br>
Published: tbd <br>
Effective: tbd <br>
Affected Components: Generic Issuer<br>
{% endcapture %}
<div class="notice--danger">
  <h4 class="no_toc">Enforcement did:webvh over did:tdw</h4>
  {{ notice-text | markdownify }}
</div>

Registries no longer accept `did:tdw` as issuer DID. All issuers must migrate to `did:webvh`. A 3-month transition period applies; afterwards `did:tdw` is no longer supported.

## Action required

### Generic Issuer
Tag ⚠️ Required soon  
Tag 🚨 Breaking

## Migration steps

1. **Update Generic Issuer** to a version that supports `did:webvh` (feature flag `FEATURE_DID_WEBVH_ENABLED`).
2. **Config update**: enable `FEATURE_DID_WEBVH_ENABLED` and provide the `did:webvh` issuer DID, verification method, and HSM key ID via `configuration_override`.
3. **Onboard again** with the new `did:webvh` DID in Trust Registry / Base Registry.

## Timeline

- **tbd** – Generic Issuer release X.X.X with `did:webvh` support available
- **tbd** – Transition period started (Registries accept both `did:tdw` and `did:webvh`)
- **Effective Date + 3 months** – `did:tdw` no longer supported; Registries reject `did:tdw` issuer DIDs
