{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules
    ./../../profiles/boot.nix
    ./../../profiles/essentials.nix
    ./../../profiles/vault.nix
  ];

  networking.hostName = "vicuna";
}
