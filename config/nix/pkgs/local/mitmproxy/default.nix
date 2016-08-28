{ pkgs, pythonPackages, stdenv }:

with pkgs.lib;

let
  x = rec {

      pillow_3_2_0 = pythonPackages.buildPythonPackage rec {
        name = "Pillow-3.2.0";

        src = pkgs.fetchurl {
          url = "https://github.com/python-pillow/Pillow/archive/3.2.0.tar.gz";
          sha256 = "1yi0n2hgnb6ipclah1g75cfiwgx04w7azl50i3aqk3z3aqlrqjzb";
        };

        doCheck = false;

        buildInputs = with pythonPackages; [
          pkgs.freetype pkgs.libjpeg pkgs.zlib pkgs.libtiff pkgs.libwebp pkgs.tcl nose pkgs.lcms2 ]
          ++ optionals (isPyPy) [ pkgs.tk pkgs.xorg.libX11 ];

        preConfigure =
          let
            libinclude' = pkg: ''"${pkg.out}/lib", "${pkg.out}/include"'';
            libinclude = pkg: ''"${pkg.out}/lib", "${pkg.dev}/include"'';
          in ''
            sed -i "setup.py" \
                -e 's|^FREETYPE_ROOT =.*$|FREETYPE_ROOT = ${libinclude pkgs.freetype}|g ;
                    s|^JPEG_ROOT =.*$|JPEG_ROOT = ${libinclude pkgs.libjpeg}|g ;
                    s|^ZLIB_ROOT =.*$|ZLIB_ROOT = ${libinclude pkgs.zlib}|g ;
                    s|^LCMS_ROOT =.*$|LCMS_ROOT = ${libinclude' pkgs.libwebp}|g ;
                    s|^TIFF_ROOT =.*$|TIFF_ROOT = ${libinclude pkgs.libtiff}|g ;
                    s|^TCL_ROOT=.*$|TCL_ROOT = ${libinclude' pkgs.tcl}|g ;'
          ''
          + stdenv.lib.optionalString stdenv.isDarwin ''
            substituteInPlace setup.py \
              --replace '"/Library/Frameworks",' "" \
              --replace '"/System/Library/Frameworks"' ""
          '';
      };


      cryptography_1_3_2 = pythonPackages.buildPythonPackage rec {
        name = "cryptography-${version}";
        version = "1.3.2";

        src = pkgs.fetchurl {
          url = "https://pypi.python.org/packages/04/da/35f9a1d34dab5d777f65fb87731288f338ab0ae46a525ffdf0405b573dd0/cryptography-1.3.2.tar.gz";
          sha256 = "121067qdbzd0ir0nxjdf0kgai7qlsc9yh2xhrj4cavcn4y4gmapv";
        };

        buildInputs = with pythonPackages; [
          pkgs.openssl
          pretend cryptography_vectors iso8601 pyasn1 pytest py hypothesis1
        ] ++ optional stdenv.isDarwin pkgs.darwin.apple_sdk.frameworks.Security;

        propagatedBuildInputs = with pythonPackages; [
          six idna ipaddress pyasn1 cffi pyasn1-modules sqlite3
        ] ++ optional (versionOlder python.pythonVersion "3.4") enum34;

        __impureHostDeps = [ "/usr/lib" ];
      };


      pyperclip_1_5_27 = pythonPackages.buildPythonPackage rec {
        version = "1.5.27";
        name = "pyperclip-${version}";

        src = pkgs.fetchurl {
          url = "mirror://pypi/p/pyperclip/${name}.zip";
          sha256 = "1i9zxm7qc49n9yxfb41c0jbmmp2hpzx98kaizjl7qmgiv3snvjx3";
        };

        doCheck = false;
      };


      requests_2_9_1 = pythonPackages.buildPythonPackage rec {
        name = "requests-${version}";
        version = "2.9.1";
        nativeBuildInputs = [ pythonPackages.pytest ];
        doCheck = false;
        src = pkgs.fetchurl {
          url = "mirror://pypi/r/requests/${name}.tar.gz";
          sha256 = "0zsqrzlybf25xscgi7ja4s48y2abf9wvjkn47wh984qgs1fq2xy5";
        };
      };


      backports_ssl_match_hostname_3_5_0_1 = pythonPackages.buildPythonPackage rec {
        name = "backports.ssl_match_hostname-3.5.0.1";
        src = pkgs.fetchurl {
          url = "mirror://pypi/b/backports.ssl_match_hostname/${name}.tar.gz";
          sha256 = "1wndipik52cyqy0677zdgp90i435pmvwd89cz98lm7ri0y3xjajh";
        };
      };


      hyperframe = pythonPackages.buildPythonPackage rec {
        name = "hyperframe-3.2.0";
        src = pkgs.fetchurl {
          url = "https://github.com/python-hyper/hyperframe/archive/v3.2.0.tar.gz";
          sha256 = "0br1v6jk950jl56kmcwhxmsvza7vrxi1vxm5745b720qwfpkwyma";
        };
      };


      passlib_1_6_5 = pythonPackages.buildPythonPackage rec {
        version = "1.6.5";
        name    = "passlib-${version}";
        src = pkgs.fetchurl {
          url = "mirror://pypi/p/passlib/passlib-${version}.tar.gz";
          sha256 = "1z27wdxs5rj5xhhqfzvzn3yg682irkxw6dcs5jj7mcf97psk8gd8";
        };
        buildInputs = with pythonPackages; [ nose pybcrypt];
      };


      urwid_1_3_1 = pythonPackages.buildPythonPackage rec {
        name = "urwid-1.3.1";
        doCheck = false;
        src = pkgs.fetchurl {
          url = "mirror://pypi/u/urwid/${name}.tar.gz";
          sha256 = "18cnd1wdjcas08x5qwa5ayw6jsfcn33w4d9f7q3s29fy6qzc1kng";
        };
      };


      tornado_4_3 = pythonPackages.buildPythonPackage rec {
        name = "tornado-${version}";
        version = "4.3";
        propagatedBuildInputs = with pythonPackages; [
          backports_abc
          backports_ssl_match_hostname_3_5_0_1
          certifi
          singledispatch
        ];
        checkPhase = ''
          ${pythonPackages.python.interpreter} -m unittest discover *_test.py
        '';
        src = pkgs.fetchurl {
          url = "mirror://pypi/t/tornado/${name}.tar.gz";
          sha256 = "1gzgwayl6hmc9jfcl88bni4jcsk2jcca9dn1rvrfsvnijcjx7hn9";
        };
      };


      h2 = pythonPackages.buildPythonPackage rec {
        name = "h2-2.4.1";
        # propegatedBuildInputs = [ ];
        buildInputs = [
          hpack_2_3_0
          hyperframe
          pythonPackages.enum34
        ];
        src = pkgs.fetchurl {
          url = "mirror://pypi/u/h2/${name}.tar.gz";
          md5 = "60ff588868b90c43605ccd0fc674e99e";
        };
      };


      hpack_2_3_0 = pythonPackages.buildPythonPackage rec {
        name = "hpack-${version}";
        version = "2.3.0";
        src = pkgs.fetchurl {
          url = "mirror://pypi/h/hpack/hpack-${version}.tar.gz";
          md5 = "a07355ab119f8989a098311bda1c3d7b";
        };
      };


      blinker_1_4 = pythonPackages.buildPythonPackage rec {
        name = "blinker-${version}";
        version = "1.4";
        src = pkgs.fetchurl {
          url = "mirror://pypi/b/blinker/${name}.tar.gz";
          sha256 = "1dpq0vb01p36jjwbhhd08ylvrnyvcc82yxx3mwjx6awrycjyw6j7";
        };
      };


      ConfigArgParse_0_10_0 = pythonPackages.buildPythonPackage rec {
        name = "ConfigArgParse-${version}";
        version = "0.10.0";
        src = pkgs.fetchurl {
          url = "mirror://pypi/C/ConfigArgParse/ConfigArgParse-${version}.tar.gz";
          sha256 = "19wh919gbdbzxzpagg52q3lm62yicm95ddlcx77dyjc1slyshl1v";
        };
        doCheck = false;
      };


      html2text_2016_1_8 = pythonPackages.buildPythonPackage rec {
        name = "html2text-2016.1.8";
        disabled = ! pythonPackages.isPy27;
        src = pkgs.fetchurl {
          url = "mirror://pypi/h/html2text/${name}.tar.gz";
          sha256 = "0ydh1g7i3l35sw6jswm5p9m7cy92g7a6801qwgviyxi6n7wld008";
        };
      };

      pyopenssl_bumped = pythonPackages.buildPythonPackage rec {
        name = "pyopenssl-${version}";
        version = "16.0.0";

        src = pkgs.fetchurl {
          url = "mirror://pypi/p/pyOpenSSL/pyOpenSSL-${version}.tar.gz";
          sha256 = "0zfijaxlq4vgi6jz0d4i5xq9ygqnyps6br7lmigjhqnh8gp10g9n";
        };

        doCheck = false;

        propagatedBuildInputs = [
          cryptography_1_3_2
          pythonPackages.pyasn1
          pythonPackages.idna
        ];
      };

      mitmproxy_0_17 = pythonPackages.buildPythonPackage rec {

        baseName = "mitmproxy";
        name = "${baseName}-${version}";
        version = "0.17";

        src = pkgs.fetchurl {
          url = "https://github.com/mitmproxy/mitmproxy/archive/v0.17.tar.gz";
          sha256 = "14yqk50fb8q73m9sdv29a8drz0m2xk30wg33xblj22rw89mgn2hk";
        };

        propagatedBuildInputs = with pythonPackages; [
          tornado_4_3
          cryptography_1_3_2
          pillow_3_2_0 
          pyperclip_1_5_27
          requests_2_9_1
          backports_ssl_match_hostname_3_5_0_1
          watchdog
          hyperframe
          passlib_1_6_5
          urwid_1_3_1 
          h2
          blinker_1_4
          hpack_2_3_0
          ConfigArgParse_0_10_0 
          lxml_3_5
          html2text_2016_1_8
          pyopenssl_bumped
          pyasn1 flask protobuf click construct pyparsing
        ];

        doCheck = false;

        postInstall = ''
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" \
              --prefix PYTHONPATH : "$PYTHONPATH"
          done
        '';
      };

  };

in x.mitmproxy_0_17
