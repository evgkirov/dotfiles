# Scheme name: Rosé Pine
# Scheme system: base16
# Scheme author: Emilia Dunfelt &lt;edun@dunfelt.se&gt;
# Template author: Tinted Theming (https://github.com/tinted-theming)

_gen_fzf_default_opts() {

    local color00='#191724'
    local color01='#1f1d2e'
    local color02='#26233a'
    local color03='#6e6a86'
    local color04='#908caa'
    local color05='#e0def4'
    local color06='#e0def4'
    local color07='#524f67'
    local color08='#eb6f92'
    local color09='#f6c177'
    local color0A='#ebbcba'
    local color0B='#31748f'
    local color0C='#9ccfd8'
    local color0D='#c4a7e7'
    local color0E='#f6c177'
    local color0F='#524f67'

    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS""\
 --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D""\
 --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C""\
 --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

}

_gen_fzf_default_opts
