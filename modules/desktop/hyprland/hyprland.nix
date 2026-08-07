{
  config,
  pkgs,
  lib,
  ...
}: let
  hyprlandConf = ./hyprland.conf;
  hyprlandRunner = pkgs.writeShellScriptBin "start-hyprland-wrapped" ''
    source /etc/profile
    mkdir -p ~/.config/hypr
    touch ~/.config/hypr/noctalia.conf
    exec /run/current-system/sw/bin/Hyprland -c ${hyprlandConf}
  '';

  customWaylandSession =
    (pkgs.writeTextDir "share/wayland-sessions/hyprland-wrapped.desktop" ''
      [Desktop Entry]
      Name=Hyprland (Wrapped)
      Comment=Hyprland mit deklarativer Nix-Config
      Exec=${hyprlandRunner}/bin/start-hyprland-wrapped
      Type=Application
    '').overrideAttrs {
      passthru.providedSessions = ["hyprland-wrapped"];
    };
in {
  options = {
    xanterella = {
      hyprland = {
        enable = lib.mkEnableOption "Aktiviert hyprland";
      };
    };
  };

  config = lib.mkIf config.xanterella.hyprland.enable {
    environment = {
      systemPackages = with pkgs; [
        hyprland
      ];
    };
    programs = {
      hyprland = {
        enable = true;
        xwayland = {
          enable = true;
        };
      };
    };
    services = {
      displayManager = {
        sessionPackages = [
          customWaylandSession
        ];
      };
    };
    environment = {
      sessionVariables = {
        XDG_SESSION_TYPE = "wayland";
        NIXOS_OZONE_WL = "1";
        PASSWORD_STORE = "basic";
      };
    };
    xdg = {
      portal = {
        enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-hyprland
          pkgs.xdg-desktop-portal-gtk
        ];
      };
    };
  };
}
