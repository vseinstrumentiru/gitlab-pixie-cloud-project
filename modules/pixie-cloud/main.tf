resource "null_resource" "cloud_secrets" {
  provisioner "local-exec" {
    command = "chmod +x ${path.module}/cloud_secrets.sh && ${path.module}/cloud_secrets.sh ${var.pixie_cloud_ns}"
    interpreter = ["/bin/sh", "-c"]
  }
}

resource "helm_release" "pixie_cloud" {
  name              = "pixie-cloud"
  chart             = "${path.module}/chart"
  namespace         = var.pixie_cloud_ns
  dependency_update = true
  create_namespace  = true
  timeout           = 600
  wait              = false
  depends_on        = [ null_resource.cloud_secrets ]
  values = [<<EOF
domainName: ${var.domain_name}
%{ if var.cloud_components_node_selector != null }
nodeSelector:
  ${ var.cloud_components_node_selector.label }: ${ var.cloud_components_node_selector.value }
%{ endif }
%{ if var.cloud_components_tolerations != null }
tolerations:
  ${indent(2,yamlencode(var.cloud_components_tolerations))}
%{ endif }
stan:
  volumeClaimTemplate:
    storageClassName: ${var.stan_storage_class}
postgresql:
  global:
    storageClass: ${var.postgresql_storage_class}
  persistence:
    storageClass: ${var.postgresql_storage_class}
  primary:
%{ if var.postgresql_node_selector != null }
    nodeSelector:
      ${ var.postgresql_node_selector.label }: ${ var.postgresql_node_selector.value }
%{ endif }
%{ if var.postgresql_tolerations != null }
    tolerations:
      ${indent(6,yamlencode(var.postgresql_tolerations))}
%{ endif }
elasticsearch:
%{ if var.elasticsearch_node_selector != null }
  nodeSelector:
    ${ var.elasticsearch_node_selector.label }: ${ var.elasticsearch_node_selector.value }
%{ endif }
%{ if var.postgresql_tolerations != null }
  tolerations:
    ${indent(4,yamlencode(var.elasticsearch_tolerations))}
%{ endif }
  volumeClaimTemplate:
    storageClassName: ${var.elasticsearch_storage_class}
EOF
  ]
}
