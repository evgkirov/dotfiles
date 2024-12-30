# https://gist.github.com/fourthdimension/b9c0b80c60d57406f602fde12fa6470a

function ghcs --description 'Wrapper around `gh copilot suggest` to suggest a command based on a natural language description of the desired output effort. Supports executing suggested commands if applicable.'
    # Check if any arguments were provided
    if not set -q argv[1]
        echo "Please provide a description of the desired output."
        return 1
    end

    # Combine all arguments into a single query string
    set -l query (string join " " $argv)

    # Call gh copilot suggest with the provided query
    gh copilot suggest -t shell "$query"
end
 
