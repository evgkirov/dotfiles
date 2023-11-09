yabai=(
  script="$PLUGIN_DIR/yabai.sh"
  associated_display=active
)

sketchybar --add event window_focus            \
           --add event windows_on_spaces       \
           --add item yabai left               \
           --set yabai "${yabai[@]}"           \
           --subscribe yabai window_focus      \
                             space_change      \
                             windows_on_spaces \
                             mouse.clicked
