{ stdenv, fetchurl, fetchFromGitHub, python3Packages }:

let
  flask_ = with python3Packages; buildPythonPackage {
    name = "flask-0.11";

    src = fetchurl {
      url = "mirror://pypi/F/Flask/Flask-0.11.tar.gz";
      sha256 = "14xlrpa6720n2azfld5x0fzq6c20lardk3745wipiq8dgxd419r9";
    };

    propagatedBuildInputs = [ itsdangerous click werkzeug jinja2 ];

    meta = {
      homepage = http://flask.pocoo.org/;
      description = "A microframework based on Werkzeug, Jinja 2, and good intentions";
      license = licenses.bsd3;
    };
  };

in python3Packages.buildPythonPackage rec {
    baseName = "mitmproxy";
    name = "${baseName}-${version}";
    version = "1.0.2";

    src = fetchFromGitHub {
      owner = baseName;
      repo = baseName;
      rev = "v${version}";
      sha256 = "19nqg7s1034fal8sb2rjssgcpvxh50yidyjhnbfmmi8v3fbvpbwl";
    };

    propagatedBuildInputs = with python3Packages; [
      pyopenssl pyasn1 urwid pillow flask_ click pyperclip blinker
      construct pyparsing html2text tornado brotlipy requests2
      sortedcontainers passlib cssutils h2 ruamel_yaml jsbeautifier
      watchdog editorconfig
    ];

    # Tests fail due to an error with a decorator
    doCheck = false;

    meta = with stdenv.lib; {
      description = "Man-in-the-middle proxy";
      homepage = "http://mitmproxy.org/";
      license = licenses.mit;
      maintainers = with maintainers; [ fpletz ];
    };
}
