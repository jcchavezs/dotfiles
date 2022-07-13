#!/bin/bash

touch ${HOME}/.env

mkdir -p ${HOME}/Workspace/source/github.com/jcchavezs
mkdir ${HOME}/Workspace/gource
mkdir ${HOME}/Workspace/tools

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update
brew upgrade
brew cleanup

# Setup GIT
ln -sf ${HOME}/.dotfiles/.gitconfig ${HOME}/.gitconfig
brew install pre-commit
brew install gh

# Install ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm -rf $ZSH_CUSTOM/plugins/zsh-autosuggestions || true
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
rm -rf ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-history-substring-search || true
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

# Install VIM
brew install vim
brew install fzf
rm -rf ${HOME}/.vim/bundle/Vundle.vim || true
git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim

# Install mysql-client
brew install mysql-client

# Install httpie
brew install httpie

# Install htop
brew install htop

# Install AG
brew install the_silver_searcher

brew install kustomize

(mv ${HOME}/.zshrc ${HOME}/.zshrc_backup || true) && ln -s ${HOME}/.dotfiles/.zshrc ${HOME}/.zshrc
ln -s ${HOME}/.dotfiles/functions.zsh ${ZSH_CUSTOM}/functions.zsh

(mv ${HOME}/.vimrc ${HOME}/.vimrc_backup || true) && ln -s ${HOME}/.dotfiles/.vimrc ${HOME}/.vimrc
cp ${HOME}/.dotfiles/vs-settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json

# Install Go
brew install go
mkdir ${HOME}/Workspace/gource/pkg
mkdir ${HOME}/Workspace/gource/bin
go get golang.org/x/tools/cmd/goimports

# Install protobuf
brew install protobuf
export GO111MODULE=on
go get github.com/golang/protobuf/protoc-gen-go
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc

# Install PHP
brew install php@8.0

# Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
composer global require symfony/thanks
composer global require friendsofphp/php-cs-fixer

# Install RVM
curl -sSL https://get.rvm.io | bash
ln -s ${HOME}/.rvm/scripts/functions/version ${HOME}/.rvm/scripts/version

# Install node
brew install node
brew install yarn

# Install Java
java -version
brew install maven
brew info maven
brew install pmd

# Install kotlin
brew install kotlin

# Install scala
brew install scala
brew install sbt

# Install clang-format
brew install clang-format

# Install ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm -rf $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
rm -rf ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

# Install VIM
brew install vim
brew install fzf
rm -rf ${HOME}/.vim/bundle/Vundle.vim
git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim

# Install httpie
brew install httpie
brew install jq

# Install watch
brew install watch
brew install gnu-sed

# Install tmux
brew install tmux

# Install retry
brew pull 27283
brew install retry

# Install AG
brew install the_silver_searcher

(mv ${HOME}/.zshrc ${HOME}/.zshrc_backup || true) && ln -s ${HOME}/.dotfiles/.zshrc ${HOME}/.zshrc
(mv ${HOME}/.vimrc ${HOME}/.vimrc_backup || true) && ln -s ${HOME}/.dotfiles/.vimrc ${HOME}/.vimrc

# Install latex
brew cask install basictex
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