# Dotfiles

This is my repository for my dotfiles.
So far management is done through simple scripts that I've put together.
Nothing too fancy like GNU Stow yet.
I'll start using something like it if this gets out of hand.

Please note that there are git submodules (with submodules of their own) in this
repository. Add `--recursive` to the `git clone` command or run `git submodule
update --init --recursive` after the initial clone. In case you forget to do this,
`bootstrap.sh` now handles initializing the submodules for you.

Thanks to [Michael Smalley][smalley] for a starting point for my scripts. 


[smalley]: http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
