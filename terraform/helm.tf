resource "helm_release" "services" {
  for_each         = local.services
  name             = each.key
  namespace        = each.value.namespace
  create_namespace = true
  repository       = each.value.repository
  chart            = each.value.chart
  version          = each.value.version

  values = [
    local.services_values[each.key]
  ]
}
