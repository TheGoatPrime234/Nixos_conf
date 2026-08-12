{
  config,
  pkgs,
  lib,
  pkgs-unstable,
  ...
}: {
  options = {
    xanterella = {
      vikunja = {
        enable = lib.mkEnableOption "Aktiviert Vikuna";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "xanterella.de/vikunja";
        };
      };
    };
  };

  config = lib.mkIf config.xanterella.vikunja.enable {
    services = {
      vikunja = {
        enable = true;
        port = 8919;
        frontendScheme = "https";
        frontendHostname = "lutik";
        settings = {
          service = {
            frontendurl = "https://${config.xanterella.vikunja.domain}:3456/";
          };
        };
      };
      tailscale = {
        permitCertUid = "caddy";
      };
      caddy = {
        enable = true;
        virtualHosts = {
          "https://${config.xanterella.vikunja.domain}:3456" = {
            extraConfig = ''
              reverse_proxy 127.0.0.1:${toString config.services.vikunja.port}
            '';
          };
        };
      };
    };
    users = {
      users = {
        caddy = {
          extraGroups = ["tailscale"];
        };
      };
    };
  };
}
