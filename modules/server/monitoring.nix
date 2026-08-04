{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      monitoring = {
        enable = lib.mkEnableOption "Aktiviert Monitoring";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "xanterella.de/monitoring";
        };
      };
    };
  };
  config = lib.mkIf config.xanterella.monitoring.enable {
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
          "https://${config.xanterella.monitoring.domain}" = {
            extraConfig = ''
              handle /grafana* {
                       reverse_proxy ${config.services.grafana.settings.server.http_addr}:${toString config.services.grafana.settings.server.http_port}
                }
            '';
          };
        };
      };
      prometheus = {
        enable = true;
        port = 9090;
        listenAddress = "127.0.0.1";
        retentionTime = "15d";
        exporters = {
          node = {
            enable = true;
            enabledCollectors = [
              "systemd"
            ];
            port = 9100;
            listenAddress = "127.0.0.1";
          };
        };
        scrapeConfigs = [
          {
            job_name = "nixos-laptop";
            scrape_interval = "10s";
            static_configs = [
              {
                targets = [
                  "127.0.0.1:${toString config.services.prometheus.exporters.node.port}"
                ];
              }
            ];
          }
        ];
      };
      grafana = {
        enable = true;
        settings = {
          server = {
            http_addr = "127.0.0.1";
            http_port = 9000;
            domain = config.xanterella.monitoring.domain;
            root_url = "%(protocol)s://%(domain)s/grafana/";
            serve_from_sub_path = true;
          };
        };
        provision = {
          enable = true;
          datasources = {
            settings = {
              datasources = [
                {
                  name = "Prometheus";
                  type = "prometheus";
                  access = "proxy";
                  url = "http://127.0.0.1:${toString config.services.prometheus.port}";
                  isDefault = true;
                }
              ];
            };
          };
        };
      };
    };
    networking = {
      firewall = {
        allowedTCPPorts = [
          config.services.grafana.settings.server.http_port
        ];
      };
    };
  };
}
