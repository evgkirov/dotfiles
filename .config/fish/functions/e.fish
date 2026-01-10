function e --wraps='nvim' --description 'Open nvim in a directory or file'
    if test -n "$argv[1]"
        if test -f "$argv[1]"
            nvim $argv[1]
        else
            __zoxide_z $argv[1]
            venv_activate
            nvim
        end
    else
        nvim
    end
end
