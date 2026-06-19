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
    ./../../profiles/server/apps-server.nix
  ];
  networking = {
    hostName = "lutik";
  };
  system = {
    stateVersion = "26.05";
  };
}
