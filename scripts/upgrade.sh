. scripts/utils.sh

fmt_header "Upgrading packages"

fmt_step "Running platform-specific upgrade script"
sh macos/upgrade.sh

fmt_success "Upgrade complete!"
