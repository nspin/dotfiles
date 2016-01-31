{ stdenv, fetchgit, bash, cmake, python27, llvmPackages }:

stdenv.mkDerivation {

  name = "ycm";
  src = fetchgit {
    url = "git://github.com/valloric/youcompleteme";
    rev = "f94b342989deb1a20b5f87ef2a7d30b16a9ff733";
    sha256 = "0a4d7e30a3ecdb22cb8ffa9bafae8b3bdb160c92ab5e2ce57413f2177e28eedc";
  };
  dependencies = [];
  buildInputs = [
    python27 cmake
    (if stdenv.isDarwin then llvmPackages.clang else llvmPackages.clang-unwrapped)
    llvmPackages.llvm
  ];

  configurePhase = ":";

  buildPhase = ''
    patchShebangs .

    mkdir -p $out
    cp -a ./ $out

    mkdir $out/build
    cd $out/build
    cmake -G "Unix Makefiles" . $out/third_party/ycmd/cpp -DPYTHON_LIBRARIES:PATH=${python27}/lib/libpython2.7.so -DPYTHON_INCLUDE_DIR:PATH=${python27}/include/python2.7 -DUSE_CLANG_COMPLETER=ON -DUSE_SYSTEM_LIBCLANG=ON
    make ycm_support_libs -j''${NIX_BUILD_CORES} -l''${NIX_BUILD_CORES}}
    ${python27}/bin/python $out/third_party/ycmd/build.py --clang-completer --system-libclang
  '';

  # TODO: implement proper install phase rather than keeping everything in store
  # TODO: support llvm based C completion, See README of git repository
  installPhase = ":";

  meta = {
    description = "Fastest non utf-8 aware word and C completion engine for Vim";
    homepage = http://github.com/Valloric/YouCompleteMe;
    license = stdenv.lib.licenses.gpl3;
    maintainers = with stdenv.lib.maintainers; [marcweber jagajaga];
    platforms = stdenv.lib.platforms.linux;
  };
}
