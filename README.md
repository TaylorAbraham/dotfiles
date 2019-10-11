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
https://wiki.archlinux.org/index.php/installation_guide
- Use WPA Supplicant for connecting to wifi
- Mounts are as follows:
    - mount /dev/nvme0n1p6 /mnt
    - mount /dev/nvme0n1p1 /mnt/boot/efi
    - mount /dev/nvme0n1p3 /mnt/windows

## Brightness keys not working
Edit `/etc/default/grub`, and in it add `acpi_osi=` to the end of the `GRUB_CMDLINE_LINUX_DEFAULT` boot parameters. If that doesn't work, consult https://wiki.archlinux.org/index.php/intel_graphics#Backlight_is_not_adjustable

## Mounting Windows with proper permissions
- Figure out your user id
- Mount with uid, gid set to yourself
- This will set you to have normal access to the /windows mount as if it was a home directory
- Regenerate fstab with genfstab
    - Make sure to mount other file systems

