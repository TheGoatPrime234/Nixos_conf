{
  config,
  pkgs-new,
  lib,
  ...
}: {
  options = {
    xanterella = {
      immich-server = {
        enable = lib.mkEnableOption "Aktiviert Immich";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "xanterella.de/immich";
        };
      };
    };
  };
  config = lib.mkIf config.xanterella.immich-server.enable {
    age = {
      secrets = {
        immich-env = {
          file = ./../agenix/immich.env.age;
        };
      };
    };
    virtualisation = {
      podman = {
        enable = true;
        defaultNetwork = {
          settings = {
            dns_enabled = true;
          };
        };
      };
      oci-containers = {
        backend = "podman";
        containers = {
          immich-redis = {
            image = "docker.io/redis:6.2-alpine";
          };
          immich-postgres = {
            image = "docker.io/pgvector/pgvector:pg14";
            environment = {
              POSTGRES_USER = "postgres";
              POSTGRES_DB = "immich";
            };
            environmentFiles = [config.age.secrets.immich-env.path];
            volumes = ["/mnt/server-data/immich/db:/var/lib/postgresql/data"];
          };
          immich-server = {
            image = "ghcr.io/immich-app/immich-server:v3.1.0";
            dependsOn = ["immich-postgres" "immich-redis"];
            ports = [
              "127.0.0.1:2283:2283"
            ];
            volumes = ["/mnt/server-data/immich/upload:/usr/src/app/upload"];
            environment = {
              DB_HOSTNAME = "immich-postgres";
              DB_USERNAME = "postgres";
              DB_DATABASE_NAME = "immich";
              REDIS_HOSTNAME = "immich-redis";
              TZ = "Europe/Berlin";
              IMMICH_HOST = "127.0.0.1";
            };
            environmentFiles = [
              config.age.secrets.immich-env.path
            ];
          };
          immich-machine-learning = {
            image = "ghcr.io/immich-app/immich-machine-learning:v3.1.0";
            dependsOn = ["immich-server"];
            volumes = ["/mnt/server-data/immich/model-cache:/cache"];
          };
        };
      };
    };
    systemd = {
      tmpfiles = {
        rules = [
          "d /mnt/server-data/immich 0755 root root -"
          "d /mnt/server-data/immich/db 0755 root root -"
          "d /mnt/server-data/immich/upload 0755 root root -"
          "d /mnt/server-data/immich/model-cache 0755 root root -"
        ];
      };
    };
    services = {
      tailscale = {
        permitCertUid = "caddy";
      };
      caddy = {
        enable = true;
        virtualHosts = {
          "https://${config.xanterella.immich-server.domain}:9999" = {
            extraConfig = ''
              reverse_proxy 127.0.0.1:2283
            '';
          };
        };
      };
    };
    networking = {
      firewall = {
        allowedTCPPorts = [9999 2283];
      };
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
  };
}
