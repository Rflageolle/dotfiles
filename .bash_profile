#!/usr/bin/env bash

source .bash_prompt

source .bash_functions

export PATH="$PATH:$HOME/bin"
export EDITOR=/usr/bin/nano

case $( uname -s ) in
"Darwin"|"darwin"|"*BSD*"|"*bsd*" )
    export LSCOLORS=GxFxCxDxBxegedabagaced
    export CLICOLOR=1 # Environment var rather than ls alias
    ;;
* )
    formats="di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:"
    formats+="su=30;41:sg=30;46:tw=30;42:ow=30;43"
    export LS_COLORS=$formats
    alias ls="ls --color=auto"
    ;;
esac

if [ -f /usr/local/share/bash-completion/bash_completion ]; then
    source /usr/local/share/bash-completion/bash_completion
fi
