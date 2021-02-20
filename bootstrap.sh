#!/usr/bin/env bash

set -eu

# set timezone
timedatectl set-ntp true
timedatectl set-timezone Asia/Tokyo

# install necessary
pacman -Syyu --noconfirm --needed base base-devel reflector git zsh neovim tmux exa bat docker docker-compose

# change mirror
reflector --country 'Japan' --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

# enable docker
systemctl enable docker
usermod -aG docker vagrant

# change locale
cat <<EOF > /etc/locale.gen
en_US.UTF-8 UTF-8
ja_JP.UTF-8 UTF-8
EOF
locale-gen

# change default shell
chsh -s $(which zsh) vagrant
