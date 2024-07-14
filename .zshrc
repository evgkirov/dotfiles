# https://www.youtube.com/watch?v=ud7YxC33Z3w

# Essentials
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Welcome screen
# which nerdfetch &> /dev/null || brew install nerdfetch
# nerdfetch

# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Prompt
which starship &>/dev/null || brew install starship
eval "$(starship init zsh)"

# Completions
zinit light zsh-users/zsh-completions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
autoload -U compinit && compinit
zinit light Aloxaf/fzf-tab  # fzf-tab needs to be loaded after compinit, but before plugins which will wrap widgets, such as zsh-autosuggestions or fast-syntax-highlighting
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=247"

# Zoxide
which zoxide &>/dev/null || brew install zoxide
eval "$(zoxide init --cmd cd zsh)"

# Eza
which eza &>/dev/null || brew install eza
alias ls='eza --icons'
alias la='eza -a --icons'
alias ll='eza --icons -lagh --git'
alias tree='eza --tree --icons'

# Bat
which bat &>/dev/null || brew install bat
alias cat='bat'

# Fzf
which fzf &>/dev/null || brew install fzf
eval "$(fzf --zsh)"
CURRENT_THEME=$(cat $HOME/.config/themes/current)
source "$HOME/.config/themes/$CURRENT_THEME/fzf.sh"
# export FZF_DEFAULT_OPTS=" \
#  --color=bg:0,fg:7,hl:3\
#  --color=bg+:8,fg+:15,hl+:11\
#  --color=info:3,border:3,prompt:4,query:15\
#  --color=pointer:0,marker:9,spinner:9,header:1\
#  --layout=reverse"

# Keybindings
bindkey -e  # C-a, C-e
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Neovim (btw)
e() {
  if [ -n "$1" ]
  then
    if [ -f "$1" ]
    then
      nvim $1
    else
      eval "$(zoxide init zsh)"
      z $1
      nvim
    fi
  else
    nvim
  fi
}

# Other aliases
alias web="docker compose run --rm web"
alias af1="ssh -t dokku@af1"

# Theming
select_theme() {
    choice=$(fd -td --format {/} . $HOME/.config/themes | fzf)
    if [[ -v choice ]]; then
        echo "Selected $choice"
        echo $choice > $HOME/.config/themes/current
        source $HOME/.zshrc
        touch $HOME/.config/wezterm/wezterm.lua
        touch $HOME/.config/sketchybar/sketchybarrc
    fi
}

# must be at the end
zinit light zsh-users/zsh-syntax-highlighting
