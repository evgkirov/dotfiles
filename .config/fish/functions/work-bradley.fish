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

# The main checkout, in one place
function __work_bradley_root
    echo $HOME/Projects/agvend/bradley
end

# The pane the command was invoked from. Neither a run-shell child nor a popup
# inherits TMUX_PANE, so the tmux binding passes it in; a shell we were typed
# into has it already. Every tmux call below targets it, because an untargeted
# one resolves against whichever session tmux considers "best"
function __work_bradley_pane
    if set -q BRADLEY_PANE[1]; and test -n "$BRADLEY_PANE"
        echo $BRADLEY_PANE
    else if set -q TMUX_PANE[1]
        echo $TMUX_PANE
    end
end

# Registered linked worktrees, main checkout excluded, as "<path>\t<branch>".
# --porcelain keeps paths with spaces intact, unlike the padded human format,
# and carries the branch on its own line. Trees whose directory is gone stay
# registered (git calls them prunable) and must not reach the picker
function __work_bradley_list
    set -l rows (git -C (__work_bradley_root) worktree list --porcelain | awk '
        /^worktree / { path = substr($0, 10); branch = "" }
        /^branch /   { branch = substr($0, 8); sub("^refs/heads/", "", branch) }
        /^$/         { if (path != "") print path "\t" branch; path = "" }
        END          { if (path != "") print path "\t" branch }
    ')
    set -e rows[1]
    for row in $rows
        if test -d (string split -f1 \t -- $row)
            echo $row
        end
    end
end

# Just the paths out of the rows above
function __work_bradley_paths
    __work_bradley_list | string split -f1 \t
end

# Pick a worktree, listed as its path beside its branch. Any argument after the
# prompt becomes a literal entry below the worktrees. Echoes the chosen path, or
# the literal entry when one was picked. Returns 1 when fzf is cancelled
function __work_bradley_pick --argument-names prompt
    set -l extra $argv[2..-1]

    set -l paths
    set -l shown
    set -l branches
    for row in (__work_bradley_list)
        set -l path (string split -f1 \t -- $row)
        set -l branch (string split -f2 \t -- $row)
        if test -z "$branch"
            set branch '(detached)'
        end
        set -a paths $path
        set -a shown (string replace -- $HOME '~' $path)
        set -a branches $branch
    end

    # string pad with no width aligns every entry to the longest of them, which
    # is what lines the branch column up
    set -l padded (string pad -r -- $shown)
    set -l menu
    set -l i 1
    for branch in $branches
        set -a menu "$padded[$i]  $branch"
        set i (math $i + 1)
    end
    set -a menu $extra

    set -l picked (printf '%s\n' $menu | fzf --prompt $prompt)
    if test -z "$picked"
        return 1
    end

    # The menu runs parallel to $paths for the worktree rows; anything past
    # them is a literal entry that stands for itself
    set -l idx (contains -i -- $picked $menu)
    if test $idx -le (count $paths)
        echo $paths[$idx]
    else
        echo $picked
    end
end

# Re-enter the command inside a floating pane, carrying the invoking pane.
# -EE keeps the popup open when the command fails, which is what makes the
# error messages readable — a single -E closed it before they could be read
function __work_bradley_popup --argument-names cmd dir pane
    tmux display-popup -EE -w 80% -h 80% -T "bradley worktree $cmd" \
        -t $pane -d $dir -e "BRADLEY_PANE=$pane" \
        "fish -c 'work-bradley $cmd'"
end

# Shared prelude: check the checkout, resolve the invoking pane, and bounce into
# a floating pane when we are not in one yet. Echoes the session id that every
# later tmux call targets. Returns 2 once the popup has been spawned, 1 on failure
function __work_bradley_enter --argument-names cmd dir
    set -l root (__work_bradley_root)
    if not test -d $root
        echo "work-bradley: cannot find $root" >&2
        return 1
    end

    set -l pane (__work_bradley_pane)
    if test -z "$pane"
        echo "work-bradley: must be run inside a tmux session" >&2
        return 1
    end

    if not set -q BRADLEY_PANE[1]
        __work_bradley_popup $cmd $dir $pane
        return 2
    end

    set -l sid (tmux display-message -p -t $pane '#{session_id}')
    if test -z "$sid"
        echo "work-bradley: cannot resolve the session for pane $pane" >&2
        return 1
    end

    echo $sid
end

function __work_bradley_start
    set -l root (__work_bradley_root)

    set -l sid (__work_bradley_enter up $root)
    switch $status
        case 2
            return 0
        case 0
        case '*'
            return 1
    end

    # Treat bradley as a singleton: join an existing one rather than building a
    # second environment beside it. Only claim the name when it is free —
    # renaming over a live session fails, and the old code ignored that
    if tmux has-session -t =bradley 2>/dev/null
        set -l bradley_sid (tmux display-message -p -t =bradley '#{session_id}')
        if test "$bradley_sid" != "$sid"
            tmux switch-client -t =bradley
            set sid $bradley_sid
        end
    else
        tmux rename-session -t $sid bradley
    end

    # Ensure "main" exists. Reuse the session's sole window only while it is
    # still auto-named: window indexes are never renumbered, so "is this index
    # 1" would happily rename a ticket window that inherited the index
    if not contains -- main (tmux list-windows -t $sid -F '#{window_name}')
        set -l windows (tmux display-message -p -t $sid '#{session_windows}')
        set -l auto (tmux display-message -p -t $sid '#{?automatic-rename,1,0}')
        if test "$windows" = 1; and test "$auto" = 1
            tmux rename-window -t $sid main
        else
            tmux new-window -d -n main -t "$sid:" -c $root
        end
    end

    # Focus main's first pane: dev-up and the picker belong there
    tmux select-window -t "$sid:=main"
    tmux select-pane -t "$sid:=main.1"

    # The dev stack runs inside OrbStack
    orbctl start
    or begin
        echo "work-bradley: orbctl start failed" >&2
        return 1
    end

    # Bring up the shared dev services on every run. By absolute path: running
    # bin/dev-*.sh from inside a worktree builds a second, duplicate infra stack.
    # --app has to stay, or --remove-orphans sweeps the running app containers
    $root/bin/dev-up.sh --app --proxy -d
    or begin
        echo "work-bradley: dev-up.sh failed" >&2
        return 1
    end

    # Container monitor beside the main shell, only if none is running.
    # pane_current_command reverts to the shell the moment lazydocker exits, so
    # mark the pane instead — otherwise every re-run splits another one
    if not contains -- lazydocker (tmux list-panes -s -t $sid -F '#{@bradley_role}')
        set -l lzd_pane (tmux split-window -h -d -P -F '#{pane_id}' -t "$sid:=main" -c $root)
        tmux set -p -t $lzd_pane @bradley_role lazydocker
        tmux send-keys -t $lzd_pane lazydocker Enter
    end

    # Pick a linked worktree (main excluded) or choose to create one
    set -l picked (__work_bradley_pick 'bradley worktree> ' "Create new")
    # fzf cancelled. A deliberate abort is not a failure: returning non-zero
    # would leave the popup sitting open
    or begin
        echo Aborted
        return 0
    end

    set -l choice $picked
    if test "$picked" = "Create new"
        set choice (__work_bradley_create)
        or return 1
        if test -z "$choice"
            echo Aborted
            return 0
        end
    end

    # One directory, or nothing downstream makes sense: a helper that leaks a
    # stray line onto stdout would otherwise turn into tmux arguments
    if test (count $choice) -ne 1; or not test -d $choice[1]
        echo "work-bradley: unusable worktree path: $choice" >&2
        return 1
    end

    # Ticket window already open -> just switch to it
    set -l ticket (basename $choice)
    if contains -- $ticket (tmux list-windows -t $sid -F '#{window_name}')
        tmux select-window -t "$sid:=$ticket"
        return 0
    end

    # New window per ticket: shell | claude | nvim, side by side, evenly sized
    set -l win (tmux new-window -P -F '#{window_id}' -t "$sid:" -n $ticket -c $choice)

    # Boot the worktree services in the window's shell pane. worktree-up.sh has
    # no WT_PROJECT_ROOT override, so it has to be the worktree's own copy
    if test -x $choice/bin/worktree-up.sh
        tmux send-keys -t $win "$choice/bin/worktree-up.sh" Enter
    else
        tmux send-keys -t $win "echo 'no bin/worktree-up.sh in this worktree'" Enter
    end

    # Claude pane (takes focus)
    set -l claude_pane (tmux split-window -h -P -F '#{pane_id}' -t $win -c $choice)
    tmux send-keys -t $claude_pane "claude --effort=max" Enter

    # Nvim pane (keeps focus on claude)
    set -l nvim_pane (tmux split-window -h -d -P -F '#{pane_id}' -t $win -c $choice)
    tmux send-keys -t $nvim_pane nvim Enter

    # Balance the three panes
    tmux select-layout -t $win even-horizontal
end

# Create a worktree for a JIRA ticket and echo its path. Echoes nothing and
# returns 0 when the user aborts; returns 1 when creation fails.
# This function's stdout is the path and nothing else, because the caller
# captures it. read's -P prompt is safe here: fish draws it through the line
# editor to the terminal, not to stdout (a bare read would show "read>" instead)
function __work_bradley_create
    read -l -P 'bradley: JIRA ticket: ' ticket
    or return 0

    # A bare Enter leaves the variable set but empty, so test the value: "set -q
    # ticket[1]" is true here and only catches Ctrl-D
    set ticket (string trim -- $ticket)
    if test -z "$ticket"
        return 0
    end

    # Headless Claude builds the tree while this popup watches. Its running
    # commentary goes to stderr on purpose: this function's stdout is the
    # worktree path, and the caller captures it
    set -l before (__work_bradley_paths)
    if not claude -p "create a new worktree for JIRA ticket $ticket" >&2
        echo "work-bradley: worktree creation failed" >&2
        return 1
    end

    # The new tree is whatever the registry gained. Only a registered worktree
    # counts: the carcass a half-deleted checkout leaves behind is a directory
    # with the right name and nothing else in it
    set -l added
    for tree in (__work_bradley_paths)
        if not contains -- $tree $before
            set -a added $tree
        end
    end
    if test (count $added) -eq 0
        echo "work-bradley: no new worktree for '$ticket' found" >&2
        return 1
    end
    if test (count $added) -gt 1
        echo "work-bradley: several new worktrees after '$ticket': $added" >&2
        return 1
    end

    echo $added[1]
end

# Shared teardown prelude: resolve the worktree (implicit when we are inside
# one, otherwise fzf) and focus its ticket window if one is open. Echoes the
# path. Returns 1 when no worktrees exist, 2 when the picker is cancelled
function __work_bradley_teardown_tree --argument-names verb sid
    set -l trees (__work_bradley_paths)
    if not set -q trees[1]
        echo "work-bradley: no worktrees found" >&2
        return 1
    end

    # Ask git which worktree we are in. Prefix-matching $PWD confuses
    # BRAD-20583 with BRAD-20583-followup, and there are two such pairs
    set -l choice
    set -l top (git -C $PWD rev-parse --path-format=absolute --show-toplevel 2>/dev/null)
    if test -n "$top"; and contains -- $top $trees
        set choice $top
    end

    if test -z "$choice"
        # fzf cancelled. Reported through the exit status, not stdout, which the
        # caller is capturing
        set choice (__work_bradley_pick "bradley worktree $verb> ")
        or return 2
    end

    # One directory, or the caller would tear down something else entirely
    if test (count $choice) -ne 1; or not test -d $choice[1]
        echo "work-bradley: unusable worktree path: $choice" >&2
        return 1
    end

    # The ticket names both the worktree directory and its window. Do not create
    # the window when it is missing: a bare one would later make "up" believe
    # the tree is provisioned and skip worktree-up.sh entirely
    set -l ticket (basename $choice)
    if contains -- $ticket (tmux list-windows -t $sid -F '#{window_name}')
        tmux select-window -t "$sid:=$ticket"
    end

    echo $choice
end

function __work_bradley_down
    set -l root (__work_bradley_root)

    set -l sid (__work_bradley_enter down $PWD)
    switch $status
        case 2
            return 0
        case 0
        case '*'
            return 1
    end

    set -l choice (__work_bradley_teardown_tree down $sid)
    switch $status
        case 2
            echo Aborted
            return 0
        case 0
        case '*'
            return 1
    end
    set -l ticket (basename $choice)

    # Run main's copy against the tree rather than cd-ing into it: most
    # worktrees carry an older worktree-down.sh, and WT_PROJECT_ROOT works even
    # on a checkout that is already half-deleted
    WT_PROJECT_ROOT=$choice $root/bin/worktree-down.sh

    # worktree-down.sh guards every step with || true and returns 0 even when it
    # finds no stack, so there is no failure signal here to branch on
    if contains -- $ticket (tmux list-windows -t $sid -F '#{window_name}')
        tmux kill-window -t "$sid:=$ticket"
    end
end

function __work_bradley_destroy
    set -l root (__work_bradley_root)

    set -l sid (__work_bradley_enter destroy $PWD)
    switch $status
        case 2
            return 0
        case 0
        case '*'
            return 1
    end

    set -l choice (__work_bradley_teardown_tree destroy $sid)
    switch $status
        case 2
            echo Aborted
            return 0
        case 0
        case '*'
            return 1
    end
    set -l ticket (basename $choice)

    # Branch context for the decision: which branch the tree is on and whether
    # it still tracks a remote
    set -l branch (git -C $choice branch --show-current)
    set -l branch_info
    if test -z "$branch"
        set branch_info "detached HEAD"
    else
        # for-each-ref prints an empty line when there is no upstream, and fish
        # captures that as one empty element — so test the value, not the count,
        # or a never-pushed branch reads as "has remote" at the confirmation
        set -l upstream (git -C $root for-each-ref --format='%(upstream:short) %(upstream:track)' refs/heads/$branch | string trim)
        if test -z "$upstream"
            set branch_info "$branch, local-only"
        else if string match -q '*gone*' -- $upstream
            set branch_info "$branch, remote gone"
        else
            set branch_info "$branch, has remote"
        end
    end

    # Deletion needs a deliberate yes: the full path and branch are on screen
    read -l -P "work-bradley: destroy $choice — $branch_info [y/N]? " confirm
    or begin
        echo Aborted
        return 0
    end
    if test "$confirm" != y
        echo Aborted
        return 0
    end

    WT_PROJECT_ROOT=$choice $root/bin/worktree-down.sh

    # Plain git remove: refuses on uncommitted/untracked files
    if not git -C $root worktree remove $choice
        echo "work-bradley: git worktree remove failed" >&2
        return 1
    end

    if contains -- $ticket (tmux list-windows -t $sid -F '#{window_name}')
        tmux kill-window -t "$sid:=$ticket"
    end
end
