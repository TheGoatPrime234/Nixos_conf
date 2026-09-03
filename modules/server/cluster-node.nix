{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: let
  cfg = config.xanterella.cluster-node;
in {
  options = {
    xanterella = {
      cluster-node = {
        enable = lib.mkEnableOption "Aktiviert die Vorbereitung für Services";

        domain = lib.mkOption {
          type = lib.types.str;
          default = "xanterella.de";
        };

        tailscale-domain = lib.mkOption {
          type = lib.types.str;
          default = "gute-nessie.ts.net";
        };

        head = lib.mkEnableOption "Macht den Server zum Head Server";

        monitoring-server = lib.mkOption {
          type = lib.types.str;
          default = "";
        };
      };
    };
  };
  config = lib.mkMerge [
    (lib.mkIf config.xanterella.cluster-node.enable {
      services = {
        caddy = {
          enable = true;
        };
        tailscale = {
          enable = true;
          permitCertUid = "caddy";
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
      networking = {
        firewall = {
          trustedInterfaces = ["tailscale0"];
        };
      };
    })
    (lib.mkIf (config.xanterella.cluster-node.enable && config.xanterella.cluster-node.head) {
      age = {
        secrets = {
          cloudflare-token = {
            file = ./../agenix/cloudflare-token.age;
          };
        };
      };
      services = {
        caddy = {
          enable = true;
          virtualHosts = {
            "home.${cfg.domain}" = {
              extraConfig = ''
                reverse_proxy http://lacrux.${cfg.tailscale-domain}:8123
              '';
            };
            "jellyfin.${cfg.domain}" = {
              extraConfig = ''
                reverse_proxy http://swetik.${cfg.tailscale-domain}:8096
              '';
            };
            "paperless.${cfg.domain}" = {
              extraConfig = ''
                reverse_proxy http://[NODE].${cfg.tailscale-domain}:2731
              '';
            };

            "audiobookshelf.${cfg.domain}" = {
              extraConfig = ''
                reverse_proxy http://[NODE].${cfg.tailscale-domain}:13378 {
                  flush_interval -1
                }
                request_body {
                  max_size 0
                }
              '';
            };

            "immich.${cfg.domain}" = {
              extraConfig = ''
                reverse_proxy http://[NODE].${cfg.tailscale-domain}:2283 {
                  flush_interval -1
                }
                request_body {
                  max_size 0
                }
              '';
            };

            "immich-ml.${cfg.domain}" = {
              extraConfig = ''
                reverse_proxy http://[NODE].${cfg.tailscale-domain}:3003
              '';
            };

            "livesync.${cfg.domain}" = {
              extraConfig = ''
                reverse_proxy http://[NODE].${cfg.tailscale-domain}:5984
              '';
            };

            "homarr.${cfg.domain}" = {
              extraConfig = ''
                reverse_proxy http://[NODE].${cfg.tailscale-domain}:7575
              '';
            };

            "vaultwarden.${cfg.domain}" = {
              extraConfig = ''
                reverse_proxy http://[NODE].${cfg.tailscale-domain}:8222
              '';
            };

            "vikunja.${cfg.domain}" = {
              extraConfig = ''
                reverse_proxy http://[NODE].${cfg.tailscale-domain}:8919
              '';
            };

            "grafana.${cfg.domain}" = {
              extraConfig = ''
                reverse_proxy http://[NODE].${cfg.tailscale-domain}:9000
              '';
            };

            "attic.${cfg.domain}" = {
              extraConfig = ''
                handle {
                  reverse_proxy http://[NODE].${cfg.tailscale-domain}:6000
                }
              '';
            };

            "matrix.${cfg.domain}" = {
              extraConfig = ''
                handle /_matrix* {
                  reverse_proxy http://[NODE].${cfg.tailscale-domain}:8008
                }
                handle /_synapse/client* {
                  reverse_proxy http://[NODE].${cfg.tailscale-domain}:8008
                }
              '';
            };
          };
        };
      };
      environment = {
        systemPackages = with pkgs-unstable; [
          vlc
        ];
      };
      systemd = {
        services = {
          cloudflare-tunnel = {
            description = "Cloudflare Zero Trust Tunnel";
            wantedBy = ["multi-user.target"];
            after = ["network-online.target"];
            wants = ["network-online.target"];

            serviceConfig = {
              ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run";
              EnvironmentFile = config.age.secrets.cloudflare-token.path;

              Restart = "always";
              RestartSec = "5s";
              DynamicUser = true;
            };
          };
        };
      };
    })
  ];
}
