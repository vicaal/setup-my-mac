#!/usr/bin/env bash

COMPUTER_NAME=$1
LOCAL_HOST_NAME=$2

# Close any open System Preferences panes, to prevent them from overriding settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# For reference:
# https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/
# https://github.com/mathiasbynens/dotfiles/blob/master/.macos

# Keybord: Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2

# Keyboard: Enable Key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Set a blazingly fast trackpad speed
defaults write -g com.apple.trackpad.scaling -float 5.0

# Finder: show hidden files
defaults write com.apple.finder AppleShowAllFiles YES

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: Disable warning when chaning file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Finder: Show files and directories as list
# TODO Fix - Works, but the value is reseted
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Finder: Set default search folder to current folder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Finder: Open folders in new window instead of tab
defaults write com.apple.finder FinderSpawnTab -bool false

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Finder: Set default Finder location to home
defaults write com.apple.finder NewWindowTarget -string "PfLo" && \
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

# Finder: Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
    Privileges -bool true

# Power Management: Disable computer sleep forever
sudo systemsetup -setcomputersleep Never

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: map tap with two fingers to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Dock: Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Dock: Disable Dock auto hide delay!
defaults write com.apple.dock autohide-delay -float 0

# Dock: Disable Dock popup animation
defaults write com.apple.dock autohide-time-modifier -float 0

# Dock: Set pinning to Center
defaults write com.apple.dock pinning -string middle

# Dock: Set position to Left
defaults write com.apple.Dock orientation -string left

# Dock: Set the icon size of Dock items
defaults write com.apple.dock tilesize -int 32

# Dock: Make Dock size immutable
defaults write com.apple.Dock size-immutable -bool yes

# Dock: Make Dock immutable
defaults write com.apple.dock contents-immutable -bool true

# Dock: Don't show recent apps
defaults write com.apple.dock show-recents -bool FALSE

# Dock: Wipe all app icons from the Dock
defaults write com.apple.dock persistent-apps -array

# Dock: Add Firefox to Dock
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Firefox.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

# Dock: Add VSCode to Dock
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Visual Studio Code.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

# Dock: Add iTerm to Dock
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/iTerm.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

# Dock: Add Spotify to Dock
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Spotify.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

# MenuBar: Show battery percentage in Menu Bar
defaults write com.apple.menuextra.battery ShowPercent YES

# MenuBar: Sets date format in Menu Bar - See http://nsdateformatter.com/ for rerefence
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm:ss"

# MenuBar: Flash separators (I like to count the seconds)
defaults write com.apple.menuextra.clock FlashDateSeparators -bool true

# MenuBar: Add Bluetooth, AirPort (WiFi), Battery, Volume
defaults write com.apple.systemuiserver menuExtras -array \
	"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
	"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
	"/System/Library/CoreServices/Menu Extras/Battery.menu" \
	"/System/Library/CoreServices/Menu Extras/Volume.menu"

# Network: Sets the computer name
sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName "$LOCAL_HOST_NAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"

# Login Items: Add Alfred to Login Items
osascript -e 'tell application "System Events" to make login item at end with properties {name: "Alfred 4", path:"/Applications/Alfred 4.app", hidden:false}'

# Login Items: Add Karabiner-Elements to Login Items
osascript -e 'tell application "System Events" to make login item at end with properties {name: "Karabiner-Elements", path:"/Applications/Karabiner-Elements.app", hidden:false}'

# Disable Dashboard forever!
defaults write com.apple.dashboard mcx-disabled -boolean TRUE

# Enable full keyboard access for all controls (enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set highlight color to blue
defaults write NSGlobalDomain AppleHighlightColor -string "0.0 0.0 1.0"

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disables screen saver
defaults -currentHost write com.apple.screensaver idleTime 0

# iTunes: Prevent iPhone from syncing automatically
defaults write com.apple.iTunes DeviceBackupsDisabled -bool true
defaults write com.apple.iTunes AutomaticDeviceBackupsDisabled -bool true

# iTunes: Prevent from opening automatically when a iOS device is connected
defaults write com.apple.iTunesHelper ignore-devices 1

# Use scroll gesture with the Ctrl (^) modifier key to zoom
# TODO Fix - Seens like a problem in Mojave
# defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad HIDScrollZoomModifierMask -int 262144
defaults write com.apple.AppleMultitouchTrackpad HIDScrollZoomModifierMask -int 262144
/usr/libexec/PlistBuddy -c "Set :closeViewScrollWheelToggle true" ~/Library/Preferences/com.apple.universalaccess.plist

# Remove all tags from contextual menu
/usr/libexec/PlistBuddy -c "Delete :FavoriteTagNames" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Add :FavoriteTagNames array" ~/Library/Preferences/com.apple.finder.plist

# Hot corners
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
# Top left screen corner → Mission Control
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Show application windows
defaults write com.apple.dock wvous-bl-corner -int 3
defaults write com.apple.dock wvous-bl-modifier -int 0
# Bottom right screen corner → no-op
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

# Kill apps
for app in "Activity Monitor" \
	"Address Book" \
	"cfprefsd" \
	"Dock" \
	"Finder" \
	"Messages" \
	"Photos" \
	"Safari" \
	"ControlStrip" \
	"SystemUIServer"; do
	killall "${app}"
done
