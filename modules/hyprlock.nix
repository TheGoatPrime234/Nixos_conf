{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.hyprlock.enable = lib.mkEnableOption "Aktiviert hyprlock";
  };

  config = lib.mkIf config.xanterella.hyprlock.enable {
    environment.systemPackges = with pkgs; [
      hyprlock
    ];
    programs.hyprlock.enable = true;
  };
}
