---
title: Designing the visualization for Issuer, Verifier and Credential
toc: true
toc_sticky: true
excerpt: Learn how to define the visual layout for issuer, verifier and credentials with OCA
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

This manual describes how to define the visual presentation of a Verifiable Credential (VC) displayed in the swiyu App, the digital wallet of the Swiss Confederation.

Its goal is to enable issuers in creating clean, professional looking credentials that effectively represent their organisation or service. This guide provides all necessary information to prepare from the start the appropriate graphic assets and deterimine the suitable settings. 

The instruction is based on the credential visualisation with OID Credential Issuer Metadata and Overlays Capture Architecture (OCA), which are defined in the [Swiss Profiles].

## Purpose and Overview 

In the swiyu wallet app, Verifiable Credentials (VC) are visually represented as cards to allow users to easily recognise and utilise them.  According to the implemented credential visualisation metadata, an issuer/verifier can define the following:

- the verifier's or issuer's name and logo
- the background colour of the credential
- the logo of the credential
- the name of the credential
- the displayed complementary info of the credential (description)
- the attributes of the credential
- the clustering and ordering of the the credential's attributes

All these visible or readible features are set and configured by the issuer/verifier in it's Credential Issuer Metadata and/or OCA Bundle. 

Below is an example of how various credentials are displayed in different situations in the swiyu app.  

[![credential preview and detail](../../assets/images/vc_credential-preview-detail.png)](../../assets/images/vc_credential-preview-detail.png)

As an example we take this metadata (OID4VCI and OID4VP), and focus only on the relevant fields (technical fields are hidden):

```
credential_issuer_metadata.json: |
{
  ...

  "display": [
    {
      "name": "Issuer title",
      "locale": "en",
      "logo": {
        "uri": "data:image/png;base64,<...base64code....>"
      }
    }
  ],
  "credential_configurations_supported": {
    "demo-sdjwt": {
      "format": "vc+sd-jwt",
      
      ...
      
      "display": [
        {
          "name": "Title of credential",
          "locale": "en",
          "logo": {
            "uri": "data:image/png;base64,<...base64code....>"
          },
          "description": "Demo purpose",
          "background_color": "#FF5733"
        }
      ],
      "claims": {
        "given_name": {
          "value_type": "string",
          "display": [
            {
              "name": "Given name",
              "locale": "en"
            }
          ]
        },
        "family_name": {
          "value_type": "string",
          "display": [
            {
              "name": "Surname",
              "locale": "en"
            }
          ]
        }
      },
      "order": [
        "family_name",
        "given_name"
      ]
    }
  }
}
```

```
oca_bundle.json: |
{
  "capture_bases": [
    {
      "type": "spec/capture_base/1.0",
      "digest": "abc-123",
      "attributes": {
        "given_name": "Text",
        "family_name": "Text"
      }
    }
  ],
  "overlays": [
    {
      "type": "spec/overlays/meta/1.0",
      "capture_base": "abc-123",
      "language": "en",
      "name": "Title of credential",
      "description": "Demo purpose"
    },
    {
      "type": "spec/overlays/label/1.0",
      "capture_base": "abc-123",
      "language": "en",
      "attribute_labels": {
        "given_name": "Given name",
        "family_name": "Surname"
      }
    },
    {
      "type": "aries/overlays/branding/1.1",
      "capture_base": "abc-123",
      "language": "en",
      "theme": "light",
      "logo": "data:image/png;base64,<...base64code....>",
      "primary_background_color": "#FF5733",
      "primary_field": "Demo purpose for {{given_name}} {{family_name}}"
    }
  ]
}
```

```
verification_authorization_request.json: |
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
credential_issuer_metadata.json: |

"locale": "en-GB"
```

```
oca_bundle.json: |

"language": "en-GB"
```
```
verification_authorization_request.json: |
{
  "client_name#en-GB": "Reference Demo Verifier",
  "client_name": "REF Demo Verifier (Fallback)",
  "logo_uri#en-GB": "data:image/png;base64,<...base64code....>",
  "logo_uri": "data:image/png;base64,<...base64code....>"
}
```

All following definitions can be localed. The swiyu app supports the following languages: DE, FR, IT, RM, EN.

If none of the languages supported by the app are declared in the visualisation metadata, the app selects a suitable default locale based on the device settings and the general range of locales declared in the visualisation metadata.

{% capture notice-text %}

<b>Definition pro Language (Localisation)</b>
Background colour, logos, name and description can be set per language.

<b>Locale region</b>
Be aware that the app preferred language selection mechanism tries to exactly match the locale. A language with additional region information like "de-CH" will not be the same language as just "de".

It is recommended to always use region information when declaring visualisation metadata.

{% endcapture %}

<div class="notice--info">
  <h3 class="no_toc">Good to know:</h3>
  {{ notice-text | markdownify }}
</div>

## Background Color

```
credential_issuer_metadata.json: |
{
  ...

  "credential_configurations_supported": {
    "demo-sdjwt": {
	  ...
      "display": [
        {
          ...
          "background_color": "#FF5733"
        }
      ]
    }
  }
}
```

```
oca_bundle.json: |
{
  ...

  "overlays": [
    {
      "type": "aries/overlays/branding/1.1",
      ...
      "primary_background_color": "#FF5733"
    }
  ]
}
```

The background color is a solid HEX color value (e.g., #FFFFFF, #000000, #FF5733, etc.)

Images are not supported.

No transparency/alpha channels are supported.

{% capture notice-text %}
**Readability** 

To ensure proper contrast and legibility of the information displayed on the card (such as the VC name, description, and logo/icon), a gradient overlay is applied. This helps text and icons stand out clearly against the chosen background colour, improving readability and overall user experience.

Furthermore, the swiyu app will automatically adjust the colour of the text and the logo to black or white, depending on the brightness or darkness of the defined colour.

**Darkmode**

Although the swiyu app supports dark mode, the VC’s color scheme remains unaffected by this setting. Consequently, its background color stays the same in both light and dark modes.

**Demo-Watermark**

All the credentials which are issued within the swiyu Public Beta environment are applied with a DEMO watermark to differentiate those credentials to the productive ones.

{% endcapture %}

<div class="notice--info">
  <h3 class="no_toc">Good to know:</h3>
  {{ notice-text | markdownify }}
</div>

## Logo/Icon for Issuer, Verifier & Credential

The logo or icon dimensions must not exceed 512×512 pixels and will be displayed at 24×24 pixels at any zoom level.

The logo or icon must be a transparent PNG (excluding the background). 

No alpha channels or transparency for solid elements. 

The Logo must be provided as image data URL, https URL are not supported.

Multi-colored logos and gradients are automatically converted to a monochrome version to foster readability and ease of use. 

The swiyu app will automatically tint the logo to black or white, depending on the brightness or darkness of the background colour.

[![logo conversion](../../assets/images/vc_logo_conversion.png)](../../assets/images/vc_logo_conversion.png)
[![logo scaling](../../assets/images/vc_logo_scaling.png)](../../assets/images/vc_logo_scaling.png)

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

### Credential Logo

```
credential_issuer_metadata.json: |
{
  ...

  "credential_configurations_supported": {
    "demo-sdjwt": {
      ...
      "display": [
        {
          ...
          "logo": {
            "uri": "data:image/png;base64,<...base64code....>"
          }
        }
      ]
    }
  }
}
```

```
oca_bundle.json: |
{
  ...

  "overlays": [
    {
      "type": "aries/overlays/branding/1.1",
      ...
      "logo": "data:image/png;base64,<...base64code....>"
    }
  ]
}
```

### Issuer Logo

The issuer's logo is part of the OID Credential Issuer Metadata and will be used for the credential offer screen and in the detail view of the credential.

[![issuer logo](../../assets/images/vc_issuer_logo.png)](../../assets/images/vc_issuer_logo.png)

```
credential_issuer_metadata.json: |
{
  ...

  "display": [
    {
      ...

      "logo": {
        "uri": "data:image/png;base64,<...base64code....>"
      }
    }
  ]
}
```

### Verifier Logo

The verifier's logo is only part of the OID4VP Authorization Request and will be used in the presentation request screen.

[![verifier logo](../../assets/images/vc_verifier_name_logo.png)](../../assets/images/vc_verifier_name_logo.png)

```
verification_authorization_request.json: |
{
  "client_id": "${CLIENT_ID}",
  ...
  "logo_uri": "data:image/png;base64,<...base64code....>"
}
```



## Name

Care to use a self-explanatory credential name that is of reasonable length. 

Think to set the various language versions of it so that name is displayed in the app language of the user. 

{% capture notice-text %}
If you issue a family of diverse credentials (like e.g. entry pass spa, entry pass fitness & spa) try to integrate the difference already in the name and/or the color so that it is easier for a user to distinguish them.

[![name](../../assets/images/oca-name.png)](../../assets/images/oca-nameo.png)


{% endcapture %}

<div class="notice--info">
  <h4 class="no_toc">Recommendation:</h4>
  {{ notice-text | markdownify }}
</div>

### Credential Name

```
credential_issuer_metadata.json: |
{
  ...

  "credential_configurations_supported": {
    "demo-sdjwt": {
      ...
      "display": [
        {
          ...
          "name": "Title of credential"
        }
      ]
    }
  }
}
```

```
oca_bundle.json: |
{
  ...

  "overlays": [
    {
      "type": "spec/overlays/meta/1.0",
      ...
      "name": "Title of credential"
    }
  ]
}
```

### Issuer Name
The issuer's name is only part of the OID Credential Issuer Metadata and will be used for the credential offer screen and in the detail view of the credential.

```
credential_issuer_metadata.json: |
{
  ...

  "display": [
    {
      ...

      "name": "Issuer title"
    }
  ]
}
```

### Verifier Name
The verifier's name is only part of the OID4VP Authorization Request and will be use in the presentation request screen.

```
verification_authorization_request.json: |
{
  "client_id": "${CLIENT_ID}",
  ...
  "client_name": "Verifier title"
}
```

## Description

Carefully chose which metadata should come as complementary information on the overview right under the credential's name.

Keep metadata concise and relevant to avoid overwhelming the user with unnecessary information.

```
credential_issuer_metadata.json: |
{
  ...

  "credential_configurations_supported": {
    "demo-sdjwt": {
      "format": "vc+sd-jwt",
      
      ...
      
      "display": [
        {
          ...
          "description": "Demo purpose"
        }
      ]
    }
  }
}
```

```
oca_bundle.json: |
{
  ...

  "overlays": [
    {
      "type": "spec/overlays/meta/1.0",
      ...
      "description": "Demo purpose"
    },
    {
      "type": "aries/overlays/branding/1.1",
      ...
      "primary_field": "Demo purpose for {{given_name}} {{family_name}}"
    }
  ]
}
```
With an OCA Bundle, the description is taken in first priority from the Branding Overlay and if not declared, the description is used from the Meta Overlay.

{% capture notice-text %}
**Templating support**
The Branding Overlay's primary_field supports templating. The placeholders in double brackets get replaced by the attribute value of the credential. 
{% endcapture %}

<div class="notice--info">
  <h4 class="no_toc">Recommendation:</h4>
  {{ notice-text | markdownify }}
</div>

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

## Order of Attributes

The display-order of attributes for a credential will be applied in the credential offer screen, in the detail view of the credential and in the verification presentation request screen.

[![name](../../assets/images/oca-vc-ordering.png)](../../assets/images/oca-vc-ordering.png)


```
credential_issuer_metadata.json: |
{
  ...

  "credential_configurations_supported": {
    "demo-sdjwt": {
      "format": "vc+sd-jwt",
      
      ...
      
      "order": [
        "family_name",
        "given_name"
      ]
    }
  }
}
```
```
oca_bundle.json: |
{
  ...

  "overlays": [
    {
      "type": "extend/overlays/order/1.0",
      ...
      "attribute_orders": {
        "given_name": 2,
        "family_name": 1
      }
    }
  ]
}
```

## Clustering of Attributes

Clustering enables you to organise your attributes into groups. Within each cluster, you can use three headlines (H1, H2 and H3) to organise and categorise your attributes, making them easier for users to scan. Headline 1 for the cluster itself is optional, as are all other headlines.

[![name](../../assets/images/oca-vc-clustering.png)](../../assets/images/oca-vc-clustering.png)

Clustering can only be defined within an OCA Bundle by declaring Capture Bases. Headlines are taken from the respective OCA Label Overlay.

```
oca_bundle.json: |
{
  "capture_bases": [
    {
      "type": "spec/capture_base/1.0",
      "digest": "root",
      "attributes": {
        "basis": "refs:abc-123",
        "additional": "refs:xyz-789"
      }
    },
    {
      "type": "spec/capture_base/1.0",
      "digest": "abc-123",
      "attributes": {
        "given_name": "Text",
        "family_name": "Text"
      }
    },
    {
      "type": "spec/capture_base/1.0",
      "digest": "xyz-789",
      "attributes": {
        "birthday": "DateTime",
        "over_18": "Boolean"
      }
    }
  ],
  "overlays": [
    {
      "capture_base": "root",
      "type": "spec/overlays/label/1.0",
      "attribute_labels": {
        "basis": "Basis Data",
        "additional": "Additional Data"
      }
    },
    {
      "type": "extend/overlays/order/1.0",
      "capture_base": "root",
      "attribute_orders": {
        "basis": 1,
        "additional": 2
      }
    }
  ]
}
```
As an example, the above OCA Bundle defines two clusters, in the display-order "basis" first and second "additional", with each a H1 headline "Basis Data" and "Additional Data". Cluster "basis" contains the attributes "given_name" and "family_name" while cluster "additional" contains attributes "birthday" and "over_18".  

```
- basis
  - given_name
  - family_name
- additional
  - birthday
  - over_18
```

{% capture notice-text %}
**Default clustering**<br>
For Credential Issuer Metadata, a single cluster is displayed without a headline. This is the same as for an OCA Bundle, which declares a single Capture Base containing attributes not only of type Reference. 

**Single cluster with headline**<br>
A single cluster with a given headline is created by declaring a root Capture Base that contains a single Reference attribute pointing to another Capture Base that holds the attributes of this cluster. The H1 headline is taken from the Label Overlay corresponding to the root Capture Base.

**Subclusters and headlines H2-H3**<br>
Clusters can be nested. For example, a Capture Base "CB1" may contain an attribute of type Reference to another Capture Base "CB2". The cluster "CB2" is then a subcluster of the cluster "CB1" with the headline "H2". The swiyu app will display up to three levels; any further nested clusters will be displayed as if they were on level three.
{% endcapture %}

<div class="notice--info">
  <h3 class="no_toc">Good to know:</h3>
  {{ notice-text | markdownify }}
</div>

## Data Types

>> hier weiter

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

