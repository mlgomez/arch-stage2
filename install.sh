#!/bin/bash

#####################################################################
# This is a personal installation script for stage 2 of archinstall #
# Please run this only AFTER you have installed archlinux and       #
# logged in.                                                        #
#                                                                   #
# When running archinstall on installation DO NOT install a         #
# desktop environment. This script will install a window manager    #
# for you. You may choose to install a DE over this if you wish     #
# after the script has finished setting everything up for you.      #
#                                                                   #
# This script will install all i3-gaps with polybar and a few       #
# gizmos to get you started. Enjoy!                                 #
#                                                                   #
# Script by Miguel Leiva-Gomez                                      #
#####################################################################

#######################
# !!!! IMPORTANT !!!! #
# Extra Notes         #
#######################

# Nothing to see here


##################
# Initial setup. #
##################

echo "Welome to the Stage 2 installer for Arch Linux! This script will install a \
window manager and several other accompanying tools to partially automate the \
post-installation setup of Arch Linux on machines.\
\
Please pay attention to your screen while the installation process takes place.\
You will be prompted for your password at least once."


# Set some variables for this script
workingdir=$PWD

# Create typical subdirectories for home dir if they don't exist

if [[ ! -d "$HOME/Downloads" ]]; then
	mkdir "$HOME/Downloads"
fi

if [[ ! -d "$HOME/Documents" ]]; then
	mkdir "$HOME/Documents"
fi

if [[ ! -d "$HOME/Music" ]]; then
	mkdir "$HOME/Music"
fi

if [[ ! -d "$HOME/Pictures" ]]; then
	mkdir "$HOME/Pictures"
fi

if [[ ! -d "$HOME/Videos" ]]; then
	mkdir "$HOME/Videos"
fi


# Let's configure pacman before we run it.
sudo cp dotfiles/pacman.conf /etc/pacman.conf

# Before running package management, update system
sudo pacman -Syu --noconfirm

#################################
# Setting environment variables #
#################################

sudo echo "\
QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment

#####################
# Installing system #
#####################

# Grab the prerequisites for later in installation
sudo pacman -S --needed --noconfirm base-devel
sudo pacman -S --needed --noconfirm git

# Can't believe base package doesn't include this
sudo pacman -S --needed --noconfirm acpi

# Grab all the packages needed for graphics
sudo pacman -S --needed --noconfirm xorg
sudo pacman -S --needed --noconfirm sddm

# Grab what we need for audio in case we don't have it
sudo pacman -S --needed --noconfirm pipewire
sudo pacman -S --needed --noconfirm wireplumber
sudo pacman -S --needed --noconfirm pipewire-pulse

# We may need to enable audio services before installing anything else
systemctl enable --user pipewire wireplumber pipewire-pulse

# Install i3-gaps and some other tools
sudo pacman -S --needed --noconfirm i3-gaps

# Used for setting wallpaper and previewing images.
sudo pacman -S --needed --noconfirm feh

# Gotta get them thumbnails
sudo pacman -S --needed --noconfirm ffmpegthumbs
sudo pacman -S --needed --noconfirm ffmpegthumbnailer


sudo pacman -S --needed --noconfirm nano


# I like kate. Sue me.
sudo pacman -S --needed --noconfirm kate

# Shell stuff & terminal that we use for our specific fish config
sudo pacman -S --needed --noconfirm fish
sudo pacman -S --needed --noconfirm fzf
sudo pacman -S --needed --noconfirm bat
sudo pacman -S --needed --noconfirm starship
sudo pacman -S --needed --noconfirm alacritty
sudo pacman -S --needed --noconfirm neofetch
sudo pacman -S --needed --noconfirm pkgfile

# Audio post-processing
sudo pacman -S --needed --noconfirm easyeffects

# Screenshot utility for our i3 config
sudo pacman -S --needed --noconfirm spectacle

# Notification daemon
sudo pacman -S --needed --noconfirm dunst

# Authentication tools
sudo pacman -S --needed --noconfirm polkit-kde-agent
sudo pacman -S --needed --noconfirm gnome-keyring

# Launcher
sudo pacman -S --needed --noconfirm rofi

# File search utility; aliased to "locate" in fish config for convenience
sudo pacman -S --needed --noconfirm plocate

# Feather-light terminal-based file manager
sudo pacman -S --needed --noconfirm ranger

# Fonts
sudo pacman -S --needed --noconfirm ttf-font-awesome
sudo pacman -S --needed --noconfirm ttf-dejavu

# JSON navigator needed in some scripts like weather
sudo pacman -S --needed --noconfirm jq

# Get some theme files
sudo pacman -S --needed --noconfirm breeze
sudo pacman -S --needed --noconfirm breeze-gtk
sudo pacman -S --needed --noconfirm breeze-icons

# Get the theme configuration stuff.
sudo pacman -S --needed --noconfirm qt5ct
sudo pacman -S --needed --noconfirm lxappearance

# Lightweight GUI file manager
sudo pacman -S --needed --noconfirm pcmanfm

#########################
# Installing AUR Helper #
#########################

cd "$HOME" || exit 1

# Check if yay pkg exists

pacman -Qs yay
if [[ $? -ne 0 ]]; then
	# Maybe yay directory already exists. Run rm just in case.
	rm -rf "yay"

	# Download and install yay
	git clone http://aur.archlinux.org/yay.git
    cd "yay" || exit 1
    makepkg -si --noconfirm
fi

#########################################################
# NOTE: alacritty has problems running without gpu so   #
# let's install an alternative terminal just in case... #
#########################################################
yay -S --needed --noconfirm termite

# Install yay pkgs

# Vim with sysclipboard compatibility
yay -S --needed --noconfirm vim-clipboard

# NOTE: Polybar doesn't work with our network detection unless
# we use the dev version, for now
yay -S --needed --noconfirm polybar-git

# Some preliminary stuff for the fish shell
yay -S --needed --noconfirm find-the-command
yay -S --needed --noconfirm exa

# We need a browser.
yay -S --needed --noconfirm brave-bin

# Some fonts
yay -S --needed --noconfirm nerd-fonts-fantasque-sans-mono
yay -S --needed --noconfirm ttf-weather-icons

# Network management utility
yay -S --needed --noconfirm networkmanager-dmenu-git

# Audio spectrum display for terminal; pretty cool graphics.
yay -S --needed --noconfirm cava

# Picom-git needed because of --experimental-backends flag for blur.
yay -S --needed --noconfirm picom-git

######################
# Configuring system #
######################


# In case .config does not exist.....
if [[ ! -d "$HOME/.config" ]]; then
	mkdir "$HOME/.config"
fi

cd "$workingdir" || exit 1
cp -r dotfiles/alacritty "$HOME/.config"
cp -r dotfiles/easyeffects "$HOME/.config"
cp -r dotfiles/fish "$HOME/.config"
cp -r dotfiles/i3 "$HOME/.config"
cp -r dotfiles/picom "$HOME/.config"
cp -r dotfiles/polybar "$HOME/.config"
cp -r dotfiles/termite "$HOME/.config"
cp -r dotfiles/cava "$HOME/.config"
cp -r dotfiles/qt5ct "$HOME/.config"
cp -r dotfiles/gtk-3.0 "$HOME/.config"
cp -r dotfiles/.icons "$HOME"
cp dotfiles/starship.toml "$HOME/.config"
sudo cp dotfiles/ftc.fish /usr/share/doc/find-the-command

# Ask user if using touchpad
echo "Are you using a touchpad? y/n"
read -r touchpad

# Kinda clear I have no goddamn clue how to properly write a bash script.
if [ "$touchpad" == "y" ] || [ "$touchpad" == "Y" ] || [ "$touchpad" == "yes" ] || [ "$touchpad" == "Yes" ]; then
    echo "Would you like to enable tap to click on your touchpad?"
    read -r yn
    if [ "$yn" == "y" ] || [ "$yn" == "Y" ] || [ "$yn" == "yes" ] || [ "$yn" == "Yes" ]; then
        sudo mkdir -p /etc/X11/xorg.conf.d
        sudo cp dotfiles/90-touchpad.conf /etc/X11/xorg.conf.d/
    fi
fi

# Copy wallpapers and create wallpapers folder
mkdir "$HOME/Wallpapers"
cd "$workingdir/assets"
find . -iname '*.jpg' -exec cp {} "$HOME/Wallpapers" \;

# Let's do a chsh to try to change to the fish shell
echo "Changing shell to fish"
chsh -s /usr/bin/fish

##################
# Start services #
##################

echo "Enabling Services"
systemctl start --user pipewire wireplumber pipewire-pulse
sudo systemctl enable sddm
sudo systemctl start sddm
