#!/bin/sh

if [ "$SENDER" = "front_app_switched" ]; then
    sketchybar --set $NAME label="$INFO" icon=$($CONFIG_DIR/app_icons.sh "$INFO")
fi
