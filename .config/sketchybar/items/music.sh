music=(
    background.color=$DATA_MUSIC_BG
    drawing=off
    label.max_chars=20
    script="$PLUGIN_DIR/music.sh"
    updates=on
    scroll_texts=on
)

sketchybar \
    --add item music right \
    --set music "${music[@]}" \
    --subscribe music media_change
