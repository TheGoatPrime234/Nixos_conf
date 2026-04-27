{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./../modules/local.nix
    ./modules/essentials.nix
    ./modules/nixedit.nix
    ./modules/hyprland.nix
    ./modules/laptop.nix
    ./modules/game.nix
    ./modules/cybersecurity.nix
    ./modules/vault.nix
    inputs.spicetify-nix.nixosModules.default
    inputs.nixvim.nixosModules.default
    ./../modules/ani-cli.nix
    ./../modules/audio.nix
    ./../modules/bluetooth.nix
    ./../modules/btop.nix
    ./../modules/direnv.nix
    ./../modules/gnome-keyring.nix
    ./../modules/gparted.nix
    ./../modules/nvidia.nix
    ./../modules/tailscale.nix
    ./../modules/tree.nix
    ./../modules/vscode.nix
    ./../modules/wget.nix
    ./../modules/zip.nix
    ./../modules/zen-browser.nix
    ./../modules/yazi.nix
    ./../modules/spicetify.nix
  ];

  config = {
    xanterella = {
      local.enable = true;
      ani-cli.enable = true;
      audio.enable = true;
      bluetooth.enable = true;
      btop.enable = true;
      direnv.enable = true;
      gnome-keyring.enable = true;
      gparted.enable = true;
      nvidia.enable = true;
      tailscale.enable = true;
      tree.enable = true;
      vscode.enable = true;
      wget.enable = true;
      zip.enable = true;
      zen-browser.enable = true;
      yazi.enable = true;
      spicetify.enable = true;
    };
  };
}
