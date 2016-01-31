{ fzf, tmux }:
{ name = "fzf-tmux";
  src = ./.;
  cpp = {
    FZF_DIR = fzf;
    TMUX_DIR = tmux;
  };
  libs = [ "attoparsec" ];
}
