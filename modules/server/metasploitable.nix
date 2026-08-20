{
  config,
  pkgs,
  lib,
  pkgs-unstable,
  ...
}: let
  cfg = config.xanterella.metasploitable;
  nodeCfg = config.xanterella.cluster-node;
in {
  options = {
    xanterella = {
      metasploitable = {
        enable = lib.mkEnableOption "Aktiviert Vaultwarden ohne externes Speichermedium";
      };
    };
  };

  config = lib.mkIf (cfg.enable && nodeCfg.enable) {
    networking = {
      interfaces = {
        metasploit-net = {
          virtual = true;
          ipv4 = {
            addresses = [
              {
                address = "10.99.99.1";
                prefixLength = 24;
              }
            ];
          };
        };
      };
    };
    virtualisation = {
      oci-containers = {
        backend = "podman";
        containers = {
          metasploitable = {
            image = "tleemcjr/metasploitable2:latest";
            autoStart = false;
            ports = [
              "10.99.99.1:21:21"
              "10.99.99.1:22:22"
              "10.99.99.1:80:80"
            ];
          };
        };
      };
    };
  };
}
