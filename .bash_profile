RegularUserPart="\[\e[36m\]\u\[\e[0m\]"
RootUserPart="\[\e[31;5m\]\u\[\e[0m\]"
Between="\[\e[0m\]@\[\e[0m\]"
HostPart="\[\e[32m\]\h\[\e[0m\]:"
PathPart="\[\e[34;1m\]\w\[\e[0m\]"

case `id -u` in
    0) export PS1="$RootUserPart$Between$HostPart$PathPart # ";;
    *) export PS1="$RegularUserPart$Between$HostPart$PathPart $ ";;
esac

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export EDITOR=/usr/bin/nano
export PATH="$PATH:$HOME/bin"

function cs()
{
  cd "$@" && ls
}
export -f cs

function mkcd()
{
  mkdir $1
  cd $1
}
export -f mkcd

function school()
{
  cs "$HOME/Documents/School/Fall_17/$1"*
}
export -f school
