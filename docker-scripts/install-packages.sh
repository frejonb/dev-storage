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
apt-get -y install --no-install-recommends lsb-release wget gnupg2 ca-certificates
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list

apt-get update

apt-get -y install --no-install-recommends \
build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
zsh jq fzf gettext vim watch unzip openssh-server git \
postgresql-client-12

# Configure ssh server
mkdir /var/run/sshd
mkdir ~/.ssh
ssh-keygen -A
# Delete cached files we don't need anymore:
apt-get clean all
rm -rf /var/lib/apt/lists/*
