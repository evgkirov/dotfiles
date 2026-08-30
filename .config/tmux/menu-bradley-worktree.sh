#!/bin/sh

# Worktree items of the prefix-g menu: run "work-bradley <command>" in a
# floating pane anchored to the pane the key was pressed in.
# Expects TMUX_PANE to identify the invoking pane (see bind g in tmux.conf)

cmd=${1:?usage: menu-bradley-worktree.sh <command>}

tmux_bin=$(command -v tmux || echo /opt/homebrew/bin/tmux)

case $cmd in
    up | down | destroy) ;;
    *)
        $tmux_bin display-message "menu-bradley-worktree: unknown command '$cmd'"
        exit 1
        ;;
esac

# Every tmux call below needs the invoking pane; without it they would resolve
# against whichever session tmux considers "best", which is how "down" ends up
# tearing down a worktree the user is not looking at
if [ -z "$TMUX_PANE" ]; then
    $tmux_bin display-message 'menu-bradley-worktree: TMUX_PANE is not set'
    exit 1
fi

# Start where the pane is. work-bradley decides from the worktree registry
# whether that path is inside a tree, so no window-name guessing here
dir=$($tmux_bin display-message -p -t "$TMUX_PANE" '#{pane_current_path}')

$tmux_bin display-popup -EE -w 80% -h 80% -T "bradley worktree $cmd" \
    -t "$TMUX_PANE" -d "$dir" -e "BRADLEY_PANE=$TMUX_PANE" \
    "fish -c 'work-bradley $cmd'"
