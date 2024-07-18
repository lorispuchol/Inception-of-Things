# Create the k3d cluster with agent:0 accessible by port mapping
sudo k3d cluster create p3 -p "8082:30080@agent:0" --agents 2

sudo kubectl create namespace argocd
sudo kubectl create namespace dev

# Install Wil42/playground App
sudo kubectl apply -f confs/app.yaml -n dev

#Install ArgoCD
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Get ArgoCD password
sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# Forward 8080 localport to 443 argocd Service Port
# A batter way is to Set up a LoadBalancer because if the terminal or the service crash ArgoCD become inaccessible
## https://k3d.io/v5.3.0/usage/exposing_services/
## https://metallb.universe.tf/

sudo kubectl port-forward svc/argocd-server -n argocd 8080:443

# curl localhost:8082