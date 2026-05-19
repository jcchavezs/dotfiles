#!/bin/bash

touch ${HOME}/.env

mkdir -p ${HOME}/Workspace/source/github.com/jcchavezs
mkdir -p ${HOME}/Workspace/gource
mkdir -p ${HOME}/Workspace/tools

BREW=${BREW:-brew}

# Install $BREW
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
$BREW update
$BREW upgrade
$BREW cleanup

# Setup GIT
ln -sf ${HOME}/.dotfiles/.gitconfig ${HOME}/.gitconfig
git config --global alias.wta '!f() { git worktree add -b "$1" "../$1"; }; f'
git config --global alias.wtr '!f() { git worktree remove "../$1"; }; f'
git config --global alias.wtl '!f() { git worktree list; }; f'
$BREW install pre-commit
$BREW install gh

# Install ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm -rf $ZSH_CUSTOM/plugins/zsh-autosuggestions || true
git clone git@github.com:zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
rm -rf ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-history-substring-search || true
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

# Install mysql-client
$BREW install mysql-client

# Install htop
$BREW install htop

$BREW install helm

$BREW install coreutils

$BREW install kustomize

$BREW install kubectx

(mv ${HOME}/.zshrc ${HOME}/.zshrc_backup || true) && ln -s ${HOME}/.dotfiles/.zshrc ${HOME}/.zshrc
ln -s ${HOME}/.dotfiles/functions.zsh ${ZSH_CUSTOM}/functions.zsh
cp ${HOME}/.dotfiles/vs-settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json

# Install Go
$BREW install go
mkdir ${HOME}/Workspace/gource/pkg
mkdir ${HOME}/Workspace/gource/bin
go get golang.org/x/tools/cmd/goimports

# Install protobuf
$BREW install buf

# Install PHP
$BREW install php@8.0

# Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
composer global require symfony/thanks
composer global require friendsofphp/php-cs-fixer

# Install RVM
curl -sSL https://get.rvm.io | bash
ln -s ${HOME}/.rvm/scripts/functions/version ${HOME}/.rvm/scripts/version

# Install node
$BREW install node
$BREW install yarn

# Install Java
java -version
$BREW install maven
$BREW info maven
$BREW install pmd

# Install kotlin
$BREW install kotlin

# Install clang-format
$BREW install clang-format

# Install ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm -rf $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
rm -rf ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

rm -rf ${HOME}/.zsh-kubectl-prompt
git clone git@github.com:superbrothers/zsh-kubectl-prompt.git ${HOME}/.zsh-kubectl-prompt

# Install httpie
$BREW install jq

# Install watch
$BREW install watch
$BREW install gnu-sed

# Install tmux
$BREW install tmux

# Install retry
$BREW pull 27283
$BREW install retry

(mv ${HOME}/.zshrc ${HOME}/.zshrc_backup || true) && ln -s ${HOME}/.dotfiles/.zshrc ${HOME}/.zshrc

# Install latex
$BREW cask install basictex
sudo tlmgr update --self
sudo tlmgr install latexmk enumitem stmaryrd collection-fontsrecommended

# Add VS Code settings
cp ${HOME}/.dotfiles/vs-settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json

extensions="${HOME}/.dotfiles/vs-extensions.txt"
while IFS= read -r line
do
  code --install-extension $line
done < "$extensions"

cp ./karabiner.json ${HOME}/.config/karabiner/karabiner.json
