pkgs: with pkgs; [

# nix
nix-repl
nix-prefetch-scripts
patchelf

# convenience
rlwrap

# general
coreutils
gnumake
which
zip
unzip
rsync
file

# dev
my-vim
tmux
git
mercurial
subversion
fzf

python27

(python34.buildEnv.override {
  extraLibs = import ../lists/pp.nix python34Packages;
})

jre
jdk
openssl

python27Packages.pycrypto

]
