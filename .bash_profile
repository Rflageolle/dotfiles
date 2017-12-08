#!/usr/bin/env bash

source .bash_prompt

source .bash_functions

export PATH="$PATH:$HOME/bin"
export EDITOR=/usr/bin/nano
export CLICOLOR=1

case $( uname -s ) in
"Darwin"|"darwin"|"*BSD*"|"*bsd*" )
    export LSCOLORS=GxFxCxDxBxegedabagaced
    ;;
* )
    export LS_COLORS=GxFxCxDxBxegedabagaced
    ;;
esac

if [ -f /usr/local/share/bash-completion/bash_completion ]; then
    source /usr/local/share/bash-completion/bash_completion
fi
