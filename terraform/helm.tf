data "template_file" "values_yaml" {
  for_each = local.services

  template = file("${path.module}/templates/${each.key}-values.yaml.tpl")

  vars = {
    kftray_alias       = each.value.kftray.alias
    kftray_local_port  = each.value.kftray.local_port
    kftray_target_port = each.value.kftray.target_port
  }
}


resource "helm_release" "services" {
  for_each = local.services

  name             = each.key
  namespace        = each.value.namespace
  create_namespace = true
  repository       = each.value.repository
  chart            = each.value.chart
  version          = each.value.version

  values = [
    data.template_file.values_yaml[each.key].rendered
  ]

  depends_on = [kind_cluster.default]
}

