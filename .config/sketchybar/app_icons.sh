#!/usr/bin/env bash

# prefixed with nf-md-
get_app_icon() {
    if [[ "$2" == *"- NVIM"* ]]; then
        echo 
        return
    fi

    case $1 in
    "1Password") echo 󱉼 ;;
    "Activity Monitor") echo 󱕎 ;;
    "AetherSX2") echo  ;;
    "AlDente") echo 󱅠 ;;
    "Anki") echo 󰓎 ;;
    "App Store") echo  ;;
    "Arq") echo  ;;
    "Banktivity") echo 󰁰 ;;
    "BetterDisplay") echo 󰨇 ;;
    "Books") echo 󱓷 ;;
    "Calculator") echo 󰃬 ;;
    "Calendar") echo 󰸗 ;;
    "ChatGPT") echo 󰧑 ;;
    "CleanMyMac") echo 󰃢 ;;
    "Clock") echo 󰥔 ;;
    "Contacts") echo 󰛋 ;;
    "Cyberduck") echo 󰇥 ;;
    "Dash") echo D ;;
    "Day One") echo 󰃀 ;;
    "Dictionary") echo 󰗊 ;;
    "Discord") echo 󰙯 ;;
    "Docker Desktop") echo 󰡨 ;;
    "Docker") echo 󰡨 ;;
    "Endel") echo 󰥛 ;;
    "FaceTime") echo 󰕧 ;;
    "Fantastical") echo 󰸗 ;;
    "Figma") echo  ;;
    "Find My") echo 󰐷 ;;
    "Finder") echo 󰀶 ;;
    "GitHub Desktop") echo 󰊤 ;;
    "GitKraken") echo  ;;
    "Ghostty") echo 󰞷 ;;
    "Google Chrome Canary") echo 󰊯 ;;
    "Google Chrome") echo 󰊯 ;;
    "Google Meet") echo 󰕧 ;;
    "Hand Mirror") echo 󱇽 ;;
    "Home Assistant") echo 󰟐 ;;
    "Home") echo 󰋜 ;;
    "IINA") echo 󰐊 ;;
    "Keynote") echo 󰐨 ;;
    "Ledger Live") echo 󰖄 ;;
    "Little Snitch") echo 󰈐 ;;
    "Little Snitch Network Monitor") echo 󰈐 ;;
    "MacDown") echo  ;;
    "Macs Fan Control") echo 󰈐 ;;
    "Mail") echo 󰇮 ;;
    "Maps") echo 󰦂 ;;
    "Messages") echo 󰭹 ;;
    "MindNode") echo 󰌪 ;;
    "Menu Bar Controller for Sonos") echo 󰐎 ;;
    "MultiViewer for F1") echo 󰶓 ;;
    "Music") echo 󰝚 ;;
    "Neovide") echo  ;;
    "Notes") echo 󰎞 ;;
    "Numbers") echo 󰄨 ;;
    "OBS Studio") echo  ;;
    "Obsidian") echo 󰇈 ;;
    "OrbStack") echo 󰡨 ;;
    "Pages") echo 󰏪 ;;
    "Phanpy") echo 󰫑 ;;
    "Photos") echo  ;;
    "Pixelmator Pro") echo 󰃣 ;;
    "Podcasts") echo 󰦔 ;;
    "Poedit") echo 󰗊 ;;
    "Postico") echo 󰟆 ;;
    "Preview") echo 󰋩 ;;
    "PyCharm CE") echo 󰌠 ;;
    "PyCharm") echo 󰌠 ;;
    "QuickTime Player") echo  ;;
    "Rakuten Viber") echo 󰖣 ;;
    "Raycast") echo 󰍉 ;;
    "Reminders") echo 󰝖 ;;
    "Rocket.Chat") echo 󱓞 ;;
    "Safari") echo 󰀹 ;;
    "Session") echo 󰁫 ;;
    "Setapp") echo 󰣏 ;;
    "Shortcuts") echo  ;;
    "Slack") echo 󰒱 ;;
    "Sonos") echo 󰓃 ;;
    "Spotify") echo 󰓇 ;;
    "Steam") echo 󰓓 ;;
    "Steam Helper") echo 󰓓 ;;
    "Stocks") echo 󰄪 ;;
    "Sublime Text") echo 󰰡 ;;
    "System Settings") echo 󰒓 ;;
    "TV") echo 󰠹 ;;
    "TablePlus") echo 󰟆 ;;
    "Telegram Desktop") echo  ;;
    "Telegram") echo  ;;
    "Timing") echo 󰥔 ;;
    "Things") echo 󰄲 ;;
    "Tower") echo 󰴾 ;;
    "Transmission") echo 󰇚 ;;
    "Twitter") echo 󰕄 ;;
    "Ukelele") echo  ;;
    "Upwork") echo 󰰨 ;;
    "Weather") echo 󰖕 ;;
    "WezTerm") echo  ;;
    "WhatsApp (old)") echo 󰖣 ;;
    "WhatsApp") echo 󰖣 ;;
    "X") echo 󰕄 ;;
    "YouTube") echo 󰗃 ;;
    "Zed") echo 󰰶 ;;
    "iPhone Mirroring") echo  ;;
    "iTerm2") echo 󰞷 ;;
    "zoom.us") echo 󰕧 ;;
    *) echo 󰘔 ;;
    esac
}

get_app_icon "$1"
