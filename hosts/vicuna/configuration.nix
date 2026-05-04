{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules
    ./../../profiles/boot_server.nix
    ./../../profiles/essentials.nix
    ./../../profiles/.nix
    ./../../profiles/server.nix
  ];

  networking.hostName = "vicuna";
}
