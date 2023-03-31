#!/bin/sh

cd `dirname $0`
SRC=`pwd`

rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
ln -svf "$SRC/.config/nvim" "$HOME/.config/nvim"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

