{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.rofi.enable = lib.mkEnableOption "Aktiviert rofi";
  };

  config = lib.mkIf config.xanterella.rofi.enable {
    environment.systemPackages = with pkgs; [
      rofi
    ];
  };
}
