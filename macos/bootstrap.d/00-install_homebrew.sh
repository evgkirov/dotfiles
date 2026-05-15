. scripts/utils.sh

fmt_step "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

fmt_step "Adding Homebrew to PATH"
echo >>/Users/evgkirov/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >>/Users/evgkirov/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv zsh)"
