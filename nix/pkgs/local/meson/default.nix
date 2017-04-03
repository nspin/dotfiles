{ lib, python3Packages, fetchurl }:
python3Packages.buildPythonPackage rec {

  # version = "0.39.1";
  version = "0.37.0";
  name = "meson-${version}";

  src = fetchurl {
    url = "mirror://pypi/m/meson/${name}.tar.gz";
    sha256 = "0g9wixi46vb0phap1kp5lhxqh4bsf3cws9bac4dcp7yjz71a9823";
    # sha256 = "0l16rpmy4jmn7q4shy9wf9f0rv6v3yk18wwh67hdyc4psrv5igv7";
  };

  postInstall = ''
    # ls $out
  '';

  meta = with lib; {
    homepage = http://mesonbuild.com;
    description = "SCons-like build system that use python as a front-end language and Ninja as a building backend";
    license = licenses.asl20;
    maintainers = with maintainers; [ mbe rasendubi ];
    platforms = platforms.all;
  };
}
