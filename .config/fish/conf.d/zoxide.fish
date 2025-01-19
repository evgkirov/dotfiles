if status is-interactive

    if not command -v zoxide >/dev/null
        brew install zoxide
    end

    zoxide init fish --cmd cd | source

end

