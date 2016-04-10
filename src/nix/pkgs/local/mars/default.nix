{ stdenv, fetchurl, jdk }:

stdenv.mkDerivation {
  name = "mars-4.5";
  builder = ./builder.sh;
  src = fetchurl {
    url = http://courses.missouristate.edu/KenVollmar/mars/MARS_4_5_Aug2014/Mars4_5.jar;
    sha256 = "15kh1fahkkbbf4wvb6ijzny4fi5dh4pycxyzp5325dm2ddkhnd5c";
  };
  inherit jdk;
}
