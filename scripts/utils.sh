#!/bin/bash

# Shared utilities for dotfiles scripts
# Source this file to use: . scripts/utils.sh

# --- Formatting ---

_FMT_BOLD='\033[1m'
_FMT_DIM='\033[2m'
_FMT_BLUE='\033[34m'
_FMT_GREEN='\033[32m'
_FMT_YELLOW='\033[33m'
_FMT_CYAN='\033[36m'
_FMT_RESET='\033[0m'

fmt_header() {
    printf "\n${_FMT_BOLD}${_FMT_BLUE}==>${_FMT_RESET} ${_FMT_BOLD}%s${_FMT_RESET}\n" "$1"
}

fmt_step() {
    printf "  ${_FMT_CYAN}-->${_FMT_RESET} %s\n" "$1"
}

fmt_info() {
    printf "  ${_FMT_DIM}%s${_FMT_RESET}\n" "$1"
}

fmt_success() {
    printf "  ${_FMT_GREEN}%s${_FMT_RESET}\n" "$1"
}

fmt_warning() {
    printf "  ${_FMT_YELLOW}%s${_FMT_RESET}\n" "$1"
}

fmt_run_script() {
    printf "  ${_FMT_CYAN}-->${_FMT_RESET} Running ${_FMT_DIM}%s${_FMT_RESET}\n" "$1"
}

# --- Script runner ---

run_dir() {
    local dir="$1"
    for script in "$dir"/*.sh; do
        if [ -f "$script" ]; then
            fmt_run_script "$script"
            sh "$script"
        fi
    done
}
