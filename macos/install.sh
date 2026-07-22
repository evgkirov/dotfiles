. scripts/utils.sh

fmt_step "Installing packages from Brewfile"
brew update
brew upgrade
brew bundle install --file=macos/Brewfile
brew bundle cleanup --file=macos/Brewfile --force
