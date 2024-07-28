#!/usr/bin/env bash

# Remove uneeded programs
echo "Uninstalling unwanted programs..."

pacman -R \
	epiphany

# Install applications
echo "Instaling applications..."
sudo pacman -Sy --needed \
	dmenu \
	xorg-server \
	xorg-xinit \
	xorg-xrandr \
	i3 \
	stow \
	neovim \
	feh \
	kitty \
	firefox \
	ufw \
	stow \
	ttf-font-awesome \
	ttf-jetbrains-mono

echo ""

# Setup firewall
echo "Setting up ufw..."
sudo ufw limit 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
echo ""

# Install yay
# Check if yay has already been installed 
if ! command -v yay &> /dev/null
then
	echo "Installing yay"
	pacman -S --needed git base-devel
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ..
else
	echo "Skipping, yay already installed"
fi

# Now that we have yay, let's install Picom
yay -S picom

# Stow configs
echo "Stowing config files"
stow i3/
stow rofi/
stow polybar/

# Copy polybar config
/echo "Copying polybar config"
#sudo cp -f polybar/config.ini /etc/polybar/config.ini

# Copy xinitrc if it does not exist
if ! test -f ~/.xinitrc
then
	echo "Copying xinitrc"
	cp ./xinitrc ~/.xinitrc
else
	echo "xinitrc already copied"
fi
