#!/bin/sh

cd `dirname $0`
SRC=`pwd`

rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

ln -svf "$SRC/.config/nvim" "$HOME/.config/nvim"

