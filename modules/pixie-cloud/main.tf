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
EOF
  ]
}
