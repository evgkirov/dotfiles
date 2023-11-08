#!/bin/bash 

cd `dirname $0`
SRC=`pwd`

function relink {
    dst_file="$HOME/$1"
    mkdir -p "`dirname \"$dst_file\"`"
    ln -svf "$SRC/$1" "$HOME/$1"
}

function copy {
    dst_file="$HOME/$1"
    mkdir -p "`dirname \"$dst_file\"`"
    cp -v "$SRC/$1" "$HOME/$1"
}

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install mas
brew bundle

relink .skhdrc
relink .yabairc
relink .simplebarrc
relink .config/sketchybar
relink .config/svim
relink "Library/Application Support/Übersicht/widgets/custom"
relink ".config/karabiner/karabiner.json"
# relink ".config/nvim"
sh install_my_nvim.sh

copy "Library/Containers/net.televator.Vimari.SafariExtension/Data/Library/Application Support/userSettings.json"
cp -r "Applications/Neovim.app" /Applications 
