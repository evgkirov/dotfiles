#!/bin/bash

update() {
  source "$CONFIG_DIR/colors.sh"
  COLOR=$GREY2
  if [ "$SELECTED" = "true" ]; then
    COLOR=$RED
  fi
  sketchybar --set $NAME icon.highlight=$SELECTED \
                         label.highlight=$SELECTED \
                         background.border_color=$COLOR
}

set_space_label() {
  sketchybar --set $NAME icon="$@"
}

update
