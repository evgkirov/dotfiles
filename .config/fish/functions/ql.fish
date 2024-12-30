function ql --description 'QuickLook files, use -v for verbose mode'
    if test "$argv[1]" = "-v"
        set -e argv[1]
        qlmanage -p -d 4 $argv  # -d : debug level (1-4)
    else
        qlmanage -p $argv &>/dev/null  # silence
    end
end
