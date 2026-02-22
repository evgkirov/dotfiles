SCRIPT_DIR="$(dirname "$0")"
MACOS_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

APPS_PLIST="$MACOS_DIR/dock-apps.plist"
OTHERS_PLIST="$MACOS_DIR/dock-others.plist"

TMPFILE="$(mktemp)"
defaults export com.apple.dock "$TMPFILE"

if [ -f "$APPS_PLIST" ]; then
    plutil -replace persistent-apps -xml "$(cat "$APPS_PLIST")" "$TMPFILE"
    echo "Restored persistent-apps"
fi

if [ -f "$OTHERS_PLIST" ]; then
    plutil -replace persistent-others -xml "$(cat "$OTHERS_PLIST")" "$TMPFILE"
    echo "Restored persistent-others"
fi

defaults import com.apple.dock "$TMPFILE"
rm -f "$TMPFILE"

killall Dock
