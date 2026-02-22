. scripts/utils.sh

fmt_header "Dumping configurations"

fmt_step "Running platform-specific dump_config scripts"
run_dir macos/dump_config.d

fmt_success "Config dump complete!"
