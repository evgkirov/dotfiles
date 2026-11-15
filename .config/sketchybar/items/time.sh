time=(
    background.color=$DATA_TIME_BG
    icon=
    script="$PLUGIN_DIR/time.sh"
    click_script="skhd -k \"lctrl - 2\" ; open -a Clock.app"
    update_freq=10
)

sketchybar \
    --add item time right \
    --set time "${time[@]}"
