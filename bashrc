source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config


# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

