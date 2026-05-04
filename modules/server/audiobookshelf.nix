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
    services = {
      audiobookshelf = {
        enable = true;
        host = "vicuna";
        port = 13378;
        openFirewall = true;
      };
    };
  };
}
