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
    rev = "e58486b791e6e1126ffd46d4ef634b8fef104f7f";
    sha256 = "1abp1wh10wdvrii1jyzg12a0c5jk2yf88mczxkjwql0r7wcn89qd";
  };

  "vim-dirvish" = fetchgit {
    url = "https://github.com/justinmk/vim-dirvish";
    rev = "c273c462d774ed2db5f6d382265cf5897e554de0";
    sha256 = "1fv1kk7y280kx8c0iy9rg43i8gr0h8308al8sm85qvmfx5fcbi9d";
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
    rev = "632d92e85d4b6d5413ee4a643ce570efb09c8d6b";
    sha256 = "0mw2wxr4y5r1j3lj4ilihs83l2afsr0lnxzy73v1hsahs70vayx8";
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
    rev = "e018777b38eedaa23b96cfee40382d000e464e31";
    sha256 = "1j4r6gkjs7kk2nwhmlwzm1nzzwrk96sr8xfbj0vwa847bsq3p591";
  };

  "cscope_macros.vim" = fetchgit {
    url = "https://github.com/vim-scripts/cscope_macros.vim";
    rev = "d1e0c369e8c25ecfd57d20382f1ed6fe0a1ac694";
    sha256 = "19m901kwcpvz847nviy3jnrvnv1v9sf54pr6n3b99cim1cpa7z6j";
  };

  "vim-snippets" = fetchgit {
    url = "https://github.com/honza/vim-snippets";
    rev = "7c7e7d47ecb51813de7573f056af99e1790d5eff";
    sha256 = "1hm227kzh5g6l8wpxwjhb0kf2packlnqi8v90q8286m6v8c2ca1a";
  };

  "ultisnips" = fetchgit {
    url = "https://github.com/SirVer/ultisnips";
    rev = "6fdc3647f72e0a1f321ea6bd092ecd01f7c187ba";
    sha256 = "1zp3xcmxk6cn38zmxxy5s2wnw9djskwkmspq2s9vqliyhprf9sy3";
  };

  "tabular" = fetchgit {
    url = "https://github.com/godlygeek/tabular";
    rev = "00e1e7fcdbc6d753e0bc8043e0d2546fa81bf367";
    sha256 = "185jpisk9hamcwb6aiavdzjdbbigzdra8f4mgs98r9cm9j448xkz";
  };

  "nerdtree" = fetchgit {
    url = "https://github.com/scrooloose/nerdtree";
    rev = "e653a682705234e9bffac0c32995f339e66df684";
    sha256 = "1d99ki7dzv6iw1bs61rv9k9z8kf2bi00dxrvlvs09jbgnjil2r92";
  };

  "vim-nix" = fetchgit {
    url = "https://github.com/LnL7/vim-nix";
    rev = "d781ccada822c8a42c0d70f548e3b8563ffe0a3d";
    sha256 = "0lklzbibyf0w5p7k0bri90daa1fj5z9yhj0jxgg9scikk4kkx1f7";
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
    rev = "75807e683a48d51416b9bcc7e7ffef96aa130ecd";
    sha256 = "1zfz8pqj120kbl0v15bvk9b0c6x04zmvlimr6nfka20mrpq7gh36";
  };

  "vim-colors-solarized" = fetchgit {
    url = "https://github.com/nickspinale/vim-colors-solarized";
    rev = "3993f5caa7f2b4cb7b190adcb4e6d26c0a1ffc6c";
    sha256 = "1y80awip0q5ihj6b9kxhh48s3d1vc66406sav6ixghv39d8dqvdg";
  };

}
