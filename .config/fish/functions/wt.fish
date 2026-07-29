function wt --wraps="cd (git worktree list | awk '{print }' | fzf)" --description "alias wt cd (git worktree list | awk '{print }' | fzf)"
    cd (git worktree list | fzf | awk '{print $1}') $argv
end
