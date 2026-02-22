. scripts/utils.sh

fmt_step "Updating Homebrew"
brew update

fmt_step "Upgrading installed packages"
brew upgrade

fmt_step "Running install script"
sh macos/install.sh
