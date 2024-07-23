RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Create the k3d cluster with agent:0 accessible by port mapping
sudo k3d cluster delete p3
sudo k3d cluster delete bonus
sudo k3d cluster create bonus -p "8082:30080@agent:0" --agents 2 --wait

sudo kubectl create namespace argocd
sudo kubectl create namespace dev
sudo kubectl create namespace gitlab

# Deploy Wil42/playground App (this app run on 8888 port) # Check if the deployment is ready 
# No need because ArgoCD will deploy the app
# sudo kubectl apply -f confs/app/app.yaml -n dev
# sudo kubectl rollout status deployment/app-deployment -n dev

#Install ArgoCD, and wait for the Argo CD server deployment to be ready
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sleep 2
if ! sudo kubectl wait --namespace argocd --for=condition=Ready pod --selector=app.kubernetes.io/name=argocd-server --timeout=300s; then
  echo -e "${RED}Argo CD server deployment is not ready${NC}"
  exit 1
fi
echo "${GREEN}Argo CD server deployment is ready${NC}"

# Get ArgoCD password
echo "ArgoCD username: admin"
echo "ArgoCD password: $(sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"
# sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# Forward 8080 localport to 443 argocd Service Port
# sudo kubectl port-forward svc/argocd-server -n argocd 8080:443

########################################################################################################################
########################################################################################################################
########################################################################################################################

# A batter way is to Set up a LoadBalancer because if the terminal or the service crash ArgoCD become inaccessible
## https://k3d.io/v5.3.0/usage/exposing_services/
## https://metallb.universe.tf/
## https://argo-cd.readthedocs.io/en/stable/getting_started/


# Install MetalLB which expose the cluster on the pool of ip
sudo kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.7/config/manifests/metallb-native.yaml
sleep 2
if ! sudo kubectl wait --namespace metallb-system --for=condition=Ready pod --selector=app=metallb --timeout=300s; then
  echo "${RED}MetalLB is not ready${NC}"
  exit 1
fi
echo "${GREEN}MetalLB is ready${NC}"

# IP Address Pool and Layer 2 Advertisement configuration for metalLB
sudo kubectl apply -f confs/LoadBalancer/l2.yaml
sudo kubectl apply -f confs/LoadBalancer/ip.yaml

# Patch ArgoCD service as LoadBalancer type. It will automatically get an IP of metalLB
# An external IP address is assigned to the service
sudo kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# Conf ArgoCD for app
sudo kubectl apply -f confs/argocd/app-argocd.yaml


######################################
########### Bonus ####################
######################################


# install Gitlab with minikube configuration
sudo helm repo add gitlab https://charts.gitlab.io/
sudo helm repo update

sudo helm upgrade --install gitlab gitlab/gitlab \
   --timeout 600s   \
   --namespace gitlab \
   -f https://gitlab.com/gitlab-org/charts/gitlab/raw/master/examples/values-minikube-minimum.yaml


sudo kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.7/config/manifests/metallb-native.yaml
sleep 2
if ! sudo kubectl wait --for=condition=Ready pod --selector=app=webservice -n gitlab; then
  echo "${RED}Gitlab is not ready${NC}"
  exit 1
fi
echo "${GREEN}Gitlab is ready${NC}"

sudo kubectl patch svc gitlab-webservice-default -n gitlab -p '{"spec": {"type": "LoadBalancer"}}'


# Ingress isn't usefull, we can access to gitlab by port 8181
# Ingress is usefull because if we want to access git by port 8080, we have no return of the statics datas like javascript
# So the ingress permit to have the return of all this datas.
# The ingress take a ip in the pool of metalLB, same as traefik because traekik works the ingress
sudo kubectl apply -f confs/ingress/ingress.yaml
