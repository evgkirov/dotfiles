#!/bin/sh

value=$(sketchybar --query $NAME | /opt/homebrew/bin/jq ".label.value" | tr -d "\"m")
value=$((value - 1))

sketchybar --set $NAME label="${value}m"
