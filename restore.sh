#!/bin/bash 

cd `dirname $0`
SRC=`pwd`


function relink {
    dst_file="$HOME/$1"
    mkdir -p "`dirname \"$dst_file\"`"
    ln -svf "$SRC/$1" "$HOME/$1"
}

relink .skhdrc
relink .spacebarrc
relink .yabairc

relink "Library/Application Support/Code/User/keybindings.json"
relink "Library/Application Support/Code/User/settings.json"
