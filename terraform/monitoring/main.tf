provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
    kubernetes {
        config_path = "~/.kube/config"
    }
}

resource "kubernetes_namespace" "monitoring_namespace" {
    metadata {
        name = "monitoring"
    }
}

resource "helm_release" "prometheus" {
    chart      = "prometheus"
    name       = "prometheus"
    namespace  = "monitoring"
    repository = "https://prometheus-community.github.io/helm-charts"

    timeout = "600"
}

resource "helm_release" "grafana" {
    chart      = "grafana"
    name       = "grafana"
    repository = "https://grafana.github.io/helm-charts"
    namespace  = "monitoring"

    timeout = "600"
}