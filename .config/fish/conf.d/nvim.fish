if status is-interactive

    function e
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

    alias ei="cdi && e"

end
