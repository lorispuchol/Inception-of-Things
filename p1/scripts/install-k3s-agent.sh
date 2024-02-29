# Install K3s agent node
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=$(cat /vagrant/confs/node-token) sh - < /dev/null
# K3S_URL is the URL of your server node = https://192.168.56.110.
# 6443 is the default port for the K3s server node.
# K3S_TOKEN is stored at /var/lib/rancher/k3s/server/node-token on your server node.