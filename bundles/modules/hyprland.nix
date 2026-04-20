{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./../../modules/hyprland.nix
    ./../../modules/hyprpaper.nix
  ];

  config = {
    xanterella = {
      hyprland.enable = true;
      hyprpaper.enable = true;
    };
  };
}
