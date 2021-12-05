#!/bin/bash

#####################################################################
# This is a personal installation script for stage 2 of archinstall #
# Please run this only AFTER you have installed archlinux and       #
# logged in. Do not run this as root or with chroot.                #
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

# Run pacman -S --needed base-devel git before running this script!


##############################################
# Initial setup. Let's get the tools we need #
##############################################

# Set some variables for this script
workingdir=$PWD

# Get the user's password
echo "Please enter your user password to continue installation. Type 'fuckoff' to cancel."
read $passwd

if [[ $passwd == "fuckoff" ]]; then
	exit 1
fi

# Create typical subdirectories for home dir if they don't exist

mkdir $HOME/Downloads
mkdir $HOME/Documents
mkdir $HOME/Music
mkdir $HOME/Pictures
mkdir $HOME/Videos

# Before running package management, update system
echo $passwd | sudo pacman -Syu --noconfirm

# Let's install an AUR helper... Switch to home directory always when doing this!!

cd $HOME
git clone http://aur.archlinux.org/yay.git
cd yay
mkpkg -si --noconfirm

# NOTE: When using yay, attempt to pass --noconfirm just like with pacman
# This might help the installation process go along more smoothly.
# Echo $passwd as well so it can skip sudo

# Grab all the packages needed for graphics
echo $passwd | sudo pacman -S --needed xorg lightdm
echo $passwd | sudo systemctl enable lightdm

# Install i3-gaps and some other tools then copy configs
echo $passwd | sudo pacman -S --needed --noconfirm i3-gaps feh \
fish fzf bat starship alacritty easyeffects neofetch \
picom spectacle dunst polkit-kde-agend xorg-xrandr rofi plocate

# Install yay pkgs

echo $passwd | yay -S --needed --noconfirm polybar find-the-command \


# In case .config does not exist.....
mkdir $HOME/.config

cd $workingdir
cp dotfiles/alacritty $HOME/.config
cp dotfiles/easyeffects $HOME/.config
cp dotfiles/fish $HOME/.config
cp dotfiles/i3 $HOME/.config
cp dotfiles/picom $HOME/.config
cp dotfiles/polybar $HOME/.config
cp dotfiles/starship.toml $HOME/.config
echo $passwd | sudo cp dotfiles/ftc.fish /usr/share/doc/find-the-command

# Copy wallpapers and create wallpapers folder
mkdir $HOME/Wallpapers
find -iname '*.jpg' -exec cp {} $HOME/Wallpapers \;

# Start services

sudo systemctl start lightdm