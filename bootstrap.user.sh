#!/usr/bin/env zsh

set -eu

cd /home/vagrant

# remove bash dotfiles
rm -f .bash_logout .bash_profile .bashrc

project_dir=Projects

# install dotfiles
mkdir "${project_dir}" && cd "${project_dir}"
git clone https://github.com/shun-shobon/dotfiles
cd /home/vagrant
dotfiles=(".cache" ".config" ".data" ".vimrc" ".zshenv")
for file in ${dotfiles[@]}; do
    ln -s "Projects/dotfiles/${file}" "${file}"
done
source .zshenv

# install paru
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -sri --noconfirm
cd /home/vagrant
rm -rf paru
