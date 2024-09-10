#
resource "kubernetes_namespace" "grafana" {
  metadata {
    annotations = {}
    labels      = {}
    name        = "monitoring"
  }
}
#
#######################################################################
data "kubectl_path_documents" "docs_grafana" {
  pattern = "./manifests/grafana/*.yaml"
}
resource "kubectl_manifest" "docs_grafana" {
  for_each  = toset(data.kubectl_path_documents.docs_grafana.documents)
  yaml_body = each.value
  depends_on = [
    kubernetes_namespace.grafana
  ]
}
#
data "kubectl_path_documents" "docs_influxdb" {
  pattern = "./manifests/influxdb/*.yaml"
}
resource "kubectl_manifest" "docs_influxdb" {
  for_each  = toset(data.kubectl_path_documents.docs_influxdb.documents)
  yaml_body = each.value
  depends_on = [
    kubernetes_namespace.grafana
  ]
}
#
data "kubectl_path_documents" "docs_telegraf" {
  pattern = "./manifests/telegraf/*.yaml"
}
resource "kubectl_manifest" "docs_telegraf" {
  for_each  = toset(data.kubectl_path_documents.docs_telegraf.documents)
  yaml_body = each.value
  depends_on = [
    kubernetes_namespace.grafana
  ]
}
#
data "kubectl_path_documents" "docs_chronograf" {
  pattern = "./manifests/chronograf/*.yaml"
}
resource "kubectl_manifest" "docs_chronograf" {
  for_each  = toset(data.kubectl_path_documents.docs_chronograf.documents)
  yaml_body = each.value
  depends_on = [
    kubernetes_namespace.grafana
  ]
}
#