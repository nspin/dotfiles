###############################
# NICK SPINALE
# $HOME/.bash_profile
###############################

# Check if interactive
[ -z "$PS1" ] && reset

# FOR SCHOOL COMPUTERS
# IDKWHAT="/usr/local/bin"
# if [ -d $IDKWHAT ] ; then
#     export PATH=$IDKWHAT:$PATH
# fi

# ADD HASKELL BINARIES TO PATH
HSBIN="$HOME/.cabal/bin"
if [ -d $HSBIN ] ; then
    export PATH=$HSBIN:$PATH
fi

# EVERYTHING ELSE
source $HOME/.bashrc
