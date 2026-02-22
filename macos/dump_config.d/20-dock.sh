. scripts/utils.sh

SCRIPT_DIR="$(dirname "$0")"
MACOS_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

fmt_step "Exporting Dock layout to plist files"
defaults export com.apple.dock - | plutil -extract persistent-apps xml1 -o "$MACOS_DIR/dock-apps.plist" -
defaults export com.apple.dock - | plutil -extract persistent-others xml1 -o "$MACOS_DIR/dock-others.plist" -

fmt_success "Saved dock-apps.plist and dock-others.plist"
