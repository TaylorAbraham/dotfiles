# Overview
My personal dotfiles and an installer script to set them up. In this guide I reference my unix username `tay` and my Windows account folder name `taylo`, so change them to your folder names accordingly.

- [Dotfile Installation](#dotfile-installation)
- [General Post-OS Install/Setup](#general-post-os-installsetup)
  * [Zsh + OhMyZsh](#zsh--ohmyzsh)
  * [Important utilities](#important-utilities)
  * ["Important" utilities](#important-utilities)
  * [SSH Keys](#ssh-keys)
  * [npm Global Without sudo](#npm-global-without-sudo)
- [WSL Installation](#wsl-installation)
- [Arch Installation](#arch-installation)
  * [Brightness keys not working](#brightness-keys-not-working)
  * [Mounting Windows with proper permissions](#mounting-windows-with-proper-permissions)

# Dotfile Installation
```
git clone git@github.com:TaylorAbraham/dotfiles.git
cd dotfiles
./dot-install.sh
```

# General Post-OS Install/Setup

## Zsh + OhMyZsh
```
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Important utilities
`build-essential` installs make tools
```
sudo apt install -y tmux inotify-tools ruby-dev build-essential
vundle
```

## "Important" utilities
```
sudo apt install -y neofetch lolcat cowsay fortune-mod
```

## SSH Keys
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

## npm Global Without sudo
https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md

# WSL Installation
1. Through the Microsoft Store, install a Linux distro of your choice and Windows Terminal
2. Follow in full: https://docs.microsoft.com/en-us/windows/wsl/wsl2-install
3. Open Terminal settings and set Ubuntu to the default, and fix the starting directory to be your WSL home instead of your Windows home
```
"startingDirectory" : "//wsl$/Ubuntu/home/tay"
```
4. Follow [instructions above](#zsh--ohmyzsh) for installing Zsh + OhMyZsh
5. Set up Windows ssh keys in a Powershell prompt, and add them to GitHub
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
cat C:\Users\taylo\.ssh\id_rsa.pub | clip
```
6. Set up WSL ssh keys and fix private key permissions (NOTE: cp is used instead of making a symlink because this allows file permissions of your private key to be fixed)
```
cp -r /mnt/c/Users/taylo/.ssh ~/.ssh
chmod 600 ~/.ssh/id_rsa
```
7. Install dotfiles
```
cd ~
git clone git@github.com:TaylorAbraham/dotfiles-wsl2.git
mv dotfiles-wsl2 dotfiles
cd dotfiles && ./dot-install.sh
```
8. Install Node LTS (nvm is currently very bugged with WSL 2)
```
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
sudo apt install -y nodejs
```
9. Fix tmux re-prompting you for sudo password by disabling tty tickets. Open sudoers and add `Defaults:tay !tty_tickets`
```
sudo update-alternatives --config editor
sudo su
visudo /etc/sudoers
```
10. Install utilities [listed above](#important-utilities)
11. Fix firewall rules for inbound WSL connections. By default, the Windows Firewall will prevent any inbound connections to a server running on WSL 2. Fix WSL firewall rules with [the script in this comment](https://github.com/microsoft/WSL/issues/4150#issuecomment-504209723). Make sure to follow the instructions and tick off "Run with highest privilege" at the first screen of making the task. The command will be "powershell" with arguments something like "-File C:\Users\ryan_\Scripts\WSLFirewallFix.ps1"

Extra resources are available at https://nickymeuleman.netlify.com/blog/linux-on-windows-wsl2-zsh-docker and https://nickymeuleman.netlify.com/blog/gui-on-wsl2-cypress

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
