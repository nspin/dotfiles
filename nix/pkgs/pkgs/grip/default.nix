{ fetchzip, python27Packages }: 
with python27Packages; buildPythonPackage {
  name = "grip-4.3.2";

  src = fetchzip {
    url = "https://pypi.python.org/packages/8b/9d/698a7a3a8b57c28eacac27f269c9d0da228d20ee734edbe9451e3e0f7cde/grip-4.3.2.zip";
    sha256 = "08d1n640r5f25ys4w6ifcirp6hqw50g1vmblxf2lhsbr9zili3dk";
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
