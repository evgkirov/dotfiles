#!/bin/sh

# Seamless pane/window navigation for tmux + yabai + nvim
# Expects TMUX_PANE to identify the invoking pane

direction=$1

tmux_bin=$(command -v tmux || echo /opt/homebrew/bin/tmux)
yabai_bin=$(command -v yabai || echo /opt/homebrew/bin/yabai)

case $direction in
    left)  flag=L; edge=left;   yabai_dir=west;  display=2 ;;
    down)  flag=D; edge=bottom; yabai_dir=south; display="" ;;
    up)    flag=U; edge=top;    yabai_dir=north; display="" ;;
    right) flag=R; edge=right;  yabai_dir=east;  display=1 ;;
    *) exit 1 ;;
esac

if [ -n "$TMUX_PANE" ]; then
    set -- $($tmux_bin display -p -t "$TMUX_PANE" "#{pane_at_${edge}} #{window_zoomed_flag} #{window_panes}")
    at_edge=$1 zoomed=$2 panes=$3
    if [ "$zoomed" = "1" ] && [ "$panes" -gt 1 ]; then
        exec $tmux_bin select-pane -t "$TMUX_PANE" "-$flag"
    fi
    if [ "$at_edge" != "1" ]; then
        exec $tmux_bin select-pane -t "$TMUX_PANE" "-$flag"
    fi
fi

if ! $yabai_bin -m window --focus "$yabai_dir"; then
    [ -n "$display" ] && $yabai_bin -m display --focus "$display"
fi
