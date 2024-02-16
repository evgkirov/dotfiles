session=(
    background.color=$DATA_SESSION
    drawing=off
    icon=
    label=0
    script="$PLUGIN_DIR/session.sh"
    update_freq=60
    updates=when_shown
)

sketchybar \
    --add item session right \
    --set session "${session[@]}"
