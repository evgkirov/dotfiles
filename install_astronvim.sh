#!/bin/sh

rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
nvim

