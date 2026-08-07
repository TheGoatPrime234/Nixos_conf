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
      hyprland = {
        enable = true;
      };
      hyprpicker = {
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
      noctalia = {
        enable = true;
      };
    };
  };
}
