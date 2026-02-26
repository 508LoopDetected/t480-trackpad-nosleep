# t480-trackpad-nosleep

Built/tested on Linux kernel 6.18.9-arch1-2. This fixes the trackpad on a ThinkPad T480 after upgrading to an X1 Extreme (Gen 1) glass trackpad. The replacement trackpad enters doze mode too aggressively, causing missed taps and input lag. This patches the `rmi_core` kernel module to set the `NOSLEEP` bit, keeping the trackpad awake.

A pacman hook automatically rebuilds the patched module whenever the kernel is upgraded.

## Usage

```
sudo ./install.sh    # install hook + patch current kernel, then reboot
sudo ./uninstall.sh  # remove hook + restore stock modules, then reboot
```
