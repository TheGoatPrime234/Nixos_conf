{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.audiobookshelf.enable = lib.mkEnableOption "Aktiviert audiobookshelf";
  };

  config = lib.mkIf config.xanterella.audiobookshelf.enable {
    environment.systemPackages = with pkgs; [
      audiobookshelf
    ];
    systemd = {
      tmpfiles = {
        rules = [
          "d /mnt/data/nix/audiobookshelf/metadata 0750 audiobookshelf audiobookshelf -"
          "d /mnt/data/nix/audiobookshelf/audiobooks 0750 audiobookshelf audiobookshelf -"
          "d /mnt/data/nix/audiobookshelf/podcasts 0750 audiobookshelf audiobookshelf -"
        ];
      };
    };
    services = {
      audiobookshelf = {
        enable = true;
        host = "0.0.0.0";
        port = 13378;
        openFirewall = true;
        dataDir = "/mnt/data/nix/audiobookshelf/metadata";
      };
    };
    networking = {
      firewall = {
        allowedTCPPorts = [
          13378
        ];
      };
    };
  };
}
