volume=(
    background.color=$DATA_VOLUME_BG
    script="$PLUGIN_DIR/volume.sh"
    update_freq=60
)

sketchybar \
    --add item volume right \
    --set volume "${volume[@]}" \
    --subscribe volume volume_change
