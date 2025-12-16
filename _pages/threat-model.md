---
title: Threat Model
permalink: /threat-model/
collection: threat-model
entries_layout: grid
classes: wide
---


# Introduction

Threat modeling is a systematic approach used to identify, understand, and mitigate potential security threats to a system before they can be exploited. By anticipating possible attack vectors, organizations can design more secure systems, prioritize resources effectively, and reduce the risk of security breaches.

Having a threat model early in the development or design process allows teams to implement targeted safeguards rather than relying on reactive fixes after a vulnerability is discovered. The purpose of threat modeling extends beyond just finding weaknesses. It fosters a security mindset among developers, architects, and stakeholders, encouraging collaboration and informed decision-making.

Our threat model has multiple purposes:

- Consider the system context, and understand what it does, how it does it and why
- Apply an adversarial perspective to the system we are building
- Understand and justify the security need and the measures needed to protect a system
- Identify threats to the system as early as possible (shift left)
- Identify threats that are/can be exploited by linking threats to our found vulnerabilities
- Mitigate threats actively by defining and implementing countermeasures
- Give a structured overview over the most critical risks and state of our system to our system for business to take future decisions
- Search for better countermeasures (if e.g. many vulnerabilities occur)
- Prioritize features/countermeasures depending on the risk of the underling threat

# Scope

In the context of security, a threat is anything that has the potential to cause harm to a system, asset, or organization. Threats can come from many sources—such as hackers, malware, natural disasters, or even human error—and they exploit vulnerabilities to compromise confidentiality, integrity, or availability. In this threat model we focus on human threat sources, and threat actors who for one reason or another seek to harm the trust infrastructure. Threats like natural disasters are defined in the upcoming incidence response plan.

The threat model concerns all components inside the Trust Infrastructure. Specific credentials (like: e-ID, mDL, eLFA, ...) are built on top of our Trust Infrastructure and are therefore not part of this threat model.
There is one exception: All code inside the wallet concerns the overall security of the wallet and is therefore in scope of this threat model. This means that also the parts specifically built for the e-ID inside the wallet are part of this threat model. 
The support process including the non-conformity process (later both denoted by "Support") are also included. Level 1 support is always in scope where Level 2 and 3 are only in scope when the problem concerns the trust infrastructure. Support for specific credentials (e-ID, eLFA, mDL, ...) are not in scope anymore starting from Level 2 support.

# STRIDE Framework

STRIDE is a widely used framework for categorizing different types of security threats. It helps teams systematically identify potential threats during the threat modeling process. The acronym STRIDE stands for six key threat categories:

- *S*poofing: Pretending to be someone or something else to gain unauthorized access.
- *T*ampering: Altering data or code to cause harm.
- *R*epudiation: Denying an action or transaction, making it hard to prove accountability.
- *I*nformation Disclosure: Exposing sensitive information to unauthorized parties.
- *D*enial of Service: Disrupting system availability to legitimate users.
- *E*levation of Privilege: Gaining higher access rights than allowed.

# See Threats by Component
