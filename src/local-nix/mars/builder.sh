source $stdenv/setup

mkdir -p $out/bin
mkdir -p $out/share/java

cp $src $out/share/java/Mars4_5.jar

echo '#!/bin/sh' > $out/bin/mars
echo "$jdk/bin/java -jar $out/share/java/Mars4_5.jar" '$@' >> $out/bin/mars
chmod +x $out/bin/mars
