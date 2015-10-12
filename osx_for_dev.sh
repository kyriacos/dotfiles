#!/bin/sh

# Some things taken from here
# https://gist.github.com/matthewmueller/e22d9840f9ea2fee4716
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx

# Ask for the administrator password upfront
sudo -v

echo "This script will make your Mac awesome"

###############################################################################
# SSD-specific tweaks                                                         #
# ###############################################################################
#
# # Disable local Time Machine snapshots
# sudo tmutil disablelocal
#
# # Disable hibernation (speeds up entering sleep mode)
# sudo pmset -a hibernatemode 0
#
# # Remove the sleep image file to save disk space
# sudo rm /private/var/vm/sleepimage
# # Create a zero-byte file instead…
# sudo touch /private/var/vm/sleepimage
# # …and make sure it can’t be rewritten
# sudo chflags uchg /private/var/vm/sleepimage
#
# # Disable the sudden motion sensor as it’s not useful for SSDs
# sudo pmset -a sms 0

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
# ###############################################################################
echo ""
echo "Enabling full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo ""
echo "Disabling press-and-hold for keys in favor of a key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo ""
echo "Disabling auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo ""
echo "Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

echo ""
echo "Use scroll gesture with the Ctrl (^) modifier key to zoom"
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

echo ""
echo "Follow the keyboard focus while zoomed in"
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

###############################################################################
# Finder
# ###############################################################################

echo ""
echo "Showing icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

echo ""
echo "Showing status bar in Finder by default"
defaults write com.apple.finder ShowStatusBar -bool true

echo ""
echo "Allowing text selection in Quick Look/Preview in Finder by default"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo ""
echo "Displaying full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo ""
echo "Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv

echo ""
echo "Avoiding the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo ""
echo "Use list view in all Finder windows by default"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

echo ""
echo "When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo ""
echo "Show icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

echo ""
echo "Enabling snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

echo ""
echo "Show the ~/Library folder"
chflags nohidden ~/Library

###############################################################################
# Dock & Mission Control
# ###############################################################################

echo ""
echo "Setting Dock to auto-hide"
defaults write com.apple.dock autohide -bool true


echo ""
echo "Don’t automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

# Add iOS Simulator to Launchpad
# sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/iOS Simulator.app" "/Applications/iOS Simulator.app"

###############################################################################
# Hot Corners
# ###############################################################################
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
echo ""
echo "Setup hot corners"
echo "Top left screen corner → Mission Control"
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0
echo "Top right screen corner → Desktop"
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Start screen saver
#defaults write com.apple.dock wvous-bl-corner -int 5
#defaults write com.apple.dock wvous-bl-modifier -int 0

###############################################################################
# Safari & WebKit
# ###############################################################################
echo ""
echo "Enabling Safari's debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo ""
echo "Allow hitting the Backspace key to go to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

echo ""
echo "Enabling the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

echo ""
echo "Adding a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo ""
echo "Press Tab to highlight each item on a web page"
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

###############################################################################
# Mail
# ###############################################################################
#echo ""
#echo "Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
#defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

###############################################################################
# Time Machine
# ###############################################################################

echo ""
echo "Preventing Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
#hash tmutil &> /dev/null && sudo tmutil disablelocal

###############################################################################
# Activity Monitor                                                            #
# ###############################################################################

echo ""
echo "Show the main window when launching Activity Monitor"
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

echo ""
echo "Visualize CPU usage in the Activity Monitor Dock icon"
defaults write com.apple.ActivityMonitor IconType -int 5

echo ""
echo "Show all processes in Activity Monitor"
defaults write com.apple.ActivityMonitor ShowCategory -int 0

echo ""
echo "Sort Activity Monitor results by CPU usage"
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Mac App Store                                                               #
# ###############################################################################

echo ""
echo "Enable the WebKit Developer Tools in the Mac App Store"
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

echo ""
echo "Enable Debug Menu in the Mac App Store"
defaults write com.apple.appstore ShowDebugMenu -bool true

###############################################################################
# Spotlight                                                                   #
# ###############################################################################

# Hide Spotlight tray-icon (and subsequent helper)
# sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.

#sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

# Change indexing order and disable some search results
# Yosemite-specific search results (remove them if your are using OS X 10.9 or older):
#   MENU_DEFINITION
#   MENU_CONVERSION
#   MENU_EXPRESSION
#   MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
#   MENU_WEBSEARCH             (send search queries to Apple)
#   MENU_OTHER
#defaults write com.apple.spotlight orderedItems -array \
#  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
#  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
#  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
#  '{"enabled" = 1;"name" = "PDF";}' \
#  '{"enabled" = 1;"name" = "FONTS";}' \
#  '{"enabled" = 0;"name" = "DOCUMENTS";}' \
#  '{"enabled" = 0;"name" = "MESSAGES";}' \
#  '{"enabled" = 0;"name" = "CONTACT";}' \
#  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
#  '{"enabled" = 0;"name" = "IMAGES";}' \
#  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
#  '{"enabled" = 0;"name" = "MUSIC";}' \
#  '{"enabled" = 0;"name" = "MOVIES";}' \
#  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
#  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
#  '{"enabled" = 0;"name" = "SOURCE";}' \
#  '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
#  '{"enabled" = 0;"name" = "MENU_OTHER";}' \
#  '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
#  '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
#  '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
#  '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
# Load new settings before rebuilding the index
#killall mds > /dev/null 2>&1
# Make sure indexing is enabled for the main volume
#sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
#sudo mdutil -E / > /dev/null

###############################################################################
# Screen                                                                      #
# ###############################################################################
#
# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
# defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
# defaults write com.apple.screencapture disable-shadow -bool true

# echo ""
# echo "Enable subpixel font rendering on non-Apple LCDs"
# defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Enable HiDPI display modes (requires restart)
# sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true


###############################################################################
# Kill affected applications
# ###############################################################################
echo "Done! Some of the changes require a logout or restart."
