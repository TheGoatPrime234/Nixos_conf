{
  config,
  pkgs,
  lib,
  pkgs-unstable,
  ...
}: {
  options = {
    xanterella = {
      audiobookshelf = {
        enable = lib.mkEnableOption "Aktiviert audiobookshelf ohne externes Speichermedium";
      };
      audiobookshelf-extern = {
        enable = lib.mkEnableOption "Aktiviert Audiobookshelf mit externem Speichermedium";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.xanterella.audiobookshelf.enable {
      environment = {
        systemPackages = with pkgs-unstable; [
          audiobookshelf
        ];
      };
      fileSystems = {
        "/var/lib/audiobookshelf" = {
          device = "server-data/nix/audiobookshelf";
          options = ["bind"];
        };
      };
      services = {
        audiobookshelf = {
          enable = true;
          package = pkgs-unstable.audiobookshelf;
          host = "0.0.0.0";
          port = 13378;
          openFirewall = true;
        };
      };
      systemd = {
        services = {
          audiobookshelf = {
            environment = {
              ROUTER_BASE_PATH = "/audiobookshelf";
            };
          };
        };
      };
      networking = {
        firewall = {
          allowedTCPPorts = [
            13378
          ];
        };
      };
    })
    (lib.mkIf config.xanterella.audiobookshelf-extern.enable {
      environment = {
        systemPackages = with pkgs-unstable; [
          audiobookshelf
        ];
      };
      fileSystems = {
        "/var/lib/audiobookshelf" = {
          device = "/mnt/server-data/nix/audiobookshelf";
          options = ["bind"];
          # Sagt NixOS, dass es erst die Hauptfestplatte mounten muss, bevor dieser Mount passiert
          depends = ["/mnt/server-data"];
        };
      };
      services = {
        audiobookshelf = {
          enable = true;
          package = pkgs-unstable.audiobookshelf;
          host = "0.0.0.0";
          port = 13378;
          openFirewall = true;
        };
      };
      systemd = {
        services = {
          audiobookshelf = {
            environment = {
              ROUTER_BASE_PATH = "/audiobookshelf";
            };
          };
        };
      };
      networking = {
        firewall = {
          allowedTCPPorts = [
            13378
          ];
        };
      };
    })
  ];
}
