function dot
    set -l start_dir (pwd)
    cd $DATA_DIR
    switch $argv[1]
        case cd
            return
        case '*'
            make $argv
    end
    cd $start_dir
end

# Completions for dot command
complete -c dot -f
complete -c dot -a "(grep -E '^\.PHONY:' $DATA_DIR/Makefile | sed 's/\.PHONY: //' | tr ' ' '\n')"
complete -c dot -a cd -d "Change to dotfiles directory"

