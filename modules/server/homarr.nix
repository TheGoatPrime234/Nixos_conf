{
  config,
  pkgs-new,
  lib,
  inputs,
  ...
}: let
  cfg = config.xanterella.homarr;
  nodeCfg = config.xanterella.cluster-node;
in {
  options = {
    xanterella = {
      homarr = {
        enable = lib.mkEnableOption "Aktiviert Homarr. Eine Homepage";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "${nodeCfg.domain}";
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && nodeCfg.enable) {
    virtualisation = {
      oci-containers = {
        backend = "podman";
        containers = {
          homarr = {
            image = "ghcr.io/ajnart/homarr:latest";
            ports = [
              "0.0.0.0:7575:7575"
            ];
            volumes = [
              "${inputs.xanterella-etc}/homarr:/app/data/configs"
              "/mnt/server-data/homarr/icons:/app/public/icons"
              "/mnt/server-data/homarr/data:/data"
            ];
          };
        };
      };
    };

    systemd = {
      tmpfiles = {
        rules = [
          "d /mnt/server-data/homarr 0755 root root -"
          "d /mnt/server-data/homarr/configs 0755 root root -"
          "d /mnt/server-data/homarr/icons 0755 root root -"
          "d /mnt/server-data/homarr/data 0755 root root -"
        ];
      };
    };
  };
}
