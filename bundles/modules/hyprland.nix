{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./../../modules/hyprland.nix
    ./../../modules/hyprpaper.nix
    ./../../modules/hypridle.nix
    ./../../modules/sddm.nix
    ./../../modules/hyprlock.nix
    ./../../modules/wlogout.nix
    ./../../modules/hyprpicker.nix
    ./../../modules/pulxemixer.nix
    ./../../modules/screenshots.nix
    ./../../modules/kitty.nix
    ./../../modules/rofi.nix
    ./../../modules/cava.nix
    ./../../modules/quickshell.nix
  ];

  config = {
    xanterella = {
      hyprland.enable = true;
      hyprpaper.enable = true;
      hypridle.enable = true;
      sddm.enable = true;
      hyprlock.enable = true;
      wlogout.enable = true;
      hyprpicker.enable = true;
      pulsemixer.enable = true;
      screenshots.enable = true;
      kitty.enable = true;
      rofi.enable = true;
      cava.enable = true;
      quickshell.enable = true;
    };
  };
}
