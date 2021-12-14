# What the hell is this?

This is my own personal "stage 2" install for Arch Linux.

It contains i3-gaps window manager with my pre-configured dotfiles. It's nothing extraordinarily special, but it helps automate my process of installing Arch on new systems.

If you like it, you're welcome to use it.

# What gets installed

The script installs:

- A graphical environment (xorg)
- A display manager for graphical login (sddm)
- Pipewire (via wireplumber + pipewire-pulse services for best compatibility & performance)
- i3-gaps (for those sweet, sweet gaps)
- kate (because I like it. sue me...)
- A custom shell based on Garuda Linux's config.fish
- Alacritty terminal (termite as well, in case you have trouble with GLX and other errors)
- A modern launcher (rofi)
- A special file locator (plocate, aliased to "locate" for convenience")
- A terminal file manager that does it all! (ranger)
- Many more packages and perhaps other stuff in the future.

# How to install

After you've finished installing Arch, get out of chroot and boot into your newly installed system.

For best results, install only base packages + sudo and whatever else you need to get your installation complete and boot into a terminal.

After you're done and logged in, with your terminal in the home folder, install the things you need to run this script:

> pacman -S --needed base-devel git

Now it's time to clone this repository:

> git clone https://github.com/mlgomez/arch-stage2-install

Change directory to the new one:

> cd arch-stage2-install

Make sure the script is executable:

> chmod +x stage2-default.sh

Now just run the script:

> ./stage2-default.sh

Enjoy!

# Credit

- Shell configuration with Starship and other tools like fzf and bat were inspired largely by the work the Garuda team put in.
- If you manage a project or know someone else I may have gotten dotfiles/inspiration from that I forgot about, feel free to post that ***politely*** in the Issues section and I'll mention them at my earliest convenience!
