{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules
    ./../../profiles/boot/boot.nix
    ./../../profiles/essentials/essentials.nix
    ./../../profiles/apps/apps.nix
    #    ./../../profiles/desktops/desktop.nix
    ./../../profiles/desktops/hyprland.nix
    ./../../profiles/dev.nix
    ./../../profiles/vault.nix
    ./../../profiles/cybersec.nix
    ./../../profiles/creative.nix
    ./../../profiles/gaming.nix
  ];
  boot = {
    binfmt = {
      emulatedSystems = ["aarch64-linux"];
    };
  };
  networking = {
    hostName = "xeravus";
  };
  system = {
    stateVersion = "25.11"; # Did you read the comment?
  };
}
