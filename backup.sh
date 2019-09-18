#!/bin/bash

set -e
echo "Backing up VS Code settings and extensions."
cp ${HOME}/Library/Application\ Support/Code/User/settings.json ${HOME}/.dotfiles/vs-settings.json
code --list-extensions > ${HOME}/.dotfiles/vs-extensions.txt

echo "DONE."
