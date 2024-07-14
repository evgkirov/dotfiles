#!/bin/bash

cd $(dirname $0)
SRC=$(pwd)

function relink {
    dst_file="$HOME/$1"
    rm -rf "$dst_file"
    mkdir -p "$(dirname \"$dst_file\")"
    ln -svf "$SRC/$1" "$HOME/$1"
}

function copy {
    dst_file="$HOME/$1"
    rm -rf "$dst_file"
    mkdir -p "$(dirname \"$dst_file\")"
    cp -v "$SRC/$1" "$HOME/$1"
}

# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# brew install mas
# brew bundle

relink .config/borders
relink .config/karabiner/karabiner.json
relink .config/nvim
relink .config/sketchybar
relink .config/skhd
relink .config/starship.toml
relink .config/svim
relink .config/themes
relink .config/wezterm
relink .config/yabai
relink .ideavimrc
relink .vimrc
relink .zshrc

copy "Library/Containers/net.televator.Vimari.SafariExtension/Data/Library/Application Support/userSettings.json"
# cp -r "Applications/Neovim.app" /Applications
