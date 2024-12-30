function ghce --description 'Wrapper around `gh copilot explain` to explain a given input command in natural language.'
    set -l debug_mode $GH_DEBUG

    argparse 'd/debug' 'h/help' -- $argv
    or return

    if set -q _flag_help
        echo "USAGE
  ghce [flags] <command>

FLAGS
  -d, --debug   Enable debugging
  -h, --help    Display help usage

EXAMPLES

# View disk usage, sorted by size
ghce 'du -sh | sort -h'

# View git repository history as text graphical representation
ghce 'git log --oneline --graph --decorate --all'

# Remove binary objects larger than 50 megabytes from git history
ghce 'bfg --strip-blobs-bigger-than 50M'"
        return
    end

    if set -q _flag_debug
        set debug_mode 'api'
    end

    set -lx GH_DEBUG $debug_mode
    gh copilot explain $argv
end
