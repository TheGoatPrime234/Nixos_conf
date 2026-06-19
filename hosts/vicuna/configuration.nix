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
    firmwareSize = 256;
  };
  fileSystems = {
    "/mnt/server-data" = {
      device = "/dev/disk/by-uuid/1046B06546B04CEA";
      fsType = "ntfs";
      options = [
        "defaults"
        "nofail"
        "x-systemd.device-timeout=5s"
      ];
    };
  };
  system = {
    stateVersion = "25.11";
  };
}
