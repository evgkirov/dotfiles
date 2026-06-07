. scripts/utils.sh

fmt_header "Installing dotfiles"

fmt_step "Running platform-specific install script"
sh macos/install.sh

fmt_step "Stowing dotfiles to home directory"
stow -vv -t $HOME .

fmt_step "Installing dot.fish"
sed "s|\$DATA_DIR|$(pwd)|g" scripts/dot.fish > ${HOME}/.config/fish/functions/dot.fish

fmt_success "Install complete!"
