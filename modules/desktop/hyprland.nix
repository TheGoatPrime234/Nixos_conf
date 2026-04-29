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
    environment.sessionVariables = {
      XDG_SESSION_TYPE = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
      PASSWORD_STORE = "basic";
    };
    xdg = {
      portal = {
        enable = true;
        extraPortals = [pkgs.xdg-desktop-portal-hyprland];
      };
    };
  };
}
