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

relink .skhdrc
relink .yabairc
relink .simplebarrc
relink "Library/Application Support/Übersicht/widgets/custom"

relink "Library/Application Support/Code/User/keybindings.json"
relink "Library/Application Support/Code/User/settings.json"

copy "Library/Containers/net.televator.Vimari.SafariExtension/Data/Library/Application Support/userSettings.json"
