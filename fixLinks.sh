#!/usr/bin/env bash

source "./definitions.sh"

echo "Changing to the $dotfiles_dir directory"
cd $dotfiles_dir || exit
echo "...done"

echo "Fixing any missing links."

while read -r -d '' file; do
    file=$( basename "$file" )
    if [ ! -e "$HOME/$file" ]; then
        echo "Fixing symlink to $file in home directory."
        ln -sf "$dotfiles_dir/$file" "$HOME/$file"
    fi
done < <( find . -not \( -name "." -o -name ".DS_Store" \) -print0 )

echo "...done"
