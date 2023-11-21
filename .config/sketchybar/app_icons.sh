#!/usr/bin/env bash

# prefixed with nf-md-
get_app_icon() {
    if [[ "$2" == *"- NVIM"* ]]; then
        echo 
        return
    fi

    case $1 in
        "Activity Monitor") echo 󱕎 ;;
        "Arq") echo  ;;
        "AlDente") echo 󱅠 ;;
        "Anki") echo 󰓎 ;;
        "App Store") echo  ;;
        "Banktivity") echo 󰁰 ;;
        "Books") echo 󱓷 ;;
        "Calculator") echo 󰃬 ;;
        "Calendar") echo 󰸗 ;;
        "Clock") echo 󰥔 ;;
        "ChatGPT") echo 󰧑 ;;
        "Contacts") echo 󰛋 ;;
        "Day One") echo 󰃀 ;;
        "Dictionary") echo 󰗊 ;;
        "Discord") echo 󰙯 ;;
        "Docker Desktop") echo 󰡨 ;;
        "FaceTime") echo 󰕧 ;;
        "Find My") echo 󰐷 ;;
        "Finder") echo 󰀶 ;;
        "GitHub Desktop") echo 󰊤 ;;
        "Google Chrome") echo 󰊯 ;;
        "Home Assistant") echo 󰟐 ;;
        "Home") echo 󰋜 ;;
        "IINA") echo 󰐊 ;;
        "iTerm2") echo 󰞷 ;;
        "Keynote") echo 󰐨 ;;
        "Mail") echo 󰇮 ;;
        "Maps") echo 󰦂 ;;
        "Messages") echo 󰭹 ;;
        "MultiViewer for F1") echo 󰶓 ;;
        "Music") echo 󰝚 ;;
        "Notes") echo 󰎞 ;;
        "Numbers") echo 󰄨 ;;
        "Obsidian") echo 󰇈 ;;
        "Pages") echo 󰏪 ;;
        "Phanpy") echo 󰫑 ;;
        "Photos") echo  ;;
        "Poedit") echo 󰗊 ;;
        "Pixelmator Pro") echo 󰃣 ;;
        "Podcasts") echo 󰦔 ;;
        "Preview") echo 󰋩 ;;
        "Rakuten Viber") echo 󰖣 ;;
        "Reminders") echo 󰝖 ;;
        "Rocket.Chat") echo 󱓞 ;;
        "Safari") echo 󰀹 ;;
        "Session") echo 󰁫 ;;
        "Shortcuts") echo  ;;
        "Stocks") echo 󰄪 ;;
        "Spotify") echo 󰓇 ;;
        "Sublime Text") echo 󰰡 ;;
        "System Settings") echo 󰒓 ;;
        "TablePlus") echo 󰟆 ;;
        "Telegram Desktop") echo  ;;
        "Telegram") echo  ;;
        "Things") echo 󰄲 ;;
        "TV") echo 󰠹 ;;
        "Twitter") echo 󰕄 ;;
        "Upwork") echo 󰰨 ;;
        "Weather") echo 󰖕 ;;
        "WhatsApp") echo 󰖣 ;;
        "WhatsApp (old)") echo 󰖣 ;;
        # *) echo 󰘔 ;;
        *) echo  ;;
    esac
}

get_app_icon "$1"
