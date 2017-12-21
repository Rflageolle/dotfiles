#!/usr/bin/env bash

source "./definitions.sh"

# create dotfiles_old in homedir
echo "Creating $old_dotfiles_dir for backup of any existing dotfiles in ~"
mkdir -p $old_dotfiles_dir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dotfiles_dir directory"
cd $dotfiles_dir || exit
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory,
# then create symlinks
while read -r -d '' file; do
    file=$( basename "$file" )
    echo "Moving any existing dotfiles from ~ to $old_dotfiles_dir"
    mv "$HOME/$file" "$old_dotfiles_dir"
    echo "Creating symlink to $file in home directory."
    ln -s "$dotfiles_dir/$file" "$HOME/$file"
done < <(find . -not \( -name "." -o -name ".DS_Store" \) -print0)


# Now that this is a one time setup script
# add brew.sh and source it. for brew installed programs
# see https://github.com/mathiasbynens/dotfiles
