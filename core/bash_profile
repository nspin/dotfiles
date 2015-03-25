###############################
# NICK SPINALE
# $HOME/.bash_profile
###############################

# Check if interactive
[ -z "$PS1" ] && reset

SUSTUFF="/sbin:/usr/sbin"
export PATH=$PATH:$SUSTUFF

# ADD HASKELL BINARIES TO PATH
HSBIN="$HOME/.cabal/bin"
if [ -d $HSBIN ] ; then
    export PATH=$HSBIN:$PATH
fi

# EVERYTHING ELSE
source $HOME/.bashrc
