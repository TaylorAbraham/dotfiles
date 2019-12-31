#!/bin/bash

# Dotfile paths
dir=~/dotfiles
backupdir=~/dotfiles_old
dotfiles=".zshrc .bash_aliases .vimrc .tmux.conf .gitconfig .wsl_startup"

# Make backup folder
echo "Creating $olddir for current dotfiles backup..."
mkdir -p $backupdir
echo "Done"

# Back up each dotfile and symlink to the new ones
cd $dir
for dotfile in $dotfiles; do
  echo "Backing up old $dotfile..."
  mv ~/$dotfile $backupdir
  echo "Done"
  echo "Creating symlink to new $dotfile..."
  ln -s $dir/$dotfile ~/$dotfile
  echo "Done"
done

# Restart zsh
source ~/.zshrc
