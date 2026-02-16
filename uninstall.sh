#!/bin/bash
#
# Removes the rmi4 nosleep pacman hook and restores stock modules.
#

set -euo pipefail

green()  { printf '\033[1;32m%s\033[0m\n' "$*"; }
yellow() { printf '\033[1;33m%s\033[0m\n' "$*"; }

yellow "Removing hook files..."
sudo rm -f /etc/pacman.d/hooks/90-rmi4-nosleep.hook
sudo rm -f /usr/local/bin/rmi4-nosleep-hook
sudo rm -rf /usr/local/share/rmi4-nosleep

yellow "Reinstalling linux package to restore stock modules..."
sudo pacman -S --noconfirm linux

green "Done! Reboot to load the stock rmi4 module."
