# Introduction to Korifi

Korifi was born out of the need for internal development platforms to be built over Kubernetes. Korifi’s purpose is to deliver an inherently higher order abstraction over Kubernetes, ultimately enabling developers to focus on building applications. It is purpose-built to serve as a means to deploy and manage applications on Kubernetes while providing automated networking, security, availability, and much more. 

Korifi integrates into your DevOps toolchain with support for build, test, deploy, and monitoring stages. It includes Kubernetes-native tools such as Envoy and kpack, while also allowing teams to extend their existing CI/CD, logging, and observability tools. With Korifi, software engineering teams can establish a comprehensive Kubernetes strategy and adopt best practices across development, testing, and deployment phases.



## Origins: Discuss the problems Korifi is solving and the origin for the approach.
## CF on Bosh: Korifi and its relationship to Cloud Foundry on Bosh
## Approach: Reusing K8s ecosystem
## Roadmap: What is the current status and what does the future hold for Korifi.


Kubernetes co-inventor Craig McLuckie at the helm of the Cloud Foundry Foundation as the chairman of its board, it’s maybe no surprise that the organization is doubling down on this.



- Why?

 the open source Cloud Foundry project has established itself as the go-to platform as a service (PaaS) for many larger enterprises that want to offer their developers a language-agnostic developer experience that abstracts away most of the infrastructure concerns. 




- Korifi vs Bosh


He also said that the existing Cloud Foundry product isn’t going away and won’t get replaced by this new product, especially because while Cloud Foundry works great with Windows workloads, that’s not something the Kubernetes project, which comes out of the Linux world, ever focused on (though it’s worth noting that Kubernetes has also made some strides in supporting Windows workloads, too).

- Korifi vs other K8s distros

“As Kubernetes has matured, our community has built several Cloud Foundry abstractions to reduce Kubernetes complexities,” Chris Clark, Cloud Foundry’s program manager, said. “The proven Cloud Foundry developer experience already saves organizations millions of dollars by maximizing developer productivity. With Korifi, we’re building on a new architecture learned from previous iterations like cf-for-k8s and KubeCF. Korifi brings greater interoperability with cloud-native technologies, bringing the ease and simplicity of the Cloud Foundry app developer experience to Kubernetes.”

CF Korifi - "We envision a CF on K8s that provides the same convenient developer outcomes that CF delivers today via Bosh"

"At the same time, operation and administration of CF on K8s should conform to K8s practices and should converge with cloud-native approaches for providing the developer outcomes that CF addresses."









- How does it work?



- Capabilities & Roadmap

This also means the organization is still looking to see if Korifi will cover all of Cloud Foundry’s capabilities or if maybe a subset will be enough, depending on how developers will use the new platform. Both VMware and SAP, two of the largest vendors in the Cloud Foundry ecosystem, will also be integrating Korifi into their own Cloud Foundry solutions.
