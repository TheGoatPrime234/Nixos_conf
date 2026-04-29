{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.aircrack-ng.enable = lib.mkEnableOption "Aktiviert aircrack-ng";
  };

  config = lib.mkIf config.xanterella.aircrack-ng.enable {
    environment.systemPackages = with pkgs; [
      aircrack-ng
    ];
  };
}
