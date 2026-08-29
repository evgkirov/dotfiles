function work-bradley --description 'Bootstrap agvend work environment'
    # Requires exactly one subcommand
    if set -q argv[2]
        echo "usage: work-bradley up|down" >&2
        return 1
    end
    switch $argv[1]
        case up
            __work_bradley_start
        case down
            __work_bradley_down
        case ''
            echo "usage: work-bradley up|down" >&2
            return 1
        case '*'
            echo "work-bradley: unknown command '$argv[1]'" >&2
            echo "usage: work-bradley up|down" >&2
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

    # Not running there yet -> relay, that run does the work
    if test "$TMUX_PANE" != "$main_pane"
        tmux send-keys -t "$main_pane" "work-bradley up" Enter
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

    # Linked worktrees (main checkout excluded)
    set -l trees (git -C $root worktree list | awk 'NR>1' | string match -r '^\S+')
    if not set -q trees[1]
        echo "work-bradley: no worktrees to take down" >&2
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
        set choice ({ printf '%s\n' $trees; } | fzf --prompt 'bradley worktree down> ')
        # fzf cancelled
        if not set -q choice[1]
            echo "Aborted"
            return 1
        end
    end

    # The ticket names both the worktree directory and its window
    set -l ticket (basename $choice)

    # Ensure the ticket window exists, then switch to it
    if not contains -- "$ticket" (tmux list-windows -t bradley -F '#{window_name}')
        tmux new-window -d -n "$ticket" -c "$choice"
    end
    tmux select-window -t "bradley:$ticket"

    # Teardown: inline when this pane is the menu popup (which then waits
    # for the script), otherwise in a fresh pane of the ticket window; the
    # window dies when worktree-down finishes either way
    if set -q BRADLEY_POPUP
        cd $choice
        ./bin/worktree-down.sh
        tmux kill-window -t "bradley:$ticket"
    else
        tmux split-window -t "bradley:$ticket" -c "$choice" "./bin/worktree-down.sh; tmux kill-window -t bradley:$ticket"
    end
end
