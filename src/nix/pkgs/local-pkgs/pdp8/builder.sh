source $stdenv/setup
mkdir -p $out/bin
cp $src/* .
make coremake
make pal
mv coremake pal $out/bin
