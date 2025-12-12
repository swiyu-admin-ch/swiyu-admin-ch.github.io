---
title: Designing the visualization for Issuer, Verifier and Credential
toc: true
toc_sticky: true
excerpt: Learn how to define the visual layout for issuer, verifier and credentials
header:
  teaser: ../assets/images/cookbook_verifiablecredential.jpg
---

{% capture notice-text %}

Please be advised that the current system and its operations are provided on a best-effort basis and will continue to evolve over time. The security of the system and its overall maturity remain under development.

{% endcapture %}

<div class="notice--danger">
  <h4 class="no_toc">Public Beta</h4>
  {{ notice-text | markdownify }}
</div>

## Introduction

This manual describes how to define the visual presentation of issuer, verifier and a verifiable credential (VC) displayed in the swiyu app, the digital wallet of the Swiss Confederation.

Its goal is to enable issuers in creating clean, professional looking credentials that effectively represent their organisation or service and to enable the visualization of issuer and verifier with logo and name. This guide provides all necessary information to prepare from the start the appropriate graphic assets and determine the suitable settings.

The instruction is based on the OID metadata, which are defined in the [Swiss Profile](https://swiyu-admin-ch.github.io/specifications/interoperability-profile/).

## Purpose and Overview 

In the swiyu wallet app, verifiable credentials (VC) are visually represented as cards to allow users to easily recognise and utilise them. At the moment [^1] an issuer/verifier can define the following:

[^1]: the OCA layer allowing more options will be deployed at a later date in 2025

- the verfier's or issuer's name and logo
- the background color of the credential
- the logo/icon of the credential
- the name of the credential
- the displayed complementary info of the credential
- attributes of the credential

All these visibility or readability features are set and configured by the issuer/verifier in their metadata. 

Below is an example of how various credentials are displayed in different situations in the swiyu app.

[![credential](../../assets/images/vc_credential.png)](../../assets/images/vc_credential.png)
[![credential attributes](../../assets/images/vc_credential_attributes.png)](../../assets/images/vc_credential_attributes.png)


As an example we take this metadata (OID4VCI and OID4VP), and focus only on the relevant fields (technical fields are hidden):

```
"display": [
          {
            "name": "Issuer title",
            "locale": "de",
            "logo": {
              "uri": "data:image/png;base64,<...base64code....>
            }
          }
        ]
 
"credential_configurations_supported": {
          "test-sdjwt": {
 
 
           ....
 
 
 
            "display": [
              {
                "name": "Title of credential",
                "locale": "de-CH",
                "logo": {
                  "uri": "data:image/png;base64,<...base64code....>"
                },
                "description": "Demo purpose",
                "background_color": "#FF5733"
              }
        }
}

```
```
verifier_client_metadata.json: |
      {
        "client_id": "${CLIENT_ID}",
        "client_name#en": "Reference Demo Verifier",
        "client_name#fr": "Vérificateur de démonstration de référence",
        "client_name#de-DE": "Referenz-Demo-Verifizier",
        "client_name#de-CH": "Referänz-Demo-Verifizier",
        "client_name#de": "Referenz-Demo-Verifizierer (Fallback DE)",
        "client_name": "REF Demo Verifier (Base)",
        "logo_uri": "data:image/png;base64,<...base64code....>",
        "logo_uri#fr": "data:image/png;base64,<...base64code....>"
      }
```

## Multilanguage

```
"locale": "de"
```

All following definitions can be localised. The swiyu app supports the following languages: DE, FR, IT, EN, RM.

If none of these languages are given in the credential, the first definition of metadata is taken.


## Background Color

```
"background_color": "#FF5733"
```

The background color is a solid HEX color value (e.g., #FFFFFF, #000000, #FF5733, etc.)

Images are not supported.

No transparency/alpha channels are supported.

{% capture notice-text %}
**Readability** 

To ensure proper contrast and legibility of the information displayed on the card (such as the VC name, user name, and logo/icon), a gradient overlay is applied. This helps text and icons stand out clearly against the chosen background color, improving readability and overall user experience.

Furthermore, the swiyu app will automatically adjust the color of the information and logo to black or white, depending on the brightness or darkness of the defined color.

**Darkmode**

Although the swiyu app supports dark mode, the VC’s color scheme remains unaffected by this setting. Consequently, its background color stays the same in both light and dark modes.

**Demo-Watermark**

All the credentials which are issued within the swiyu Public Beta environment are applied with a DEMO watermark to differentiate those credentials to the productive ones.

{% endcapture %}

<div class="notice--info">
  <h3 class="no_toc">Good to know:</h3>
  {{ notice-text | markdownify }}
</div>

## Logo/Icon for Issuer & Verifier (Credential)

The logo or icon dimensions must not exceed 512×512 pixels and will be displayed at 24×24 pixels at any zoom level.

The logo or icon must be a transparent PNG (excluding the background). 

No alpha channels or transparency for solid elements. 

Multi-colored logos and gradients are automatically converted to a monochrome version to foster readability and ease of use. 

{% capture notice-text %}
**Downscaling**  

The logo/icon is automatically scaled down to a maximum size of 24×24 px. Extreme landscape or portrait logos/icons will be scaled such that the longest side is reduced to 24 px.

Recommendation:

- Use a square format whenever possible so it scales evenly across various layouts.
- Work with simplified icons/logos so they are readable even when small. 

**Plurilingualism**

The VC supports multilingual settings. This means the logo can be defined per language.
{% endcapture %}

<div class="notice--info">
  <h3 class="no_toc">Good to know:</h3>
  {{ notice-text | markdownify }}
</div>

### Credential Icons

```
"logo": {
           "uri": "data:image/png;base64,<...base64code....>"
        }
```

### Issuer Logo

The issuer's logo is part of the OID-Metadata and will be used for the credential offer screen and in the detail view of the credential.

[![issuer logo](../../assets/images/vc_issuer_logo.png)](../../assets/images/vc_issuer_logo.png)

```
"name": "Issuer title",
"logo": {
    "uri": "data:image/png;base64,<...base64code....>
}
```

### Verifier Logo

The verifier's logo will be use in the presentation request screen.

[![verifier logo](../../assets/images/vc_verifier_name_logo.png)](../../assets/images/vc_verifier_name_logo.png)

The logo is part of the OID4VP request:

```
verifier_client_metadata.json: |
      {
        "client_id": "${CLIENT_ID}",
        "client_name#en": "Reference Demo Verifier",
        "client_name#fr": "Vérificateur de démonstration de référence",
        "client_name#de-DE": "Referenz-Demo-Verifizier",
        "client_name#de-CH": "Referänz-Demo-Verifizier",
        "client_name#de": "Referenz-Demo-Verifizierer (Fallback DE)",
        "client_name": "REF Demo Verifier (Base)",
        "logo_uri": "data:image/png;base64,<...base64code....>",
        "logo_uri#fr": "data:image/png;base64,<...base64code....>"
      }
```

[![logo conversion](../../assets/images/vc_logo_conversion.png)](../../assets/images/vc_logo_conversion.png)
[![logo scaling](../../assets/images/vc_logo_scaling.png)](../../assets/images/vc_logo_scaling.png)

## Name

```
"name": "Title of credential"
```

Care to use a self-explanatory credential name that is of reasonable length. 

Think to set the various language versions of it so that name is displayed in the app language of the user. 

{% capture notice-text %}
If you issue a family of diverse credentials (like e.g. entry pass spa, entry pass fitness & spa) try to integrate the difference already in the name and/or the color so that it is easier for a user to distinguish them.
{% endcapture %}

<div class="notice--info">
  <h4 class="no_toc">Recommendation:</h4>
  {{ notice-text | markdownify }}
</div>


## Description

```
"description": "Demo purpose"
```

Carefully chose which metadata should come as complementary information on the overview right under the VC's name.

Keep metadata concise and relevant to avoid overwhelming the user with unnecessary information.

## Fallback Versions

If no assets (neither background color nor logo) are provided, a standard visual presentation is used.

Typically, this includes:

- A neutral pre-defined background
- A fallback logo/icon

{% capture notice-text %}
**Definition per language (localisation)**

Background color and/or icon can be set per language. This means that if a definition for a particular language is missing, the fallback will primary be the English version (if available) or another one provided. 
{% endcapture %}

<div class="notice--info">
  <h3 class="no_toc">Good to know:</h3>
  {{ notice-text | markdownify }}
</div>

## Order of claims

```
"credential_configurations_supported": {
			"order": [
              "firstName",
              "lastName",
              "..."
            ]
}
```

To manage the display-order in the credential, use the order array in the metadata.

## Useful hints

- Currently, the datasets or attributes are displayed in the credential detail view exactly as defined at the VC schema level. The ability to customise the ordering or grouping of these datasets will be available once the OCA layer is implemented.
- The OCA (information overlay) is planned to be deployed at a later date in 2025.
- Multilingualism: swiyu app currently supports 5 languages (German, French, Italian, Rumantsch, English)

## General questions

**What happens if I upload a multi-colored logo?**
The logo is automatically converted to a single-color (monochrome) version. It is not possible to preserve color nuances.

**Can I use an SVG for the logo?**
Only PNG files are currently supported. SVG or other vector formats are not accepted.

**Can I submit a logo larger than 512×512 pixels?**
For the swiyu app, no. The maximum supported size for logos/icons is 512×512 pixels. If the logo exceeds this size, it will be automatically resized.

**Can I use different background and logo colors for different languages?**
Yes. The system supports localization. You can define a background color and a logo/icon for each language.

**Can I use an image instead of a background color?**
No. To ensure contrast and legibility, images are not supported.

## Further assistance

Thank you for following these guidelines. By doing so, you help to ensure that your credentials are displayed correctly in the swiyu app and are easily recognisable to users. If you have any questions or require further assistance, please feel free to open an issue in this [GitHub repository](https://github.com/swiyu-admin-ch/swiyu-admin-ch.github.io).

