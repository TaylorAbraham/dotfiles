# Overview
My personal dotfiles and an installer script to set them up

# Installation
```
git clone git@github.com:RyanAbraham/dotfiles.git
cd dotfiles
./dot-install.sh
```

# General Post-Installation

## Zsh + OhMyZsh
```
sudo apt update && sudo apt upgrade -y
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Important utilities
```
sudo apt install -y tmux inotify-tools ruby-dev
```

## "Important" utilities
```
sudo apt install -y neofetch lolcat cowsay fortune-mod youtube-dl
```

## SSH Keys
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

# WSL Installation
1. Through the Microsoft Store, install a Linux distro of your choice and Windows Terminal
2. Follow in full: https://docs.microsoft.com/en-us/windows/wsl/wsl2-install
3. Open Terminal settings and set Ubuntu to the default, and fix the starting directory to be your WSL home instead of your Windows home
```
"startingDirectory" : "//wsl$/Ubuntu/home/<USERNAME>"
```
4. Follow instructions above for installing Zsh + OhMyZsh
5. Set up Windows ssh keys in a Powershell prompt, and add them to GitHub
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
cat C:\Users\ryan_\.ssh\id_rsa.pub | clip
```
6. Set up WSL ssh keys and fix private key permissions (NOTE: cp is used instead of making a symlink because this allows file permissions of your private key to be fixed)
```
cp -r /mnt/c/Users/<USERNAME>/.ssh ~/.ssh
chmod 600 ~/.ssh/id_rsa
```
7. Install dotfiles
```
cd ~
git clone git@github.com:RyanAbraham/dotfiles.git
cd dotfiles
./dot-install.sh
```
8. Install Node LTS (nvm is currently very bugged with WSL 2)
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
nvm i --lts
```
9. Fix tmux re-prompting you for sudo password by disabling tty tickets
```
sudo su
visudo /etc/sudoers
```
And add `Defaults:<USERNAME> !tty_tickets`

**Install complete!**

# Arch Installation
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
