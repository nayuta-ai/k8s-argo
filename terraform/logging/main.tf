provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
    kubernetes {
        config_path = "~/.kube/config"
    }
}

resource "kubernetes_namespace" "logging_namespace" {
    metadata {
        name = "logging"
    }
}

resource "helm_release" "elasticsearch" {
    chart      = "elasticsearch"
    name       = "elasticsearch"
    repository = "https://helm.elastic.co"
    namespace  = "logging"
    # version = "7.17.3"

    values = [ "${file("elasticsearch-values.yaml")}" ]
    # set {
    #   name = "persistence.enabled"
    #   value = "false"
    # }

    set {
      name = "replicas"
      value = "1"
    }

    timeout = "600"
}

resource "helm_release" "kibana" {
    chart      = "kibana"
    name       = "kibana"
    repository = "https://helm.elastic.co"
    namespace  = "logging"
    # version = "7.17.3"

    timeout = "600"
}

resource "helm_release" "fluentd" {
    chart      = "fluentd-elasticsearch"
    name       = "fluentd"
    repository = "https://kiwigrid.github.io"
    namespace  = "logging"

    values = [ "${file("fluentd-values.yaml")}" ]
    timeout = "600"
}