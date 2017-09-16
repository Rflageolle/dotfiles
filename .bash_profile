source .bash_prompt

source .bash_functions

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export EDITOR=/usr/bin/nano
export PATH="$PATH:$HOME/bin"

if [ -f /usr/local/share/bash-completion/bash_completion ]; then
    source /usr/local/share/bash-completion/bash_completion
fi
