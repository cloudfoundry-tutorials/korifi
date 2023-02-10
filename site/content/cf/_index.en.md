---
title: "Korifi for CF Users"
date: 2018-12-28T11:02:05+06:00
iconifyicon: "cloudfoundry"
description: "Are you a Cloud Foundry user? Learn how Korifi extends Kubernetes to bring a Cloud Foundry-like experience to the industry-leading container orchestration platform."
# type dont remove or customize
type : "docs"
weight: 4
---

If you are an existing Cloud Foundry user, your experience with Korifi will be pretty familiar. However, the underlying implementations of the Cloud Foundry API are quite different. This section focuses on the underlying Kubernetes representations of common Cloud Foundry constructs.

Additionally, Korifi only supports a subset of the [Cloud Foundry API](http://v3-apidocs.cloudfoundry.org/version/3.131.0/index.html). The currently supported endpoints are documented in the [Korifi API](https://github.com/cloudfoundry/korifi/blob/main/docs/api.md) documentation.

##### How are orgs, spaces, and roles implemented?

Orgs and spaces are implemented using [namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/). Roles are implemented using [Kubernetes RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/).

Orgs and spaces will each have their own corresponding namespace. The name corresponds to the GUID of the org/space.

```
kubectl get namespaces

NAME                                            STATUS   AGE
...                                             Active   47h
cf-org-d255d9f0-962e-4122-bd6a-422110b15e0d     Active   23h
cf-space-0eee9ef7-ff1e-4a80-842f-a53179768b6f   Active   23h
...
```

Fetching the GUID for the org:

```
cf org --guid tutorial

cf-org-d255d9f0-962e-4122-bd6a-422110b15e0d
```

Fetching the GUID for the space:

```
cf space --guid dev

cf-space-0eee9ef7-ff1e-4a80-842f-a53179768b6f
```

Roles are mapped to a RoleBinding of a ClusterRole object:

```
kubectl get rolebindings -n cf-space-0eee9ef7-ff1e-4a80-842f-a53179768b6f
NAME                                                                  ROLE                                             AGE
cf-8d87de46bc2d38fe0c96aa24cd3191d7d4528ca101b07ecbd9d3ef3fecb53de5   ClusterRole/korifi-controllers-space-developer   23h
cf-dc43e0e171a16401f2a495e6d38f32434a2958dd430aa6ffe792d2491e4a361e   ClusterRole/korifi-controllers-space-manager     23h
default-admin-binding                                                 ClusterRole/korifi-controllers-admin             23h
```

##### What does an app look like?

Application instances are [pods](https://kubernetes.io/docs/concepts/workloads/pods/) in a [namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) corresponding to the space. `CFApp` is a [custom resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) definition.

To view this information using `kubectl`, you must first fetch the space GUID to determine the namespace name.

```
cf space --guid dev

cf-space-0eee9ef7-ff1e-4a80-842f-a53179768b6f
```

You can then use `kubectl` to view the details. For example, in the below block, there is one pod for each instance (two are running). And the pod marked "Completed" was used during staging.

```
kubectl get pods -n cf-space-0eee9ef7-ff1e-4a80-842f-a53179768b6f

NAME                                                     READY   STATUS      RESTARTS   AGE
d60fe7b7-f080-4caa-a26b-b811c88d766e-cf--cbc52994d8-0    1/1     Running     0          17h
d60fe7b7-f080-4caa-a26b-b811c88d766e-cf--cbc52994d8-1    1/1     Running     0          16h
ef3d386d-1cea-46bf-8191-fedcedba8532-build-1-build-pod   0/1     Completed   0          17h
```

To view the custom resource:

```
kubectl get cfapp -n cf-space-0eee9ef7-ff1e-4a80-842f-a53179768b6f

NAME                                   DISPLAY NAME   AGE
d60fe7b7-f080-4caa-a26b-b811c88d766e   sample-app     17h
```

There are plenty of other resources to dive into, should you choose. However, if you are a Cloud Foundry user, you likely don't care too much about the underlying implementations. Happy pushing!