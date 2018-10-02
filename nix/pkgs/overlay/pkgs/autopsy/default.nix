{ stdenv, fetchFromGitHub, sleuthkit, jdk, ant, netbeans
, lib
, fetchMavenArtifact, buildEnv
}:

let

  deps = buildEnv {
    name = "ivy-env";
    pathsToLink = [ "/share/java" ];
    paths = [

      (fetchMavenArtifact {
        groupId = "com.googlecode.java-diff-utils";
        artifactId = "diffutils";
        version = "1.2.1";
        sha256 = "0wf1la6jsibrynrfsp2a7g2gx6f9q44v30qarm9m6x6xp31rg1n9";
      })

    ];
  };

in
stdenv.mkDerivation rec {
  version = "4.8.0";
  name = "autopsy-${version}";

  # src = fetchFromGitHub {
  #   owner = "sleuthkit";
  #   repo = "autopsy";
  #   rev = name;
  #   sha256 = "1q19i5lnckivcwkkihhjk1m013j0803hsqm43nzh5j9rppfz5f16";
  # };

  src = ./autopsy;

  # postPatch = ''
  #   sed -i 's|/usr/share/java|${deps}/share/java|' bindings/java/build.xml
  # '';

  # configureFlags = lib.optionals javaBindings [ "--enable-offline" ];

  # preBuild = lib.optionalString javaBindings ''
  #   mkdir -p $TMP/.ant/lib
  # '';

  configurePhase = ''
  '';

  preBuild = ''
    mkdir -p $TMP/.ant/lib
  '';

  buildPhase = ''
    mkdir -p $NIX_BUILD_TOP/.ant/lib
    # ant -Dnbplatform.active.dir=${netbeans}/netbeans
    ant -Doffline=true -Dharness.dir=${netbeans}/netbeans/harness
  '';

  installPhase = ''
  '';

  # nativeBuildInputs = [ autoreconfHook ];
  buildInputs = [ sleuthkit jdk ant netbeans ];

  # # Hack to fix the RPATH.
  # preFixup = "rm -rf */.libs";

}
