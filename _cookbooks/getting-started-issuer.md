---
title: Getting Started as Issuer on the swiyu Trust Infrastructure
toc: true
toc_sticky: true
excerpt: Find relevant information about the VC issuance in the swiyu ecosystem
header:
  teaser: ../assets/images/cookbook_generic_issuer.jpg
---

{% capture notice-text %}

Please be advised that the current system and its operations are provided on a best-effort basis and will continue to evolve over time. The security of the system and its overall maturity remain under development.

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Sandbox</h4>
  {{ notice-text | markdownify }}
</div>


link to confluence: https://confluence.bit.admin.ch/spaces/EIDTEAM/pages/1684517181/Business+Documentation+-+swiyu+Generic+Issuer

#	Onboarding

https://swiyu-admin-ch.github.io/cookbooks/onboarding-base-and-trust-registry/

# Features to consider

https://github.com/swiyu-admin-ch/swiyu-issuer/blob/main/docs/issuance.md

## Immediate or Deferred Issuance

## Unterschied trusted/untrusted

## Batch Issuance

## Hardware Binding

Grundsätzlich muss der Issuer ein feld (TRUSTED_ATTESTATION_PROVIDERS) mit der did unseres attestation service befüllen... kein hexenwerk


# swiyu Generic Issuer

Generische Komponenten, welche [Swiss Profile Issuance](https://swiyu-admin-ch.github.io/specifications/swiss-profile-issuance/) implementiert haben.

Integration in einen "Business Issuer", welcher Geschäftslogik beinhaltet. Aufgrund der permissiven Lizenz... keine Kosten.

Wird eingesetzt in ... Keine Gewährleistung

Cookbook: https://swiyu-admin-ch.github.io/cookbooks/onboarding-generic-issuer/
Complete Documentation (pdf):


# Test your integration


-	Abfrage aHV-Nummer (-> service portal, geschützte Anfrage)

