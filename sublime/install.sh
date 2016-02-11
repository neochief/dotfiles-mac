#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

git clone git@github.com:thinkpixellab/flatland.git ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/Theme\ -\ Flatland
git clone https://github.com/SublimeText-Markdown/MarkdownEditing.git ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/MarkdownEditing
git clone https://github.com/brandonwamboldt/sublime-nginx.git ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/sublime-nginx
rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
ln -s "${DIR}/User" ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User