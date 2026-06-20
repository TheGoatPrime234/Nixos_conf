{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules
    ./../../profiles/boot/boot.nix
    ./../../profiles/essentials/essentials.nix
    ./../../profiles/apps/apps.nix
    ./../../profiles/desktops/gnome.nix
    ./../../profiles/dev.nix
    ./../../profiles/vault.nix
  ];

  networking = {
    hostName = "xorus";
  };
  system = {
    stateVersion = "25.11"; # Did you read the comment?
  };
}
