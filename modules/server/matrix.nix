{
  config,
  pkgs,
  lib,
  pkgs-unstable,
  ...
}: {
  options = {
    xanterella = {
      matrix = {
        enable = lib.mkEnableOption "Aktiviert Matrix Pipeline";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "xanterella.de/matrix";
        };
      };
    };
  };

  config = lib.mkIf config.xanterella.vaultwarden.enable {
    age = {
      secrets = {
        matrix-password = {
          file = ./../agenix/matrix.age;
        };
      };
    };
    services = {
      postgresql = {
        enable = true;
      };
      matrix-synapse = {
        enable = true;
        settings = {
          server_name = config.xanterella.matrix.domain;
          registration_shared_secret = config.age.secrets.matrix-password;
          enable_registration = false;
        };
      };
      withPostgreSQL = true;

      tailscale = {
        permitCertUid = "caddy";
      };
      caddy = {
        enable = true;
        virtualHosts = {
          "https://${config.xanterella.matrix.domain}:8443" = {
            extraConfig = ''
              handle /_matrix* {
              reverse_proxy 127.0.0.1:8080
              }
              handle /_synapse/client* {
              reverse_proxy 127.0.0.1:8080
              }
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
