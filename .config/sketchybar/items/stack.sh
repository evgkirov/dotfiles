stack=(
    display=active
    label.color=$DATA_STACK_FG
    script="$PLUGIN_DIR/stack.sh"
    icon.drawing=off
    label.padding_left=0
)

sketchybar \
    --add item stack left \
    --set stack "${stack[@]}" \
    --subscribe stack window_focus front_app_switched space_change space_windows_change display_change
