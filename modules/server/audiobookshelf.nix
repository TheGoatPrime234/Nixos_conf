{
  config,
  pkgs,
  lib,
  pkgs-unstable,
  ...
}: let
  cfg = config.xanterella.audiobookshelf;
  nodeCfg = config.xanterella.cluster-node;
in {
  options = {
    xanterella = {
      audiobookshelf = {
        enable = lib.mkEnableOption "Aktiviert audiobookshelf";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "${nodeCfg.domain}:1005";
        };
      };
    };
  };

  config = lib.mkIf (cfg.enable && nodeCfg.enable) {
    virtualisation = {
      oci-containers = {
        backend = "podman";
        containers = {
          audiobookshelf = {
            image = "ghcr.io/advplyr/audiobookshelf:latest";
            ports = [
              "0.0.0.0:13378:80"
            ];
            volumes = [
              "/mnt/server-data/audiobookshelf/config:/config"
              "/mnt/server-data/audiobookshelf/metadata:/metadata"
              "/mnt/server-data/audiobookshelf/audiobooks:/audiobooks"
            ];
          };
        };
      };
    };
    systemd = {
      tmpfiles = {
        rules = [
          "d /mnt/server-data/audiobookshelf 0755 root root -"
          "d /mnt/server-data/audiobookshelf/config 0755 root root -"
          "d /mnt/server-data/audiobookshelf/metadata 0755 root root -"
          "d /mnt/server-data/audiobookshelf/audiobooks 0755 root root -"
        ];
      };
    };
  };
}
