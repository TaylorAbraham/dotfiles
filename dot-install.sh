#!/bin/bash

dir=~/dotfiles
backupdir=~/dotfiles_old
dotfiles=".zshrc .tmux.conf .vimrc"

echo "Creating $olddir for current dotfiles backup..."
mkdir -p $backupdir
echo "Done"

echo "Changing to dotfiles directory..."
cd $dir
echo "Done"

for dotfile in $dotfiles; do
  echo "Backing up old $dotfile..."
  mv ~/$dotfile $backupdir
  echo "Done"
  echo "Creating symlink to new $dotfile..."
  ln -s $dir/$dotfile ~/$dotfile
  echo "Done"
done

source ~/.zshrc
