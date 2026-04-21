{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./../../modules/hyprland.nix
    ./../../modules/hyprpaper.nix
    ./../../modules/sddm.nix
    ./../../modules/hyprlock.nix
    ./../../modules/wlogout.nix
    ./../../modules/hyprpicker.nix
    ./../../modules/pulxemixer.nix
    ./../../modules/screenshots.nix
    ./../../modules/kitty.nix
  ];

  config = {
    xanterella = {
      hyprland.enable = true;
      hyprpaper.enable = true;
      sddm.enable = true;
      hyprlock.enable = true;
      wlogout.enable = true;
      hyprpicker.enable = true;
      pulsemixer.enable = true;
      screenshots.enable = true;
      kitty.enabel = true;
    };
  };
}
