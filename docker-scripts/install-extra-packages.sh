#!/bin/bash

# Bash "strict mode", to help catch problems and bugs in the shell
# script. Every bash script you write should include this. See
# http://redsymbol.net/articles/unofficial-bash-strict-mode/ for
# details.
set -euo pipefail

# Tell apt-get we're never going to be able to give manual
# feedback:
export DEBIAN_FRONTEND=noninteractive

# Change shell to zsh
chsh -s $(which zsh)

# Install other packages
# pyenv
curl https://pyenv.run | bash

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash


# oh-my-sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# oh-my-zsh plugins
export ZSH_CUSTOM=/root/.oh-my-zsh/custom
#git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# spaceship oh-my-zsh theme
#git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
#ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" 

# starship theme
curl -fsSL https://starship.rs/install.sh | sh /dev/stdin --yes

# Kubectl
curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.21.0/bin/linux/amd64/kubectl"
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

# Skaffold
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/v1.37.0/skaffold-linux-amd64
chmod +x skaffold
mv skaffold /usr/local/bin

# Kustomize
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
mv kustomize /usr/local/bin

# Eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/v0.115.0/eksctl_Linux_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /usr/local/bin

# Terraform
wget https://releases.hashicorp.com/terraform/0.14.4/terraform_0.14.4_linux_amd64.zip
unzip terraform_0.14.4_linux_amd64.zip
mv terraform /usr/local/bin/
rm terraform_0.14.4_linux_amd64.zip

# Mongo shell
curl -Lo mongo.deb https://repo.mongodb.org/apt/debian/dists/buster/mongodb-org/4.4/main/binary-amd64/mongodb-org-shell_4.4.3_amd64.deb
dpkg -i ./mongo.deb
rm mongo.deb

# Mongo db tools
curl -Lo mongotools.deb https://fastdl.mongodb.org/tools/db/mongodb-database-tools-debian10-x86_64-100.3.1.deb
dpkg -i ./mongotools.deb
rm mongotools.deb

# Velero
wget https://github.com/vmware-tanzu/velero/releases/download/v1.5.2/velero-v1.5.2-linux-amd64.tar.gz
tar -xvf velero-v1.5.2-linux-amd64.tar.gz
mv velero-v1.5.2-linux-amd64/velero /usr/local/bin
rm velero-v1.5.2-linux-amd64.tar.gz

# argo rollouts cli
curl -LO https://github.com/argoproj/argo-rollouts/releases/latest/download/kubectl-argo-rollouts-linux-amd64
chmod +x /kubectl-argo-rollouts-linux-amd64
mv /kubectl-argo-rollouts-linux-amd64 /usr/local/bin/kubectl-argo-rollouts

# helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm get_helm.sh

# docker compose
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Krew
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

# Kubeseal
wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.14.1/kubeseal-linux-amd64 -O kubeseal
install -m 755 kubeseal /usr/local/bin/kubeseal
rm kubeseal

# Install s5cmd
wget -O s5cmd.tar.gz https://github.com/peak/s5cmd/releases/download/v1.4.0-rc.1/s5cmd_1.4.0-rc.1_Linux-64bit.tar.gz
mkdir s5cmd/
tar -xvf s5cmd.tar.gz -C s5cmd/
mv s5cmd/s5cmd /usr/local/bin
rm -fr s5cmd s5cmd.tar.gz

# Git lfs
wget https://github.com/git-lfs/git-lfs/releases/download/v3.1.2/git-lfs-linux-amd64-v3.1.2.tar.gz
mkdir gitlfs/
tar -xvf git-lfs-linux-amd64-v3.1.2.tar.gz -C gitlfs/
./gitlfs/install.sh
rm -fr gitlfs
rm git-lfs-linux-amd64-v3.1.2.tar.gz

# neovim
wget https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.deb 
apt install ./nvim-linux64.deb
rm nvim-linux64.deb
