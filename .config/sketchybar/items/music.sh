music=(
    background.color=$DATA_MUSIC
    label.max_chars="20"
    script="$PLUGIN_DIR/music.sh"
    scroll_texts="on"
)
sketchybar \
    --add item music right \
    --set music "${music[@]}" \
    --subscribe music media_change
