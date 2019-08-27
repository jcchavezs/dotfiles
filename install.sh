HOME_DIR=`cd ~; pwd`

mkdir ${HOME_DIR}/Workspace
mkdir ${HOME_DIR}/Workspace/source
mkdir ${HOME_DIR}/Workspace/gource
mkdir ${HOME_DIR}/Workspace/tools

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade
brew cleanup

# Setup GIT
ln -sf ${HOME_DIR}/.dotfiles/.gitconfig ${HOME_DIR}/.gitconfig
brew install pre-commit

# Install GOLANG
brew install go
mkdir -p ${HOME_DIR}/Workspace/gource/src/github.com/jcchavezs
mkdir ${HOME_DIR}/Workspace/gource/pkg
mkdir ${HOME_DIR}/Workspace/gource/bin
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
ln -s ${HOME_DIR}/.rvm/scripts/functions/version ${HOME_DIR}/.rvm/scripts/version

# Install node
brew install node
brew install yarn

# Install ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-${HOME_DIR}/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

# Install VIM
brew install vim
brew install fzf
git clone https://github.com/VundleVim/Vundle.vim.git ${HOME_DIR}/.vim/bundle/Vundle.vim

# Install httpie
brew install httpie
brew install jq

# Install AG
brew install the_silver_searcher

mv ${HOME_DIR}/.zshrc ${HOME_DIR}/.zshrc_backup && ln -s ${HOME_DIR}/.dotfiles/.zshrc ${HOME_DIR}/.zshrc
mv (${HOME_DIR}/.vimrc ${HOME_DIR}/.vimrc_backup || true) && ln -s ${HOME_DIR}/.dotfiles/.vimrc ${HOME_DIR}/.vimrc
ln -s ${HOME_DIR}/.dotfiles/.grc ${HOME_DIR}/.grc
cp ${HOME_DIR}/.dotfiles/vs-settings.json ${HOME_DIR}/Library/Application\ Support/Code/User/settings.json
