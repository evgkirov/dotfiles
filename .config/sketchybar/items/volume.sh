volume=(
    background.color=$DATA_VOLUME_BG
    script="$PLUGIN_DIR/volume.sh"
)

sketchybar \
    --add item volume right \
    --set volume "${volume[@]}" \
    --subscribe volume volume_change
