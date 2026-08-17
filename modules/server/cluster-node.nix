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
