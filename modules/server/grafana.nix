{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.grafana.enable = lib.mkEnableOption "Aktiviert grafana";
  };

  config = lib.mkIf config.xanterella.grafana.enable {
    environment.systemPackages = with pkgs; [
      grafana
    ];
    systemd = {
      tmpfiles = {
        rules = [
          "d /mnt/data/nix/grafana 0750 grafana grafana -"
        ];
      };
    };
    services = {
      grafana = {
        enable = true;
        dataDir = "/mnt/data/nix/grafana";
        settings = {
          server = {
            http_addr = "0.0.0.0";
            http_port = 8989;
          };
        };
      };
    };
    networking = {
      firewall = {
        allowedTCPPorts = [
          8989
        ];
      };
    };
  };
}
