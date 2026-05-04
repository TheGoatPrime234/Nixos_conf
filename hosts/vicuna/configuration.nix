{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules
    ./../../profiles/boot-server.nix
    ./../../profiles/essentials.nix
    ./../../profiles/server.nix
  ];

  networking.hostName = "vicuna";
  fileSystems = {
    "/mnt/data" = {
      device = "/dev/disk/by-uuid/1046B06546B04CEA";
      fsType = "ntfs";
      options = [
        "nofail"
        "defaults"
      ];
    };
  };
}
