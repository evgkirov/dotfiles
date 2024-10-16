# Scheme name: Edge Dark
# Scheme system: base16
# Scheme author: cjayross (https://github.com/cjayross)
# Template author: Tinted Theming (https://github.com/tinted-theming)

_gen_fzf_default_opts() {

    local color00='#262729'
    local color01='#88909f'
    local color02='#b7bec9'
    local color03='#3e4249'
    local color04='#73b3e7'
    local color05='#b7bec9'
    local color06='#d390e7'
    local color07='#3e4249'
    local color08='#e77171'
    local color09='#e77171'
    local color0A='#dbb774'
    local color0B='#a1bf78'
    local color0C='#5ebaa5'
    local color0D='#73b3e7'
    local color0E='#d390e7'
    local color0F='#5ebaa5'

    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS""\
 --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D""\
 --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C""\
 --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

}

_gen_fzf_default_opts
