{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../bundles/xeravus.nix
  ];

  networking.hostName = "xeravus";
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = [
    "root"
    "cato"
  ];
  security.pam.services.sddm.enableKwallet = true;
  networking.networkmanager.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    PASSWORD_STORE = "basic";
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11"; # Did you read the comment?
}
