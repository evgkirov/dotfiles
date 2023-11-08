time=(
    background.color=$YELLOW          
    icon=                                
    script="$PLUGIN_DIR/time.sh"         
    update_freq=10
)

sketchybar --add item time right \
           --set time "${time[@]}"
