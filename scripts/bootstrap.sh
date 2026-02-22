#!/bin/bash

# Inline formatting since this script runs standalone via curl|bash
_BOLD='\033[1m'
_DIM='\033[2m'
_BLUE='\033[34m'
_GREEN='\033[32m'
_CYAN='\033[36m'
_RESET='\033[0m'

_header() { printf "\n${_BOLD}${_BLUE}==>${_RESET} ${_BOLD}%s${_RESET}\n" "$1"; }
_step() { printf "  ${_CYAN}-->${_RESET} %s\n" "$1"; }
_info() { printf "  ${_DIM}%s${_RESET}\n" "$1"; }
_success() { printf "  ${_GREEN}%s${_RESET}\n" "$1"; }

CLONE_DIR=~/Projects/dotfiles
REPO=evgkirov/dotfiles

_header "Bootstrapping dotfiles"

_step "Creating parent directory: $(dirname "$CLONE_DIR")"
mkdir -p "$(dirname "$CLONE_DIR")"

if [ ! -d "$CLONE_DIR" ]; then
    _step "Cloning dotfiles repository"
    _info "$REPO -> $CLONE_DIR"
    git clone https://github.com/$REPO.git "$CLONE_DIR"
else
    _info "Directory $CLONE_DIR already exists, skipping clone"
fi

cd "$CLONE_DIR" || exit 1

_step "Setting git remote to SSH"
git remote set-url origin "git@github.com:$REPO.git"

_step "Running platform-specific bootstrap scripts"
. scripts/utils.sh
run_dir macos/bootstrap.d

_success "Bootstrap complete!"
