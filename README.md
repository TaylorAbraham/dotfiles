# Overview
My personal dotfiles and an installer script to set them up

# Installation
```
git clone https://github.com/RyanAbraham/dotfiles.git
cd dotfiles
./dot-install.sh
```

# Personal Notes
These notes are primarily for my own reference, for easily setting up my OS

## Arch Installation
- Use WPA Supplicant for connecting to wifi

## Brightness keys not working
Edit `/etc/default/grub`, and in it add `acpi_osi=` to the end of the `GRUB_CMDLINE_LINUX_DEFAULT` boot parameters. If that doesn't work, consult https://wiki.archlinux.org/index.php/intel_graphics#Backlight_is_not_adjustable
