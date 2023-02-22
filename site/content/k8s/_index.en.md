---
title: "Korifi for K8s Users"
date: 2018-12-28T11:02:05+06:00
iconifyicon: "kubernetes"
description: "Are you already a Kubernetes user? Learn how Korifi can simplify the deployment and management of applications on Kubernetes."
type : "docs"
weight: 3
---

As we have stated, Korifi is an implementation on top of Kubernetes. Because of this, you can view Korifi resources either at the higher level (application-centric) abstraction using the `cf` CLI or at the lower level (container-centric) using `kubectl`. However, because the use of `kubectl` is not required to use Korifi, we will not go in-depth on the use of `kubectl` with Korifi elements.

## Korifi with kubectl

You can use `kubectl` to view and interact with the underlying Korifi components. However, `kubectl` is optional as the entire lifecycle of applications can be managed using the `cf` CLI. However, we will touch on the basics below. We leave the detailed investigation to you should you choose to embark on it.

##### Namespaces

The Korifi installation creates multiple namespaces. You can view the namespaces created by Korifi (denoted below with a "*").

```
kubectl get namespaces

cert-manager*                                    Active   25h
cf*                                              Active   25h
cf-org-d255d9f0-962e-4122-bd6a-422110b15e0d*     Active   117m
cf-space-0eee9ef7-ff1e-4a80-842f-a53179768b6f*   Active   116m
default                                          Active   25h
korifi*                                          Active   25h
kpack*                                           Active   25h
kube-node-lease                                  Active   25h
kube-public                                      Active   25h
kube-system                                      Active   25h
local-path-storage                               Active   25h
projectcontour*                                  Active   25h
servicebinding-system*                           Active   25h
```

##### Application Pods

Of note are the namespaces starting with `cf-org-*` and `cf-space-*`. These correspond to the org and space created after the installation. Applications are deployed to a space. Therefore, you can view your application pods in the namespace corresponding to your space:

```
kubectl get pods -n cf-space-0eee9ef7-ff1e-4a80-842f-a53179768b6f

NAME                                                     READY   STATUS      RESTARTS   AGE
d60fe7b7-f080-4caa-a26b-b811c88d766e-cf--cbc52994d8-1    1/1     Running     0          16h
ef3d386d-1cea-46bf-8191-fedcedba8532-build-1-build-pod   0/1     Completed   0          17h
```

The pod marked "Completed" was used during your application's build process (called staging).

##### Custom Resources

As discussed earlier, Korifi uses custom resource definitions to implement Cloud Foundry constructs. You can view the list of custom resources created by Korifi.

```
kubectl api-resources | grep korifi

appworkloads          korifi.cloudfoundry.org/v1alpha1       true         AppWorkload
builderinfos          korifi.cloudfoundry.org/v1alpha1       true         BuilderInfo
buildworkloads        korifi.cloudfoundry.org/v1alpha1       true         BuildWorkload
cfapps                korifi.cloudfoundry.org/v1alpha1       true         CFApp
cfbuilds              korifi.cloudfoundry.org/v1alpha1       true         CFBuild
cfdomains             korifi.cloudfoundry.org/v1alpha1       true         CFDomain
cforgs                korifi.cloudfoundry.org/v1alpha1       true         CFOrg
cfpackages            korifi.cloudfoundry.org/v1alpha1       true         CFPackage
cfprocesses           korifi.cloudfoundry.org/v1alpha1       true         CFProcess
cfroutes              korifi.cloudfoundry.org/v1alpha1       true         CFRoute
cfservicebindings     korifi.cloudfoundry.org/v1alpha1       true         CFServiceBinding
cfserviceinstances    korifi.cloudfoundry.org/v1alpha1       true         CFServiceInstance
cfspaces              korifi.cloudfoundry.org/v1alpha1       true         CFSpace
cftasks               korifi.cloudfoundry.org/v1alpha1       true         CFTask
taskworkloads         korifi.cloudfoundry.org/v1alpha1       true         TaskWorkload
```

You can explore these resources using `kubectl` or view the representations defined in the [Korifi API](https://github.com/cloudfoundry/korifi/blob/main/docs/api.md).

## How do I...?

In Korifi, the primary unit of focus is the application. An application is a higher-level abstraction than a container. Korifi allows developers to work at the higher level but still drop down to the lower level abstraction if need be. Below, we answer common questions from Kubernetes users.

##### How do I run a container image?

With Korifi, you do not need to bring a container image. Instead, you bring your application code (uploaded during the `cf push`). Korifi will use [kpack](https://github.com/pivotal/kpack) and [Paketo](https://paketo.io) buildpacks to construct an [OCI](https://opencontainers.org/about/overview/) compatible container image for your application.

Paketo is an implementation of [Cloud Native Buildpacks](https://buildpacks.io), an easier, more streamlined, secure, and repeatable way to build container images. Cloud Native Buildpacks are part of the [Cloud Native Computing Foundation](https://cncf.io) and are supported by all major cloud providers. So while Korifi ships with the Paketo implementation, you can use other provider implementations as well.

##### How do I check on my pods?

With Korifi, applications run in pods. You do not need to create pods yourself. However, you can still run non-cf pods in the same Kubernetes instance.

An application is a higher-level construct in Korifi. Therefore you can check on your applications using the `cf` CLI. For example, you can see your apps (in an org and space) by running `cf apps`. If you deployed the sample application, you would see a list of your applications similar to:

```
Getting apps in org tutorial / space dev as cf-admin...

name         requested state   processes   routes
sample-app   started           web:1/1     sample-app.apps-127-0-0-1.nip.io
```

You can also see more details about your app with `cf app <APP_NAME>`:

```
cf app sample-app
Showing health and status for app sample-app in org tutorial / space dev as cf-admin...

name:              sample-app
requested state:   started
routes:            sample-app.apps-127-0-0-1.nip.io
last uploaded:     Thu 09 Feb 16:34:02 MST 2023
stack:             io.buildpacks.stacks.bionic
buildpacks:

type:           web
sidecars:
instances:      1/1
memory usage:   32M
     state     since                  cpu    memory         disk       logging      details
#0   running   2023-02-10T00:23:19Z   0.0%   22.1M of 32M   0 of 64M   0/s of 0/s
```

The depths of the [Cloud Foundry API](https://github.com/cloudfoundry/korifi/blob/main/docs/api.md) are outside the scope of this tutorial. However, we recommend you peruse the documentation and the features in the `cf` CLI. You will notice that you have access to all the same Kubernetes primitives and the higher-level resource definitions.

##### How do I configure my application to handle more traffic?

In Korifi, you can scale your application using `cf scale` to add instances (horizontal scale) or memory (vertical scale). Korifi will handle the rest. You do not need to update any other configuration.

##### How do I allow traffic into my application?

By default, applications are deployed with an assigned route. This route is used to access the application. Korifi manages the ingress routing for you. You can also deploy applications without a route if ingress is not required.

##### How do I create a load balancer between pods?

You don't need to. Instead, as you add (or remove) instances with the `cf scale` command, Korifi handles this for you.

##### How do I restart apps/pods/containers?

You likely won't need to in most cases. However, if you want to, you can use the `cf start`, `cf stop`, and `cf restart` commands.

##### How to update the application to a new version?

You can simply re-run the `cf push` command when you have a new version of your application.

##### How can I create isolation between projects?

You can use the Cloud Foundry constructs of [Orgs](https://docs.cloudfoundry.org/concepts/roles.html#orgs) and [Spaces](https://docs.cloudfoundry.org/concepts/roles.html#spaces). Orgs and spaces are implemented using namespaces in Korifi. Users are assigned [Cloud Foundry roles](https://docs.cloudfoundry.org/concepts/roles.html#roles) in orgs and spaces to control access using Kubernetes [RBAC](). Using the Korifi constructs is far simpler than directly managing namespaces and Kubernetes RBAC.
