#!/usr/bin/env bash

# This file is executed by devboxes when they start. You can do
# nearly anything in here but the rule of thumb here is for
# any actions that are executed must be able to be executed
# multiple times (ie. idempotent) without erroring out.

set -euox pipefail
IFS=$'\n\t'

# Step 1:
### Operating system level packages can be installed by Ubuntu or via Nix (or both)
###
### a. Installation of packages via Ubuntu
###
###    sudo apt-get update && sudo apt-get -y install btop
###
### b. Installation of packages via Nix (identify the package name via https://search.nixos.org/packages)
###
###    nix-env -iA nixpkgs.btop

# Install tools via nix
nix-env -iA nixpkgs.diff-so-fancy \
            nixpkgs.btop \
            nixpkgs.gh \
            nixpkgs.tmux \
            nixpkgs.zsh

# Step 2:
## (optional) Create a single-source of truth for your dotfiles
## by deleting files that exist or cause conflicts as the contents
## of these files should be managed instead in your dotfiles.
## rm -f ~/.bash_profile

# Step 3:
## Personalize your home directory configuring using `stow`
## https://venthur.de/2021-12-19-managing-dotfiles-with-stow.html

stow bash -t ~
stow editorconfig -t ~
stow gh -t ~
stow git -t ~
stow zsh -t ~

# Step 4:
## Ensure custom bashrc is sourced
if ! grep -q "source ~/.bashrc_custom" ~/.bashrc 2>/dev/null; then
    echo "" >> ~/.bashrc
    echo "# Load custom bash configuration from dotfiles" >> ~/.bashrc
    echo '[ -f ~/.bashrc_custom ] && source ~/.bashrc_custom' >> ~/.bashrc
    echo "Added custom bashrc sourcing to ~/.bashrc"
fi

# Step 5:
## Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k theme
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Install zsh plugins
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Step 6:
## Set zsh as default shell (requires password)
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "To make zsh your default shell, run: chsh -s $(which zsh)"
fi
