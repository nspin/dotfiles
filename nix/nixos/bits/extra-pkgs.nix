{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    mercurial subversion wget

    zip unzip p7zip

    rsync 
    sshfsFuse
    telnet

    gnumake

    htop
    bind
    openssl

    readme-preview

  ];

}
