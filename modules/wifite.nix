{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.wifite.enable = lib.mkEnableOption "Aktiviert wifite";
  };

  config = lib.mkIf config.xanterella.wifite.enable {
    environment.systemPackages = with pkgs; [
      wifite2
    ];
  };
}
