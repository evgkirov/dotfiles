date=(
    background.color=$DATA_DATE
    icon=󰃭                               
    script="$PLUGIN_DIR/date.sh"         
    update_freq=60                        
)
sketchybar --add item date right \
           --set date "${date[@]}"
