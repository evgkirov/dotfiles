echo "---> Running platform-specific install script"
sh macos/install.sh

echo "---> Stowing dotfiles to home directory"
stow -vv -t $HOME .
