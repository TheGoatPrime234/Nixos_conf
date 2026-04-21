{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./modules/hyprland.nix
    ./modules/nixedit.nix
    ./modules/laptop.nix
    ./../modules/bluetooth.nix
    ./../modules/boot.nix
    ./../modules/dbus.nix
    ./../modules/git.nix
    ./../modules/nvidia.nix
    ./../modules/playerctl.nix
    ./../modules/tailscale.nix
    ./../modules/zip.nix
  ];

  config = {
    xanterella = {
      bluetooth.enable = true;
      boot.enable = true;
      dbus.enable = true;
      git.enable = true;
      nvidia.enable = true;
      playerctl.enable = true;
      tailscale.enable = true;
      zip.enable = true;
    };
  };
}
