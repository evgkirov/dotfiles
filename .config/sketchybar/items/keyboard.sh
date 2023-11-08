keyboard=(
    background.color=$ORANGE
    icon=󰌌                              
    script="$PLUGIN_DIR/keyboard.sh"      
    update_freq=1                      
)

sketchybar --add item keyboard right \
           --set keyboard "${keyboard[@]}"
