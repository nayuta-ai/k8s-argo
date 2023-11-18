provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "new_namespace" {
    metadata {
        name = "argocd"
    }
}

provider "helm" {
    kubernetes {
        config_path = "~/.kube/config"
    }
}

resource "helm_release" "my-argocd" {
    name       = "my-argocd"
    repository = "https://charts.bitnami.com/bitnami"
    chart      = "argo-cd"
    namespace  = "argocd"
}