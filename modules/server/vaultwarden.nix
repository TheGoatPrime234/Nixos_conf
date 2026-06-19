{
  config,
  pkgs,
  lib,
  pkgs-unstable,
  ...
}: {
  options = {
    xanterella = {
      vaultwarden = {
        enable = lib.mkEnableOption "Aktiviert Vaultwarden ohne externes Speichermedium";
      };
      vaultwarden-extern = {
        enable = lib.mkEnableOption "Aktiviert vaultwarden mit externem Speichermedium";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.xanterella.vaultwarden.enable {
      environment = {
        systemPackages = with pkgs-unstable; [
          vaultwarden
        ];
      };
      systemd = {
        services = {
          vaultwarden = {
            serviceConfig = {
              ReadWritePaths = [
                "server-data/nix/vaultwarden"
              ];
            };
          };
        };
        tmpfiles = {
          rules = [
            "d server-data/nix/vaultwarden 0750 vaultwarden vaultwarden -"
          ];
        };
      };
      services = {
        vaultwarden = {
          enable = true;
          config = {
            DATA_FOLDER = "server-data/nix/vaultwarden";
            ROCKET_ADDRESS = "0.0.0.0";
            ROCKET_PORT = 8222;
          };
        };
      };
      networking = {
        firewall = {
          allowedTCPPorts = [
            8222
          ];
        };
      };
    })
    (lib.mkIf config.xanterella.vaultwarden-extern.enable {
      environment = {
        systemPackages = with pkgs-unstable; [
          vaultwarden
        ];
      };
      systemd = {
        services = {
          vaultwarden = {
            serviceConfig = {
              ReadWritePaths = [
                "/mnt/server-data/nix/vaultwarden"
              ];
            };
          };
        };
        tmpfiles = {
          rules = [
            "d /mnt/server-data/nix/vaultwarden 0750 vaultwarden vaultwarden -"
          ];
        };
      };
      services = {
        vaultwarden = {
          enable = true;
          config = {
            DATA_FOLDER = "/mnt/server-data/nix/vaultwarden";
            ROCKET_ADDRESS = "0.0.0.0";
            ROCKET_PORT = 8222;
          };
        };
      };
      networking = {
        firewall = {
          allowedTCPPorts = [
            8222
          ];
        };
      };
    })
  ];
}
