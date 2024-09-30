# Kubernetes Local Cluster with Kind, Terraform and Kftray Integration

## Overview

This is the project which I have created as an easy way to get a k8s cluster operated together with the automation part which is the use of [Kind (Kubernetes IN Docker)](https://kind.sigs.k8s.io/) and `Terraform` for the same purpose.

This project is different from the needed work of using Ingress, NodePort, or LoadBalancer to your services and instead it uses [Kftray](https://github.com/hcavarsan/kftray) as a port forward manager and auto-imports ports through the use of the auto-import feature to import the port forwarding by annotations in k8s services.

## Why?

Locally, Ingress controllers are not needed or the services being exposed with NodePort/LoadBalancer, since it will be an overhead and will make the situation mismanaged. In this set up, what happens is everything remains inside the cluster. That makes the whole environment more secure and simpler to manage.

## Getting Started

Before you begin, make sure you have these installed on your computer:

- [Docker](https://www.docker.com/get-started)
- [Terraform (v1.0.0 or later)](https://www.terraform.io/downloads.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/)
- [Kftray](https://github.com/hcavarsan/kftray) for managing port forwarding automatically

### 1. Terraform

To bootstrap all the k8s cluster stack, just clone this repository and run terrarform:

```bash
git clone https://github.com/hcavarsan/kind-kftray-example
cd kind-kftray-example/terraform
terraform init
terraform apply --auto-approve
```

### 2. Install Kftray

Access the [Kftray GitHub page](https://github.com/hcavarsan/kftray) and follow the installation instructions.

### 3. Import kubectl port forwards configurations

Kftray scans the services and finds the ports they need to connect. It then sets up the forwarding automatically.

So, once 'terraform apply' finishes, follow these steps:

1. Open Kftray and click the tray icon to open the main window.
2. Click the menu icon in the bottom left corner.
3. Select **"Auto Import"**.
4. Click **"Set kubeconfig"** and choose the kubeconfig file created by Terraform (like `~/.kube/kind-config-kftray-cluster`).
5. Select the right context (e.g., `kftray-cluster`) from the dropdown.
6. Click **"Import"** to load the port forwarding settings automatically.

After importing, you can start port forwarding by toggling the switch next to each service in Kftray or simply click **"Start All"** to forward everything at once.

### 4. Access Your Services

With Kftray handling the port forwarding, you can access your services easily at these URLs:

- **Argo CD:** [http://localhost:16080](http://localhost:16080)
- **Prometheus:** [http://localhost:19090](http://localhost:19090)
- **Grafana:** [http://localhost:13080](http://localhost:13080)
- **Jaeger:** [http://localhost:15090](http://localhost:15090)


## Customizing the cluster and kftray setting

### Cluster Settings

You can customize the cluster settings by editing the `variables.tf` file. For example, if you want to change the cluster name or Kubernetes version, just update file:

```hcl
variable "cluster_name" {
  description = "Name of the Kind cluster"
  type        = string
  default     = "kftray-cluster"
}

variable "kubernetes_version" {
  description = "Version of the Kind node image"
  type        = string
  default     = "v1.30.4"
}
```

### Service Versions

If you need different versions of the services, you can update them in the `variables.tf` file as well. For example, to change the Argo CD version:

```hcl
variable "argocd_chart_version" {
  description = "Argo CD Helm chart version"
  type        = string
  default     = "5.19.12"
}
```

Do the same for Prometheus, Grafana, and Jaeger if needed.

### Kftray Port Forwarding

You can customize how ports are forwarded by editing the `locals.tf` file:

```hcl
locals {
  services = {
    argocd = {
      kftray = {
        alias       = "argocd"
        local_port  = "16080"
        target_port = "http"
      }
    }
    # Add other services here
  }
}
```

- **alias:** The name you see in Kftray.
- **local_port:** The port on your computer to access the service.
- **target_port:** The service’s port or port name.
