#!/bin/bash

if [ "$SENDER" = "media_change" ]; then
    state=$(jq -r '.state' <<<"$INFO")
    if [ "$state" = "playing" ]; then
        app=$(jq -r '.app' <<<"$INFO")
        title=$(jq -r '.title' <<<"$INFO")
        artist=$(jq -r '.artist' <<<"$INFO")

        label="${artist} – ${title}"
        [ -z "$artist" ] && label="$title"

        if [ "$app" = "Endel" ]; then
            label="$title"
        fi

        sketchybar --set $NAME \
            label="$label" \
            drawing=on \
            icon=$($CONFIG_DIR/app_icons.sh "$app") \
            click_script="osascript -e 'tell application \"$app\" to activate'"
    else
        sketchybar --set $NAME drawing=off
    fi
fi
