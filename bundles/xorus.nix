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
    ./modules/vault.nix
    inputs.spicetify-nix.nixosModules.default
    inputs.nixvim.nixosModules.default
    ./../modules/audio.nix
    ./../modules/btop.nix
    ./../modules/direnv.nix
    ./../modules/gnome-keyring.nix
    ./../modules/tailscale.nix
    ./../modules/tree.nix
    ./../modules/wget.nix
    ./../modules/zip.nix
    ./../modules/yazi.nix
  ];

  config = {
    xanterella = {
      local.enable = true;
      audio.enable = true;
      btop.enable = true;
      direnv.enable = true;
      gnome-keyring.enable = true;
      tailscale.enable = true;
      tree.enable = true;
      wget.enable = true;
      zip.enable = true;
      yazi.enable = true;
    };
  };
}
