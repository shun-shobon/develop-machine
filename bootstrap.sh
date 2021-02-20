#!/usr/bin/env bash

set -eu

# set timezone
timedatectl set-ntp true
timedatectl set-timezone Asia/Tokyo

# install necessary
pacman -Syyu --noconfirm --needed base base-devel git zsh neovim tmux exa bat docker docker-compose

systemctl enable docker

cat <<EOF > /etc/locale.gen
en_US.UTF-8 UTF-8
ja_JP.UTF-8 UTF-8
EOF
locale-gen

chsh -s $(which zsh) vagrant

usermod -aG docker vagrant
