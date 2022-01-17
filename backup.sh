#!/bin/bash

set -e
echo "Backing up VS Code settings and extensions."
cp ${HOME}/Library/Application\ Support/Code/User/settings.json ./vs-settings.json
code --list-extensions > ./vs-extensions.txt
cp ${HOME}/.config/karabiner/karabiner.json ./karabiner.json

echo "DONE."
