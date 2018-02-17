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
Fixes any missing symlinks in $HOME, adding symlinks from
$dotfiles_dir.

Usage: $(basename "$0") [-h|--help]
-h or --help: Show this message and exit
EOF
    exit 0
fi

echo "Changing to the $dotfiles_dir directory"
cd "$dotfiles_dir" || exit 1
echo "...done"

echo "Fixing any missing links."

while read -r -d '' file; do
    file=$(basename "$file")
    if [[ ! -e $HOME/$file ]]; then
        echo "Fixing symlink to $file in home directory."
        ln -sf "$dotfiles_dir/$file" "$HOME/$file"
    fi
done < <( find . -not \( -name "." -o -name ".DS_Store" \) -print0 )

echo "...done"
