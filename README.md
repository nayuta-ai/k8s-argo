# k8s-argo
## How to install
- [minikube](https://minikube.sigs.k8s.io/docs/start/)
- [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## How to use
0. Clone repository
```
$ git clone https://github.com/nayuta-ai/k8s-argo.git
$ cd k8s-argo
$ git checkout -b terraform origin/terraform
```
1. Start minikube
```
$ minikube start
```
2. Install ArgoCD and Open a port for ArgoCD UI
```
$ cd terraform
$ terraform init
$ terraform plan
$ terraform apply -lock=false -lock-timeout="10m"
$ kubectl patch svc my-argocd-argo-cd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
$ kubectl port-forward svc/my-argocd-argo-cd-server -n argocd 8080:443
```
Access `http://localhost:8080`

3. Get a password for ArgoCD UI

The Username is "admin", but the Password is obtained by the following command.
```
% kubectl -n argocd get secret argocd-secret -o template="{{.data.clearPassword | base64decode}}"; echo
```
4. Integrate ArgoCD with Github
```
$ cd ..
$ kubectl apply -f argocd/application.yaml
```

## Reference
- [A guide to Terraform for Kubernetes beginners](https://opensource.com/article/20/7/terraform-kubernetes)
- [Getting Started with Kubernetes provider](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/guides/getting-started#kubernetes)
- [Command: apply](https://developer.hashicorp.com/terraform/cli/commands/apply)
- [Bitnami Helm ChartでArgo CDをインストール及び ... - IK.AM](https://ik.am/entries/659)
