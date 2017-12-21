#!/usr/bin/env bash

# Migration tool for dotfiles.
# Usage: "./migrate.sh .file" moves .file to dotfiles_dir and installs a
#   symlink into ~/. If .file is already in dotfiles_dir, this removes it
#   from dotfiles_dir and replaces it over the symlink.

source "$HOME/.dotfiles/definitions.sh"
declare -a Removed
declare -a Added

cd "$dotfiles_dir" || exit

for file in "$@"; do
    [[ $file =~ \..+ ]] || continue # Skip non-dot files TODO: Considder not
    if [ -f "$file" ] || [ -d "$file" ]; then
        echo "Removing symlink to $file from home directory."
        rm "$HOME/$file"
        echo "Moving $file back to home directory"
        mv "$dotfiles_dir/$file" "$HOME/$file"
        git add "$file"
        Removed=("${Removed[@]}" "$file")
    else
        echo "Migrating $file to $dotfiles_dir"
        mv "$HOME/$file" "$dotfiles_dir/$file"
        echo "Creating symlink to $file in home directory."
        ln -s "$dotfiles_dir/$file" "$HOME/$file"
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
