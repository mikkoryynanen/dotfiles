#!/usr/bin/env bash

# Remove uneeded programs
echo "Uninstalling unwanted programs..."

sudo pacman -R \
	epiphany

# Install applications
echo "Instaling applications..."
sudo pacman -S \
	i3 \
	dmenu \
	xorg-server \
	xorg-xinit \
	xorg-util \
	yay \
	stow \
	neovim \

