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
	stow 

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

# Stow configs
stow i3/
stow polybar/
stow rofi/

# Copy xinitrc if it does not exist
if ! test -f ~/.xinitrc
then
	echo "Copying xinitrc"
	cp ./xinitrc ~/.xinitrc
else
	echo "xinitrc already copied"
fi
