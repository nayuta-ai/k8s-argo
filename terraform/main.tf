provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "argocd_namespace" {
    metadata {
        name = "argocd"
    }
}

resource "kubernetes_namespace" "monitoring_namespace" {
    metadata {
        name = "monitoring"
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

    # set {
    #   name = "server.service.type"
    #   value = "LoadBalancer"
    # }
}

resource "helm_release" "my-prometheus" {
    chart      = "prometheus"
    name       = "prometheus"
    namespace  = "monitoring"
    repository = "https://prometheus-community.github.io/helm-charts"
}

resource "helm_release" "my-grafana" {
    chart      = "grafana"
    name       = "grafana"
    repository = "https://grafana.github.io/helm-charts"
    namespace  = "monitoring"
}