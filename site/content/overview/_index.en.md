---
title: "An Overview of the Korifi Project"
icon: "fas fa-list" 
description: "In this introductory section, learn how Korifi simplifies the deployment and management of applications on Kubernetes."
type : "docs"
weight: 1
---

Kubernetes alone does not provide a high-productivity development platform for building and running modern applications. Even as the cloud-native community addresses application platform concerns through related projects, it is still complicated to bring them together into a cohesive platform. Korifi's purpose is to deliver an **inherently higher-order abstraction over Kubernetes**, ultimately enabling developers to **focus on building applications and simplifying the operations process**.

The Cloud Foundry community is building Korifi to meet the need for internal development platforms on Kubernetes. It is purpose-built to serve as a means to deploy applications while providing **automated networking, security, availability, and much more**. The principal value of Cloud Foundry continues to be its **first-class, multi-tenant, self-service experience** for app developers, including not only running app workloads but also building and maintaining the app artifacts, exposing those apps to their end users, and provisioning and connecting dependencies (services) for those apps.

With Korifi, software engineering teams can establish a **comprehensive Kubernetes strategy** and adopt best practices across the development, testing, and deployment phases.

## Korifi vs. Cloud Foundry with BOSH

Korifi shares the same principal goal of Cloud Foundry: to delight developers and operators with a highly efficient, modern model for cloud-native application delivery and management. However, Korifi is very different architecturally from traditional Cloud Foundry.

Traditional Cloud Foundry is deployed via BOSH, on virtual machines, using infrastructure-as-a-service providers like VMWare or AWS. The core components of conventional Cloud Foundry are implemented in custom code and run as processes on virtual machines.

Korifi is a new approach to implementing the Cloud Foundry APIs on Kubernetes. Most of the core Cloud Foundry components have been replaced by implementations using Kubernetes native equivalents. Custom code implementation is a last resort.


## Approach

The Korifi project adopts an entirely new approach to implementing the proven capabilities of the Cloud Foundry API. As Korifi continues to grow and evolve, the intention is to continue embracing the best solutions the Kubernetes ecosystem offers. 

### Guiding Principles

The Korifi project is guided by the following principles: 

- Korifi should **integrate with projects and technologies from Kubernetes** and other cloud-native ecosystems as replacements for custom Cloud Foundry subsystems where these ecosystem projects have demonstrated widespread adoption and operational maturity. 

- Conversely, Korifi should **retain Cloud Foundry-specific concepts** where there is no clear or dominant replacement coming from cloud-native ecosystems but should prepare to replace them in the future. 

- The control plane components of Korifi should **interact with the subsystems through defined interfaces** that allows for introducing alternative technologies from other ecosystems.

- The community reference deployment (which you will install next) should be **optimized for initial, lightweight usage and experimentation**. 

- The default developer-facing behavior of Korifi should strive to **match that of Cloud Foundry today** while providing the ability to opt into different behavior using alternative subsystems.

- The Cloud Foundry API entities should have an analogous **representation in the Kubernetes API**, and Korifi should eventually allow users to manipulate either representation.

Through the rest of this material, we detail the Kubernetes ecosystem components currently in use and the custom resources defined by Korifi.

### Architectural Subsystems

From an architectural perspective, we want to retain the CF developer experience and developer-facing API but implemented in terms of operator-facing interfaces for the following subsystems (in priority order):

- **Networking and Connectivity**, including ingress routing, application service mesh, and network security policies
- **Identity, Authentication, and Authorization**, including CF user roles and resource ownership
- **Workload Orchestration**, including running CF app processes and tasks or the ability to schedule workloads on one or more separate Kubernetes clusters
- **Artifact Building**, including creating and updating app images and storing them in registries
- **Observability**, including app logging, monitoring, and request tracing
- **Service Marketplace**, including registering and exposing service plans to tenants, provisioning services, and binding them to workloads

Each of these interfaces will have one or more backing implementations, coming either from the Kubernetes ecosystem or the Cloud Foundry community.

### Cloud Foundry Capabilities

Korifi continues to support core Cloud Foundry capabilities:

- **Multi-cloud**: Korifi is deployed using [Helm](https://helm.sh) and supports multiple public and private cloud providers. Korifi is lightweight and can even run workloads at the edge.

- **Multi-tenant**:  Korifi utilizes Kubernetes [role-based access control](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) and [custom resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) definitions to mimic the robust Cloud Foundry paradigm of orgs, spaces, users and roles. Together, the two provide a foundation for multi-tenancy that is resilient and secure.

- **Any language, any framework**: Korifi preserves the classic Cloud Foundry experience of being able to deploy apps written in any language or framework with a single cf push command. It enhances the app developer experience by using [Paketo](https://paketo.io) buildpacks to build applications as OCI-compliant containers. App developers no longer have to wrangle with complex YAML or Dockerfiles for containerized deployments to Kubernetes.


## Roadmap

From the [Vision for CF on Kubernetes](https://docs.google.com/document/d/1rG814raI5UfGUsF_Ycrr8hKQMo1RH9TRMxuvkgHSdLg/edit) document:

> "We envision a Cloud Foundry on Kubernetes (CF on K8s) that provides the same convenient developer outcomes that Cloud Foundry delivers today via BOSH, and that enables these developers to migrate their workloads smoothly from their existing CF environments to CF on K8s. While an ideal outcome for current CF users would be to preserve complete compatibility with existing behavior and to provide a completely transparent migration of running app workloads within existing environments, we also see opportunities to deliver pragmatic solutions sooner at the expense of complete compatibility or transparency."

The Korifi project aims to bring the best developer and operator experiences to Kubernetes. The team continues to work hard implementing and evolving additional Cloud Foundry APIs.
