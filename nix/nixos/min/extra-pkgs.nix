{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    mercurial subversion wget rsync zip unzip p7zip

    gnumake

    htop
    bind
    openssl

    readme-preview

  ];

}
