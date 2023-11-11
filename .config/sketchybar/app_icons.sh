#!/usr/bin/env bash

# prefixed with nf-md-
get_app_icon() {
    if [[ "$2" == *"- NVIM"* ]]; then
        echo 
        return
    fi

    case $1 in
        "AlDente") echo 󱅠 ;;
        "Anki") echo 󰓎 ;;
        "App Store") echo  ;;
        "Banktivity") echo 󰁰 ;;
        "Calculator") echo 󰃬 ;;
        "Calendar") echo 󰸗 ;;
        "Contacts") echo 󰛋 ;;
        "Day One") echo 󰃀 ;;
        "Dictionary") echo 󰗊 ;;
        "Discord") echo 󰙯 ;;
        "Docker Desktop") echo 󰡨 ;;
        "Find My") echo 󰐷 ;;
        "Finder") echo 󰀶 ;;
        "GitHub Desktop") echo 󰊤 ;;
        "Google Chrome") echo 󰊯 ;;
        "Home Assistant") echo 󰟐 ;;
        "Home") echo 󰋜 ;;
        "iTerm2") echo 󰞷 ;;
        "Keynote") echo 󰐨 ;;
        "Mail") echo 󰇮 ;;
        "Maps") echo 󰦂 ;;
        "Messages") echo 󰭹 ;;
        "Music") echo 󰝚 ;;
        "Notes") echo 󰎞 ;;
        "Numbers") echo 󰄨 ;;
        "Obsidian") echo 󰇈 ;;
        "Pages") echo 󰏪 ;;
        "Photos") echo  ;;
        "Pixelmator Pro") echo 󰃣 ;;
        "Podcasts") echo 󰦔 ;;
        "Reminders") echo 󰝖 ;;
        "Rocket.Chat") echo 󱓞 ;;
        "Safari") echo 󰀹 ;;
        "Session") echo 󰁫 ;;
        "Shortcuts") echo  ;;
        "Spotify") echo 󰓇 ;;
        "Sublime Text") echo 󰰡 ;;
        "System Settings") echo 󰒓 ;;
        "Telegram Desktop") echo  ;;
        "Telegram") echo  ;;
        "Things") echo 󰄲 ;;
        "TV") echo 󰠹 ;;
        "Twitter") echo 󰕄 ;;
        "Upwork") echo 󰰨 ;;
        "Weather") echo 󰖕 ;;
        # *) echo 󰘔 ;;
        *) echo  ;;
    esac
}

get_app_icon "$1"
