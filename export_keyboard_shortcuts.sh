#!/bin/sh
#
# Snapshot current macOS keyboard shortcuts into dots/macos/ for version control.
# Run this whenever you update shortcuts in System Settings > Keyboard.

set -e

DEST="$HOME/.dotfiles/dots/macos"

echo "Exporting keyboard shortcuts to $DEST"

cp ~/Library/Preferences/com.apple.symbolichotkeys.plist "$DEST/"
plutil -convert xml1 "$DEST/com.apple.symbolichotkeys.plist"
echo "  ✓ com.apple.symbolichotkeys"

cp ~/Library/Preferences/com.apple.ServicesMenu.Services.plist "$DEST/"
plutil -convert xml1 "$DEST/com.apple.ServicesMenu.Services.plist"
echo "  ✓ com.apple.ServicesMenu.Services"

echo ""
echo "Done. Commit the changes in dots/macos/ to save them."
