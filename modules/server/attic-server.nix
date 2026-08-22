{
  config,
  pkgs-unstable,
  lib,
  ...
}: let
  cfg = config.xanterella.attic-server;
  nodeCfg = config.xanterella.cluster-node;
in {
  options = {
    xanterella = {
      attic-server = {
        enable = lib.mkEnableOption "Aktiviert Attic für Caching";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "${nodeCfg.domain}:1001";
        };
      };
    };
  };

  config = lib.mkIf (cfg.enable && nodeCfg.enable) {
    services = {
      atticd = {
        enable = true;
        environmentFile = "/root/secrets/atticd.env";
        settings = {
          listen = "127.0.0.1:6000";
          database = {
            url = "sqlite:///mnt/server-data/attic/server.db";
          };
          storage = {
            type = "local";
            path = "/mnt/server-data/attic/storage";
          };
          chunking = {
            "nar-size-threshold" = 65536;
            "min-size" = 16384;
            "avg-size" = 65536;
            "max-size" = 262144;
          };
        };
      };
    };
    systemd = {
      tmpfiles = {
        rules = [
          "d /mnt/server-data/attic 0750 atticd atticd -"
          "d /mnt/server-data/attic/storage 0750 atticd atticd -"
        ];
      };
      services = {
        atticd = {
          serviceConfig = {
            ReadWritePaths = ["/mnt/server-data/attic"];
          };
        };
      };
    };
    environment = {
      systemPackages = with pkgs-unstable; [
        openssl
      ];
    };
    services = {
      caddy = {
        virtualHosts = {
          "https://${cfg.domain}" = {
            extraConfig = ''
              handle {
              reverse_proxy ${config.services.atticd.settings.listen}
              }
            '';
          };
        };
      };
    };
  };
}
