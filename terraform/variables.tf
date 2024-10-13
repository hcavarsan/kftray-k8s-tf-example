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

variable "kubeconfig_dir" {
  description = "Directory to store the kubeconfig file"
  type        = string
  default     = "~/.kube"
}


variable "argocd_chart_version" {
  description = "Version of the Argo CD Helm chart"
  type        = string
  default     = "5.19.12"
}


variable "prometheus_chart_version" {
  description = "The version of the Prometheus chart to deploy."
  type        = string
  default     = "25.27.0"
}

variable "grafana_chart_version" {
  description = "The version of the Grafana chart to deploy."
  type        = string
  default     = "8.5.0"
}


variable "jaeger_chart_version" {
  description = "The version of the Jaeger chart to deploy."
  type        = string
  default     = "3.3.1"
}

variable "meshery_chart_version" {
  description = "The version of the Meshery chart to deploy."
  type        = string
  default     = "0.7.38"
}
