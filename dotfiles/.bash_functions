#!/usr/bin/env bash

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

# OS specific functions
case $( uname -s ) in
    "Darwin"|"darwin" )
        # macOS
        function school()
        {
          cs "$HOME/Documents/School/Fall_17/$1"*
        }
        export -f school

        function dman()
        {
          open dash://manpages:"$*"
        }
        export -f dman
        ;;
    * )
        # Put other OS function here
        ;;
esac
