SPACE_ICONS=("web" "mnge" "comm" "dev" "3d" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")

sketchybar \
    --add event window_focus \
    --add event windows_on_spaces

for i in "${!SPACE_ICONS[@]}"; do
    sid=$(($i + 1))
    # "lctrl - 0" is bound to space 10
    key=$(($sid % 10))
    space=(
        background.color=$SPACE_BG
        icon=${SPACE_ICONS[i]}
        icon.color=$SPACE_FG
        icon.highlight_color=$SPACE_ACTIVE_FG
        icon.padding_right=10
        icon.y_offset=1
        label.color=$SPACE_FG
        label.drawing=off
        label.highlight_color=$SPACE_ACTIVE_FG
        label.y_offset=0
        label.padding_left=0
        script="$PLUGIN_DIR/space.sh"
        space=$sid
    )

    sketchybar \
        --add space space.$sid left \
        --set space.$sid ${space[@]} \
        icon.font="$TEXT_FONT" \
        label.font="$ICON_FONT" \
        click_script="/opt/homebrew/bin/yabai -m config mouse_follows_focus off && /opt/homebrew/bin/skhd -k 'alt - $key' && sleep 1 && /opt/homebrew/bin/yabai -m config mouse_follows_focus on" \
        --subscribe space.$sid window_focus space_windows_change \
        space_change \
        windows_on_spaces

done
