
resource "kind_cluster" "default" {
  name            = var.cluster_name
  node_image      = "kindest/node:${var.kubernetes_version}"
  kubeconfig_path = pathexpand("${var.kubeconfig_dir}/kind-config-${var.cluster_name}")
  wait_for_ready  = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"

      extra_port_mappings {
        container_port = 80
        host_port      = 80
        protocol       = "TCP"
      }
    }

    node {
      role = "worker"
    }
  }
}
