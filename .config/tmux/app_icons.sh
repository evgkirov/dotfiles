#!/usr/bin/env bash

# prefer icons prefixed with nf-md-
get_app_icon() {
    case $1 in
    # Apps
    *"- Nvim"*) echo  ;;  # Neovim
    *"OC | "*) echo 󰝣 ;;  # OpenCode
    *"codex "*) echo  ;;  # Codex
    *"✳"*) echo ✳ ;;  # Claude Code has its own icon 
    *"lazydocker "*) echo 󰡨 ;;  # lazydocker
    *"lazygit "*) echo  ;;  # lazygit
    *"IPython "*) echo 󰌠 ;;  # IPython
    *"python "*) echo 󰌠 ;;  # Python
    *"python3"*) echo 󰌠 ;;  # Python

    # Directories
    *"/dotfiles"*) echo  ;;  # dotfiles
    *"/finances"*) echo  ;;  # finances

    # Fallback
    *) echo  ;;
    esac
}

get_app_icon "$1"
