#!/bin/bash

if [ "$SENDER" = "media_change" ]; then
    state=$(jq -r '.state' <<<"$INFO")
    echo $state
    if [ "$state" = "playing" ]; then
        app=$(jq -r '.app' <<<"$INFO")
        title=$(jq -r '.title' <<<"$INFO")
        artist=$(jq -r '.artist' <<<"$INFO")
        sketchybar --set $NAME \
            label="$title by $artist" \
            drawing=on \
            icon=$($CONFIG_DIR/app_icons.sh "$app") \
            click_script="osascript -e 'tell application \"$app\" to activate'"
    else
        sketchybar --set $NAME drawing=off
    fi
fi
