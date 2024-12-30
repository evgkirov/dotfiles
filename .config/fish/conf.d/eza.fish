if status is-interactive

    if not command -v eza >/dev/null
        brew install eza
    end

    alias ls='eza --icons'
    alias la='eza -a --icons'
    alias ll='eza --icons -lagh --git'
    alias tree='eza --tree --icons'

end

