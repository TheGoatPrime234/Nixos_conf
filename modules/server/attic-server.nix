{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      attic-server = {
        enable = lib.mkEnableOption "Aktiviert Attic für Caching";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "xanterella.de/attic";
        };
      };
    };
  };

  config = lib.mkIf config.xanterella.attic-server.enable {
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
      systemPackages = with pkgs; [
        openssl
      ];
    };
    users = {
      users = {
        caddy = {
          extraGroups = [
            "tailscale"
          ];
        };
      };
    };
    services = {
      tailscale = {
        permitCertUid = "caddy";
      };
      caddy = {
        enable = true;
        virtualHosts = {
          "https://${config.xanterella.attic-server.domain}" = {
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
