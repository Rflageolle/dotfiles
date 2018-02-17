#!/usr/bin/env bash

DIR=$(dirname "$0")
FULL_RELATIVE_PATH=$(cd "$DIR" && pwd)

DEFINITION_FILE="$FULL_RELATIVE_PATH/definitions.sh"
if [[ ! -e $DEFINITION_FILE ]]; then
    echo "Definitions file missing"
    exit 1
fi

source "$DEFINITION_FILE"

if [[ $1 = "-h" || $1 = "--help" ]]; then
    cat <<EOF
Migrates files to or from the dotfiles repo. Makes a git commit after operation.
For each file in <files...>:
  If the file exists in $dotfiles_dir
    it is moved to $HOME replacing the symlink;
    if the file in $HOME is not a symlink it is skipped.
  If the file does not exist in $dotfiles_dir
    it is moved to $dotfiles_dir and a symlink
    to it is placed in $HOME.

Usage: $(basename "$0") [-h|--help] <files...>
-h or --help: Show this message and exit. (Ignores <files...>)
files...: a list of filenames to operate on
EOF
    exit 0
fi

declare -a Removed
declare -a Added

cd "$dotfiles_dir" || exit 1

for file in "$@"; do
    if [[ -f $file || -d $file ]]; then
        if [[ ! -L $HOME/$file ]]; then
            echo "$HOME/$file is not a symlink. Skipping."
            continue
        fi
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

message="Migrate:"
if [[ ${#Added[@]} -gt 0 ]]; then
    message="$message Added: ${Added[*]}"
fi
if [[ ${#Removed[@]} -gt 0 ]]; then
    message="$message Removed: ${Removed[*]}"
fi

git commit -m "$message"
