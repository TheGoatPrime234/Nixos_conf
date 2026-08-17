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
          default = "${nodeCfg.domain}:1";
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
            url = "sqlite:///var/lib/atticd/server.db";
          };
          storage = {
            type = "local";
            path = "/var/lib/atticd/storage";
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
