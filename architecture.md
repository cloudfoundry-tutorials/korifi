# Korifi Architecture

McLuckie noted that this new project is the result of some deeper changes to how the Cloud Foundry Foundation operates. “With Project Korifi, we’ve really come together as a community and worked through a lot of the structures that we put in place to emulate what we learned worked well in the Kubernetes community,” McLuckie explained. “So [we] have a technical oversight committee and special interest group forums to work through design, ideation and execution and then produce something which works not just for one vendor — or which was one vendor’s thesis of what an ideal abstraction of [Cloud Foundry] on a Kubernetes destination would look like — but to pull the broader group together.”



- Vision for CF on K8s doc

Reimplementing CF api using CRDs, web hooks, rbac in place of bespoke CF components.
leverage more from K8s
leverage existing interfaces (contour vs )
Only implement when it doesn't exist
Allow users to chose between CF or K8s API depending on need

Korifi 
State using Custom Resources - no db
namespaces for orgs/spaces
authentication - standard K8s
cf cli uses local kubeconfig
pod selector labels for staging and running logs
k8s service binding interface
app specfic creds in secrets


CRDs
- CFApp
- CFPackage - image w/ application by GUID
- CFBuild - mem, disk, lifecycle info
- CFProcess - each process in the app manifest, instance count, mem quota, etc
- CFTask
- CFDomain
- CFRoute
- CFServiceInstance - UPSI only
- CFServiceBinding

Core resources
- Kpack - staging
  - Build
- secret
- Job
- Stateful Set
- Pod
- HttpProxy - Contour
- Service 
- Metric Server

Installing
- Helm


CRDs:  Use kubectl to view the resources
Apps: viewing pods
Tenancy: orgs, spaces, users
Reiterate dependency roles: contour, kpack, etc.