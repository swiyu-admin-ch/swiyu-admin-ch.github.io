---
title: "Announcement of the change dossiers"
categories:
  - PublicBeta
---
# Why we're introducing Change Dossiers

The swiyu Trust Infrastructure is a living ecosystem. As we continue to harden the protocol, close security gaps, and evolve the trust model, we will from time to time need to make changes that affect how generic Issuers, generic Verifiers, Wallet providers, and other integrators interact with the infrastructure. Some of these changes will be additive and safe. Others, by necessity, will be breaking.

To make these changes transparent, predictable, and manageable for everyone building on swiyu, we are introducing [Change Dossiers (CD)](https://swiyu-admin-ch.github.io/change-dossiers/): standardized announcements published to the ecosystem whenever a change to the Trust Infrastructure requires action on the part of integrators.

Each Change Dossier will clearly state:

* **What is changing** and why
* **Which components** are affected (DID Resolver, generic Issuer, generic Verifier, Wallet, Status Registry, Trust Registry, etc.)
* **What action is required**, and from whom
* **The migration steps** to follow
* **The timeline**, including key dates

# Our approach: Expand, Migrate, Contract

Wherever technically possible, changes to the Trust Infrastructure will follow the **EMC pattern (Expand, Migrate, Contract)**:

1. **Expand** the new behavior, field, endpoint, or capability is introduced alongside the existing one. Nothing is removed yet, and existing integrations continue to work unchanged.
2. **Migrate** the ecosystem is given a defined window to adopt the new behavior. This is the phase **Change Dossiers** are published for, and where we provide guidance, migration steps, and support.
3. **Contract** once the migration window has passed, the old behavior is retired.

This pattern lets us evolve the Trust Infrastructure without forcing integrators into rushed, unplanned rework, and lets us run our own contracting work without breaking the ecosystem out from under anyone.

# Timelines: three months, by default

For changes of meaningful scope, anything that requires integrators to adapt their implementation, our standard commitment is to give the swiyu ecosystem **at least three months** between the publication of a **Change Dossier** and the point at which the old behavior is contracted (retired). This is intended to give teams enough time to plan, implement, test, and roll out their migration in a controlled way, rather than reacting under time pressure.

# The exception: critical security vulnerabilities

There is one deliberate exception to this rule: critical security vulnerabilities. If we identify a vulnerability in the Trust Infrastructure that poses a serious risk to the ecosystem, we will not wait three months to fix it. In such cases:

* A fix may need to be deployed on a significantly shorter timeline.
* The fix may, in some cases, be breaking, because the risk of leaving a critical vulnerability open outweighs the cost of a shortened migration window.
* We will still use a **Change Dossier** to communicate the change as clearly and as early as circumstances allow, but the standard three-month notice period does not apply.

We don't take this exception lightly, and we'll continue to give as much notice as the security situation reasonably allows, but the safety of the ecosystem as a whole takes priority over migration convenience in these cases.

# What this means for you

Watch for **Change Dossiers** on this site, each one will tell you exactly what's changing, whether it affects your component(s), and what to do about it.
For standard (non-security) breaking changes, you can expect a minimum three-month runway from publication to the change taking effect.
For critical security fixes, please treat **Change Dossiers** as high priority and act promptly, even if the usual migration timeline doesn't apply.

We believe this approach gives the swiyu ecosystem the transparency and predictability it needs, while still allowing us to keep the Trust Infrastructure secure and moving forward.

