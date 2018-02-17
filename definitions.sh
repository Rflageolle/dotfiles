#!/usr/bin/env bash

if [[ -z ${FULL_RELATIVE_PATH+x} ]]; then
    DIR=$(dirname "$0")
    FULL_RELATIVE_PATH=$(cd "$DIR" && pwd)
fi

# Dotfiles directory is defined relative to file that is using these
# definitions

dotfiles_dir="$FULL_RELATIVE_PATH/dotfiles"                # dotfiles directory
old_dotfiles_dir="$HOME/.dotfiles_old"          # old dotfiles backup directory

if [[ $(basename "$0") = "definitions.sh" ]]; then
    cat <<EOF
This file is intended to define common variables for other scripts.
As such running it on its own makes little sense.
EOF
fi
