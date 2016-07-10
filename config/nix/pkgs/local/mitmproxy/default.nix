{ pkgs, pythonPackages }:

let self = pythonPackages;
in with pkgs.lib; pythonPackages.buildPythonPackage rec {
    baseName = "mitmproxy";
    name = "${baseName}-${version}";
    version = "0.14.0";

    src = pkgs.fetchurl {
      url = "https://github.com/mitmproxy/mitmproxy/archive/v0.14.tar.gz";
      sha256 = "072yihnrv78lffk2r12jk7phs4c8mc1gs4y96cp9rg63vw6w1fry";
    };

    propagatedBuildInputs = with self; [
      pyopenssl pyasn1 urwid pillow lxml flask protobuf netlib click
      ConfigArgParse pyperclip blinker construct pyparsing html2text tornado
    ];

    doCheck = false;

    postInstall = ''
      for prog in "$out/bin/"*; do
        wrapProgram "$prog" \
          --prefix PYTHONPATH : "$PYTHONPATH"
      done
    '';

    meta = {
      description = ''Man-in-the-middle proxy'';
      homepage = "http://mitmproxy.org/";
      license = licenses.mit;
    };
}
