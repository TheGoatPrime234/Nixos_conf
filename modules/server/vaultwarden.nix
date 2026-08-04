{
  config,
  pkgs,
  lib,
  pkgs-unstable,
  ...
}: {
  options = {
    xanterella = {
      vaultwarden = {
        enable = lib.mkEnableOption "Aktiviert Vaultwarden ohne externes Speichermedium";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "xanterella.de/vaultwarden";
        };
      };
    };
  };

  config = lib.mkIf config.xanterella.vaultwarden.enable {
    services = {
      vaultwarden = {
        enable = true;
        config = {
          DOMAIN = "https://${config.xanterella.vaultwarden.domain}";
          WEBSOCKET_ENABLED = true;
          ROCKET_ADDRESS = "127.0.0.1";
          ROCKET_PORT = 8222;
        };
      };
      tailscale = {
        permitCertUid = "caddy";
      };
      caddy = {
        enable = true;
        virtualHosts = {
          "https://${config.xanterella.vaultwarden.domain}:8443" = {
            extraConfig = ''
              reverse_proxy 127.0.0.1:8222
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
    networking = {
      firewall = {
        allowedTCPPorts = [
          8222
        ];
      };
    };
  };
}
