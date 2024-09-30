output "endpoint" {
  description = "API endpoint for the Kind cluster."
  value       = kind_cluster.default.endpoint
}

output "kubeconfig" {
  description = "Kubeconfig file for the Kind cluster."
  value       = kind_cluster.default.kubeconfig
  sensitive   = true
}

output "credentials" {
  description = "Credentials for authenticating with the Kind cluster."
  value = {
    client_certificate     = kind_cluster.default.client_certificate
    client_key             = kind_cluster.default.client_key
    cluster_ca_certificate = kind_cluster.default.cluster_ca_certificate
  }
  sensitive = true
}
