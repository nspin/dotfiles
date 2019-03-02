{ fetchgit, python3Packages }:

python3Packages.buildPythonPackage {
  name = "fznode";
  src = fetchgit {
    url = "https://github.com/nspin/fznode.git";
    sha256 = "1zfkrir3qrnni69m3y2asj28jpfsdr46hap57ixfrca4zpzrwjjj";
  };
}
