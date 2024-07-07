SPACE_ICONS=("web" "mnge" "comm" "dev" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")
# SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")

sketchybar \
    --add event window_focus \
    --add event windows_on_spaces

for i in "${!SPACE_ICONS[@]}"; do
    sid=$(($i + 1))
    space=(
        background.color=$SPACE_BG
        # click_script="yabai -m space --focus $sid"
        icon=${SPACE_ICONS[i]}
        icon.color=$SPACE_FG
        icon.highlight_color=$SPACE_ACTIVE_FG
        icon.padding_right=8
        icon.y_offset=1
        label.color=$SPACE_FG
        label.drawing=off
        label.highlight_color=$SPACE_ACTIVE_FG
        label.y_offset=0
        script="$PLUGIN_DIR/space.sh"
        space=$sid
    )

    sketchybar \
        --add space space.$sid left \
        --set space.$sid ${space[@]} \
        icon.font="$TEXT_FONT" \
        label.font="$ICON_FONT" \
        click_script="yabai -m config mouse_follows_focus off && yabai -m space --focus $sid && sleep 1 && yabai -m config mouse_follows_focus on" \
        --subscribe space.$sid window_focus \
        space_change \
        windows_on_spaces

done

# sketchybar --add item space_separator left                         \
#            --set space_separator icon=                            \
# 	   			icon.color=$GREY0    \
#                                  padding_left=10                   \
#                                  padding_right=10                  \
#                                  label.drawing=off
