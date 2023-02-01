# k8s-argo
## How to install
- [minikube](https://minikube.sigs.k8s.io/docs/start/)
- [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## How to use
0. Clone repository
```
$ git clone https://github.com/nayuta-ai/k8s-argo.git
$ cd k8s-argo
$ git checkout -b terraform origin/terraform-tmp
```
1. Start minikube
```
$ minikube start
```

### ArgoCD
1. Install ArgoCD and Open a port for ArgoCD UI
```
$ cd terraform/argocd
$ terraform init
$ terraform plan
$ terraform apply

$ kubectl port-forward svc/my-argocd-argo-cd-server -n argocd 8080:443
```
Access `http://localhost:8080`

2. Get a password for ArgoCD UI

The Username is "admin", but the Password is obtained by the following command.
```
% kubectl -n argocd get secret argocd-secret -o template="{{.data.clearPassword | base64decode}}"; echo
```
3. Integrate ArgoCD with Github
```
$ cd ../../ # now k8s-argo directory
$ kubectl apply -f argocd/application.yaml
```
### Grafana(Monitoring)
1. Install ArgoCD and Open a port for ArgoCD UI
```
$ cd terraform/argocd
$ terraform init
$ terraform plan
$ terraform apply

$ kubectl port-forward --namespace monitoring svc/grafana 3000:80
```
Access `http://localhost:3000`

2. Get a password for Grafana UI

The Username is "admin", but the Password is obtained by the following command.
```
$ kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

## Kibana (Logging)
1. Open port for Elastic
```
$ cd terraform/logging
$ terraform init
$ terraform plan
$ terraform apply
$ kubectl port-forward svc/kibana-kibana 5601 -n logging
```
Access `http://localhost:5601`

2. Get a password for Kibana UI

The Username is "elastic", but the Password is obtained by the following command.
```
% kubectl get secret elasticsearch-master-credentials -n logging -o jsonpath='{.data.password}' | base64 --decode; echo
```
## OPA/Gatekeeper
```
$ cd terraform/opa
$ terraform init
$ terraform plan
$ terraform apply
```

## Reference
- [A guide to Terraform for Kubernetes beginners](https://opensource.com/article/20/7/terraform-kubernetes)
- [Getting Started with Kubernetes provider](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/guides/getting-started#kubernetes)
- [Command: apply](https://developer.hashicorp.com/terraform/cli/commands/apply)
- [Resource: helm_release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)
- [Bitnami Helm ChartでArgo CDをインストール及び ... - IK.AM](https://ik.am/entries/659)
- [Prometheus and Grafana setup in Minikube](https://blog.marcnuri.com/prometheus-grafana-setup-minikube)
- [Cluster-level Logging in Kubernetes with Fluentd](https://medium.com/kubernetes-tutorials/cluster-level-logging-in-kubernetes-with-fluentd-e59aa2b6093a)
- [How To Set Up an Elasticsearch, Fluentd and Kibana (EFK) Logging Stack on Kubernetes](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-elasticsearch-fluentd-and-kibana-efk-logging-stack-on-kubernetes)
- [How-To: Set up Fluentd, Elastic search and Kibana in Kubernetes](https://docs.dapr.io/operations/monitoring/logging/fluentd/)
- [Logging in Kubernetes with Elasticsearch, Kibana, and Fluentd](https://mherman.org/blog/logging-in-kubernetes-with-elasticsearch-Kibana-fluentd/)