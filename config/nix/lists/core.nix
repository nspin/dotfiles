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

(python35.buildEnv.override {
  extraLibs = import ../lists/pp.nix python35Packages;
})

jre
jdk
openssl

python27Packages.pycrypto

]
