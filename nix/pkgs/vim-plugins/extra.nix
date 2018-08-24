{ python2, ycmd }: {

  youcompleteme.extra = ''
    substituteInPlace plugin/youcompleteme.vim \
      --replace "'ycm_path_to_python_interpreter', '''" \
                "'ycm_path_to_python_interpreter', '${python2}/bin/python'"

    rm -r third_party/ycmd
    ln -s ${ycmd}/lib/ycmd third_party
  '';
}
