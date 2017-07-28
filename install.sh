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

# Install GOLANG
brew install go
mkdir ~/Workspace/gource/src
mkdir ~/Workspace/gource/pkg
mkdir ~/Workspace/gource/bin

# Install PHP
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php
brew install php70
export PATH=/usr/local/php5/bin:$PATH

# Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Install RVM
curl -sSL https://get.rvm.io | bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install Python
brew install python

# Install Vagrant
brew cask install virtualbox
brew cask install vagrant
brew cask install vagrant-manager

mv .zshrc .zshrc_backup && ln -s .dotfiles/.zshrc .zshrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mv .vimrc .vimrc_backup && ln -s .dotfiles/.vimrc .vimrc
ln -s ~/Dropbox/Resources/Settings/.env .env
git config --global core.excludesfile '~/.dotfiles/.gitignore.global'
ln -s ~/.rvm/scripts/functions/version ~/.rvm/scripts/version

