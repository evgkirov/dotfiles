CURRENT_THEME=$(cat $HOME/.config/themes/current)

source $HOME/.config/themes/$CURRENT_THEME/sketchybar.sh

export DATA_FG="${DATA_FG:-$BAR_BG}"
export SPACE_ACTIVE_BG="${SPACE_ACTIVE_BG:-$SPACE_FG}"
export SPACE_ACTIVE_FG="${SPACE_ACTIVE_FG:-$SPACE_BG}"
export DATA_FRONT_APP_FG="${DATA_FRONT_APP_FG:-$SPACE_FG}"
export DATA_STACK_FG=$DATA_FRONT_APP_FG
