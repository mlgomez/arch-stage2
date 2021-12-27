# What the hell is this?

This is my own personal "stage 2" install for Arch Linux.

It contains i3-gaps window manager with my pre-configured dotfiles. It's nothing extraordinarily special, but it helps automate my process of installing Arch on new systems.

It also has a unified theme applied to as many elements as possible. If you never riced Arch before, this will basically do it for you. Play around with the colors and enjoy.

# What gets installed

## Essentials

- A couple of useful monitoring utilities:
    - acpi - Allows for management and monitoring of battery
    - htop - CLI-based system monitor
- xorg
- sddm - A display manager for graphical login
- Pipewire audio server (via wireplumber + pipewire-pulse services for best compatibility & performance)
- i3-gaps (for those sweet, sweet gaps)
- Thumbnailers (ffmpegthumbs & ffmpegthumbnailer)
- feh - an image previewer that is also used to set wallpapers
- Authentication applications (gnome-keyring & polkit-kde-agent)
- dunst - A notification daemon
- picom - X compositor that allows for visual effects like dual kawase blur and shadows
- (optional) Tap-to-click functionality for touchpads. You'll get a prompt.

## Appearance

- qt5ct - Configuration utility for Qt applications
- lxappearance - Configuration utility for GTK+ applications
- Breeze - The KDE Breeze suite, for both Qt and GTK+, with icons
- Font Awesome - Used for icons in the bar
- DejaVu font - System font
- Fantasque Sans Mono Nerd Font - Used in terminal
- Weather Icons - For the weather module in the bar

## Utilities

- PCManFM - A graphical light-weight file manager
- ranger - A lighter-weight file manager that runs on the terminal with vim-like commands
- spectacle - KDE's screenshot utility, which can run CLI commands that are bound to keys
    - Shift+PrtScn = Copy area to clipboard
    - Ctrl+PrtScn = Opens spectacle after taking a shot
- Kate text editor
- Vim with system clipboard integration
- Alacritty - A terminal
    - In case you have problems running Alacritty, termite is also installed as an alternative
- Brave browser - A browser based on Chromium that blocks ads by default among other things
- cava - A pretty cool audio spectrum viewer
- EasyEffects - Powerful audio post-processing utility; I recommend running Belisarius Perfect EQ + Normalization preset. I found it to work best on most sound systems while balancing the audio.

## Shell

This custom script installs and sets up the fish shell with fzf, bat, starship, neofetch, and find-the-command utilities integrated into the config.fish file, almost entirely inspired by Garuda Linux.

# How to install

After you've finished installing Arch, get out of chroot and reboot into your newly installed system.

For best results, install only base packages + sudo and whatever else you need to get your installation complete and boot into a terminal.

After you're done and logged in, with your terminal in the home folder, install the things you need to run this script:

> pacman -S --needed base-devel git

Now it's time to clone this repository:

> git clone https://github.com/mlgomez/arch-stage2

Change directory to the new one:

> cd arch-stage2

Make sure the script is executable:

> chmod +x install.sh

Now just run the script:

> ./install.sh

Enjoy!

# Credit

- Shell configuration with Starship and other tools like fzf and bat were inspired largely by the work the Garuda team put in.
- Polybar configuration inspired by https://github.com/Yucklys/polybar-nord-theme
- EasyEffects presets were taken from https://github.com/JackHack96/PulseEffects-Presets; Belisarius Perfect EQ + Normalization preset drew inspiration from JackHack96's project.
- If you manage a project or know someone else I may have gotten dotfiles/inspiration from that I forgot about, feel free to post that ***politely*** in the Issues section and I'll mention them at my earliest convenience!
