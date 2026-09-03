{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  cfg = config.xanterella.prometheus;
  nodeCfg = config.xanterella.cluster-node;
in {
  options = {
    xanterella = {
      prometheus = {
        enable = lib.mkEnableOption "Aktiviert Prometheus";
      };
    };
  };
  config = lib.mkIf (cfg.enable && nodeCfg.enable) {
    services = {
      prometheus = {
        exporters = {
          node = {
            enable = true;
            enabledCollectors = [
              "systemd"
              "hwmon"
              "tcpstat"
            ];
            listenAddress = "0.0.0.0";
            port = 9100;
          };
          process = {
            enable = true;
            port = 9101;
            listenAddress = "0.0.0.0";
            settings = {
              process_names = [
                {
                  name = "Netbird";
                  cmdline = [".*netbird.*"];
                }
                {
                  name = "Tailscale";
                  cmdline = [".*tailscaled.*"];
                }
                {
                  name = "Caddy";
                  cmdline = [".*caddy.*"];
                }
                {
                  name = "Grafana";
                  cmdline = [".*grafana.*"];
                }
                {
                  name = "Immich";
                  cmdline = [
                    ".*podman-immich-postgres.*"
                    ".*podman-immich-server.*"
                    ".*podman-immich-redis.*"
                  ];
                }
                {
                  name = "GitHub-Runner";
                  cmdline = [".*github-runner.*"];
                }
                {
                  name = "Vikunja";
                  cmdline = [".*vikunja.*"];
                }
                {
                  name = "Vaultwarden";
                  cmdline = [".*vaultwarden.*"];
                }
                {
                  name = "Audiobookshelf";
                  cmdline = [".*audiobookshelf.*"];
                }
                {
                  name = "Matrix Synapse";
                  cmdline = [".*synapse.*"];
                }
                {
                  name = "Matrix Discord";
                  cmdline = [".*mautrix-discord.*"];
                }
                {
                  name = "Matrix Whatsapp";
                  cmdline = [".*mautrix-whatsapp.*"];
                }
                {
                  name = "Attic";
                  cmdline = [".*atticd.*"];
                }
              ];
            };
          };
        };
      };
    };
  };
}
