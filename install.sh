#!/bin/bash

mkdir -p ${HOME}/Workspace/source/github.com/jcchavezs || true
mkdir ${HOME}/Workspace/gource || true
mkdir ${HOME}/Workspace/tools || true

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update
brew upgrade
brew cleanup
brew tap caskroom/cask

# Setup GIT
ln -sf ${HOME}/.dotfiles/.gitconfig ${HOME}/.gitconfig
brew install pre-commit

# Install ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

# Install VIM
brew install vim
brew install fzf
git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim

# Install mysql-client
brew install mysql-client

# Install httpie
brew install httpie

# Install htop
brew install htop

# Install AG
brew install the_silver_searcher

mv (${HOME}/.zshrc ${HOME}/.zshrc_backup || true) && ln -s ${HOME}/.dotfiles/.zshrc ${HOME}/.zshrc
mkdir -p ${ZSH_CUSTOM}/custom
ln -s ${HOME}/.dotfiles/functions.zsh ${ZSH_CUSTOM}/functions.zsh

mv (${HOME}/.vimrc ${HOME}/.vimrc_backup || true) && ln -s ${HOME}/.dotfiles/.vimrc ${HOME}/.vimrc
ln -s ${HOME}/.dotfiles/.grc ${HOME}/.grc
cp ${HOME}/.dotfiles/vs-settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json

# Install Go
brew install go
mkdir -p ${HOME}/Workspace/gource/src/github.com/jcchavezs
mkdir ${HOME}/Workspace/gource/pkg
mkdir ${HOME}/Workspace/gource/bin
brew install grc
go get golang.org/x/tools/cmd/goimports

# Install PHP
brew install php@7.3

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
brew cask install adoptopenjdk8
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
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

# Install VIM
brew install vim
brew install fzf
git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim

# Install httpie
brew install httpie
brew install jq

# Install watch
brew install watch

# Install retry
brew pull 27283
brew install retry

# Install AG
brew install the_silver_searcher

mv (${HOME}/.zshrc ${HOME}/.zshrc_backup || true) && ln -s ${HOME}/.dotfiles/.zshrc ${HOME}/.zshrc
mv (${HOME}/.vimrc ${HOME}/.vimrc_backup || true) && ln -s ${HOME}/.dotfiles/.vimrc ${HOME}/.vimrc
ln -s ${HOME}/.dotfiles/.grc ${HOME}/.grc

# Install latex
brew cask install basictex
sudo tlmgr update --self
sudo tlmgr install latexmk enumitem stmaryrd collection-fontsrecommended

# Add VS Code settings
cp ${HOME}/.dotfiles/vs-settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json

extensions='./vs-extensions.txt'
while IFS= read -r line
do
  code --install-extension $line
done < "$extensions"
