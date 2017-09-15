#!/usr/bin/env bash

########## Variables

dir="$HOME/.dotfiles"                    # dotfiles directory
olddir="$HOME/.dotfiles_old"             # old dotfiles backup directory

##########

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir || exit
echo "...done"

# TODO: Fix behavor when fixing a symlink to a directory dotfile
while read -r -d '' file; do
    echo "Fixing symlink to $file in home directory."
    ln -sf "$dir/$file" "$HOME/$file"
done < <(find . -name ".*" ! -name "." ! -name ".git" ! -name ".DS_Store" -print0 | sed "s/\.\///g")

