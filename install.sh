cd ~

mkdir ~/Workspace
mkdir ~/Workspace/source
mkdir ~/Workspace/gource
mkdir ~/Workspace/tools

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade
brew cleanup

# Setup GIT
#git config --global user.name "José Carlos Chávez"
#git config --global user.email jcchavezs@gmail.com
#git config --global core.excludesfile '~/.dotfiles/.gitignore.global'
#git config --global core.editor "/usr/bin/vim"
ln -sf .dotfiles/.gitconfig ~/.gitconfig
brew install tig
brew install pre-commit
brew install diff-so-fancy

# Install GOLANG
brew install go
mkdir ~/Workspace/gource/src
mkdir ~/Workspace/gource/pkg
mkdir ~/Workspace/gource/bin
brew install grc

# Install PHP
#brew tap homebrew/dupes
#brew tap homebrew/versions
#brew tap homebrew/homebrew-php
brew install php71

#Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
composer global require symfony/thanks

# Install RVM
curl -sSL https://get.rvm.io | bash
ln -s ~/.rvm/scripts/functions/version ~/.rvm/scripts/version

# Install ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

# Install VIM
brew install vim
brew install fzf
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install Python
brew install python

# Install Vagrant
brew cask install virtualbox
brew cask install vagrant
brew cask install vagrant-manager

# Install httpie
brew install httpie
brew install jq

# Install AG
brew install the_silver_searcher

mv .zshrc .zshrc_backup && ln -s .dotfiles/.zshrc .zshrc
mv .vimrc .vimrc_backup && ln -s .dotfiles/.vimrc .vimrc
ln -s ~/Dropbox/Resources/Settings/.env .env
ln -s .dotfiles/.grc .grc
cp ~/.dotfiles/vs-settings.json ~/Library/Application\ Support/Code/User/settings.json
