{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./modules/hyprland.nix
    ./modules/nixedit.nix
    ./../modules/fastfetch.nix
    ./../modules/git.nix
    ./../modules/nixvim.nix
    ./../modules/nvidia.nix
    ./../modules/tailscale.nix
    ./../modules/boot.nix
    ./../modules/bluetooth.nix
    ./../modules/yazi.nix
    ./../modules/rofi.nix
  ];

  config = {
    xanterella = {
      alejandra.enable = true;
      fastfetch.enable = true;
      git.enable = true;
      nixvim.enable = true;
      nvidia.enable = true;
      tailscale.enable = true;
      boot.enable = true;
      bluetooth.enable = true;
      yazi.enable = true;
      rofi.enable = true;
    };
  };
}
