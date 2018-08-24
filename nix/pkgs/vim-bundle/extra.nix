{ python3, ycmd }: {

  youcompleteme.extra = ''
    echo "HIFDSF"
    substituteInPlace plugin/youcompleteme.vim \
      --replace "'ycm_path_to_python_interpreter', '''" \
                "'ycm_path_to_python_interpreter', '${python3}/bin/python'"

    rm -r third_party/ycmd
    ln -s ${ycmd}/lib/ycmd third_party
  '';
}
