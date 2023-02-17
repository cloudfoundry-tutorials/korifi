---
title: "Installing Korifi locally"
icon: "fas fa-laptop-code" 
description: "Korifi is lightweight and easy to deploy. Experience the power and simplicity of Korifi by installing it locally on Kubernetes using Kind."
# type dont remove or customize
type : "docs"
weight: 2 
---

In this exercise, you will install Korifi locally on [kind](https://kind.sigs.k8s.io) using a locally deployed container registry. To install Korifi on another Kubernetes provider, see the [installation documentation](https://github.com/cloudfoundry/korifi/blob/main/INSTALL.md) in GitHub.

## Prerequisites

You will need the following prerequisites to use Korifi locally. If you are a Kubernetes user, you likely already have most of these tools installed.

Follow the instructions below to install the prerequisites.

* [Docker Desktop](https://docs.docker.com/desktop/): Kind uses Docker to run Kubernetes container nodes. Install Docker Desktop according to the instructions.

* [kind](https://kind.sigs.k8s.io/docs/user/quick-start#installation): kind is a tool for running local Kubernetes clusters using Docker container “nodes”. Install kind by following the directions. You only need to install `kind`; you do not need to create a cluster yet.

* [Helm](https://helm.sh/docs/intro/install/): Helm is a package manager for Kubernetes. Helm is used to install Korifi on a Kubernetes cluster. Install Helm according to the instructions.

* [kubectl](https://kubernetes.io/docs/tasks/tools/): kubectl is the the Kubernetes command-line tool, allowing you to run commands against Kubernetes clusters. Install `kubectl` according to the instructions.

* [cf](https://github.com/cloudfoundry/cli/wiki/V8-CLI-Installation-Guide): cf is the Cloud Foundry command-line tool. Install the latest version of the Cloud Foundry CLI according to the instructions.

* [kbld](https://carvel.dev/kbld/): kbld builds and copies the required docker images to the local registry. Install the latest version of kbld according to the instructions.

## Installation Overview

The Korifi development team maintains an installation script to install Korifi locally. It installs the Kubernetes ecosystem dependencies outlined below and a local container registry. We will use this script to install Korifi. If you prefer, you can follow the [installation instructions](https://github.com/cloudfoundry/korifi/blob/main/INSTALL.kind.md) on GitHub to install Korifi manually.

The install script does the following before installing Korifi:

- Creates a [kind](https://kind.sigs.k8s.io) cluster with the correct port mappings for Korifi and other components.
- Deploys a local Docker registry using the [twuni helm chart](https://github.com/twuni/docker-registry.helm).
- Creates an admin user for Cloud Foundry.
- Installs [cert-manager](https://github.com/cert-manager/cert-manager). cert-manager is used to create and manage internal certificates within the cluster.
- Installs [kpack](https://github.com/pivotal/kpack). kpack is used to build runnable applications from source code using [Cloud Native Buildpacks](https://buildpacks.io/).
- Installs [contour](https://projectcontour.io). Contour is the ingress controller for Korifi.
- Installs the [service binding runtime](https://github.com/servicebinding/runtime) which is an implementation of the [service binding spec](https://servicebinding.io/).
- Install the [metrics server](https://github.com/kubernetes-sigs/metrics-server)

## Installing Korifi

While you can install all of the above manually, it is far easier to use the `deploy-on-kind.sh` script in the Korifi repository. 

> Please note the Korifi development team uses this script for local development. It is not intended for production use. At times the script may change or break.

To install Korifi:

- Clone the Korifi repository locally: `git clone https://github.com/cloudfoundry/korifi`
- Change to the `scripts` directory: `cd korifi/scripts`
- Install Korifi using the `deploy-on-kind.sh` script: `./deploy-on-kind.sh korifi`
  
  > Note, the name 'korifi' above is the name of the cluster created in kind. You can use any name you would like.

## Deploying an Application

We have provided a sample application you can deploy to your Korifi instance. However, before deploying, we need to set up our Cloud Foundry instance a bit by doing the following:

- Target the Cloud Foundry instance: `cf api login --skip-ssl-validation`
- Authenticate: `cf auth cf-admin`
- Create an [Org](https://docs.cloudfoundry.org/concepts/roles.html#orgs): `cf create-org tutorial`
- Create a [Space](https://docs.cloudfoundry.org/concepts/roles.html#spaces): `cf create-space -o tutorial dev`
- Target the Org and Space you created: `cf target -o tutorial -s dev`

Now you are ready to deploy the application:

- Clone the sample application: `git clone https://github.com/cloudfoundry-tutorials/korifi-sample-app.git`
- Change the application directory: `cd korifi-sample-app`
- Deploy the application: `cf push`

At a high level, the following happens:

- The `cf` command line interface uploads the application bits
- Korifi uses [kpack](https://github.com/pivotal/kpack) and [Paketo buildpacks](https://paketo.io) to build a container image for the application
- The container image is stored in the local Docker registry
- The container image is deployed to Kubernetes
- Ingress traffic will be mapped to the application using [Contour](https://projectcontour.io)

You will see an output that ends with something similar to the following. If you copy the route, you should be able to open the application in a browser.

```
requested state:   started
routes:            sample-app.apps-127-0-0-1.nip.io
last uploaded:     Thu 09 Feb 11:02:52 MST 2023
stack:             io.buildpacks.stacks.bionic
buildpacks:        

type:            web
sidecars:        
instances:       1/1
memory usage:    32M
start command:   sh "/workspace/start.sh"
     state     since                  cpu    memory   disk     logging      details
#0   running   2023-02-09T18:03:43Z   0.0%   0 of 0   0 of 0   0/s of 0/s   
```

In the next section, we will look at Korifi and the deployed application using `kubectl`.




