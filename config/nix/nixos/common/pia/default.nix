{ pkgs, lib, config, ... }:

let

  cfg = config.my.pia;

  piaAt = server: {
    autoStart = false;
    up = "echo nameserver $nameserver | ${pkgs.openresolv}/sbin/resolvconf -m 0 -a $dev";
    down = "${pkgs.openresolv}/sbin/resolvconf -d $dev";
    config = ''
      client
      dev tun
      proto udp
      remote ${server}.privateinternetaccess.com 1198
      resolv-retry infinite
      nobind
      persist-key
      persist-tun
      cipher aes-128-cbc
      auth sha1
      tls-client
      remote-cert-tls server
      auth-user-pass ${/cfg/local/pia/auth}
      comp-lzo
      verb 1
      reneg-sec 0
      crl-verify ${/cfg/local/pia/crl.rsa.2048.pem}
      ca ${/cfg/local/pia/ca.rsa.2048.crt}
      disable-occ
    '';
  };

in with lib; {

  options = {
    my.pia = {
      enable = mkEnableOption "pia";
      servers = mkOption {
        default = {
          sweden = "pia";
        };
        type = lib.types.attrs;
        description = ''
          Map from PIA servers to service sub-names.
          ("myname", "myserver") will create service openvpn-myname.service that connects to myserver.privateinternetaccess.com.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.openvpn.servers = builtins.listToAttrs (map
        (attrName: {
          name = attrName;
          value = piaAt (builtins.getAttr attrName cfg.servers);
        })
        (builtins.attrNames cfg.servers)
      );
  };

}
