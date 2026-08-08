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

    # HIER IST DIE MAGIE: NixOS verwaltet die Dateien für uns deklarativ!
    # %h steht für das Home-Verzeichnis des aktuellen Users.
    systemd.user.tmpfiles.rules = [
      # Erstellt den Ordner, falls er fehlt
      "d %h/.config/hypr 0755 - - -"
      # Erstellt den Symlink zu deiner Datei im schreibgeschützten Nix-Store
      "L+ %h/.config/hypr/hyprland.conf - - - - ${hyprlandConf}"
      # Erstellt die leere noctalia.conf (fixt den Crash auf neuen Laptops!)
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
