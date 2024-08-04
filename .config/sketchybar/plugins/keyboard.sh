#!/bin/sh
sketchybar --set $NAME label="$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID | sed 's/org.unknown.keylayout.ENSR/EN/g' | sed 's/org.unknown.keylayout.RUSR/RU/g' | sed 's/com.apple.keylayout.//g' | sed 's/RussianWin/RU/g')"
