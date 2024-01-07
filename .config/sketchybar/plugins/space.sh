#!/bin/bash

source "$CONFIG_DIR/colors.sh"
BACKGROUND_COLOR=$SPACE_BG

if [ "$SELECTED" = "true" ]; then
    BACKGROUND_COLOR=$SPACE_ACTIVE_BG
fi

space=(
    background.color=$BACKGROUND_COLOR
    icon.highlight=$SELECTED
    label.highlight=$SELECTED
)

sketchybar --set $NAME ${space[@]}

CURRENT_SPACES="$(yabai -m query --displays | jq -r '.[].spaces | @sh')"
# args=(--set '/space\..*/')
args=()
while read -r line; do
    for space in $line; do
        icon_strip=""
        label_drawing="on"
        raw_apps=$(yabai -m query --windows --space $space | jq -r ".[].app")
        if [ "${raw_apps}" != "" ]; then
            while read -r app; do
                icon_strip+="$($CONFIG_DIR/app_icons.sh "$app") "
            done <<<"${raw_apps}"
        fi
        if [ "$icon_strip" = "" ]; then
            label_drawing="off"
        fi
        args+=(--set space.$space label="$icon_strip" label.drawing=$label_drawing)
    done
done <<<"$CURRENT_SPACES"

sketchybar -m "${args[@]}"
