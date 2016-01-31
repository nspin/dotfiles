source $stdenv/setup

closure=""
for d in $libraries; do
    findInputs $d closure propagated-native-build-inputs
done

mkdir $out
pkgdb=$out

for p in $closure; do
    if test -d "$p/lib/$ghcname/package.conf.d"; then
        cp "$p/lib/$ghcname/package.conf.d/"*.conf $pkgdb
    fi
done
$ghc/bin/ghc-pkg --package-db=$pkgdb recache

