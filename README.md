# k8s-argo
## How to use
1. Start minikube
```
$ minikube start
```
2. Install ArgoCD and Open a port for ArgoCD UI
```
$ kubectl create ns argocd
$ kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
$ kubectl port-forward -n argocd svc/argocd-server 8080:443
```
Access `http://localhost:8080`

3. Get a password for ArgoCD UI

The Username is "admin", but the Password is obtained by the following command.
```
$ kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```
4. Integrate ArgoCD with Github
```
$ kubectl apply -f application.yaml
```
