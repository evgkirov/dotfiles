SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  sketchybar --add space space.$sid left                                 \
             --set space.$sid space=$sid                                 \
                              icon=${SPACE_ICONS[i]}                     \
			      icon.color=0xffddc7a1 \
                     icon.padding_left=8                   \
                     icon.padding_right=8 \
			      label.color=0xffddc7a1 \
                              background.color=0xff7c6f64                \
                              background.corner_radius=5                 \
                              background.drawing=off                     \
                              label.drawing=off                          \
                              script="$PLUGIN_DIR/space_old.sh"              \
                              click_script="yabai -m space --focus $sid"
done


sketchybar --add item space_separator left                         \
           --set space_separator icon=                            \
	   			icon.color=0xff7c6f64    \
                                 padding_left=10                   \
                                 padding_right=10                  \
                                 label.drawing=off                
