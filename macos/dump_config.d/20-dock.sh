SCRIPT_DIR="$(dirname "$0")"
MACOS_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

defaults export com.apple.dock - | plutil -extract persistent-apps xml1 -o "$MACOS_DIR/dock-apps.plist" -
defaults export com.apple.dock - | plutil -extract persistent-others xml1 -o "$MACOS_DIR/dock-others.plist" -

echo "Saved dock-apps.plist and dock-others.plist"
