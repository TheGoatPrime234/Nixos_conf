{
  config,
  pkgs-unstable,
  lib,
  inputs,
  ...
}: let
  cfg = config.xanterella.livesync;
  nodeCfg = config.xanterella.cluster-node;
in {
  options = {
    xanterella = {
      livesync = {
        enable = lib.mkEnableOption "Aktiviert Livesync für Obsidian";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "${nodeCfg.domain}:1008";
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && nodeCfg.enable) {
    age = {
      secrets = {
        couchdb-env = {
          file = ./../agenix/couchdb.env.age;
        };
      };
    };
    virtualisation = {
      oci-containers = {
        containers = {
          obsidian-couchdb = {
            image = "couchdb:3";
            ports = ["127.0.0.1:5984:5984"];
            environmentFiles = [config.age.secrets.couchdb-env.path];
            cmd = ["/bin/sh" "-c" "echo '[chttpd]\nenable_cors = true\n[cors]\norigins = app://obsidian.md,capacitor://localhost,http://localhost\ncredentials = true\nmethods = GET, PUT, POST, HEAD, DELETE\nheaders = accept, authorization, content-type, origin, referer, x-csrf-token' > /opt/couchdb/etc/local.d/cors.ini && /docker-entrypoint.sh /opt/couchdb/bin/couchdb"];
          };
        };
      };
    };

    systemd = {
      tmpfiles = {
        rules = [
          "d /mnt/server-data/livesync 0755 root root -"
          "d /mnt/server-data/livesync/configs 0755 root root -"
          "d /mnt/server-data/livesync/icons 0755 root root -"
          "d /mnt/server-data/livesync/data 0755 root root -"
        ];
      };
    };
    services = {
      caddy = {
        virtualHosts = {
          "https://${cfg.domain}" = {
            extraConfig = ''
              reverse_proxy 127.0.0.1:7575
            '';
          };
        };
      };
    };
  };
}
