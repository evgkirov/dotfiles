. scripts/utils.sh

fmt_step "Installing packages from Brewfile"
brew bundle --cleanup --file=macos/Brewfile
