{ fetchgit, python3Packages }:

python3Packages.buildPythonPackage {
  name = "fznode";
  src = fetchgit {
    url = "https://github.com/nspin/fznode.git";
    rev = "bd8941a9c151f6a01acb65a01239095f3aacc2ee";
    sha256 = "0444rwbx8j1sxw359x7x1dllaigjcgb0nkffzjqr7875g2mn1sr7";
  };
}
