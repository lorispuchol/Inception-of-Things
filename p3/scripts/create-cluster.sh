k3d cluster create p3 -p "8082:30080@agent:0" --agents 2

k create namespace argo-cd
k create namespace dev

k apply -f confs/app.yaml

# curl localhost:8082