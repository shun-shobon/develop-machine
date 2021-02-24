#!/usr/bin/env zsh

set -eu

cd /home/vagrant

# remove bash dotfiles
rm -f .bash_logout .bash_profile .bashrc

project_dir=Projects

# install dotfiles
mkdir "${project_dir}" && cd "${project_dir}"
git clone https://github.com/shun-shobon/dotfiles
cd "${HOME}"
"${HOME}/${project_dir}/dotfiles/.bin/install.sh"
source "${HOME}/.zshenv"
source "${HOME}/.config/zsh/rc/variable.zsh"

# install paru
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -sri --noconfirm
cd /home/vagrant
rm -rf paru

# install neovim-nightly
paru neovim-nightly-git

# install nvm
mkdir "${NVM_DIR}"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
source "${NVM_DIR}/nvm.sh"
nvm install --lts
