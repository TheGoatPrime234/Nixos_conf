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
      };
      syncthing_server-extern = {
        enable = lib.mkEnableOption "Aktiviert Syncthing_server mit externem Speichermedium";
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
            "d server-data/nix/syncthing 0750 syncthing syncthing -"
            "d server-data/nix/syncthing/data 0750 syncthing syncthing -"
            "d server-data/nix/syncthing/config 0750 syncthing syncthing -"
          ];
        };
      };
      services = {
        syncthing = {
          enable = true;
          systemService = true;
          dataDir = "server-data/nix/syncthing/data";
          configDir = "server-data/nix/syncthing/config";
          user = "syncthing";
          group = "syncthing";
          guiAddress = "0.0.0.0:8384";
        };
      };
      networking = {
        firewall = {
          allowedTCPPorts = [
            8384
          ];
        };
      };
    })
    (lib.mkIf config.xanterella.syncthing_server-extern.enable {
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
          guiAddress = "0.0.0.0:8384";
        };
      };
      networking = {
        firewall = {
          allowedTCPPorts = [
            8384
          ];
        };
      };
    })
  ];
}
