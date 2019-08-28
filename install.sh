mkdir -p ${HOME}/Workspace/source/github.com/jcchavezs
mkdir ${HOME}/Workspace/gource
mkdir ${HOME}/Workspace/tools

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade
brew cleanup
brew tap caskroom/cask

# Setup GIT
ln -sf ${HOME}/.dotfiles/.gitconfig ${HOME}/.gitconfig
brew install pre-commit

# Install GOLANG
brew install go
mkdir -p ${HOME}/Workspace/gource/src/github.com/jcchavezs
mkdir ${HOME}/Workspace/gource/pkg
mkdir ${HOME}/Workspace/gource/bin
brew install grc

# Install PHP
brew install php71

#Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
composer global require symfony/thanks

# Install RVM
curl -sSL https://get.rvm.io | bash
ln -s ${HOME}/.rvm/scripts/functions/version ${HOME}/.rvm/scripts/version

# Install node
brew install node
brew install yarn

# Install Java
brew cask install java
brew cask info java
brew install maven
brew info maven

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

# Install AG
brew install the_silver_searcher

mv (${HOME}/.zshrc ${HOME}/.zshrc_backup || true) && ln -s ${HOME}/.dotfiles/.zshrc ${HOME}/.zshrc
mv (${HOME}/.vimrc ${HOME}/.vimrc_backup || true) && ln -s ${HOME}/.dotfiles/.vimrc ${HOME}/.vimrc
ln -s ${HOME}/.dotfiles/.grc ${HOME}/.grc
cp ${HOME}/.dotfiles/vs-settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json
