#!/bin/sh
sketchybar --set $NAME label="$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID | sed 's/org.sil.ukelele.keyboardlayout.t.english-ilyabirmantypography/EN/g' | sed 's/org.sil.ukelele.keyboardlayout.t.russian-ilyabirmantypography/RU/g' | sed 's/com.apple.keylayout.//g' | sed 's/RussianWin/RU/g')"

