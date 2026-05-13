. scripts/utils.sh

fmt_step "Installing packages from Brewfile"
brew bundle --cleanup --file=macos/Brewfile

fmt_step "Installing packages from npm"
bun install -g $(cat macos/npm-packages.txt)
bun update -g $(cat macos/npm-packages.txt)
