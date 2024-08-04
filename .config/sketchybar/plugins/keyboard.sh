#!/bin/sh
sketchybar --set $NAME label="$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID | sed 's/com.evgkirov.keyboardlayout.custom.en+sr/EN/g' | sed 's/com.evgkirov.keyboardlayout.custom.ru+sr/RU/g')"
