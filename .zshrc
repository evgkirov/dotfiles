# https://www.youtube.com/watch?v=ud7YxC33Z3w

# Essentials
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"


# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Change cursor shape for different vi modes.
# https://unix.stackexchange.com/a/614203
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

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

# GitHub
eval "$(gh copilot alias -- zsh)"
alias \?=ghcs

# Zoxide
which zoxide &>/dev/null || brew install zoxide
eval "$(zoxide init --cmd cd zsh)"
alias ..="cd .."

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

# Keybindings
# bindkey -e  # C-a, C-e
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward
# autoload -U up-line-or-beginning-search
# autoload -U down-line-or-beginning-search
# zle -N up-line-or-beginning-search
# zle -N down-line-or-beginning-search
# bindkey "^[[A" up-line-or-beginning-search # Up
# bindkey "^[[B" down-line-or-beginning-search # Down

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
export EDITOR=nvim
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
alias ei="cdi && e"

# Other aliases
alias web="docker compose run --rm web"
alias af1="ssh -t dokku@af1"
alias yabai_post_update='echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai'
function ql() {
    if [[ "$1" == '-v' ]]; then
    shift
        qlmanage -p -d 4 "$@"  # -d : debug level (1-4)
    else
        qlmanage -p "$@" &>/dev/null  # silence
    fi
}


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

# Welcome screen

# 1. fortune + cowsay
which fortune &> /dev/null || brew install fortune
which cowsay &> /dev/null || brew install cowsay
fortune -s | cowsay

# 2. cutefetch
# if [ ! -f $HOME/.local/opt/cutefetch/cutefetch ]; then
#     git clone https://github.com/cybardev/cutefetch.git $HOME/.local/opt/cutefetch
#     cd $HOME/.local/opt/cutefetch
#     git checkout 9ed7cd87a89ab8f0f4b2b51fb8b4dd1ee64e46bf
#     chmod +x $HOME/.local/opt/cutefetch/cutefetch
# fi
# $HOME/.local/opt/cutefetch/cutefetch
#
# 3. pfetch
# which pfetch &> /dev/null || brew install pfetch
# PF_COL2=0 PF_INFO="ascii title os host uptime pkgs memory shell wm de" pfetch
# PF_COL2=0 PF_INFO="ascii title os host kernel uptime pkgs memory shell wm de" pfetch
#
# 4. fastfetch
# which fastfetch &> /dev/null || brew install fastfetch
# fastfetch
