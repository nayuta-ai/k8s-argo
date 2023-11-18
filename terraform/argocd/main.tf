provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
    kubernetes {
        config_path = "~/.kube/config"
    }
}

resource "kubernetes_namespace" "argocd_namespace" {
    metadata {
        name = "argocd"
    }
}

resource "helm_release" "argocd" {
    name       = "argocd"
    repository = "https://charts.bitnami.com/bitnami"
    chart      = "argo-cd"
    namespace  = "argocd"

    timeout = "600"
    # set {
    #   name = "server.service.type"
    #   value = "LoadBalancer"
    # }
}