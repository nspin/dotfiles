{ pkgs, lib, config, ... }:

let

  cfg = config.my.pia;

  auth = builtins.toFile "pia-auth" ''
    ${cfg.username}
    ${cfg.password}
  '';

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
      auth-user-pass ${auth}
      comp-lzo
      verb 1
      reneg-sec 0
      crl-verify ${./crl.rsa.2048.pem}
      ca ${./ca.rsa.2048.crt}
      disable-occ
    '';
  };

in with lib; {

  options.my.pia = {

    enable = mkEnableOption "pia";

    username = mkOption {
      type = types.str;
    };

    password = mkOption {
      type = types.str;
    };

    servers = mkOption {
      default = {
        sweden = "sweden";
      };
      type = lib.types.attrs;
      description = ''
        Map from PIA servers to service sub-names.
        ("myname", "myserver") will create service openvpn-myname.service that connects to myserver.privateinternetaccess.com.
      '';
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
