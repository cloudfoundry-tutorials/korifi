---
title: "Mostly Asked Questions"
description: "this is meta description"
draft: false
_build:
  render: never
  list: never
---


{{< faq "How does Korifi differ from traditional Cloud Foundry?" >}}
Korifi shares the same core goal of Cloud Foundry: to delight developers and operators with a highly efficient, modern model for cloud-native application delivery and management. However, Korifi is very different architecturally from traditional Cloud Foundry. 

Traditional Cloud Foundry is deployed via [BOSH](https://bosh.io), on virtual machines, using infrastructure-as-a-service providers like VMWare or AWS. The core components of conventional Cloud Foundry are implemented in custom code and run as processes on virtual machines.

Korifi is a new approach to implementing the Cloud Foundry APIs on Kubernetes. Most of the core Cloud Foundry components are replaced by implementations using Kubernetes native equivalents. Korifi leverages Kubernetes custom resources and role-based access control to implement the Cloud Foundry APIs, and whenever possible, Korifi uses existing Kubernetes ecosystem components.
{{</ faq >}}

{{< faq "What problems does Korifi solve for Kubernetes users?" >}}
Korifi’s purpose is to deliver an inherently higher-order abstraction over Kubernetes, ultimately enabling developers to focus on building applications. These higher-order abstractions bring automated containerization, networking, security, availability, and much more to Kubernetes. In short, Korifi significantly reduces the complexity of building, deploying, and managing applications on Kubernetes.
{{</ faq >}}

{{< faq "Is Korifi ready for production deployments?" >}}
Like so many things in tech, it depends. Korifi is still in active development and has yet to release a stable 1.0 version. It is a rapidly evolving open-source project. However, Korifi primarily leverages Kubernetes capabilities. When deployed to a production-ready instance of Kubernetes, it is possible to reap the benefits of Korifi in production. 

It is also important to note that Korifi supports a subset of the Cloud Foundry version 3 API. Therefore, the current feature set may or may not meet your needs. 

Ultimately, only you can determine if it is appropriate to run Korifi (or any software) in production. Therefore, we recommend understanding the current features, roadmap, and development cadence before committing to production deployments. 
{{</ faq >}}

{{< faq "How can I get started with Korifi?" >}}
The easiest way to start is to follow the guide above to install Korifi locally. You can also follow the [installation instructions](https://github.com/cloudfoundry/korifi/blob/main/INSTALL.md) on GitHub to install Korifi in another provider. 

As you continue with Korifi, we recommend joining the [Cloud Foundry Slack](https://slack.cloudfoundry.org) and joining the `korifi-dev` channel.
{{</ faq >}}

{{< faq "What does the name 'Korifi' mean?" >}}
Sticking with the Kubernetes approach of using Greek names, Korifi roughly translates to "mountaintop."
{{</ faq >}}

{{< faq "What's next for Korifi?" >}}
Korifi will continue with active development, implementing more Cloud Foundry API endpoints and bringing new features and capabilities to Kubernetes. The team has laid out their [vision for CF on Kubernetes](https://docs.google.com/document/d/1rG814raI5UfGUsF_Ycrr8hKQMo1RH9TRMxuvkgHSdLg/edit), guiding the development efforts.
{{</ faq >}}
