source $stdenv/setup

cppFlags=$(echo "$cppPairs" | sed -e 's/ /\n/g' | paste -d " " - - | awk '{ print "-D" $1 "=\"" $2 "\""; }')

mkdir -p $out/bin
for main in $(ls $src | grep "^[a-z-]\+\.hs" | sed -e "s/\.hs//g"); do
    ghc -hidir . -odir . -package-db $pkgdb -i$src -o $out/bin/$main $cppFlags $src/$main
done
