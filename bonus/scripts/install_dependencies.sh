
# Install k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Set up Docker's apt repository
## Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

## Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update


## Install the Docker packages
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Install kubectl
curl -LO https://dl.k8s.io/release/v1.30.0/bin/linux/amd64/kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

# Validate the kubectl binary against the checksum file:
# echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
# If valid, the output is:

# kubectl: OK
# If the check fails, sha256 exits with nonzero status and prints output similar to:

# kubectl: FAILED
# sha256sum: WARNING: 1 computed checksum did NOT match

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo "alias k='sudo kubectl'" >> /home/loris/.zshrc
source /home/loris/.zshrc

