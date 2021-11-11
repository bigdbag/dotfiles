#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
	# Write permissions for Homebrew 
	sudo chown -R $(whoami) /usr/local/include /usr/local/lib /usr/local/lib/pkgconfig
	chmod u+w /usr/local/include /usr/local/lib /usr/local/lib/pkgconfig

  echo "Checking for Homebrew..."
	# Check for Homebrew and install it if missing
	if test ! $(which brew)
	then
		echo "Installing Homebrew..."
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

  echo "Found Homebrew! Updating and upgrading..."
	# Make sure we’re using the latest Homebrew
	brew update

	# Upgrade any already-installed formulae
	brew tap homebrew/core
	brew tap heroku/brew
	brew upgrade

  echo "CLI Brewing"
	apps=(
		awscli
		dockutil
		git
		screen
		screenfetch
		tig
		tree
		v8-315
		wget
	)
  brew install "${apps[@]}"
	sudo easy_install pip

	# Install Caskroom
	brew tap homebrew/cask
	brew tap homebrew/cask-versions

  echo "App Brewing"

	apps=(
		zoom
		slack
		visual-studio-code
		firefox
		beekeeper-studio
		cyberduck
		microsoft-edge
    webstorm
    private-internet-access
    stats
    bettertouchtool
    bartender
    teamviewer
    app-cleaner
    unclutter
    clipy
    karabiner-elements
    vlc
    docker
    discord
		figma
		iterm2
		spotify
		postman
	)
	brew install --cask "${apps[@]}"

	# Remove outdated versions from the cellar
	brew cleanup

  echo "Setting MacOS defaults"
  osascript -e 'tell application "System Preferences" to quit'
  sudo -v
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
  sudo nvram SystemAudioVolume=" "
  defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
  sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
  launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null
  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
  defaults write NSGlobalDomain KeyRepeat -int 1
  defaults write NSGlobalDomain InitialKeyRepeat -int 10

  defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshots"
  defaults write com.apple.screencapture type -string "png"
  defaults write NSGlobalDomain AppleFontSmoothing -int 1
  sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
  defaults write com.apple.dock autohide-delay -float 0
  defaults write com.apple.terminal FocusFollowsMouse -bool true
  defaults write org.x.X11 wm_ffm -bool true
  defaults write com.googlecode.iterm2 PromptOnQuit -bool false




	# Set defaults
	defaults write com.apple.systemuiserver menuExtras -array
	"/System/Library/CoreServices/Menu Extras/Bluetooth.menu"
	"/System/Library/CoreServices/Menu Extras/Clock.menu" 
	"/System/Library/CoreServices/Menu Extras/Displays.menu"
	"/System/Library/CoreServices/Menu Extras/Volume.menu"
	killall SystemUIServer

  echo "Setting Dock Items"
	# Set Dock items
	OLDIFS=$IFS
	IFS=''

	apps=(
	  Launchpad
		'Microsoft Edge'
		'Visual Studio Code'
		Webstorm
		iTerm
		Spotify
		Slack
		'System Preferences'
	)

	dockutil --no-restart --remove all $HOME
	for app in "${apps[@]}"
	do
		echo "Keeping $app in Dock"
		dockutil --no-restart --add /Applications/$app.app $HOME
	done
	killall Dock

	# restore $IFS
	IFS=$OLDIFS

elif [ "$(uname)" == "Linux" ]; then
	# JDK
	sudo add-apt-repository ppa:linuxuprising/java

	# Make sure we’re using the latest repositories
	apt update

	# Upgrade any already-installed packages
	apt upgrade

	apps=(
		awscli
		figlet
		git
		golang-go
		graphviz
		mysql-server
		oracle-java16-installer
		postgresql postgresql-contrib
		screen
		screenfetch
		tig
		tree
		wget
		zsh
	)
	apt install "${apps[@]}"
	curl https://cli-assets.heroku.com/install.sh | sh

	# Remove no longer required packages
	sudo apt autoremove
fi

# Go to the base directory
cd "$(dirname "${BASH_SOURCE}")";
git init
git remote add origin git@github.com:ridhwaans/dotfiles.git

# Install submodules
git submodule add -f git@github.com:zsh-users/antigen.git .zsh/bundle
git submodule add -f git@github.com:nvm-sh/nvm.git .nvm
git submodule add -f git@github.com:jenv/jenv.git .jenv
git submodule add -f git@github.com:pyenv/pyenv.git .pyenv
cd .pyenv
git submodule add -f git@github.com:pyenv/pyenv-virtualenv.git plugins/pyenv-virtualenv
cd ..
git submodule add -f git@github.com:rbenv/rbenv.git .rbenv
cd .rbenv
git submodule add -f git@github.com:rbenv/ruby-build.git plugins/ruby-build
git submodule add -f git@github.com:jf/rbenv-gemset.git plugins/rbenv-gemset
cd ..

# Symlink dotfiles
git pull origin master;

for file in $(ls -A); do
if ! [[ "$file" =~ ^(.git|media|README.md|setup.sh|remote-setup.sh|setup-corp-ad-ctc.sh|setup-wishabi.sh)$ ]]; then 
	sudo ln -sf $PWD/$file $HOME/
fi
done

# Run `chsh -s $(which zsh)` to set ZSH as the default shell
# In Mac, add `zsh` to Full Disk Access in Security & Privacy (cmd+shift+G in Finder)
# Run `:PluginInstall` in Vim
# Install language versions, language package managers separately under version managers
