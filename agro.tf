data "kubectl_file_documents" "nginx2" {
    content = file("./nginx2.yaml")
}

resource "kubectl_manifest" "nginx2" {
    depends_on = [
      kubectl_manifest.argocd,
    ]
    count     = length(data.kubectl_file_documents.nginx2.documents)
    yaml_body = element(data.kubectl_file_documents.nginx2.documents, count.index)
    override_namespace = "argocd"
}
