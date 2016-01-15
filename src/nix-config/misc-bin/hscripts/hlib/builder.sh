source $stdenv/setup

closure=""
for d in $deps; do
    findInputs $d closure propegated-native-build-inputs
done

mkdir pkgdb
for p in $closure; do
    if [ -d "$p/lib/$ghcname/packages.conf.d" ]; then
        cp "$p/lib/$ghcname/packages.conf.d/"*.conf pkgdb/
    fi
done
ghc-pkg --package-db=pkgdb recache

cppFlags=$(echo "$cppPairs" | sed -e 's/ /\n/g' | paste -d " " - - | awk '{ print "-D" $1 "=\"" $2 "\""; }')
# cppFlags=$(echo "$cppPairs" | sed -e 's/ /\n/g' | paste -d " " - - | while read symbol value; do
#     echo -n "-D$symbol=\"$value\" "
# done)

mkdir -p $out/bin
for main in $(ls $src | grep "^[a-z]\+\.hs" | sed -e "s/\.hs//g"); do
    # echo ghc -hidir . -odir . -package-db pkgdb -i$src -o $out/bin/$main $cppFlags $src/$main
    ghc -hidir . -odir . -package-db pkgdb -i$src -o $out/bin/$main $cppFlags $src/$main
done
