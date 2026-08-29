#!/bin/sh
# Worktree items of the prefix-g menu: run "work-bradley <command>" in a
# floating pane. Starting in the worktree when invoked from a ticket
# window (tree picked implicitly), or in the main checkout (picker)
# otherwise.

cmd=${1:?usage: menu-bradley-worktree.sh <command>}

name=$(tmux display-message -p '#{window_name}')

if [ "$name" = "main" ]; then
    # Not a ticket window: start outside any tree so the picker shows up
    dir=$HOME/Projects/agvend/bradley
else
    # Ticket window: its panes live in the worktree
    dir=$(tmux display-message -p '#{pane_current_path}')
fi

tmux display-popup -E -w 80% -h 80% -T "bradley worktree $cmd" \
    -d "$dir" -e BRADLEY_POPUP=1 "fish -c 'work-bradley $cmd'"
