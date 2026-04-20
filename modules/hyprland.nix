{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.hyprland.enable = lib.mkEnableOption "Aktiviert hyprland";
  };

  config = lib.mkIf config.xanterella.hyprland.enable {
    environment.systemPackages = with pkgs; [
      hyprland
    ];
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
