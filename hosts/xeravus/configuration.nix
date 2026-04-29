{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules
    ./../../profiles/boot.nix
    ./../../profiles/essentails.nix
    ./../../profiles/hyprland.nix
    ./../../profiles/vault.nix
    ./../../profiles/cybersec.nix
    ./../../profiles/gaming.nix
  ];

  networking.hostName = "xeravus";
  system.stateVersion = "25.11"; # Did you read the comment?
}
