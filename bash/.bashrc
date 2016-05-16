alias ipy='ipython qtconsole --pylab=inline &'
alias ll='ls -l'
alias julia='ipython notebook --profile julia'
alias e='emacsclient -c -a "" '
export CLICOLOR=1 # Color ls
export IPYTHON=1 # pyspark using ipython shell
export FCFLAGS="-O3 -pipe -march=native"
export RUST_SRC_PATH=~/Documents/rust/rust/src # For racer

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
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Useful timestamp format
HISTTIMEFORMAT='%F %T '
