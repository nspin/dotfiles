source $stdenv/setup

closure=""
for d in $libs; do
    findInputs $d closure propagated-native-build-inputs
done

mkdir $out
pkgdb=$out

for p in $closure; do
    if test -d "$p/lib/$ghcName/package.conf.d"; then
        cp "$p/lib/$ghcName/package.conf.d/"*.conf $pkgdb
    fi
done
$ghc/bin/ghc-pkg --package-db=$pkgdb recache

