#!/bin/bash
#
# Installs the rmi4 nosleep pacman hook.
# Run once after a fresh Arch install or from your dotfiles.
#
# What it does:
#   1. Installs linux-headers (needed to build modules)
#   2. Copies the patch, hook script, and pacman hook into place
#   3. Runs the hook once to patch the current kernel
#
# After this, kernel upgrades via yay/pacman automatically rebuild
# the patched module. No manual steps needed.
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

green()  { printf '\033[1;32m%s\033[0m\n' "$*"; }
yellow() { printf '\033[1;33m%s\033[0m\n' "$*"; }

# Install linux-headers if missing
if ! pacman -Q linux-headers &>/dev/null; then
    yellow "Installing linux-headers..."
    sudo pacman -S --needed linux-headers
fi

# Copy files into system locations
yellow "Installing hook files..."
sudo mkdir -p /usr/local/share/rmi4-nosleep
sudo cp "$SCRIPT_DIR/rmi4-nosleep.patch" /usr/local/share/rmi4-nosleep/
sudo cp "$SCRIPT_DIR/rmi4-nosleep-hook" /usr/local/bin/rmi4-nosleep-hook
sudo chmod +x /usr/local/bin/rmi4-nosleep-hook
sudo mkdir -p /etc/pacman.d/hooks
sudo cp "$SCRIPT_DIR/90-rmi4-nosleep.hook" /etc/pacman.d/hooks/

# Run the hook now to patch the current kernel
yellow "Patching current kernel..."
sudo /usr/local/bin/rmi4-nosleep-hook

green "Done! The rmi4 nosleep patch will auto-apply on every kernel upgrade."
green "Reboot to activate (or run: sudo modprobe -r rmi_smbus && sudo modprobe rmi_smbus)"
