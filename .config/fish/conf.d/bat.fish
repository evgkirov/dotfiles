if status is-interactive

    if not command -v bat >/dev/null
        brew install bat
    end

    # alias cat='bat'

end

