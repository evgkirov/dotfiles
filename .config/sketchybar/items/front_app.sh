front_app=(
    label.color=$DATA_FRONT_APP
    icon.color=$DATA_FRONT_APP
    script="$PLUGIN_DIR/front_app.sh"
)

sketchybar --add item front_app left \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched

