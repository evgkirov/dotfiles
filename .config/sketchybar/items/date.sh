date=(
    background.color=$DATA_DATE_BG
    icon=󰃭
    script="$PLUGIN_DIR/date.sh"
    click_script="skhd -k \"lctrl - 2\" ; open -a Calendar.app"
    update_freq=60
)

sketchybar \
    --add item date right \
    --set date "${date[@]}"
