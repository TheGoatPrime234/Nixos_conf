{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.hyprpicker.enable = lib.mkEnableOption "Aktiviert xyy";
  };

  config = lib.mkIf config.xanterella.hyprpicker.enable {
    environment.systemPackages = with pkgs; [
      hyprpicker
    ];
  };
}
