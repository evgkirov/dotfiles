#!/bin/bash

CLONE_DIR=~/Projects/dotfiles
REPO=evgkirov/dotfiles

echo "---> Creating parent directory: $(dirname "$CLONE_DIR")"
mkdir -p "$(dirname "$CLONE_DIR")"

if [ ! -d "$CLONE_DIR" ]; then
    echo "---> Cloning dotfiles repository from $REPO to $CLONE_DIR"
    git clone https://github.com/$REPO.git "$CLONE_DIR"
else
    echo "---> Directory $CLONE_DIR already exists, skipping clone"
fi

cd "$CLONE_DIR" || exit 1
echo "---> Setting git remote to SSH"
git remote set-url origin "git@github.com:$REPO.git"

echo "---> Running platform-specific bootstrap scripts"
scripts/utils/run_dir.sh macos/bootstrap.d
