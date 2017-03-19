{ stdenv, fetchgit, bash, cmake, python, go, Cocoa, rustracerd, llvmPackages, ycmd }:

stdenv.mkDerivation {

    name = "youcompleteme-2016-11-04";
    src = fetchgit {
      url = "git://github.com/valloric/youcompleteme";
      rev = "4f2494e87ebd5a6e9b5dc10a436d4d943f137fe6";
      sha256 = "03fl5ccql6v6da27wns0fiqcyhn0rmwx5vz7l3xqq1xg3x44m5n2";
    };
    dependencies = [];
    buildInputs = [
      python go cmake
      (if stdenv.isDarwin then llvmPackages.clang else llvmPackages.clang-unwrapped)
      llvmPackages.llvm
    ] ++ stdenv.lib.optional stdenv.isDarwin Cocoa;

    propagatedBuildInputs = stdenv.lib.optional (!stdenv.isDarwin) rustracerd;

    patches = [
      ./1-top-cmake.patch
      ./2-ycm-cmake.patch
    ];

    buildPhase = ''
      patchShebangs .
      substituteInPlace plugin/youcompleteme.vim \
        --replace "'ycm_path_to_python_interpreter', '''" "'ycm_path_to_python_interpreter', '${python}/bin/python'"

      mkdir build
      pushd build
      cmake -G "Unix Makefiles" . ../third_party/ycmd/cpp -DPYTHON_LIBRARIES:PATH=${python}/lib/libpython2.7.so -DPYTHON_INCLUDE_DIR:PATH=${python}/include/python2.7 -DUSE_CLANG_COMPLETER=ON -DUSE_SYSTEM_LIBCLANG=ON
      make ycm_core -j''${NIX_BUILD_CORES} -l''${NIX_BUILD_CORES}}
      ${python}/bin/python ../third_party/ycmd/build.py --gocode-completer --clang-completer --system-libclang
      popd
    '';

    meta = {
      description = "Fastest non utf-8 aware word and C completion engine for Vim";
      homepage = http://github.com/Valloric/YouCompleteMe;
      license = stdenv.lib.licenses.gpl3;
      maintainers = with stdenv.lib.maintainers; [marcweber jagajaga];
      platforms = stdenv.lib.platforms.unix;
    };
  }
