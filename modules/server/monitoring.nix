{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  cfg = config.xanterella.monitoring;
  nodeCfg = config.xanterella.cluster-node;
  ClusterNodes = ["lutik"];
in {
  options = {
    xanterella = {
      monitoring = {
        enable = lib.mkEnableOption "Aktiviert Monitoring";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "${nodeCfg.domain}:99";
        };
      };
    };
  };
  config = lib.mkIf config.xanterella.monitoring.enable {
    services = {
      prometheus = {
        enable = true;
        port = 9090;
        listenAddress = "127.0.0.1";
        retentionTime = "15d";
        scrapeConfigs = [
          {
            job_name = "node";
            scrape_interval = "10s";
            scheme = "https";
            static_configs =
              builtins.map (host: {
                targets = [
                  "${host}.gute-nessie.ts.net:9999"
                ];
                labels = {
                  nodename = host;
                };
              })
              ClusterNodes;
          }
          {
            job_name = "process";
            scrape_interval = "10s";
            scheme = "https";
            static_configs =
              builtins.map (host: {
                targets = [
                  "${host}.gute-nessie.ts.net:9998"
                ];
                labels = {
                  nodename = host;
                };
              })
              ClusterNodes;
          }
        ];
      };
      grafana = {
        enable = true;
        settings = {
          server = {
            http_addr = "127.0.0.1";
            http_port = 9000;
            domain = cfg.domain;
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
          dashboards = {
            settings = {
              providers = [
                {
                  name = "GitHub Dashboard";
                  options = {
                    path = "${inputs.xanterella-etc}";
                  };
                }
              ];
            };
          };
        };
      };
      caddy = {
        enable = true;
        globalConfig = ''
          servers {
          metrics
          }
        '';
        virtualHosts = {
          "https://${cfg.domain}" = {
            extraConfig = ''
              reverse_proxy ${config.services.grafana.settings.server.http_addr}:${toString config.services.grafana.settings.server.http_port}
            '';
          };
        };
      };
    };
    systemd = {
      services = {
        grafana = {
          environment = {
            GF_DASHBOARDS_DEFAULT_HOME_DASHBOARD_PATH = "${inputs.xanterella-etc}/grafana/monitoring.json";
          };
        };
      };
    };
  };
}
