. scripts/utils.sh

fmt_header "Checking for outdated packages"

fmt_step "Running platform-specific outdated script"
sh macos/outdated.sh

fmt_success "Done!"
