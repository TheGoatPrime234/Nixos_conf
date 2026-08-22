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
    ./../../profiles/server/headless.nix
    ./../../profiles/apps/swetik-apps.nix
  ];
  networking = {
    hostName = "swetik";
  };
  system = {
    stateVersion = "26.05";
  };
}
