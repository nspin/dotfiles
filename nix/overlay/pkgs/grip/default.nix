{ fetchzip, python27Packages }: 
with python27Packages; buildPythonPackage rec {
  pname = "grip";
  version = "4.5.2";
  name = "${pname}-${version}";

  src = fetchPypi {
    inherit pname version;
    sha256 = "03xacz7w2ga7y902n4v7xf3idcvyy900ilav6kp0pn4ffdf7x2q4";
  };

  propagatedBuildInputs = [
    docopt
    flask
    markdown
    path-and-address
    pygments
    requests
  ];

}
