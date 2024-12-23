# Scheme name: Nord
# Scheme system: base16
# Scheme author: arcticicestudio
# Template author: Tinted Theming (https://github.com/tinted-theming)

_gen_fzf_default_opts() {

    local color00='#2e3440'
    local color01='#3b4252'
    local color02='#434c5e'
    local color03='#4c566a'
    local color04='#d8dee9'
    local color05='#e5e9f0'
    local color06='#eceff4'
    local color07='#8fbcbb'
    local color08='#bf616a'
    local color09='#d08770'
    local color0A='#ebcb8b'
    local color0B='#a3be8c'
    local color0C='#88c0d0'
    local color0D='#81a1c1'
    local color0E='#b48ead'
    local color0F='#5e81ac'

    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS""\
 --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D""\
 --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C""\
 --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

}

_gen_fzf_default_opts
