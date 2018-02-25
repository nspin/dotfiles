{ stdenv, fetchurl, fetchFromGit, python35Packages, qt5 }:

with python35Packages;
let

  ruamel-yaml = buildPythonPackage rec {
    name = "ruamel.yaml-0.14.4";
    src = fetchurl {
      url = "mirror://pypi/r/ruamel.yaml/${name}.tar.gz";
      sha256 = "0mkm9x5sgz9y97618m7y506yp68fzwdzwa3gb5y8g3pg6k99hl8v";
    };
    doCheck = false;
  };

  whither = buildPythonPackage rec {
    baseName = "whither";
    name = "${baseName}-${version}";
    version = "0.3.1";

    src = fetchurl {
      url = "mirror://pypi/w/whither/${name}.tar.gz";
      sha256 = "0fccv0cgd6v2sz472b05rmh4kah9pck4wizds33sxxk2m841i8vm";
    };

    preConfigure = ''
      # sed -i 's/PyQt5/PyQt4/' setup.py
      sed -i "s/'PyQt5'/'numpy'/" setup.py
    '';

    propagatedBuildInputs = [
      numpy
      qt5.qtwebengine
      ruamel-yaml
      pyqt5
    ];

  };

in
  stdenv.fetchFromGit
