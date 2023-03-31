#!/bin/sh

rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim

