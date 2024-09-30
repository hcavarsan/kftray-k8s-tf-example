# locals block
locals {
  services = {
    argocd = {
      namespace  = "argocd"
      repository = "https://argoproj.github.io/argo-helm"
      chart      = "argo-cd"
      version    = var.argocd_chart_version
      kftray = {
        server = {
          alias       = "argocd"
          local_port  = "16080"
          target_port = "http"
        }
      }
    }
    prometheus = {
      namespace  = "monitoring"
      repository = "https://prometheus-community.github.io/helm-charts"
      chart      = "prometheus"
      version    = var.prometheus_chart_version
      kftray = {
        server = {
          alias       = "prometheus"
          local_port  = "19090"
          target_port = "9090"
        }
        alertmanager = {
          alias       = "alertmanager"
          local_port  = "19093"
          target_port = "9093"
        }
      }
    }
    grafana = {
      namespace  = "monitoring"
      repository = "https://grafana.github.io/helm-charts"
      chart      = "grafana"
      version    = var.grafana_chart_version
      kftray = {
        grafana = {
          alias       = "grafana"
          local_port  = "13080"
          target_port = "3000"
        }
      }
    }
    jaeger = {
      namespace  = "observability"
      repository = "https://jaegertracing.github.io/helm-charts"
      chart      = "jaeger"
      version    = var.jaeger_chart_version
      kftray = {
        query = {
          alias       = "jaeger"
          local_port  = "15090"
          target_port = "16686"
        }
      }
    }
  }

  services_values = {
    for service_name, service in local.services :
    service_name => templatefile("${path.module}/templates/${service_name}-values.yaml.tpl", {
      kftray = service.kftray
    })
  }
}

