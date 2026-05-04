{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.syncthing_server.enable = lib.mkEnableOption "Aktiviert syncthing_server";
  };

  config = lib.mkIf config.xanterella.syncthing_server.enable {
    environment.systemPackages = with pkgs; [
      syncthing
    ];
    systemd = {
      tmpfiles = {
        rules = [
          "d /mnt/data/nix/syncthing 0750 syncthing syncthing -"
          "d /mnt/data/nix/syncthing/data 0750 syncthing syncthing -"
          "d /mnt/data/nix/syncthing/config 0750 syncthing syncthing -"
        ];
      };
    };
    services = {
      syncthing = {
        enable = true;
        systemService = true;
        dataDir = "/mnt/data/nix/syncthing/data";
        configDir = "/mnt/data/nix/syncthing/config";
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
  };
}
