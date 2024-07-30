# Kind ArgoCD

This repository contains scripts and configuration files to set up a test cluster using Kind and deploy ArgoCD.

## Prerequisites

Before getting started, make sure you have the following prerequisites installed:

- Docker
- Kind
- kubectl
- Helm

## Getting Started

To create the test cluster and deploy ArgoCD, follow these steps:

```bash
make create-cluster
```

This Makefile target is responsible for creating a test cluster, deploying the Ingress-Nginx controller, adding the Argo CD Helm repository, updating dependencies, and installing the Argo CD chart onto the cluster.

That's it! Now you can start and stop the test cluster as needed. Happy coding!

## Usage

For more advanced usage and customization, you can refer to the [argocd-root-basics](https://github.com/mazelab/argocd-root-basics.git) repository as an example.

### Useful tasks

```bash
make recreate-cluster
```

Running this command will recreate the test cluster, ensuring a fresh setup for further testing and deployment.

```bash
make get-initial-argo-password
```

Getting the Initial ArgoCD admin Password

```bash
make reinstall-argocd
```

Reinstall ArgoCD. Useful if you unintentionally delete the ArgoCD part.

```bash
make start
```

Starts the kind docker container.

```bash
make stop
```

Stops the running kind cluster without deletion.

```bash
make clean
````

Warning, this is a destructive action. It will delete the cluster container.
