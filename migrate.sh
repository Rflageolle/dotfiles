#!/usr/bin/env bash

# Migration tool for dotfiles.
# Usage: ".~/migrate.sh .file" moves .file to ~/.dotfiles and installs a
#   symlink into ~/. If .file is already in .dotfiles, removes it, replacing
#   it over the symlink.

dir="$HOME/.dotfiles/dotfiles"
declare -a Removed
declare -a Added

cd "$dir" || exit

for file in "$@"; do
    [[ $file =~ \..+ ]] || continue # Skip non-dot files TODO: Considder not
    if [ -f "$file" ] || [ -d "$file" ]; then
        echo "Removing symlink to $file from home directory."
        rm "$HOME/$file"
        echo "Moving $file back to home directory"
        mv "$dir/$file" "$HOME/$file"
        git add "$file"
        Removed=("${Removed[@]}" "$file")
    else
        echo "Migrating $file to $dir"
        mv "$HOME/$file" "$dir/$file"
        echo "Creating symlink to $file in home directory."
        ln -s "$dir/$file" "$HOME/$file"
        git add "$file"
        Added=("${Added[@]}" "$file")
    fi
done

# git commit -m "Added (${Added[@]}) and Removed (${Removed[@]})"
message="Migrate:"
if [[ ${#Added[@]} -gt 0 ]]; then
    message="$message Added: ${Added[*]}"
fi
if [[ ${#Removed[@]} -gt 0 ]]; then
    message="$message Removed: ${Removed[*]}"
fi

git commit -m "$message"
