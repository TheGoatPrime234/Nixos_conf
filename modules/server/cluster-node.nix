{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      cluster-node = {
        enable = lib.mkEnableOption "Aktiviert die Vorbereitung für Services";

        domain = lib.mkOption {
          type = lib.types.str;
          default = "xanterella.de";
        };

        monitoring-server = lib.mkOption {
          type = lib.types.str;
          default = "";
        };
      };
    };
  };
  config = lib.mkIf config.xanterella.cluster-node.enable {
    age = {
      secrets = {
        cloudflare-token = {
          file = ./../agenix/cloudflare-token.age;
        };
      };
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
        allowedTCPPorts = [80 443];
      };
    };
  };
}
