#!/bin/sh
osascript -e 'tell application "Safari" to activate
tell application "System Events"
  tell process "Safari"
    click menu item "New Private Window" of menu "File" of menu bar 1
  end tell
end tell'
