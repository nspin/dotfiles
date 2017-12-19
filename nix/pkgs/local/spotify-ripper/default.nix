{ fetchurl, lame, python27Packages, pkgs }:

with python27Packages;

let

  mutagen_1_30 = buildPythonPackage (rec {
    name = "mutagen-1.30";

    src = fetchurl {
      url = https://pypi.python.org/packages/2a/5d/cbbddd797e2763c124c6d11e12e97d4502788e9e4b17047054388a957878/mutagen-1.30.tar.gz;
      sha256 = "0kv2gjnzbj1w0bswmxm7wi05x6ypi7jk52s0lb8gw8s459j41gyd";
    };

    buildInputs = with pkgs; [ faad2 flac vorbis-tools liboggz glibcLocales ];

    LC_ALL = "en_US.UTF-8";

    preBuild = ''
      rm tests/test_encoding.py
    '';

  });

in buildPythonPackage {
  name = "spotify-ripper-2.10.4";

  src = fetchurl {
    url = https://pypi.python.org/packages/fb/c7/7cac3418c0282e13773883b4cfa3afa8a092b5227d09a320560230ad8025/spotify-ripper-2.10.4.tar.gz;
    sha256 = "10lqy65llr32lkmbrx3wsmpwnwnrvc3s6525dczvqgf7f75jfvc6";
  };

  preBuild = ''
    export HOME=$TMPDIR
  '';

  propagatedBuildInputs = [
    pyspotify
    colorama_3_3
    mutagen_1_30
    requests
    schedule
    
    lame
  ];

}
