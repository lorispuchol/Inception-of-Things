# Create the k3d cluster with agent:0 accessible by port mapping
sudo k3d cluster create p3 -p "8082:30080@agent:0" --agents 2

sudo kubectl create namespace argocd
sudo kubectl create namespace dev
sudo kubectl create namespace gitlab

# Install Wil42/playground App
sudo kubectl apply -f confs/app/app.yaml -n dev
# curl localhost:8082

#Install ArgoCD
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Get ArgoCD password
sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# Forward 8080 localport to 443 argocd Service Port
sudo kubectl port-forward svc/argocd-server -n argocd 8080:443


########################################################################################################################
########################################################################################################################
########################################################################################################################

# A batter way is to Set up a LoadBalancer because if the terminal or the service crash ArgoCD become inaccessible
## https://k3d.io/v5.3.0/usage/exposing_services/
## https://metallb.universe.tf/
## https://argo-cd.readthedocs.io/en/stable/getting_started/


# Install MetalLB
sudo kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.7/config/manifests/metallb-native.yaml

# Apply confs for LoadBalancer
sudo kubectl apply -f confs/LoadBalancer/l2.yaml
sudo kubectl apply -f confs/LoadBalancer/ip.yaml

# Patch ArgoCD service as LoadBalancer type
sudo kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}' # define ip du loadBalancer

# Conf ArgoCD for app
sudo kubectl apply -f confs/app-argocd.yaml

#Install Helm
wget https://get.helm.sh/helm-v3.15.3-linux-amd64.tar.gz
tar -zxvf helm-v3.15.3-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm

# install Gitlab with minikube configuration
sudo helm repo add gitlab https://charts.gitlab.io/
sudo helm repo update

sudo helm upgrade --install gitlab gitlab/gitlab \
   --timeout 600s   \
   --namespace gitlab \
   --set global.hosts.domain=gitlab.example.com \
   --set global.hosts.externalIP=172.18.0.44 \
   -f https://gitlab.com/gitlab-org/charts/gitlab/raw/master/examples/values-minikube-minimum.yaml


sudo kubectl patch svc gitlab-webservice-default -n gitlab -p '{"spec": {"type": "LoadBalancer"}}'

sudo kubectl apply -f confs/ingress/ingress.yaml
