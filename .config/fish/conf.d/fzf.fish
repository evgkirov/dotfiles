if status is-interactive

    if not command -v fzf >/dev/null
        brew install fzf
    end

    fzf --fish | source

end

