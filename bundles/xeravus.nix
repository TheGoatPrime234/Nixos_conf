{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./../hosts/xeravus/configuration.nix
    ./../hosts/xeravus/hardware-configuration.nix
    ./../modules/local.nix
    ./modules/hyprland.nix
    ./modules/nixedit.nix
    ./modules/laptop.nix
    ./modules/game.nix
    ./modules/cybersecurity.nix
    ./modules/vault.nix
    ./../modules/ani-cli.nix
    ./../modules/bluetooth.nix
    ./../modules/boot.nix
    ./../modules/btop.nix
    ./../modules/dbus.nix
    ./../modules/direnv.nix
    ./../modules/git.nix
    ./../modules/gnome-keyring.nix
    ./../modules/gparted.nix
    ./../modules/libnotify.nix
    ./../modules/nvidia.nix
    ./../modules/playerctl.nix
    ./../modules/sl.nix
    ./../modules/tailscale.nix
    ./../modules/tree.nix
    ./../modules/vscode.nix
    ./../modules/wget.nix
    ./../modules/zip.nix
    ./../modules/nixvim.nix
    ./../modules/zen-browser.nix
    ./../modules/yazi.nix
  ];

  config = {
    xanterella = {
      local.enable = true;
      ani-cli.enable = true;
      bluetooth.enable = true;
      boot.enable = true;
      btop.enable = true;
      dbus.enable = true;
      direnv.enable = true;
      git.enable = true;
      gnome-keyring.enable = true;
      gparted.enable = true;
      libnotify.enable = true;
      nvidia.enable = true;
      audio.enable = true;
      sl.enable = true;
      tailscale.enable = true;
      tree.enable = true;
      vscode.enable = true;
      wget.enable = true;
      zip.enable = true;
      nixvim.enable = true;
      zen-browser.enable = true;
      yazi.enable = true;
    };
  };
}
