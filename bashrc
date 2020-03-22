# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config

### IRIC ###
#inclure tophat-2.0.10
#inclure samtools
#inclure torque
#inclure boost-1.49.0
#inclure python-2.7.6
LD_LIBRARY_PATH=/usr/local/cuda-7.5/lib64:$LD_LIBRARY_PATH
module load torque
# module load python/3.4.4
# module load python/2.7.6
#LD_LIBRARY_PATH=/soft/bioinfo/linux_RH6/python-2.7.6/lib:$LD_LIBRARY_PATH
#export PATH="/usr/local/cuda/bin:$HOME/.local/bin:$HOME/.bin:/usr/local/bin:/usr/local/sbin:/usr/local/git/bin:$PATH"
#export PATH="$HOME/.local/bin:$HOME/.bin:/usr/local/bin:/usr/local/sbin:/usr/local/git/bin:$PATH"
# source ~/.virtualenvs/sys/bin/activate
############

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
