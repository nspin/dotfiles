source $stdenv/setup

closure=""

for p in $hpkgs; do
    findInputs $p closure propegated-native-build-inputs
done

mkdir pkgdb

for p in $closure; do
    if [ -d "$p/lib/$ghcname/packages.conf.d" ]; then
        cp "$p/lib/$ghcname/packages.conf.d/"*.conf pkgdb/
    fi
done

ghc-pkg --package-db=pkgdb recache

mkdir -p $out/bin

for main in $(ls $src | grep "^[a-z]\+\.hs" | sed -e "s/\.hs//g"); do
    ghc -hidir . -odir . -package-db pkgdb -i$src -o $out/bin/$main $cppFlags $src/$main
done
