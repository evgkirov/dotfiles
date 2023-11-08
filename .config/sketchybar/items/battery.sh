battery=(
    background.color=$VIOLET
    script="$PLUGIN_DIR/battery.sh"       
    update_freq=120                       
)

sketchybar  --add item battery right                            \
           --set battery "${battery[@]}" \
           --subscribe battery system_woke power_source_change \

