# Overview
My personal dotfiles and an installer script to set them up. In this guide I reference my unix username `tay` and my Windows account folder name `taylo`, so change them to your folder names accordingly.

- [Dotfile Installation](#dotfile-installation)
- [General Post-OS Install/Setup](#general-post-os-installsetup)
  * [Zsh + OhMyZsh](#zsh--ohmyzsh)
  * [Important utilities](#important-utilities)
  * ["Important" utilities](#important-utilities)
  * [SSH Keys](#ssh-keys)
  * [npm Global Without sudo](#npm-global-without-sudo)
- [Arch Installation As a Dual Boot with Windows](#arch-installation-as-a-dual-boot-with-windows)
  * [Part 1 - Base Installation](#part-1---base-installation)
  * [Part 2 - Once you're chroot'd and done the Arch wiki install guide](#part-2---once-youre-chrootd-and-done-the-arch-wiki-install-guide)
    + [Install some utilities](#install-some-utilities)
    + [Making a sudo user](#making-a-sudo-user)
    + [Setting up a grub dual boot](#setting-up-a-grub-dual-boot)
    + [Installing KDE Plasma](#installing-kde-plasma)
  * [Part 3 - Post-Installation](#part-3---post-installation)
    + [Install important utilities](#install-important-utilities)
    + [Configure virtual desktops](#configure-virtual-desktops)
    + [Configure Spectacle](#configure-spectacle)
    + [Set Arch to use local time](#set-arch-to-use-local-time)
  * [Appendix A - Troubleshooting](#appendix-a---troubleshooting)
  * [Brightness keys not working](#brightness-keys-not-working)
- [WSL Installation](#wsl-installation)

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

# Arch Installation As a Dual Boot with Windows

## Part 1 - Base Installation

Make a single empty partition in Windows for Arch but **DO NOT** format it.

https://wiki.archlinux.org/index.php/installation_guide

- Mounts are as follows:
    - For your empty partition that will be Arch: `mount /dev/nvme0n1p6 /mnt`
    - For your EFI partition: `mount /dev/nvme0n1p1 /mnt/boot/efi`
    - For your main windows `filesystem: mount /dev/nvme0n1p3 /mnt/windows`

## Part 2 - Once you're chroot'd and done the Arch wiki install guide

### Install some utilities
```
pacman -S vim ntfs-3g iwd
```

`ntfs-3g` allows Arch to mount the Windows filesystem once we reboot.

`iwd` gives access to `iwctl` and will let us get an internet connection if we need to troubleshoot later.

### Making a sudo user
```
pacman -S sudo
useradd --createhome tay
passwd tay
usermod --append --groups wheel tay
visudo
```
Uncomment the `%wheel ALL=(ALL) ALL` line and test with `su - tay`, then `whoami` and `sudo whoami`.

### Setting up a grub dual boot
```
pacman -S grub efibootmgr os-prober
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```
We can verify that Windows is detected with `os-prober`

### Installing KDE Plasma
```
pacman -S xorg plasma plasma-wayland-session kde-applications
systemctl enable sddm.service
systemctl enable NetworkManager.service
```

## Part 3 - Post-Installation

### Install important utilities
[Install Yay](https://github.com/Jguer/yay#installation), then install Chrome
```
yay -Syu google-chrome
```

### Configure virtual desktops

![Screenshot of 2x2 desktop arrangement](https://i.imgur.com/Hrdfai3.png)

`Shortcuts` -> `KWin`

![Screenshot of shortcuts](https://i.imgur.com/yBVIyIK.png)

### Configure Spectacle

![Screenshot of Spectacle config](https://i.imgur.com/BTrmXXN.png)

And set "Capture Rectangular Region" to `Print Screen`

### Set Arch to use local time
Only do this if you are booting into Windows semi-often, as this method relies on Windows keeping your system time up to date
```
timedatectl set-local-rtc 1 --adjust-system-clock
```

## Appendix A - Troubleshooting

## Brightness keys not working
Edit `/etc/default/grub`, and in it add `acpi_osi=` to the end of the `GRUB_CMDLINE_LINUX_DEFAULT` boot parameters. If that doesn't work, consult https://wiki.archlinux.org/index.php/intel_graphics#Backlight_is_not_adjustable

# WSL Installation
1. Through the Microsoft Store, install a Linux distro of your choice and Windows Terminal
2. Follow in full: https://docs.microsoft.com/en-us/windows/wsl/wsl2-install
3. Open Terminal settings and set Ubuntu to the default, and fix the starting directory to be your WSL home instead of your Windows home. Optionally, add a background.
```
"startingDirectory" : "//wsl$/Ubuntu/home/tay",
"backgroundImage": "C:\\Users\\Taylor\\OneDrive\\Pictures\\Backgrounds\\Wooloo.jpg",
"backgroundImageOpacity": 0.3
```
4. Follow [instructions above](#zsh--ohmyzsh) for installing Zsh + OhMyZsh
5. Set up Windows ssh keys in a Powershell prompt, and add them to GitHub
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
cat C:\Users\Taylor\.ssh\id_rsa.pub | clip
```
6. Set up WSL ssh keys and fix private key permissions (NOTE: cp is used instead of making a symlink because this allows file permissions of your private key to be fixed)
```
cp -r /mnt/c/Users/Taylor/.ssh ~/.ssh
chmod 600 ~/.ssh/id_rsa
```
7. Install dotfiles
```
cd ~
git clone git@github.com:TaylorAbraham/dotfiles.git
cd dotfiles && ./dot-install.sh
```
8. Install Node via nvm
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
nvm install lts
```
9. Fix tmux re-prompting you for sudo password by disabling tty tickets. Open sudoers and add `Defaults:tay !tty_tickets`
```
sudo update-alternatives --config editor
sudo su
visudo /etc/sudoers
```
10. Install utilities [listed above](#important-utilities)
11. Fix firewall rules for inbound WSL connections. By default, the Windows Firewall will prevent any inbound connections to a server running on WSL 2. Fix WSL firewall rules with [the script in this comment](https://github.com/microsoft/WSL/issues/4150#issuecomment-504209723). Make sure to follow the instructions and tick off "Run with highest privilege" at the first screen of making the task. The command will be `powershell` with arguments something like `-File C:\Users\ryan_\Scripts\wslbridge.ps1`

Extra resources are available at https://nickymeuleman.netlify.com/blog/linux-on-windows-wsl2-zsh-docker and https://nickymeuleman.netlify.com/blog/gui-on-wsl2-cypress

**Install complete!**
