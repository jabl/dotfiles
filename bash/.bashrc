alias ll='ls -l'
alias e='emacsclient -c -a "" '
export CLICOLOR=1 # Color ls
export IPYTHON=1 # pyspark using ipython shell
export FCFLAGS="-O3 -pipe -march=native"
export RUST_SRC_PATH=~/Documents/rust/rust/src # For racer

# OS X 10.10 doesn't include openssl, use homebrew version
if [[ $(uname -s) == "Darwin" ]]; then
    export OPENSSL_INCLUDE_DIR=`brew --prefix openssl`/include
    export OPENSSL_LIB_DIR=`brew --prefix openssl`/lib
fi

# Some useful options from
# https://github.com/mrzool/bash-sensible/blob/master/sensible.bash

# Update window size after every command
shopt -s checkwinsize

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear:reset"

# Useful timestamp format
HISTTIMEFORMAT='%F %T '
