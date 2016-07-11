{ pkgs, pythonPackages }:

let self = pythonPackages;
in with pkgs.lib; pythonPackages.buildPythonPackage rec {
    baseName = "mitmproxy";
    name = "${baseName}-${version}";
    version = "0.17";

    src = pkgs.fetchurl {
      url = "https://github.com/mitmproxy/mitmproxy/archive/v0.17.tar.gz";
      sha256 = "14yqk50fb8q73m9sdv29a8drz0m2xk30wg33xblj22rw89mgn2hk";
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
