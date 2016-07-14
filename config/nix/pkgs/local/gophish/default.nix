{ stdenv, lib, goPackages, fetchgit }:

# goPackages.buildGoPackage rec {
#   name = "gophish-${version}";
#   version = "v0.1.2";

#   # goPackagePath = "github.com/gophish/gophish";
#   goPackagePath = "";

#   src = fetchgit {
#     url = "https://github.com/gophish/gophish";
#     rev = "d04c562d7e9637db1ef5d258017553438de87504";
#     sha256 = "1g1j1zl9w1sqpvrqmsmdsjz4fhjajra35r49kbmirr4ms7a74vgc";
#   };
# }

goPackages.buildFromGitHub rec {
  name = "gophish-${version}";
  version = "v0.1.2";
  rev = "d04c562d7e9637db1ef5d258017553438de87504";
  sha256 = "1qy5bfxb1bh59mfcrpsg23vwzg7lnkshlc3qm8dsa8jkkqk3r72j";
  owner = "gophish";
  repo = "gophish";
  buildInputs = with goPackages; [ goquery context mux go-sqlite ];
}
