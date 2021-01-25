#!/bin/bash

# Bash "strict mode", to help catch problems and bugs in the shell
# script. Every bash script you write should include this. See
# http://redsymbol.net/articles/unofficial-bash-strict-mode/ for
# details.
set -euo pipefail

# Tell apt-get we're never going to be able to give manual
# feedback:
export DEBIAN_FRONTEND=noninteractive

# Update the package listing, so we know what package exist:
apt-get update

# Install security updates:
# apt-get -y upgrade

# Install packages, without unnecessary recommended packages:
apt-get -y install --no-install-recommends lsb-release wget curl gnupg2 ca-certificates software-properties-common locales
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list
# docker cli
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/debian \
$(lsb_release -cs) \
stable"
# github cli
apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
apt-add-repository https://cli.github.com/packages

apt-get update

apt-get -y install --no-install-recommends \
build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
zsh gh jq fzf gettext vim watch unzip openssh-server git less fonts-firacode htop \
postgresql-client-12 libpq-dev docker-ce-cli docker-ce=5:19.03.14~3-0~debian-buster

# Configure ssh server
mkdir /var/run/sshd
mkdir ~/.ssh
ssh-keygen -A
# Configure docker
mkdir -p /etc/docker
echo '{"hosts": ["unix:///var/run/docker.sock", "tcp://127.0.0.1:2375"]}' > /etc/docker/daemon.json
# Delete cached files we don't need anymore:
apt-get clean all
rm -rf /var/lib/apt/lists/*
