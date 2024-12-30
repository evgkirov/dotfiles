if status is-interactive

    if not command -v starship >/dev/null
        brew install starship
    end

    starship init fish | source

end

