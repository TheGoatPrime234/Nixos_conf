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
    ./../../profiles/hyprland.nix
    ./../../profiles/vault.nix
  ];

  networking.hostName = "xorus";
  system.stateVersion = "25.11"; # Did you read the comment?
}
