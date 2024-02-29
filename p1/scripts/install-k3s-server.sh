# Install of K3s server node 
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
curl -sfL https://get.k3s.io | sh - < /dev/null
sudo cp -f /var/lib/rancher/k3s/server/node-token >> /vagrant/confs/

