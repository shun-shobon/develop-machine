#!/usr/bin/env bash

set -eu

# set timezone
timedatectl set-ntp true
timedatectl set-timezone Asia/Tokyo

# install necessary
pacman -Syyu --noconfirm --needed base base-devel reflector git zsh tmux exa bat fuse-overlayfs podman podman-docker

# change locale
cat <<EOF > /etc/locale.gen
en_US.UTF-8 UTF-8
ja_JP.UTF-8 UTF-8
EOF
locale-gen

# change mirror
reflector --latest 20 --sort rate --protocol http --protocol https --save /etc/pacman.d/mirrorlist

# setup podman
cat <<EOF > /etc/containers/registries.conf
unqualified-search-registries = ["docker.io", "ghcr.io", "quay.io"]
EOF
sed -i -e '/^driver/c driver = "overlay"' -e "/^#mount_program/c mount_program = \"$(which fuse-overlayfs)\"" /etc/containers/storage.conf
echo "vagrant:10000:65536" >> /etc/subuid
echo "vagrant:10000:65536" >> /etc/subgid
podman system migrate

# change default shell
chsh -s $(which zsh) vagrant
