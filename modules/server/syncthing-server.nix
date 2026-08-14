{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      syncthing_server = {
        enable = lib.mkEnableOption "Aktiviert Syncthing_server ohne externes Speichermedium";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "xanterella.de/syncthing";
        };
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.xanterella.syncthing_server.enable {
      environment = {
        systemPackages = with pkgs; [
          syncthing
        ];
      };
      systemd = {
        tmpfiles = {
          rules = [
            "d /mnt/server-data/nix/syncthing 0750 syncthing syncthing -"
            "d /mnt/server-data/nix/syncthing/data 0750 syncthing syncthing -"
            "d /mnt/server-data/nix/syncthing/config 0750 syncthing syncthing -"
          ];
        };
      };
      services = {
        syncthing = {
          enable = true;
          systemService = true;
          dataDir = "/mnt/server-data/nix/syncthing/data";
          configDir = "/mnt/server-data/nix/syncthing/config";
          user = "syncthing";
          group = "syncthing";
          guiAddress = "127.0.0.1:8284";
          settings = {
            gui = {
              insecureSkipHostcheck = true;
            };
          };
        };
        tailscale = {
          permitCertUid = "caddy";
        };
        caddy = {
          enable = true;
          virtualHosts = {
            "https://${config.xanterella.syncthing_server.domain}:8384" = {
              extraConfig = ''
                reverse_proxy ${config.services.syncthing.guiAddress}
              '';
            };
          };
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
          allowedTCPPorts = [
            22000
            8384
          ];
          allowedUDPPorts = [
            22000
            21027
          ];
        };
      };
    })
  ];
}
