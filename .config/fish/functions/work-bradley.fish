function work-bradley --description 'Bootstrap agvend work environment'
    # Requires exactly one subcommand
    if set -q argv[2]
        echo "usage: work-bradley up|down|destroy" >&2
        return 1
    end
    switch $argv[1]
        case up
            __work_bradley_start
        case down
            __work_bradley_down
        case destroy
            __work_bradley_destroy
        case ''
            echo "usage: work-bradley up|down|destroy" >&2
            return 1
        case '*'
            echo "work-bradley: unknown command '$argv[1]'" >&2
            echo "usage: work-bradley up|down|destroy" >&2
            return 1
    end
end

function __work_bradley_start
    # Everything below creates tmux panes/windows
    if not set -q TMUX
        echo "work-bradley: must be run inside a tmux session" >&2
        return 1
    end

    # Later tmux commands target this session by name
    tmux rename-session bradley

    set -l root ~/Projects/agvend/bradley
    if not test -d $root
        echo "work-bradley: cannot find $root" >&2
        return 1
    end

    # Ensure "main" exists: the session's first window becomes it, or it is
    # recreated detached when already gone and we're elsewhere
    if not contains -- main (tmux list-windows -t bradley -F '#{window_name}')
        if test (tmux display-message -p '#{window_index}') -eq 1
            tmux rename-window main
        else
            tmux new-window -d -n main -c "$root"
        end
    end

    # Focus main's first pane: dev-up and the picker belong there
    set -l main_pane (tmux display-message -p -t bradley:main.1 '#{pane_id}')
    tmux select-window -t bradley:main
    tmux select-pane -t "$main_pane"

    # The work runs in a floating pane; it re-enters here with the flag set
    if not set -q BRADLEY_POPUP
        tmux display-popup -E -w 80% -h 80% -T 'bradley worktree up' \
            -d "$root" -e BRADLEY_POPUP=1 'fish -c "work-bradley up"'
        return 0
    end

    # Work from the main checkout
    cd $root

    # The dev stack runs inside OrbStack
    orbctl start
    or begin
        echo "work-bradley: orbctl start failed" >&2
        return 1
    end

    # Bring up the shared dev services on every run
    ./bin/dev-up.sh --app --proxy -d

    # Container monitor beside the main shell, only if none is running
    if not contains -- lazydocker (tmux list-panes -s -t bradley -F '#{pane_current_command}')
        set -l lzd_pane (tmux split-window -h -d -P -F '#{pane_id}' -t bradley:main -c "$PWD")
        tmux send-keys -t "$lzd_pane" "lazydocker" Enter
    end

    # Pick a linked worktree (main excluded) or choose to create one
    set -l picked ({ git worktree list | awk 'NR>1'; and echo "Create new"; } | fzf --prompt 'bradley worktree> ')

    # fzf cancelled
    if not set -q picked[1]
        echo "Aborted"
        return 1
    end
    if test "$picked" = "Create new"
        echo "not implemented"
        return 0
    end

    # First token of the picked line is the worktree path
    set -l choice (string match -r '^\S+' -- $picked)

    # Ticket window already open -> just switch to it
    set -l ticket (basename $choice)
    if contains -- "$ticket" (tmux list-windows -t bradley -F '#{window_name}')
        tmux select-window -t "bradley:$ticket"
        return 0
    end

    # New window per ticket: shell | claude | nvim, side by side, evenly sized
    set -l win (tmux new-window -P -F '#{window_id}' -n "$ticket" -c "$choice")

    # Boot the worktree services in the window's shell pane
    tmux send-keys -t "$win" "./bin/worktree-up.sh" Enter

    # Claude pane (takes focus)
    set -l claude_pane (tmux split-window -h -P -F '#{pane_id}' -t "$win" -c "$choice")
    tmux send-keys -t "$claude_pane" "claude --effort=max" Enter

    # Nvim pane (keeps focus on claude)
    set -l nvim_pane (tmux split-window -h -d -P -F '#{pane_id}' -t "$win" -c "$choice")
    tmux send-keys -t "$nvim_pane" "nvim" Enter

    # Balance the three panes
    tmux select-layout -t "$win" even-horizontal
end

# Shared teardown prelude: resolve the worktree (implicit when inside one,
# otherwise fzf), ensure and focus its ticket window, and echo the path.
# Returns 1 when no worktrees exist or the picker is cancelled.
function __work_bradley_teardown_tree --argument-names verb
    set -l trees (git -C ~/Projects/agvend/bradley worktree list | awk 'NR>1' | string match -r '^\S+')
    if not set -q trees[1]
        echo "work-bradley: no worktrees found" >&2
        return 1
    end

    # Inside a worktree -> use it, otherwise pick one
    set -l choice
    for tree in $trees
        if string match -q -- "$tree" $PWD; or string match -q -- "$tree/*" $PWD
            set choice $tree
            break
        end
    end
    if not set -q choice[1]
        set choice ({ printf '%s\n' $trees; } | fzf --prompt "bradley worktree $verb> ")
        # fzf cancelled
        if not set -q choice[1]
            echo "Aborted"
            return 1
        end
    end

    # The ticket names both the worktree directory and its window
    set -l ticket (basename $choice)
    if not contains -- "$ticket" (tmux list-windows -t bradley -F '#{window_name}')
        tmux new-window -d -n "$ticket" -c "$choice"
    end
    tmux select-window -t "bradley:$ticket"

    echo $choice
end

function __work_bradley_down
    # Everything below drives tmux windows/panes
    if not set -q TMUX
        echo "work-bradley: must be run inside a tmux session" >&2
        return 1
    end

    set -l root ~/Projects/agvend/bradley
    if not test -d $root
        echo "work-bradley: cannot find $root" >&2
        return 1
    end

    # The work runs in a floating pane; it re-enters here with the flag set
    if not set -q BRADLEY_POPUP
        tmux display-popup -E -w 80% -h 80% -T 'bradley worktree down' \
            -d "$PWD" -e BRADLEY_POPUP=1 'fish -c "work-bradley down"'
        return 0
    end

    set -l choice (__work_bradley_teardown_tree down)
    or return 1
    set -l ticket (basename $choice)

    # Teardown: the pause lets the output be read before the window (and
    # this popup) goes; a failed teardown keeps the window around
    cd $choice
    ./bin/worktree-down.sh
    and read -P 'press enter to close '
    and tmux kill-window -t "bradley:$ticket"
    or read -P 'press enter to close '
end

function __work_bradley_destroy
    # Everything below drives tmux windows/panes
    if not set -q TMUX
        echo "work-bradley: must be run inside a tmux session" >&2
        return 1
    end

    set -l root ~/Projects/agvend/bradley
    if not test -d $root
        echo "work-bradley: cannot find $root" >&2
        return 1
    end

    # The work runs in a floating pane; it re-enters here with the flag set
    if not set -q BRADLEY_POPUP
        tmux display-popup -E -w 80% -h 80% -T 'bradley worktree destroy' \
            -d "$PWD" -e BRADLEY_POPUP=1 'fish -c "work-bradley destroy"'
        return 0
    end

    set -l choice (__work_bradley_teardown_tree destroy)
    or return 1
    set -l ticket (basename $choice)

    # Branch context for the decision: which branch the tree is on and
    # whether it still tracks a remote
    set -l branch (git -C $choice branch --show-current)
    set -l branch_info
    if not set -q branch[1]
        set branch_info "detached HEAD"
    else
        set -l upstream (git -C $root for-each-ref --format='%(upstream)' refs/heads/$branch)
        if not set -q upstream[1]
            set branch_info "$branch, local-only"
        else if string match -q '*gone*' -- (git -C $root for-each-ref --format='%(upstream:track)' refs/heads/$branch)
            set branch_info "$branch, remote gone"
        else
            set branch_info "$branch, has remote"
        end
    end

    # Deletion needs a deliberate yes: the full path and branch are on screen
    read -l -P "work-bradley: destroy $choice — $branch_info [y/N]? " confirm
    if test "$confirm" != y
        echo "Aborted"
        return 1
    end

    # Plain git remove: refuses on uncommitted/untracked files; the pause
    # lets the output be read before the window (and this popup) goes
    cd $choice
    ./bin/worktree-down.sh
    and git -C ~/Projects/agvend/bradley worktree remove $choice
    and read -P 'press enter to close '
    and tmux kill-window -t "bradley:$ticket"
    or read -P 'press enter to close '
end
