echo "---> Updating Homebrew"
brew update

echo "---> Upgrading installed packages"
brew upgrade

echo "---> Running install script"
sh macos/install.sh
