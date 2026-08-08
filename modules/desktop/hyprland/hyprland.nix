{
  config,
  pkgs,
  lib,
  ...
}: let
  hyprlandConf = ./hyprland.conf;
in {
  options = {
    xanterella.hyprland.enable = lib.mkEnableOption "Aktiviert hyprland";
  };

  config = lib.mkIf config.xanterella.hyprland.enable {
    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
      };
    };

    systemd.user.tmpfiles.rules = [
      "d %h/.config/hypr 0755 - - -"
      "L+ %h/.config/hypr/hyprland.conf - - - - ${hyprlandConf}"
      "f %h/.config/hypr/noctalia.conf 0644 - - -"
    ];

    environment.sessionVariables = {
      XDG_SESSION_TYPE = "wayland";
      NIXOS_OZONE_WL = "1";
      PASSWORD_STORE = "basic";
    };

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}
