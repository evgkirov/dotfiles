svim_mode=(
    background.color=$DATA_SVIM_NORMAL
    icon=
    popup.align=right
    script="sketchybar --set svim.mode popup.drawing=off"
    drawing=off
)

sketchybar \
    --add item svim.mode right \
    --set svim.mode "${svim_mode[@]}" \
    --subscribe svim.mode front_app_switched window_focus \
    --add item svim.cmdline popup.svim.mode \
    --set svim.cmdline icon="Command: "
