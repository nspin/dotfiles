NIX_LINK="/nix/var/nix/profiles/unpriv-$USER"
export NIX_PROFILES="/nix/var/nix/profiles/default $NIX_LINK"

if [ -e "$NIX_LINK/etc/ssl/certs/ca-bundle.crt" ]; then
    export NIX_SSL_CERT_FILE="$NIX_LINK/etc/ssl/certs/ca-bundle.crt"
elif [ -e "$NIX_LINK/etc/ca-bundle.crt" ]; then
    export NIX_SSL_CERT_FILE="$NIX_LINK/etc/ca-bundle.crt"
fi

if [ -n "${MANPATH}" ]; then
    export MANPATH="$NIX_LINK/share/man:$MANPATH"
fi

export PATH="$NIX_LINK/bin:$PATH"

update-dotfile-links
