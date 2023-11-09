#!/usr/bin/env bash

# prefixed with nf-md-
get_app_icon() {
    if [[ "$2" == *"- NVIM"* ]]; then
        echo 
        return
    fi

    case $1 in
        "Calendar") echo 󰸗 ;;
        "Google Chrome") echo 󰊯 ;;
        "Finder") echo 󰀶 ;;
        "iTerm2") echo 󰞷 ;;
        "Mail") echo 󰇮 ;;
        "Messages") echo 󰭹 ;;
        "Obsidian") echo 󰇈 ;;
        "Rocket.Chat") echo 󱓞 ;;
        "Safari") echo 󰀹 ;;
        "Session") echo 󰁫 ;;
        "Shortcuts") echo  ;;
        "Spotify") echo 󰓇 ;;
        "Sublime Text") echo 󰰡 ;;
        "System Settings") echo 󰒓 ;;
        "Telegram") echo  ;;
        "Things") echo 󰄲 ;;
        "Twitter") echo 󰕄 ;;
        *) echo 󰘔 ;;
    esac
}

get_app_icon "$1"
