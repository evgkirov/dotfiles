. scripts/utils.sh

fmt_header "Running post-install tasks"

fmt_step "Running platform-specific post-install scripts"
run_dir macos/post_install.d

fmt_success "Post-install complete!"
