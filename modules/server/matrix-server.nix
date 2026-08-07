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
          file = ./../agenix/matrix.yaml.age;
          owner = "matrix-synapse";
          group = "matrix-synapse";
        };
        discord_secrets = {
          file = ./../agenix/mautrix_disord.env.age;
          owner = "mautrix-discord";
          group = "mautrix-discord";
        };
      };
    };
    services = {
      postgresql = {
        enable = true;
        ensureDatabases = [
          "matrix-synapse"
          "mautrix-whatsapp"
          "mautrix-discord"
        ];
        ensureUsers = [
          {
            name = "matrix-synapse";
            ensureDBOwnership = true;
          }
          {
            name = "mautrix-whatsapp";
            ensureDBOwnership = true;
          }
          {
            name = "mautrix-discord";
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
          app_service_config_files = [
            "/var/lib/mautrix-discord/discord-registration.yaml"
          ];
        };
        extraConfigFiles = [
          config.age.secrets.matrix-password.path
        ];
      };

      mautrix-whatsapp = {
        enable = true;
        settings = {
          homeserver = {
            address = "http://127.0.0.1:8008";
            domain = config.xanterella.matrix-server.domain;
          };
          database = {
            type = "postgres";
            uri = "postgres://mautrix-whatsapp@/mautrix-whatsapp?host=/run/postgresql";
          };
          bridge = {
            permissions = {
              "@Cato:${config.xanterella.matrix-server.domain}" = "admin";
            };
          };
        };
      };

      mautrix-discord = {
        enable = true;
        environmentFile = config.age.secrets.discord_secrets.path;
        settings = {
          homeserver = {
            address = "http://localhost:8008";
            domain = config.xanterella.matrix-server.domain;
          };
          database = {
            type = "postgres";
            uri = "postgres://mautrix-discord@/mautrix-discord?host=/run/postgresql";
          };
          bridge = {
            permissions = {
              "@Cato:${config.xanterella.matrix-server.domain}" = "admin";
            };
          };
        };
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
    nixpkgs.config.permittedInsecurePackages = [
      "olm-3.2.16"
    ];
  };
}
