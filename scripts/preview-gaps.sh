#!/bin/sh

yabai -m config external_bar all:43:0
yabai -m config window_gap 10
yabai -m config top_padding 0
yabai -m config bottom_padding 10
yabai -m config left_padding 10
yabai -m config right_padding 10

sketchybar --bar color=0x00000000 padding_left=10 padding_right=10 height=43

killall borders
