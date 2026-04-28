{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../bundles/xorus.nix
  ];

  networking.hostName = "xorus";
  nix.settings.experimental-features = ["nix-command" "flakes"];
  security.pam.services.sddm.enableKwallet = true;
  networking.networkmanager.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    PASSWORD_STORE = "basic";
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHc0eOrLgxwDdvrFC9WEtOsh+Sx5AqZUUKxhrQWaPIPE cato.jenisch@gmail.com"
  ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11"; # Did you read the comment?
}
