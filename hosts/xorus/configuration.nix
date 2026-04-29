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
  ];

  networking.hostName = "xorus";
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHc0eOrLgxwDdvrFC9WEtOsh+Sx5AqZUUKxhrQWaPIPE cato.jenisch@gmail.com"
  ];
  system.stateVersion = "25.11"; # Did you read the comment?
}
