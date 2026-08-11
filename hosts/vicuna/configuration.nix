{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules
    ./../../profiles/boot/boot-vicuna.nix
  ];
  networking = {
    hostName = "vicuna";
  };
  xanterella = {
    boot = {
      enable = lib.mkForce false;
    };
  };
  sdImage = {
    firmwareSize = 1024;
  };
  hardware = {
    #bluetooth = { enable = false; };
    enableRedistributableFirmware = true;
  };
  system = {
    stateVersion = "26.05";
  };
}
