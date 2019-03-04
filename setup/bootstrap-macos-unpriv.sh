NIX_LINK="/nix/var/nix/profiles/unpriv-$USER"
export NIX_PROFILES="/nix/var/nix/profiles/default $NIX_LINK"

export PATH="$NIX_LINK/bin:$PATH"

update-dotfile-links
