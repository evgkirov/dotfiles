#!/bin/sh

brew install stow

echo

stow --simulate -v -t $HOME .

echo "\n\nProceed with symlinks? [y/N] "

read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    stow -v -t $HOME .
else
    echo "Stow operation cancelled."
fi
