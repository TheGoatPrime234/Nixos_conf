{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules
    ./../../profiles/boot/boot-server.nix
    ./../../profiles/apps/lutik-apps.nix
  ];
  networking = {
    hostName = "lutik";
  };
  system = {
    stateVersion = "26.05";
  };
}
