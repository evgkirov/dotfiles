#!/bin/sh
yabai -m config external_bar all:38:0

yabai -m config window_gap 5
yabai -m config top_padding 0
yabai -m config bottom_padding 0
yabai -m config left_padding 0
yabai -m config right_padding 0

brew services restart sketchybar
