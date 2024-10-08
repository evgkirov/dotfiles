# Scheme name: Catppuccin Macchiato
# Scheme system: base16
# Scheme author: https://github.com/catppuccin/catppuccin
# Template author: Tinted Theming (https://github.com/tinted-theming)

_gen_fzf_default_opts() {

    local color00='#24273a'
    local color01='#1e2030'
    local color02='#363a4f'
    local color03='#494d64'
    local color04='#5b6078'
    local color05='#cad3f5'
    local color06='#f4dbd6'
    local color07='#b7bdf8'
    local color08='#ed8796'
    local color09='#f5a97f'
    local color0A='#eed49f'
    local color0B='#a6da95'
    local color0C='#8bd5ca'
    local color0D='#8aadf4'
    local color0E='#c6a0f6'
    local color0F='#f0c6c6'

    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS""\
 --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D""\
 --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C""\
 --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

}

_gen_fzf_default_opts
