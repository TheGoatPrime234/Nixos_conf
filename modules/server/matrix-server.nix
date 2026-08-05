{
  config,
  pkgs,
  lib,
  pkgs-unstable,
  ...
}: {
  options = {
    xanterella = {
      matrix-server = {
        enable = lib.mkEnableOption "Aktiviert Matrix Pipeline";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "xanterella.de/matrix";
        };
      };
    };
  };

  config = lib.mkIf config.xanterella.matrix-server.enable {
    age = {
      secrets = {
        matrix-password = {
          file = ./../agenix/matrix.age;
          owner = "matrix-synapse";
          group = "matrix-synapse";
        };
      };
    };
    services = {
      postgresql = {
        enable = true;
        ensureDatabases = ["matrix-synapse"];
        ensureUsers = [
          {
            name = "matrix-synapse";
            ensureDBOwnership = true;
          }
        ];
      };
      matrix-synapse = {
        enable = true;
        settings = {
          server_name = config.xanterella.matrix-server.domain;
          enable_registration = false;
          database = {
            name = "psycopg2";
            args = {
              user = "matrix-synapse";
              database = "matrix-synapse";
              host = "/run/postgresql";
            };
          };
        };
        extraConfigFiles = [
          config.age.secrets.matrix-password.path
        ];
      };

      tailscale = {
        permitCertUid = "caddy";
      };
      caddy = {
        enable = true;
        virtualHosts = {
          "https://${config.xanterella.matrix-server.domain}" = {
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
