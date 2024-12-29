#!/bin/bash

# Exit if Not in Stack
CURRENT=$(yabai -m query --windows --window | jq '.["stack-index"]')
if [[ $CURRENT -eq 0 ]]; then
    sketchybar --set stack label=""
    exit 0
fi

LAST=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
sketchybar \
    --set stack label=$(printf "[%s/%s]" "$CURRENT" "$LAST")
