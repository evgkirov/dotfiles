battery=(
    background.color=$DATA_BATTERY
    script="$PLUGIN_DIR/battery.sh"       
    click_script="open -a AlDente.app"
    update_freq=120                       
)

sketchybar --add item battery right \
           --set battery "${battery[@]}" \
           --subscribe battery system_woke power_source_change

