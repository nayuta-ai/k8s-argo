# provider "kubernetes" {
#   config_path = "~/.kube/config"
# }

provider "helm" {
    kubernetes {
        config_path = "~/.kube/config"
    }
}

# resource "kubernetes_namespace" "gatekeeper_namespace" {
#     metadata {
#         name = "gatekeeper"
#     }
# }

resource "helm_release" "gatekeeper" {
    name       = "gatekeeper"
    repository = "https://open-policy-agent.github.io/gatekeeper/charts"
    chart      = "gatekeeper"

    timeout = "600"
}