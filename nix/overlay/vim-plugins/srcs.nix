{ fetchgit }:

{

  "vim-repeat" = fetchgit {
    url = "https://github.com/tpope/vim-repeat";
    rev = "43d2678fa59d068c815d8298331c195e850ff5a7";
    sha256 = "0nb20503ka95qbx0mwhhni15drc86gfcd6kg92nf65llrvyfivk0";
  };

  "vim-commentary" = fetchgit {
    url = "https://github.com/tpope/vim-commentary";
    rev = "141d9d32a9fb58fe474fcc89cd7221eb2dd57b3a";
    sha256 = "0nncs32ayfhr557aiynq7b0sc7rxqwv7xanram53x1wvmfy14zf0";
  };

  "vim-surround" = fetchgit {
    url = "https://github.com/tpope/vim-surround";
    rev = "597068870b8f093a8b2d11536c62ff31222ee8d0";
    sha256 = "080kcgb5ayxs49q1p1cms6k1byf2fzzy8bglnspr511m9fql5a9x";
  };

  "vim-slime" = fetchgit {
    url = "https://github.com/jpalardy/vim-slime";
    rev = "1ff17cc7e8eeaf660daa5efee9e66ef83e00e686";
    sha256 = "1mrgpkyarc6igd7anzlwpbis6cwsy759ssxapfxmj1q69hyvmdl6";
  };

  "vim-dirvish" = fetchgit {
    url = "https://github.com/justinmk/vim-dirvish";
    rev = "d33796c460229b2cf0dd09fedf1b272da9d13a42";
    sha256 = "0brhbkj34yxyq5gvjkqakq0m9zwa981rv6ksca07qhw3nzpxhlkd";
  };

  "vim-bufferline" = fetchgit {
    url = "https://github.com/bling/vim-bufferline";
    rev = "651fd010aa9613a4b8636a4af8a2db0d22800262";
    sha256 = "0zls47a3v8dv3h63drbak1mxf3j2x3scvclk7bjwzlk2yp447das";
  };

  "vim-rsi" = fetchgit {
    url = "https://github.com/tpope/vim-rsi";
    rev = "24dfc44639166f910ef9e3ca3902e02df77a342a";
    sha256 = "12j02avqbmp8vr6q1z9jnya9ch0hqq5l267pw72362aq3wkw5jnm";
  };

  "vim-eunuch" = fetchgit {
    url = "https://github.com/tpope/vim-eunuch";
    rev = "10da325fb032a1acfa9222d273459f53bad30ba4";
    sha256 = "125n4amz3vmc83yv76vidsnma5w2braa69dcpj858ahnzhh329qj";
  };

  "vim-sexp" = fetchgit {
    url = "https://github.com/guns/vim-sexp";
    rev = "12292941903d9ac8151513189d2007e1ccfc95f0";
    sha256 = "1mfqbmrbqgnsc34pmcsrc0c5zvgxhhnw4hx4g5wbssfk1ddyx6y0";
  };

  "vim-sexp-mappings-for-regular-people" = fetchgit {
    url = "https://github.com/tpope/vim-sexp-mappings-for-regular-people";
    rev = "f5b66e73c81a3b4c0c8f5a8141fb09a5a213f711";
    sha256 = "1kf3bkv9wppxgifybd972avdd2563ra2387n7qc6q72b2r9mx5aa";
  };

  "youcompleteme" = fetchgit {
    url = "https://github.com/valloric/youcompleteme";
    rev = "443356132eceb391be0654663917e60cd96c51fc";
    sha256 = "12grpknpxb7d003934l3wpj9jjyzlviid3ibf4935lizmibhy099";
  };

  "cscope_macros.vim" = fetchgit {
    url = "https://github.com/vim-scripts/cscope_macros.vim";
    rev = "d1e0c369e8c25ecfd57d20382f1ed6fe0a1ac694";
    sha256 = "19m901kwcpvz847nviy3jnrvnv1v9sf54pr6n3b99cim1cpa7z6j";
  };

  "vim-snippets" = fetchgit {
    url = "https://github.com/honza/vim-snippets";
    rev = "0d7e7fad36c808b593ca602e00af4aec7516b752";
    sha256 = "1zz7p48x5vhksmfxjyvr76av8cpa1bj05rd0xf2vlq5hz5wx87bn";
  };

  "ultisnips" = fetchgit {
    url = "https://github.com/SirVer/ultisnips";
    rev = "6fdc3647f72e0a1f321ea6bd092ecd01f7c187ba";
    sha256 = "1zp3xcmxk6cn38zmxxy5s2wnw9djskwkmspq2s9vqliyhprf9sy3";
  };

  "tabular" = fetchgit {
    url = "https://github.com/godlygeek/tabular";
    rev = "339091ac4dd1f17e225fe7d57b48aff55f99b23a";
    sha256 = "0jq91770wsp2waw7pywxjqx59v0vg54gfzirgcd85pg61w22bfla";
  };

  "nerdtree" = fetchgit {
    url = "https://github.com/scrooloose/nerdtree";
    rev = "84737f2ebe533ffac9ebc21da8d1f57216962641";
    sha256 = "0cdzcswbzfjra357jnachnir1zi1l4l2l5vjn16481sf2bn8hkvn";
  };

  "vim-nix" = fetchgit {
    url = "https://github.com/LnL7/vim-nix";
    rev = "be0c6bb409732b79cc86c177ca378b0b334e1efe";
    sha256 = "1ivkwlm6lz43xk1m7aii0bgn2p3225dixck0qyhxw4zxhp2xiz06";
  };

  "idris-vim" = fetchgit {
    url = "https://github.com/idris-hackers/idris-vim";
    rev = "091ed6b267749927777423160eeab520109dd9c1";
    sha256 = "1zibar2vxcmai0k37ricwnimfdv1adxfbbvz871rc4l6h3q85if1";
  };

  "smali-vim" = fetchgit {
    url = "https://github.com/alderz/smali-vim";
    rev = "ae77727b0714f7896241b4f8ee4dcc93222bc532";
    sha256 = "11jqk2kckih6q32r82s6hwzff7ybzbwyakmq75p0ic9mijycw7gg";
  };

  "vim-markdown" = fetchgit {
    url = "https://github.com/tpope/vim-markdown";
    rev = "e2d7fcd682a461a3951e8b5067cc8a0083e75e35";
    sha256 = "1g1h3c8i4949kfh2vpxx00hryv0cca1kh44i4g1g6yxa6jdrpg1j";
  };

  "cryptol.vim" = fetchgit {
    url = "https://github.com/victoredwardocallaghan/cryptol.vim";
    rev = "15040e77c8256c9d7a8824fd95804836121ed46a";
    sha256 = "0iv8s2z7xap4mj2ad3dq67h629j2bn8zvch32azn3l0q4cppmnw8";
  };

  "chuck.vim" = fetchgit {
    url = "https://github.com/wilsaj/chuck.vim";
    rev = "7778b665829ee8ccae10b81afac951a0aaec3821";
    sha256 = "0b1bv2a5p94q5by8pkw67kdgibckll4ayn62cn4yw9w5hv4j96d2";
  };

  "Vim-Jinja2-Syntax" = fetchgit {
    url = "https://github.com/Glench/Vim-Jinja2-Syntax";
    rev = "ff113baf049525efb94ff32c3d845f817351de11";
    sha256 = "1c0m6rxqp96fq508xnwg01zna3h3wqg7lb009niy3i9hq7857swq";
  };

  "vim-colors-solarized" = fetchgit {
    url = "https://github.com/nspin/vim-colors-solarized";
    rev = "3993f5caa7f2b4cb7b190adcb4e6d26c0a1ffc6c";
    sha256 = "1y80awip0q5ihj6b9kxhh48s3d1vc66406sav6ixghv39d8dqvdg";
  };

}
