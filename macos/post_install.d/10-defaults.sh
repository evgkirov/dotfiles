. scripts/utils.sh

fmt_step "Writing NSGlobalDomain defaults"
defaults write NSGlobalDomain AppleFontSmoothing -int 0
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain InitialKeyRepeat -int 20
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

fmt_step "Writing Dock defaults"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock show-recents -bool false

fmt_step "Writing Finder defaults"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
defaults write com.apple.finder FXRemoveOldTrashItems -bool true
defaults write com.apple.finder NewWindowTarget -string "PfHm"

fmt_step "Writing screen capture defaults"
defaults write com.apple.screencapture location -string "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Screen Shots/"

fmt_step "Restarting affected processes"
killall Dock
killall Finder
killall SystemUIServer

fmt_success "System defaults applied"
