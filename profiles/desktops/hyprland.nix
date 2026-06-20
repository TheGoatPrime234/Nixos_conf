{
  config,
  lib,
  ...
}: {
  imports = [
    ./desktop.nix
  ];
  config = {
    xanterella = {
      gnome-keyring = {
        enable = true;
      };
      hypridle = {
        enable = true;
      };
      hyprland = {
        enable = true;
      };
      hyprlock = {
        enable = true;
      };
      hyprpaper = {
        enable = true;
      };
      hyprpicker = {
        enable = true;
      };
      nix-switcher = {
        enable = true;
      };
      nix-timetracker = {
        enable = true;
      };
      screenshots = {
        enable = true;
      };
      sddm = {
        enable = true;
      };
      swww = {
        enable = true;
      };
    };
  };
}
