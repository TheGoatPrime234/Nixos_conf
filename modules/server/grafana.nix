{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      grafana = {
        enable = lib.mkEnableOption "Aktiviert Grafana ohne externes Speichermedium";
      };
      grafana-extern = {
        enable = lib.mkEnableOption "Aktiviert Grafana mit externem Speichermedium";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.xanterella.grafana.enable {
      environment = {
        systemPackages = with pkgs; [
          grafana
        ];
      };
      systemd = {
        tmpfiles = {
          rules = [
            "d /home/cato/server-data/nix/grafana 0750 grafana grafana -"
          ];
        };
      };
      services = {
        grafana = {
          enable = true;
          dataDir = "/home/cato/server-data/nix/grafana";
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
    })
    (lib.mkIf config.xanterella.grafana-extern.enable {
      environment = {
        systemPackages = with pkgs; [
          grafana
        ];
      };
      systemd = {
        tmpfiles = {
          rules = [
            "d /mnt/server-data/nix/grafana 0750 grafana grafana -"
          ];
        };
      };
      services = {
        grafana = {
          enable = true;
          dataDir = "/mnt/server-data/nix/grafana";
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
    })
  ];
}
