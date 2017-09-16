#!/usr/bin/env bash

########## Variables

dir="$HOME/.dotfiles"                    # dotfiles directory
olddir="$HOME/.dotfiles_old"             # old dotfiles backup directory

##########

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir || exit
echo "...done"

echo "Fixing any missing links."

while read -r -d '' file; do
    if [ ! -e "$HOME/$file" ]; then
        echo "Fixing symlink to $file in home directory."
        ln -sf "$dir/$file" "$HOME/$file"
    fi
done < <(find . \( -path "./.git" -o -path "./old" \) -prune -o -name ".*" \
              -not \( -name "." -o -name ".DS_Store" -o -name ".gitignore" \) \
              -print0 | sed "s/\.\///g")

echo "...done"
