# Scheme name: Everforest Dark Hard
# Scheme system: base16
# Scheme author: Oskar Liew (https://github.com/OskarLiew)
# Template author: Tinted Theming (https://github.com/tinted-theming)

_gen_fzf_default_opts() {

    local color00='#272e33'
    local color01='#2e383c'
    local color02='#414b50'
    local color03='#859289'
    local color04='#9da9a0'
    local color05='#d3c6aa'
    local color06='#e4e1cd'
    local color07='#fdf6e3'
    local color08='#7fbbb3'
    local color09='#d699b6'
    local color0A='#dbbc7f'
    local color0B='#83c092'
    local color0C='#e69875'
    local color0D='#a7c080'
    local color0E='#e67e80'
    local color0F='#4c3743'

    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS""\
 --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D""\
 --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C""\
 --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

}

_gen_fzf_default_opts
