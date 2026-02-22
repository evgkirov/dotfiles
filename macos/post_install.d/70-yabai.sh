. scripts/utils.sh

fmt_step "Installing yabai service"
yabai --install-service || fmt_warning "yabai service already installed"

fmt_step "Starting yabai service"
yabai --start-service
