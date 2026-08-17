{
  config,
  pkgs,
  lib,
  pkgs-new,
  ...
}: let
  cfg = config.xanterella.audiobookshelf;
  nodeCfg = config.xanterella.cluster-node;
in {
  options = {
    xanterella = {
      audiobookshelf = {
        enable = lib.mkEnableOption "Aktiviert audiobookshelf ohne externes Speichermedium";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "${nodeCfg.domain}/audiobookshelf";
        };
      };
    };
  };

  config = lib.mkIf (cfg.enable && nodeCfg.enable) {
    services = {
      audiobookshelf = {
        enable = true;
        package = pkgs-new.audiobookshelf;
        host = "127.0.0.1";
        port = 13378;
      };
      caddy = {
        virtualHosts = {
          "https://${cfg.domain}" = {
            extraConfig = ''
              handle /audiobookshelf* {
                       reverse_proxy 127.0.0.1:13378 {
                       	flush_interval -1
                           }

                           request_body {
                       	max_size 0
                           }
                }
            '';
          };
        };
      };
    };
    systemd = {
      tmpfiles = {
        rules = [
          "d /mnt/server-data/audiobookshelf 0750 audiobookshelf audiobookshelf -"
          "d /mnt/server-data/audiobookshelf/metadata 0750 audiobookshelf audiobookshelf -"
          "d /mnt/server-data/audiobookshelf/config 0750 audiobookshelf audiobookshelf -"
        ];
      };
      services = {
        audiobookshelf = {
          environment = {
            ROUTER_BASE_PATH = "/audiobookshelf";
          };
        };
      };
    };
  };
}
