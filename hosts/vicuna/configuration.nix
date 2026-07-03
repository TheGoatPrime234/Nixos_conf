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
    ./../../profiles/server/apps-server-extern.nix
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
  fileSystems = {
    "/mnt/server-data" = {
      device = "/dev/disk/by-label/Server";
      fsType = "ext4";
      options = [
        "defaults"
        "nofail"
        "x-systemd.device-timeout=5s"
      ];
    };
  };
  hardware = {
    bluetooth = {
      enable = false;
    };
    enableRedistributableFirmware = true;
  };
  system = {
    stateVersion = "26.05";
  };
}
