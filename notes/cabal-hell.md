**Avoiding cabal-hell without nix**
*   Install GHC *only* (not the entire platform). For slackware, install 7.6 slackbuild, then build 7.10 from source.
*   Get cabal binary from haskell.org.
*   `cabal install cabal cabal-install alex happy`. These will be the *only* thing in .cabal/bin/
*   Discard old cabal binary.
*   *Only* work in sandboxes for specific projects.
*   Whenever you need Haskell stuff for your system (e.g. hlint) use the `beach` function from core/bashrcs. Binaries will have symlinks in ~/.beach/bin, which core/bash _ profile adds to `$PATH`.
*   Annoying exceptions: xmonad, yi, etc - programs that compile their own config files (which have expexted locations, which are not in sandboxes). If future releases of such programs cause dependancy hell among themselves, then this approach may have to be revised.

