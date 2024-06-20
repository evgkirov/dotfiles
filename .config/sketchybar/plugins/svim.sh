#!/usr/bin/env bash

source $CONFIG_DIR/colors.sh

DRAW_CMD="off"
if [ "$MODE" = "C" ]; then
    DRAW_CMD="on"
else
    DRAW_CMD="off"
fi

VISIBLE=on
COLOR=$DATA_SVIM_NORMAL
FULL_MODE=$MODE

if [ "$MODE" = "N" ]; then
    FULL_MODE="NORMAL"
elif [ "$MODE" = "_" ]; then
    FULL_MODE="NORMAL"
elif [ "$MODE" = "I" ]; then
    COLOR=$DATA_SVIM_INSERT
    FULL_MODE="INSERT"
elif [ "$MODE" = "V" ]; then
    FULL_MODE="VISUAL"
    COLOR=$DATA_SVIM_VISUAL
elif [ "$MODE" = "C" ]; then
    FULL_MODE="COMMAND"
    COLOR=$DATA_SVIM_COMMAND
elif [ "$MODE" = "" ]; then
    VISIBLE=off
fi

svim_mode=(
    background.color=$COLOR
    drawing=$VISIBLE
    label="$FULL_MODE"
    popup.drawing=$DRAW_CMD
)

sketchybar \
    --set svim.mode "${svim_mode[@]}" \
    --set svim.cmdline label="$CMDLINE"
